#!/usr/bin/env perl6
use v6.c;

#use Data::Dump::Tree;
use IO::Capture::Simple;

use lib <. scripts>;

use GTKScripts;

my %do_output;

grammar C-Function-Def {
  regex TOP { <top-bland> }

  rule top-normal { <function-normal>+ }
  rule top-bland  { <function-bland>+ }

  rule function-normal {
      <availability> 'G_GNUC_WARN_UNUSED_RESULT'? <func_def> |
      <availability><func_def>
  }

  rule function-bland {
      \s* <pre-definitions>? <func_def>
  }

  token pre-definitions {
      'G_GNUC_WARN_UNUSED_RESULT'                            |
      'G_GNUC_INTERNAL'                                      |
      <[A..Z]>+ '_DEPRECATED' [ '_IN_' (\d+)+ % '_' ]?
      '_FOR' \s* '(' <[\w _]>+ ')'
  }

  rule parameters {
      '(void)'
    |
      '(' [ <type> <var>? ]+ % [ \s* ',' \s* ] [','? $<va>='...' ]? ')'
  }

  # cw: Double semi-colon sometimes occurs during processing, so it is acccounted
  # for, here.
  token func_name { <[ \w+ _ ]>+ }
  rule func_def {
      <returns>
    $<sub>=[
      <func_name>
      |
      '(*' <func_name> ')'
    ]
      <parameters>
    [ <postdec>+ % \s* ]?';'';'?
  }

  regex       p { [ '*' [ \s* 'const' <!before '_'> \s* ]? ]+ }
  token       n { <[\w _]>+ }
  token       t { <n> | '(' <p> <n>? ')' \s* <parameters> }
  token     mod { 'extern' | 'unsigned' | 'long' | 'const' | 'struct' | 'enum' }
  rule     type { [ <mod>+ %% \s ]? <n>? <p>? }
  rule      var { <t> [ '[' (.+?)? ']' ]? }
  token returns { [ <mod>+ %% \s]? <.ws> <t> \s* <p>? }
  token postdec { (<[A..Z0..9]>+)+ %% '_' \s* [ '(' .+? ')' ]? }
  token      ad { 'AVAILABLE' | 'DEPRECATED' }

  token availability {
    [
      ( <[A..Z]>+'_' )+?
      <ad> [
      '_'
      ( <[A..Z]>+ )+ %% '_'
      [
      'ALL'
      |
      <[0..9]>+ %% '_'
      ]
      ]?
      |
      <[A..Z]>+'_API'
    ]
  }

}

grammar C-Function-Internal-Def is C-Function-Def {
  token ad { 'INTERNAL' }
}

# Reuse?? Why the need to redefine this when I have it in the grammar?
my token ad { 'AVAILABLE' | 'DEPRECATED' }
my token availability {
  [
      ( <[A..Z]>+'_' )+?
      <ad> [
        '_'
        ( <[A..Z 0..9]>+ )+ %% '_'
      ]?
      |
      <[A..Z]>+'_API'
  ]
}

