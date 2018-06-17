use v6.c;

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
              $<type>=[ 'const'? \w+]
  #            $<var>=[ '*'? \w <+[\w \d _]>+ ]
              $<var>=[ ['*'+]? \w+ ]
            ]+ % [ ',' \s* ]
            [','\s*'...']?
          ')'
        ]
        [ <[ A..Z '_' ]>+ ]?';'
      }

      if $fd ~~ /<func_def>/ {
        my @p;

        @p.push: [ $/<func_def><type>[$_], $/<func_def><var>[$_] ]
          for (^$/<func_def><types>.elems);
        @detected.push: {
          returns => $/<func_def><returns>,
              sub => $/<func_def><sub>,
           params => @p
        };
      } else {
        say "Function definition finished, but detected no match: \n'$fd'";
      }
      $fd = '';
      $la = False;
    }
  }

  @detected.gist.say;
}
