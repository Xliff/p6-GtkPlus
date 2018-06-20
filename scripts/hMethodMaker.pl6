use v6.c;

use Data::Dump::Tree;

my $prechop = 11;

sub MAIN ($filename, :$remove, :$output = 'all') {
  die "Cannot fine '$filename'\n" unless $filename.IO.e;

  die "Output can only be one of 'attributes', 'methods', 'subs' or 'all'"
    unless $output eq <all attributes methods subs>.any;

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

    if $fd ~~ /';' [ \s* '//' \s* .+? ]? \s* $$/ {
      my token      p { '*'+ }
      my token      t { <[\w _]>+ }
      my rule    type { 'const'? \w+ }
      my rule     var { <p>?<t> }
      my rule returns { :!s <t> \s* <p>? }

      my rule func_def {
        <returns>
        $<sub>=[ \w+ ]
        [
          '(void)'
          |
          '(' [ <type> <var> ]+ % [ ',' \s* ] ')'
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
          my $t = $_[0].Str.trim;
          if $_[1]<p> {
            $t = "CArray[{ $t.Str.trim }]" for ^($_[1]<p>.Str.trim.chars - 1);
          }
          $t;
        });

        my $call = @v.join(', ');
        my $sig = (@t [Z] @v).map( *.join(' ') ).join(', ');
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

        my $p = 1;
        my $p6r = do given $h<returns><t>.Str.trim {
          when 'gboolean' {
            'uint32';
          }
          when 'gchar' {
            $p++;
            'Str'
          }
          default {
            $_;
          }
        }
        if $h<returns><p> {
          $p6r = "CPointer[{ $p6r }]" for ^($h<returns><p>.Str.trim.chars - $p);
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

  dump @detected;
  exit;

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

  exit;

  for %getset.keys -> $gs {
    if !(
      %getset{$gs}<get>                     &&
      %getset{$gs}<get><params>.elems == 1  &&
      %getset{$gs}<set>                     &&
      %getset{$gs}<set><params>.elems == 2
    ) {
      say "Removing non-conforming get:set {$gs}...";
      if %getset{$gs}<get>.defined {
        %methods{%getset{$gs}<get><sub>} = %getset{$gs}<get>;
        %collider{%getset{$gs}<get><sub>}++;
      }
      if %getset{$gs}<set>.defined {
        %methods{%getset{$gs}<set><sub>} = %getset{$gs}<set>;
        %collider{%getset{$gs}<set><sub>}++;
      }
      %getset{$gs}:delete;
    } else {
      %getset{$gs}<get><sub> ~~ s/['get' | 'set']_//;
      %collider{ %getset{$gs}<get><sub> }++;
    }
  }

  if $output eq <all attributes>.any {
    say "\nGETSET\n------";
    for %getset.keys -> $gs {

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

  if $output eq <all methods>.any {
    say "\nMETHODS\n-------";
    for %methods.keys -> $m {

      say qq:to/METHOD/;
        method { %methods{$m}<sub> } { '(' ~ %methods{$m}<sig> ~ ')' } \{
          { %methods{$m}<original> }({ %methods{$m}<call> });
        \}
      METHOD

    }
  }

  if $output eq <all subs>.any {
    say "\nNC DEFS\n------";
    for %getset.keys -> $gs {

      # TODO -- Test routine name between:
      #  gtk_<klass>_  [gtk-3]     AND
      #  gtk_          [gtk-3]     AND
      #  g_            [glib-2.0]
      # and emit the proper library.

      say qq:to/SUBS/;
        sub %getset{$gs}<get><original> { '(' ~ %getset{$gs}<get><sig> ~ ')' }
          returns %getset{$gs}<get><p6_return>
          is native('gtk-3')
          is export
          \{ * \}

        sub %getset{$gs}<set><original> { '(' ~ %getset{$gs}<set><sig> ~ ')' }
          is native('gtk-3')
          is export
          \{ * \}
      SUBS

    }
  }

  for %methods.keys -> $m {
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

  for %collider.pairs.grep( *.value > 1 ) -> $d {
    $*ERR.say: "DUPLICATES\n----------" if !$++;
    $*ERR.say: "$d";
  }

}
