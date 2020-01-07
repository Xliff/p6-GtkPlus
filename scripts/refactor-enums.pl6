#!/usr/bin/env perl6
use v6.c;

use lib 'lib';
use lib 'scripts';

use GTKScripts;

sub MAIN ($module) {
  use Pango::Raw::Enums;
  my @enums <== $_ for Pango::Raw::Enums::EXPORT::DEFAULT::.values
                                                     .grep( * ~~ Enumeration )
                                                     .map({
                                                        my $n = .^name;
                                                        $n ~~ s/'Enums'$//;
                                                        $n;
                                                      })
                                                     .unique;

  my $maxsize = @enums.map( *.chars ).max;
  say 'Searching for:';
  for @enums.rotor( 60 / $maxsize, :partial ) {
    print "\t| { .fmt("%-{$maxsize}s") } " for $_;
    say '|';
  }

  for get-module-files() {
    (my $contents = .slurp) ~~ s:g/( @enums )'('/{ $0 }Enum(/;

    .rename("{ $_ }.ref-bak");
    .spurt($contents);
  }
}
