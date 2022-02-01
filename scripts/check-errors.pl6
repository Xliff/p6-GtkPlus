#!/usr/bin/env raku

my $max-chars = %*ENV<PROJECTS>.words.map( *.chars ).max;

for %*ENV<PROJECTS>.words {
  my $errors = "{$*HOME}/Projects/p6-{ $_ }/LastBuildResults".IO.slurp ~~
    #m:g/'SORRY!' .+?"\n"(.+)"\n" /;
    m:g/'SORRY!'/;

  print .fmt("%-{ $max-chars + 2 }s");
  print " - { $errors.elems }" if $errors;
  print "\n";
}
