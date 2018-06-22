use v6.c;

use Data::Dump::Tree;

my %do_output;

sub MAIN ($filename, :$remove, :$output = 'all') {
  die "Cannot fine '$filename'\n" unless $filename.IO.e;

  if $output ne 'all' {
    for $output.split(',') -> $o {
      die "Output can only be one of 'attributes', 'methods', 'subs' or 'all'"
        unless $o eq <all attributes methods subs>.any;
      %do_output{$o} = 1;
    }
  } else {
    %do_output<all> = 1;
  }

  my $contents = $filename.IO.open.slurp-rest;

  my $la;
  my $fd = '';
  my $i = 1;
  my @detected;
  for $contents.lines -> $l {
    if $l ~~ /^ 'GDK_' [ 'AVAILABLE' | 'DEPRECATED' ] '_'.+ / {
      $la = True;
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
      my rule returns { :!s <t> \s* <p>? }

      my rule func_def {
        <returns>
        $<sub>=[ \w+ ]
        [
          '(void)'
          |
          '(' [ <type> <var> ]+ % [ \s* ',' \s* ] ')'
        ]
        #[ <[ A..Z _ ]>+ ]?';'
      }

      my @tv;
      if $fd ~~ /<func_def>/ {

        my @p;
        my $orig = $/<func_def><sub>.Str.trim;
        my $mo = $/;
        my @tv = ($mo<func_def><type> [Z] $mo<func_def><var>);

        @p.push: [ $_[0], $_[1] ] for @tv;

        my @v = @p.map({ '$' ~ $_[1]<t>.Str.trim });
        my @t = @p.map({
          my $t = $_[0]<n>.Str.trim;
          if $_[1]<p> {
            $t = "CArray[{ $t }]" for ^($_[1]<p>.Str.trim.chars - 1);
          }
          $t;
        });

        my $call = @v.map( *.trim ).join(', ');
        my $sig = (@t [Z] @v).join(', ');
        my $sub = $mo<func_def><sub>.Str.trim;

        if $remove {
          unless $sub ~~ s/ $remove // {
            unless $sub ~~ s/ { $remove.split('_')[0] ~ '_' } // {
              $sub ~~ s/ 'g_' //;
            }
          }
        }

        my $h = {
          original => $orig.trim,
           returns => $mo<func_def><returns>,
             'sub' => $sub,
            params => @p,
              call => $call,
               sig => $sig
        };

        #my $p = 1;

        # This will eventually go into a separate CompUnit
        my $p6r = do given $h<returns><t>.Str.trim {
          when 'gpointer' {
            'OpaquePointer';
          }
          when 'va_list' {
            'OpaquePointer';
          }
          when 'gboolean' {
            'uint32';
          }
          when 'gchar' {
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
    if $d<sub> ~~ / ( [ 'get' || 'set' ] ) '_' ( .+ ) / {
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
          Proxy,new(
            FETCH => sub (\$) \{
              { %getset{$gs}<get><original> ~ '(' ~ %getset{$gs}<get><call> ~ ')' };
            \},
            STORE => -> sub (\$, { $sp } is copy) \{
              { %getset{$gs}<set><original> ~ '(' ~ %getset{$gs}<set><call> ~ ')'};
            \}
          );
        \}
      METHOD

    }
  }

  say "\nMETHODS\n-------";
  if %do_output<all> || %do_output<methods> {
    for %methods.keys.sort -> $m {

      say qq:to/METHOD/;
        method { %methods{$m}<sub> } { '(' ~ %methods{$m}<sig> ~ ')' } \{
          { %methods{$m}<original> }({ %methods{$m}<call> });
        \}
      METHOD

    }
  }

  if %do_output<all> || %do_output<subs> {
    for %methods.keys.sort -> $m {
      my $subcall = "sub %methods{$m}<original> (%methods{$m}<sig>)";

      if %methods{$m}<p6_return> && %methods{$m}<p6_return> ne 'void' {

         say qq:to/SUB/;
         $subcall
           returns %methods{$m}<p6_return>
           is native('gtk-3')
           is export
           \{ * \}
         SUB

      }  else {

          say qq:to/SUB/;
          $subcall
            is native('gtk-3')
            is export
            \{ * \}
          SUB

      }
    }
  }

  for %collider.pairs.grep( *.value > 1 ) -> $d {
    $*ERR.say: "DUPLICATES\n----------" if !$++;
    $*ERR.say: "$d";
  }

}
