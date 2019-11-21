#!/usr/bin/env perl6
use v6;

use lib 'scripts';

use GTKScripts;

sub do-clean {
  # Add a confirmation check!
  .unlink for find-files( 'lib', extension => 'ref-bak' );
  say 'All refactor backup files have been removed.';
}

sub do-refactor (@replace, $delim) {
  for get-module-files() {
    my @newlines;
    for .lines -> $l {
      for @replace.map({ .split($delim) }) {
        $l.subst(/ <{ .[0] }> /, .[1], :global);
      }
      @newlines.push($l);
    }
    .rename( .extension('ref-bak') );
    .spurt( @newlines.join("\n") );
  }
}

sub MAIN (
  :@replace,            #= A replacement pair, given as <subst><delimeter><replace>.
                        #= Can be specified more than once.
  :$delimeter = ',',    #= The delimeter used by a replacement pair.
                        #= The default is ','
  :$clean               #= Clean the backup files produced by this script
) {
  my @mains = ('replace', 'clean');
  my $dieMsg = qq:to/DIE/;
    Must specify ONE of { @mains.map( '--' ~ * ).head(* - 1).join(', ')
    } or --{ @mains[* - 1] }
    DIE

  # There can be only one.
  die $dieMsg if     [&&](@replace, $clean);
  die $dieMsg unless [||](@replace, $clean);

  when    $clean { do-clean                          }
  default        { do-refactor(@replace, $delimeter) }
}
