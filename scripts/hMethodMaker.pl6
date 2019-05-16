#!/usr/bin/env perl6
use v6.c;

#use Data::Dump::Tree;

my %do_output;

sub MAIN (
  $filename,
  :$remove,
  :$var,
  :$output = 'all',
  :$lib = 'gtk',
  :$args = 1,
  :$static = 0,
  :$internal = 0,
  :$bland = 0
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

  my $contents = $fn.IO.open.slurp-rest;

  my @ad = <AVAILABLE DEPRECATED>;
  @ad = ('INTERNAL') if $internal;
  my token availability {
    [
      ( <[A..Z]>+'_' )+?
      $<ad>=@ad [
        '_'
        ( <[A..Z 0..9]>+ )+ %% '_'
      ]?
      |
      <[A..Z]>+'_API'
    ]
  };

  # Post process for bland
  if $bland {
    $contents ~~ s:g/ '/*' ~ '*/' (.+?)//; # Comments
    $contents ~~ s:g/^^ '#' .+? \n//;      # Preprocessor
  }

  my $la;
  my $fd = '';
  my $i = 1;
  my @detected;
  for $contents.lines -> $l {
    if ($la.not && $bland) || $l ~~ /^ <availability> / {
      $la = True;
      $fd ~= $l.chomp;
      next;
    }
    if $la {
      $fd ~= ' ' ~ $l.chomp;
    }

    #[ \s* '//' \s* .+? ]?

    if $fd ~~ /';' \s* $$/ {
      my token      p { '*'+ }
      my token      t { <[\w _]>+ }
      my rule    type { 'const'? $<n>=\w+ <p>? }
      my rule     var { <t> }
      my rule returns { :!s 'const '? <t> \s* <p>? }

      my rule func_def {
        <returns>
        $<sub>=[ \w+ ]
        [
          '(void)'
          |
          '(' [ <type> <var> ]+ % [ \s* ',' \s* ] ')'
        ]
        (\s* (<[A..Z]>+)+ %% '_')?';'
      }
      my rule func_def_noav {
        <func_def>
      }
      my rule func_def_av {
        <availability> <func_def>
      }

      my (@tv, $av);
      my $m = $bland ??
        $fd ~~ /<func_def_noav>/
        !!
        $fd ~~ /<func_def_av>/;
      if $m.defined {
        $m  = $bland ?? $m<func_def_noav> !! $m<func_def_av>;
        $av = $bland ?? {} !! $m<func_dev_av><availability>;
      }
      if $m {
        my $avail = ($av<ad> // '') ne 'DEPRECATED';
        my @p;
        my $orig = $m<func_def><sub>.Str.trim;
        my @tv = ($m<func_def><type> [Z] $m<func_def><var>);

        @p.push: [ $_[0], $_[1] ] for @tv;

        my @v = @p.map({ '$' ~ $_[1]<t>.Str.trim });
        my @t = @p.map({
          my $t = $_[0]<n>.Str.trim;
          if $_[1]<p> {
            $t = "CArray[{ $t }]" for ^($_[1]<p>.Str.trim.chars - 1);
          }
          $t;
        });
        my $o_call = (@t [Z] @v).join(', ');

        if $attr && $static.not {
          @v.shift if +@v;
          @t.shift if +@t;
        }

        my $sig = (@t [Z] @v).join(', ');
        my $call = @v.map( *.trim ).join(', ');
        my $sub = $m<func_def><sub>.Str.trim;

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
          call_types => @t
        };

        #my $p = 1;

        # This will eventually go into a separate CompUnit
        my $p6r = do given $h<returns><t>.Str.trim {
          when 'gpointer' {
            'Pointer';
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
      } else {
        $*ERR.say: "Function definition finished, but detected no match: \n'$fd'";
      }
      $fd = '';
      $la = False;
    }
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
    say "\nGETSET\n------";
    for %getset.keys.sort -> $gs {

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

       say qq:to/SUB/;
       $subcall
         returns $m<p6_return>
         is native({ $lib })
         is export
         \{ * \}
       SUB

    }  else {

      say qq:to/SUB/;
      $subcall
        is native({ $lib })
        is export
        \{ * \}
      SUB

    }
  }



  say "\nMETHODS\n-------";
  if %do_output<all> || %do_output<methods> {
    for %methods.keys.sort -> $m {
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
    outputSub( %methods{$_} )     for %methods.keys.sort;
    outputSub( %getset{$_}<get> ) for  %getset.keys.sort;
    outputSub( %getset{$_}<set> ) for  %getset.keys.sort;
  }

  for %collider.pairs.grep( *.value > 1 ) -> $d {
    $*ERR.say: "DUPLICATES\n----------" if !$++;
    $*ERR.say: "$d";
  }

}
