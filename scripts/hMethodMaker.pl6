use v6.c;

use Data::Dump::Tree;

sub MAIN ($filename) {
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

    #say "FD[{ $i++ }]: $fd";

    if $fd && $fd ~~ /';'$$/ {
      my rule func_def {
        $<returns>=[ \w+ [ '*'+ ]? ]
        $<sub>=[ \w+ ]
        [
          '(void)'
          |
          '('
            [
              $<type>=[ 'const'? \w+ ]
#             $<var>=[ '*'? \w <+[\w \d _]>+ ]
              $<var>=[ ['*'+]? <[ \w _ ]>+ ]
            ]+ % [ ',' \s* ]
#           [','\s*'...']?
          ')'
        ]
        #[ <[ A..Z _ ]>+ ]?';'
      }

      if $fd ~~ /<func_def>/ {
        my @p;

        my @tv = ($/<func_def><type> [Z] $/<func_def><var>);
        #say dump @tv;

        @p.push: [ $_[0], $_[1] ] for @tv;

        my $h = {
          returns => $/<func_def><returns>,
            'sub' => $/<func_def><sub>,
           params => @p
        };

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
    if $d<sub> ~~ / '_' ( [ 'get' || 'set' ] ) '_' ( .+ ) / {
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
        %methods{%getset{$gs}<set><sub>} = %getset{$gs}<set>
      }
      %getset{$gs}:delete;
    }
  }

  say "\nGETSET\n------";
  dump %getset;

  say "\nMETHODS\n-------";
  dump %methods;



}
