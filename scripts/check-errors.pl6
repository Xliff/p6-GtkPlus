#!/usr/bin/env raku

my $max-chars = %*ENV<PROJECTS>.words.map( *.chars ).max;

for %*ENV<PROJECTS>.words {
  my $errors = "{$*HOME}/Projects/p6-{ $_ }/LastBuildResults";
  $errors = "{$*HOME}/Projects/raku-{$_}/LastBuildResults" unless $errors.IO.e;

  my $sorry = $errors.IO.slurp ~~
    #m:g/'SORRY!' .+?"\n"(.+)"\n" /;
    m:g/'SORRY!'/;

  print .fmt("%-{ $max-chars + 2 }s");
  print " - { $sorry.elems }" if $sorry;
  print "\n";
}
