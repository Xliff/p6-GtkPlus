use v6.c;

use Data::Dump::Tree;

my $prechop = 11;

sub MAIN ($filename, :$remove) {
  die "Cannot fine '$filename'\n" unless $filename.IO.e;

  my $contents = $filename.IO.open.slurp-rest;

  my $la;
  my $fd;
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

    if $fd && $fd ~~ /';'$$/ {
      my token   p { '*'+ }
      my rule type { 'const'? \w+ }
      my rule  var { <p>?$<t>=[ <[\w _]>+ ] }

      my rule func_def {
        $<returns>=[ $<t>=\w+ <p>? ]
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

        #dump $h;

        @detected.push: $h;
      } else {
        say "Function definition finished, but detected no match: \n'$fd'";
      }
      $fd = '';
      $la = False;
    }
  }

  my %methods;
  my %getset;
  for @detected -> $d {
    if $d<returns><p> {
      $d<returns> = "CPointer[{ $d<returns><t>.Str.trim }]"
        for ^($d<returns><p>.Str.trim.chars - 1);
    }

    # Convert signatures to perl6.
    #
    #$d<sub> = substr($d<sub>, $prechop);
    if $d<sub> ~~ / ( [ 'get' || 'set' ] ) '_' ( .+ ) / {
      %getset{$/[1]}{$/[0]} = $d;
    } else {
      %methods{$d<sub>} = $d;
    }
  }

  for %getset.keys -> $gs {
    unless
      %getset{$gs}<get>                     &&
      %getset{$gs}<get><params>.elems == 1  &&
      %getset{$gs}<set>                     &&
      %getset{$gs}<set><params>.elems == 2
    {
      say "Removing non-conforming get:set {$gs}...";
      if %getset{$gs}<get>.defined {
        %methods{%getset{$gs}<get><sub>} = %getset{$gs}<get>;
      }
      if %getset{$gs}<set>.defined {
        %methods{%getset{$gs}<set><sub>} = %getset{$gs}<set>;
      }
      %getset{$gs}:delete;
    }
  }

  my %collider;

  say "\nGETSET\n------";
  for %getset.keys -> $gs {

    my $s = %getset{$gs}<get><sub>;
    $s ~~ s/['get' | 'set']_//;
    %collider{$s}++;

    say qq:to/METHOD/;
      method { $s } is rw \{
        Proxy,new(
          FETCH => \{
            { %getset{$gs}<get><original> ~ '(' ~ %getset{$gs}<get><call> ~ ')' };
          \},
          STORE => \{
            { %getset{$gs}<set><original> ~ '(' ~ %getset{$gs}<set><call> ~ ')'};
          \}
        );
      \}
    METHOD

  }

  say "\nMETHODS\n-------";
  for %methods.keys -> $m {
    %collider{ %methods{$m}<sub> }++;
    say qq:to/METHOD/;
      method { %methods{$m}<sub> } { '(' ~ %methods{$m}<sig> ~ ')' } \{
        { %methods{$m}<original> }({ %methods{$m}<call> });
      \}
    METHOD

  }

  say "\nNC DEFS\n------";
  for %getset.keys -> $gs {

    # TODO -- Test routine name between:
    #  gtk_<klass>_  [gtk-3]     AND
    #  gtk_          [gtk-3]     AND
    #  g_            [glib-2.0]
    # and emit the proper library.

    say qq:to/SUBS/;
      sub %getset{$gs}<get><sub> { '(' ~ %getset{$gs}<get><sig> ~ ')' }
        is native('gtk-3')
        is export
        \{ * \}

      sub %getset{$gs}<get><sub> { '(' ~ %getset{$gs}<get><sig> ~ ')' }
        is native('gtk-3')
        is export
        \{ * \}
    SUBS

  }

  for %methods.keys -> $m {

    say qq:to/SUB/;
      sub %methods{$m}<original> { '(' ~ %methods{$m}<sig> ~ ')' }
        is native('gtk-3')
        is export
        \{ * \}
    SUB

  }

  for %collider.pairs.grep( *.value > 1 ) -> $d {
    say "DUPLICATES\n----------" if !$++;
    say $d.key;
  }

}
