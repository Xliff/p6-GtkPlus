#!/usr/bin/env perl6
use v6;

sub MAIN ($filename) {
  my $c = $filename.IO.slurp;
  my (@get, @set);

  my $m = $c ~~ m:g/"method get_" (.+?) \s* <[({]>/;
  @get.push: .[0].Str for $m.Array;

  $m = $c ~~ m:g/"method set_" (.+?) \s* <[({]>/;
  @set.push: .[0].Str for $m.Array;

  my @getset = do gather for @get.unique {
    take .Str if $_ eq @set.any
  };

  say "  method { $_ } is rw \{\n  \}\n" for @getset.sort
}