sub MAIN (
        $filename,                     #= Filename to process
  Str  :$remove,                       #= Prefix to remove from method names
  Str  :$var,                          #= Class variable name [defaults to '$!w']. If not specified class methods will be generated.
  Str  :$output-only,                  #= Only output methods and attributes matching the given pattern. Pattern should be placed in quotes.
  Bool :$no-headers,                   #= Do not display section headers.
  Int  :$trim-start,                   #= Trim lines from the beginning of the post-processed file
  Int  :$trim-end,                     #= Trim lines from the end of the post-processed file
  Str  :$remove-from-start  is copy,   #= Remove colon separated prefix strings from all lines
  Str  :$remove-from-end    is copy,   #= Remove colon separate suffix strings from all lines
  Str  :$lib                is copy,   #= Library name to use
  Str  :$delete,                       #= Comma separated list of lines to delete
  Str  :$output             =  'all',  #= Type of output: 'methods', 'attributes', 'subs' or 'all'
  Bool :$internal           =  False,  #= Add checking for INTERNAL methods
  Bool :$bland              =  True,   #= Do NOT attempt to process preprocessor prefixes to subroutines
  Bool :$get-set            =  False,  #= Convert simple get/set routine to "attribute" code.
  Bool :$raw-methods        =  False,  #= Use method format for raw invocations (NFYI)
  Bool :x11(:$X11)          =  False   #= Use GUI mode (must have a valid DISPLAY)
) {
  parse-file($CONFIG-NAME);

  $lib = %config<library> // %config<lib> // 'gtk' unless $lib;

  # Get specific option values from configuration file, if it exists,
  # and those keys are defined.
  if %config<hfile-prefix> -> $pre is copy {
    $remove-from-start ~= ':' if $remove-from-start;
    $remove-from-start ~= $pre;
    #$*ERR.say: "<hfile-perfix> = { $pre }";
  }

  if %config<hfile-suffix> -> $suf {
    $remove-from-end ~= ':' if $remove-from-end;
    $remove-from-end ~= $suf;
  }
  $remove-from-end ~= $remove-from-end ?? ':' !! '' ~ 'G_GNUC_CONST';

  my $fn = $filename;

  $fn = "{ %config<include-directory> // '/usr/include/gtk-3.0/gtk' }/$fn"
    unless $fn.starts-with('/');
  die "Cannot find '$fn'\n" unless $fn.IO.e;

  if $internal.not {
    if $output ne 'all' {
      for $output.split(',') -> $o {
        die qq:to/DIE/ unless $o eq <all attributes methods subs>.any;
        Output can only be one of 'attributes', 'methods', 'subs' or 'all'"
        DIE

        %do_output{$o} = 1;
      }
    } else {
      %do_output<all> = 1;
    }
  } else {
    %do_output<subs> = 1;
  }

  my $attr;
  with $var {
    ($attr = $var) ~~ s:g/$ <!before '!'>//;
    $attr = '$!' ~ $attr unless $attr ~~ /^ '$!' /;
  }

  my @detected;
  my $contents = $fn.IO.open.slurp-rest;

  # cw: Remove all struct definitions;
  $contents ~~ m:g/<struct>/;
  if $/ {
    for $/[].reverse {
      given .<struct> {
        #say "Removing { .from } to { .to }...";
        $contents.substr-rw( .from, .to - .from ) = ''
      }
    }
  }

  # Remove extraneous, non-necessary bits!
  $contents ~~ s:g/ '/*' ~ '*/' (.+?)//; # Comments
  $contents ~~ s:g/ 'G_STMT_START {' .+? '} G_STMT_END'//;
  $contents ~~ s:g/ '\\' $$ \s+ .+? $$//;  # Multi line defines;
  $contents ~~ s:g/ ^^ \s* '#' .+? $$//;
  $contents ~~ s:g/ ^^ \s* <[A..Z]>+ '_' [ 'BEGIN' | 'END' ] '_DECLS' \s* $$ //;
  $contents ~~ s:g/ [ 'struct' | 'union' ] <.ws> <[\w _]>+ <.ws> '{' .+? '};'//;
  $contents ~~ s:g/'typedef' .+? ';'//;
  $contents ~~ s:g/ ^ .+? '\\' $//;
  $contents ~~ s:g/ ^^ <.ws> '}' <.ws>? $$ //;
  $contents ~~ s:g/<!after ';'>\n/ /;
  $contents ~~ s:g/ ^^ 'GIMPVAR' .+? $$ //;

  # cw: Too permissive, but will work for most things. Needs an anchor to $$!
  $contents ~~ s:g/ 'G_GNUC_' <[A..Z]>+ //;

  $contents ~~ s:g/ 'gst_byte_reader_' [
                       'dup' | 'peek' | 'skip' | 'get'
                     ]'_string_utf8(reader' ',str'? ')'//;
  $contents ~~ s:g/ ^^ \s* 'static' \s* 'inline'? .+? $$ //;
  # GObject creation boilerplate
  $contents ~~ s:g/ '((obj), ' .+? ',' .+? '))'//;
  $contents ~~ s:g/ '((cls), ' .+? ',' .+? '))'//;
  $contents ~~ s:g/ '((obj), ' .+? '))'//;
  $contents ~~ s:g/ '((cls), ' .+? '))'//;
  $contents ~~ s:g/ '((obj), ' .+? ',' .+? '))'//;
  $contents ~~ s:g/ 'G_DEFINE_AUTOPTR_CLEANUP_FUNC (' .+? ', g_object_unref)' //;
  $contents ~~ s:g/ 'G_DECLARE_' [ <[A..Z]>+ ]+ % '_' ' (' <-[)]>+ ')' //;

  $contents ~~ s:g/<availability>// if $bland;

  if $remove-from-start {
    # Remove unnecessary whitespace
    $remove-from-start .= trim;
    # cw: Treat each section separated by spaces as a different item, otherwise
    # it might not work.
    $remove-from-start ~~ s:g/\s\s+/:/;
    for ( $remove-from-start // () ).split(':') -> $r {
      #$*ERR.say: "Removing { $r } from start of line...";
      say: "Removing { $r } from start of line...";
      $contents ~~ s:g/ ^^ \s* <{ $r }> <[\s\r\n]>* //;
    }
  }

  if $remove-from-end {
    # Remove unnecessary whitespace
    $remove-from-end .= trim;
    # cw: Treat each section separated by spaces as a different item, otherwise
    # it might not work.
    $remove-from-end ~~ s:g/\s\s+/:/;
    for ( $remove-from-end // () ).split(':') -> $r {
      $contents ~~ s:g/ \s* $r \s* ';' $$ /;/;
    }
    $contents ~~ s:g/ <!before ';'> <?{ $/.Str.chars }> $$/;/;
  }

  $contents = $contents.lines.skip($trim-start).join("\n")
    if $trim-start;
  $contents = $contents.lines.reverse.skip($trim-end).reverse.join("\n")
    if $trim-end;

  my regex range { (\d+) '-' (\d+) }
  my $s-fmt = '%0' ~ $contents.lines.log(10).Int + 1 ~ 'd';
  $contents = (gather for $contents.lines.kv -> $k, $v {
    # Last chance removal by line prefix.
    next if $v.starts-with('extern');

    # Last chance to clean up artifacts left by processing:
    my $val = $v;
    $val .= subst( /\s*';'/ , ';' );

    take "{ ($k + 1).fmt($s-fmt) }: { $val }"
  }).join("\n");\

  # Check for multiple semi-colons on a line and split that line.
  # This is a pain in the ass, as we have to re-perform operations that
  # have been already done to preserve correctness!
  if $contents.lines.map({ +.comb(';') }).grep( * > 1) {
    $contents = (do {
      (my $sc = $contents) ~~ s:g/^^ (\d+) ':' \s*//;
      my $count = 1;
      gather for $sc.lines {
        for .chop.split(';') {
          my $s = $_;
          if $remove-from-start {
            for ( $remove-from-start // () ).split(':') -> $r {
              $s ~~ s:g/ ^^ \s* $r \s* //;
            }
          }
          if $remove-from-end {
            for ( $remove-from-end // () ).split(':') -> $r {
              $s ~~ s:g/ \s* $r \s* ';'? $$ /;/;
            }
          }
          take "{ $count++ }: { $s };";
        }
      }
    }).join("\n");
    # $contents may change in this block, so $stripped-contents needs to be
    # updated
    # (my $stripped-contents = $contents) ~~ s:g/^^ (\d+) ':' \s*//;
  }

  if $delete {
    my @d = $delete.split(',').map({
      my &meth;
      die 'All elements in $delete must be an integer or an integer range!'
        unless $_ ~~ &range || ( &meth = .^lookup('Int') );
      my $r;
      $r = &meth($_) if &meth;
      $r = $_ unless $r;
      $r;
    });

    my @d-ranges;
    for @d {
      if $_ ~~ &range {
        @d-ranges.append: $/[0].Int ... $/[1].Int;
      } else {
        @d-ranges.push: .Int;
      }
    }

    my @c = $contents.lines;
    #say "C:------\n{ @c.join("\n") }------";
    @c.splice($_ - 1, 1) for @d-ranges.reverse;
    $contents = @c.join("\n");
  }
  (my $stripped-contents = $contents) ~~ s:g/^^ (\d+) ':' \s*//;

  my \grammar := $internal ??
    C-Function-Internal-Def
    !!
    C-Function-Def;
  my $top-rule  = $bland ?? 'top-bland'      !! 'top-normal';
  my $func-rule = $bland ?? 'function-bland' !! 'function-normal';
  my $matched = grammar.parse($stripped-contents, rule => $top-rule);

  unless $matched {
    say '============';
    say $stripped-contents;
    say '------------';
    say 'Could not find any functions!';
    say '-----------------------------';
    $contents.say;
    exit 1;
  }

  for $matched{$func-rule}[] -> $m {
    my $av = $bland ??
      { pre-definitions => ($m<pre-definitions> // '').Str } !!
      $m<availability>;

    my $avail = $bland ??
      !$av<pre-definitions>.contains('DEPRECATED')
        !!
      ($av<ad> // '') ne '_DEPRECATED';

    my @p;
    my $orig = $m<func_def><sub>.Str.trim;
    my @tv = ($m<func_def><parameters><type> [Z] $m<func_def><parameters><var>);

    @p.push: [ .[0], .[1] ] for @tv;

    sub resolve-type($match is copy) {
      say "M: { $match.gist }";

      my $t         = $match ~~ Match ?? $match<n> !! $match;
      my $orig-type = $t;

      # cw: FINALLY got around to doing something that should have been
      #     done from the start.
      $t ~~ s/^g?u?[ 'char' | 'Str' ]/Str/;
      $t ~~ s/^int/gint/;
      $t ~~ s/^float/gfloat/;
      $t ~~ s/^double/gdouble/;
      $t ~~ s/void/Pointer/;
      $t ~~ s/GError/Pointer[GError]/;

      # By testing time, $np should only contain the count of '*' in the Match
      my $np = do given $match {
        when Match { ( $match<p>.Str // '').Str.comb('*').elems }

        default    { 0 }
      }
      $t = "{ 'CArray[' x ($np - 1) }{ $t }{ ']' x ($np - 1) }" if $np > 1;
      $t;
    }

    my @v = @p.map({
      my $t = resolve-type( .[0] );
      '$' ~ .[1]<t>.Str.trim ~ do if (my $np = (.[0]<p> // '').Str.chars) {
        if $np == 1 &&
           ($t eq <gfloat gdouble>.any || $t.starts-with(<gint guint>.any).so)
        {
          ' is rw';
        }
      }
    });
    my @t = @p.map({ resolve-type(.[0] ) });
    my $o_call = (@t [Z] @v).join(', ');
    my $sub = $m<func_def><sub>.Str.trim;
    $o_call ~= ', ...' if $m<func_def><va>;

    if $attr && $sub.starts-with("{$remove // ''}new_").not {
      @v.shift if +@v;
      @t.shift if +@t;
    }

    my $sig = (@t [Z] @v).join(', ');
    my $call = @v.map( *.trim ).join(', ');
    $sig ~= ', ...' if $m<func_def><va>;

    if $attr {
      if $call.chars {
        $call = "{$attr}, {$call}";
      } else {
        if $sub ~~ (/'_new'$/ , /'_get_type' $/).any {
          $call = '';
        } else {
          $call = $attr;
        }
      }
    }

    if $remove {
      unless $sub ~~ s/ $remove // {
        unless $sub ~~ s/ { $remove.split('_')[0] ~ '_' } // {
          $sub ~~ s/ 'g_' //;
        }
      }
    }

    my $h = {
           avail => $avail,
        original => $orig.trim,
         returns => $m<func_def><returns>,
           'sub' => $sub,
          params => @p,
          o_call => $o_call,
            call => $call,
             sig => $sig,
       call_vars => @v,
      call_types => @t,
         var_arg => $m<func_def><va>:exists
    };

    #my $p = 1;

    # This will eventually go into a separate CompUnit
    my $p6r = do given $h<returns><t>.Str.trim {
      when 'gpointer' {
        'Pointer';
      }
      when 'float' {
        'gfloat'
      }
      when 'int' {
        'gint';
      }
      when 'va_list' {
      }
      when 'gboolean' {
        'uint32';
      }
      when 'gchar' | 'guchar' | 'char' {
        # This logic may no longer be necessary.
        #$p++;
        'Str';
      }
      default {
        $_;
      }
    }

    if $h<returns><p> {
      # Again, by loop time, $np should be the number of '*' characters found.
      my $np = ($h<returns><p> // '').Str;
      $np = ( ($np ~~ m:g/'*'/).Array.elems );
      $np-- if $p6r eq 'Str'; # Already counts for a '*'
      if $np > 1 {
        $p6r = "CArray[{ $p6r }]" for ^$np - 1;
      }
    }
    $h<p6_return> = $p6r;

    @detected.push: $h;
  }

  my %collider;
  my %methods;
  my %getset;
  for @detected -> $d {
    # Convert signatures to perl6.
    #
    #$d<sub> = substr($d<sub>, $prechop);
    if $d<sub> ~~ /^^ ( [ 'get' || 'set' ] ) '_' ( .+ ) / {
      %getset{$/[1]}{$/[0]} = $d;
    } else {
      %methods{$d<sub>} = $d;
      %collider{$d<sub>}++;
    }
  }

  for %getset.keys.sort -> $gs {
    if !(
      $get-set                              &&
      %getset{$gs}<get>                     &&
      %getset{$gs}<get><params>.elems == 1  &&
      %getset{$gs}<set>                     &&
      %getset{$gs}<set><params>.elems == 2
    ) {
      say "Removing non-conforming get:set {$gs}...";
      if %getset{$gs}<get>.defined {
        %methods{%getset{$gs}<get><sub>} = %getset{$gs}<get>;
        %collider{ %getset{$gs}<get><sub> }++;
      }
      if %getset{$gs}<set>.defined {
        %methods{%getset{$gs}<set><sub>} = %getset{$gs}<set>;
        %collider{ %getset{$gs}<set><sub> }++;
      }
      %getset{$gs}:delete;
    } else {
      %getset{$gs}<get><sub> ~~ s/['get' | 'set']_//;
      %collider{ %getset{$gs}<get><sub> }++;
    }
  }

  if %do_output<all> || %do_output<attributes> {
    say "\nGETSET\n------" unless $no-headers;
    for %getset.keys.sort -> $gs {
      if $output-only.defined {
        next unless $gs ~~ /<{ $output-only }>/;
      }

      my $sp = %getset{$gs}<set><call>.split(', ')[*-1];

      say qq:to/METHOD/;
        method { %getset{$gs}<get><sub> } is rw \{
          Proxy.new(
            FETCH => sub (\$) \{
              { %getset{$gs}<get><original> ~ '(' ~ %getset{$gs}<get><call> ~ ')' };
            \},
            STORE => sub (\$, { $sp } is copy) \{
              { %getset{$gs}<set><original> ~ '(' ~ %getset{$gs}<set><call> ~ ')'};
            \}
          );
        \}
      METHOD

    }
  }

  sub outputSub ($m, $method = False) {
    my $subcall = "sub $m<original> ({ $m<o_call> })";

    # if $method {
    #   # This should be done, above.
    #   my @p = $m<params>;
    #   @p.shift if @p[0][1] eq $var;
    #
    # }

    my $r = '';
    $r ~= "\n  is DEPRECATED"                 if $m<avail>.not;
    $r ~= "\n  returns { $m<p6_return> }"     if $m<p6_return> &&
                                                 $m<p6_return> ne 'void';
    $r ~= "\n  is symbol('{ $m<original> }')" if $method;

    say qq:to/SUB/;
      $subcall {
      $r }
        is native({ $lib })
        is export
      \{ * \}
      SUB
  }

  sub outputMethods {
    say "\nMETHODS\n-------" unless $no-headers;
    if %do_output<all> || %do_output<methods> {
      for %methods.keys.sort -> $m {
        if $output-only.defined {
          next unless $m ~~ /<{ $output-only }>/;
        }

        my @sig_list = %methods{$m}<sig>.split(/\, /);

        my rule replacer { «[ 'Gtk'<[A..Z]>\w+ | 'GtkWindow' ]» };
        my $sig = %methods{$m}<sig>;
        my $call = %methods{$m}<call>;
        my $mult = '';

        # $mult = %methods{$m}<call_types>.grep(/<replacer>/) ?? 'multi ' !! ''
        #   if
        #     %methods{$m}<call_types> &&
        #     %methods{$m}<call_types>[0] eq <
        #       GtkEntryIconPosition
        #       GtkTreeIter
        #     >.none;

        my $dep = %methods{$m}<avail> ?? '' !! 'is DEPRECATED ';
        my $params = %methods{$m}<call_types>.elems ?? " ({ $sig })" !! '';
        say qq:to/METHOD/.chomp;
          { $mult }method { %methods{$m}<sub> }{ $params } { $dep }\{
            { %methods{$m}<original> }({ $call });
          \}
        METHOD

        if $mult {
          my $o_call = %methods{$m}<call_vars>.clone;
          my $o_types = %methods{$m}<call_types>.clone;
          for (^$o_types) -> $oidx {
            given $oidx {
              when s/GtkWindow/GTK::Window/ {
                $o_call[$oidx] ~~ s/\$(\w+)/\$$0.window/;
              }
              when s/'Gtk' <!before 'Window'> (<[A..Z]> \w+)/GTK::$0/ {
                $o_call[$oidx] ~~ s/\$(\w+)/\$$0.widget/;
              }
            }
          }
          my $oc = $o_call.join(', ');
          my @pa = $o_types.Array [Z] %methods{$m}<call_vars>.Array;
          my $os = @pa.join(', ');
          my $params = @pa.grep( * ).elems ?? " ({ $os })" !! '';

          # { @pa.elems }
          say qq:to/METHOD/.chomp;
            { $mult }method { %methods{$m}<sub> }{ $params }  \{
              samewith({ $oc });
            \}
          METHOD

        }
        say '';
      }
    }
  }

  my ($redir-output, $use-X11, %class);
  if $X11 {
    for <
      GTK::Application
      SourceViewGTK::View
    > {
      my $cu = $_;
      say "Loading { $cu } ...";
      %class{$cu} = try require ::($cu);
      my $mod-failed = ::($cu) ~~ Failure;
      say "Failed to load $cu" if $mod-failed;

      unless (
        $use-X11 = $use-X11.defined ?? $use-X11 && $mod-failed.not
                                    !! $mod-failed.not;
      ) {
        warn "Cannot switch to GUI mode: $_ load failure";
        last
      }
    }

    capture_stdout_on($redir-output);
  }

  outputMethods;
  if %do_output<all> || %do_output<subs> {
    say "\nSUBS\n----\n" unless $no-headers;
    say "\n\n### { $fn }\n";
    outputSub( %methods{$_}    , $raw-methods) for %methods.keys.sort;
    outputSub( %getset{$_}<get>, $raw-methods) for  %getset.keys.sort;
    outputSub( %getset{$_}<set>, $raw-methods) for  %getset.keys.sort;
  }

  for %collider.pairs.grep( *.value > 1 ) -> $d {
    $*ERR.say: "DUPLICATES\n----------" if !$++ ;
    $*ERR.say: ~$d;
  }

  if $use-X11 {
    my \app  = %class<GTK::Application>;
    my \view = %class<SourceViewGTK::View>;

    my $a = app.new( title => 'org.genex.hMethodMaker' );
    $a.activate.tap({
      my $v = view.new;

      $v.buffer.text = $redir-output;
      $a.window.add($v);
      $a.window.show_all;
    });

    $a.run;
  }

}
