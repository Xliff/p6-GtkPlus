#!/usr/bin/env perl6
use v6.c;

use lib 'lib';
use lib 'scripts';

use GTKScripts;

sub MAIN {
  use GTK::Raw::Enums;

  my @enums <== $_ for GTK::Raw::Enums::EXPORT::DEFAULT::.values
                                                     .grep( * ~~ Enumeration )
                                                     .map({
                                                        my $n = .^name;
                                                        $n ~~ s/'Enum'$//;
                                                        $n;
                                                      })
                                                     .unique;

  my $maxsize = @enums.map( *.chars ).max;
  say 'Searching for:';
  for @enums.sort.rotor( 60 / $maxsize, :partial ) {
    print "\t| { .fmt("%-{$maxsize}s") } " for $_;
    say '|';
  }

  for get-module-files().sort {
    next if 'Raw' ∈ $*SPEC.splitdir( .dirname );

    print "Processing {$_} ...";
    if "{$_}.ref-bak".IO.e {
      say " already processed!";
      next;
    }
    (my $contents = .slurp) ~~ s:g/( @enums )'('/{ $0 }Enum(/;

    .rename("{ $_ }.ref-bak");
    .spurt($contents);
    say " processed in { DateTime.now - ENTER now }s";
  }
}
