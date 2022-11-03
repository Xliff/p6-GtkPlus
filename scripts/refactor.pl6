#!/usr/bin/env perl6
use v6;

use lib 'scripts';

use GTKScripts;

sub do-clean {
  # Add a confirmation check!
  .unlink for find-files( 'lib', extension => 'ref\-bak' );
  say 'All refactor backup files have been removed.';
}

sub do-refactor (@replace, $delim) {
  # First quote out all metachars in this version.
  @replace = @replace.split($delim);
  @replace[0].trans(
    [ ':' ] => [ '\\:' ],
    [ '-' ] => [ '\\-' ]
  );
  @replace[0] = rx/<{ @replace[0] }> /;

  for get-module-files() {
    .say;

    my $c = .IO.slurp;
    for @replace {
      $c.subst( .[0], .[1], :global );
    }

    .rename( .extension('ref-bak', :0parts) );
    .spurt($c);
  }
}

multi sub MAIN (:$clean is required) {
  do-clean;
}

multi sub MAIN (
  :@replace,            #= A replacement pair, given as <subst><delimeter><replace>.
                        #= Can be specified more than once.
  :$delimeter = ',',    #= The delimeter used by a replacement pair.
                        #= The default is ','
) {
  my @mains = <replace clean>;
  my $dieMsg = qq:to/DIE/;
    Must specify ONE of { @mains.map( '--' ~ * ).head(* - 1).join(', ')
    } or --{ @mains[* - 1] }
    DIE

  # There can be only one.
  die $dieMsg if     [&&](+@replace, $clean);
  die $dieMsg unless [||](+@replace, $clean);

  do-refactor(@replace, $delimeter);
}
