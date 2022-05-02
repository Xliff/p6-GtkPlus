#!/usr/bin/env raku

sub MAIN (
  :$log = 'LastBuildResults'
) {

  my $max-chars = %*ENV<PROJECTS>.words.map( *.chars ).max;

  for %*ENV<PROJECTS>.words {
    my $lbr = "{$*HOME}/Projects/p6-{ $_ }/{ $log }".IO;
    unless $lbr.r {
      say "No build results for { $_ }. Skipping...";
      next;
    }

    my $errors = $lbr.slurp ~~
      #m:g/'SORRY!' .+?"\n"(.+)"\n" /;
      m:g/'SORRY!'/;

    print .fmt("%-{ $max-chars + 2 }s");
    print " - { $errors.elems }" if $errors;
    print "\n";
  }
}
