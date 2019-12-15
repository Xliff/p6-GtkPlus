#!/usr/bin/env perl6
use v6.c;

#use Data::Dump::Tree;

my %do_output;

grammar C-Function-Def {
  rule top-normal { <function-normal>+ }
  rule top-bland  { <function-bland>+ }

  rule function-normal {
    <availability> 'G_GNUC_WARN_UNUSED_RESULT'? <func_def>
  }

  rule function-bland {
    \s* <pre-definitions>? <func_def>
  }

  token pre-definitions {
    'G_GNUC_WARN_UNUSED_RESULT'                        |
    'G_GNUC_INTERNAL'                                  |
    <[A..Z]>+ '_DEPRECATED_FOR' \s* '(' <[\w _]>+ ')'
  }

  rule func_def {
    <returns>
    $<sub>=[ \w+ ]
    [
      '(void)'
      |
      '(' [ <type> <var> | $<va>='...' ]+ % [ \s* ',' \s* ] ')'
    ] [ <postdec>+ % \s* ]?';'
  }

  token       p { '*'+ }
  token       t { <[\w _]>+ }
  rule     type { 'const'? $<n>=\w+ <p>? }
  rule      var { <t>'[]'? }
  token returns { 'const'? <.ws> <t> \s* <p>? }
  token postdec { (<[A..Z0..9]>+)+ %% '_' \s* [ '(' .+? ')' ]? }
  token      ad { 'AVAILABLE' | 'DEPRECATED' }

  token availability {
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

}

grammar C-Function-Internal-Def is C-Function-Def {
  token ad { 'INTERNAL' }
}

sub MAIN (
  $filename,          #= Filename to process
  :$remove,           #= Prefix to remove from method names
  :$var,              #= Class variable name [defaults to '$!w'
  :$output = 'all',   #= Type of output: 'method', 'attributes', 'subs' or 'all'
  :$lib = 'gtk',      #= Library name to use
  :$static = 0,       #= Class is static. Do not remove first parameter.
  :$internal = 0,     #= Add checking for INTERNAL methods
  :$bland = 0,        #= Do NOT attempt to process preprocessor prefixes to subroutines
  :$output-only,      #= Only output methods and attributes matching the given pattern. Pattern should be placed in quotes.
  :$no-headers,       #= Do not display section headers.
  :$get-set = False,  #= Convert simple get/set routine to "attribute" code.
  :$trim-start,       #= Trim lines from the beginning of the post-processed file
  :$trim-end          #= Trim lines from the end of the post-processed file
) {
  my $fn = $filename;

  $fn = "/usr/include/gtk-3.0/gtk/$fn" unless $fn.starts-with('/');
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

  # Remove extraneous, non-necessary bits!
  $contents ~~ s:g/ '/*' ~ '*/' (.+?)//; # Comments
  $contents ~~ s:g/ ^^ \s* '#' .+? $$//;
  $contents ~~ s:g/ ^^ \s* 'G_' [ 'BEGIN' | 'END' ] '_DECLS' \s* $$ //;
  $contents ~~ s:g/ [ 'struct' | 'union' ] <.ws> <[\w _]>+ <.ws> '{' .+? '};'//;
  $contents ~~ s:g/'typedef' .+? ';'//;
  $contents ~~ s:g/ ^ .+? '\\' $//;
  $contents ~~ s:g/ ^^ <.ws> '}' <.ws>? $$ //;
  $contents ~~ s:g/<!after ';'>\n//;
  $contents ~~ s:g/ ^^ 'GIMPVAR' .+? $$ //;

  $contents = $contents.lines.skip($trim-start).join("\n")
    if $trim-start & $trim-start ~~ Int;
  $contents = $contents.lines.reverse.skip($trim-end).reverse.join("\n")
    if $trim-end && $trim-end ~~ Int;

  my \grammar := $internal ??
    C-Function-Internal-Def
    !!
    C-Function-Def;
  my $top-rule  = $bland ?? 'top-bland'      !! 'top-normal';
  my $func-rule = $bland ?? 'function-bland' !! 'function-normal';
  my $matched = grammar.parse($contents, rule => $top-rule);

  unless $matched {
    say 'Could not find any functions!';
    say '-----------------------------';
    say $contents;
    exit 1;
  }

  for $matched{$func-rule}[] -> $m is rw {
    my $av = $bland ??
      { pre-definitions => ($m<pre-definitions> // '').Str } !!
      $m<availability>;

    my $avail = $bland ??
      !$av<pre-definitions>.contains('DEPRECATED')
        !!
      ($av<ad> // '') ne '_DEPRECATED';

    my @p;
    my $orig = $m<func_def><sub>.Str.trim;
    my @tv = ($m<func_def><type> [Z] $m<func_def><var>);

    @p.push: [ .[0], .[1] ] for @tv;

    sub resolve-type($t is copy) {
      # cw: FINALLY got around to doing something that should have been
      #     done from the start.
      $t ~~ s/^g?u?[ 'char' | 'Str' ]/Str/;
      $t ~~ s/^int/gint/;
      $t ~~ s/^float/gfloat/;
      $t ~~ s/^double/gdouble/;
      $t ~~ s/void/Pointer/;
      $t ~~ s/GError/CArray[Pointer[GError]]/;
      if (my $np = (.[0]<p> // '').Str.chars) {
        if $np > 1 {
          $t = "CArray[{ $t }]" for ^($np.Str.trim.chars - 1);
        }
      }

      $t;
    }

    my @v = @p.map({
      my $t = resolve-type(.[0]<n>.Str.trim);
      '$' ~ .[1]<t>.Str.trim ~ do if (my $np = (.[0]<p> // '').Str.chars) {
        if $np == 1 &&
           ($t eq <gfloat gdouble>.any || $t.starts-with(<gint guint>.any).so)
        {
          ' is rw';
        }
      }
    });
    my @t = @p.map({ resolve-type(.[0]<n>.Str.trim) });
    my $o_call = (@t [Z] @v).join(', ');
    $o_call ~= ', ...' if $m<func_def><va>;

    if $attr && $static.not {
      @v.shift if +@v;
      @t.shift if +@t;
    }

    my $sig = (@t [Z] @v).join(', ');
    my $call = @v.map( *.trim ).join(', ');
    my $sub = $m<func_def><sub>.Str.trim;
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
      when 'gchar' | 'guchar' {
        # This logic may no longer be necessary.
        #$p++;
        'Str';
      }
      default {
        $_;
      }
    }

    if $h<returns><p> {
      $p6r = "CArray[{ $p6r }]" for ^($h<returns><p>.Str.trim.chars - 1);
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

  sub outputSub($m) {
    my @p = $m<params>;
    my $subcall = "sub $m<original> ({ $m<o_call> })";

    if $m<p6_return> && $m<p6_return> ne 'void' {

      if $m<avail> {
        say qq:to/SUB/;
          $subcall
            returns $m<p6_return>
            is native({ $lib })
            is export
          \{ * \}
          SUB
      } else {
        say qq:to/SUB/;
          $subcall
            is DEPRECATED
            returns $m<p6_return>
            is native({ $lib })
            is export
          \{ * \}
          SUB
      }

    }  else {

      if $m<avail> {
        say qq:to/SUB/;
          $subcall
            is native({ $lib })
            is export
          \{ * \}
          SUB
      } else {
        say qq:to/SUB/;
          $subcall
            is DEPRECATEDs
            is native({ $lib })
            is export
          \{ * \}
          SUB
      }

    }
  }

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
      say qq:to/METHOD/.chomp;
        { $mult }method { %methods{$m}<sub> } ({ $sig }) { $dep }\{
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
        my $os = ($o_types.Array [Z] %methods{$m}<call_vars>.Array).join(', ');

        say qq:to/METHOD/.chomp;
          { $mult }method { %methods{$m}<sub> } ({ $os })  \{
            samewith({ $oc });
          \}
        METHOD

      }
      say '';
    }
  }

  if %do_output<all> || %do_output<subs> {
    say "\nSUBS\n----\n" unless $no-headers;
    say "\n\n### $filename\n";
    outputSub( %methods{$_} )     for %methods.keys.sort;
    outputSub( %getset{$_}<get> ) for  %getset.keys.sort;
    outputSub( %getset{$_}<set> ) for  %getset.keys.sort;
  }

  for %collider.pairs.grep( *.value > 1 ) -> $d {
    $*ERR.say: "DUPLICATES\n----------" if !$++ ;
    $*ERR.say: "$d";
  }

}
