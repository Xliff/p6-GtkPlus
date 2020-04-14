#!/usr/bin/env raku

sub MAIN ($filename) {
  my $contents = $filename.IO.slurp;

  $contents ~~ s:g/ ^^ ( \s* '$'.+? ' ??' .+? '!!' \s* ) \w+ ';'/$0Nil;/;

  $filename.IO.rename("{ $filename }.bak");
  $filename.IO.spurt($contents);
}
