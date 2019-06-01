#!/usr/bin/env perl6
use v6.c;

my $c = @*ARGS[0].IO.slurp;
$c ~~ m:g/^^ \s+ "# Is originally:" [ \s+ <-[\n]>+ ] ** 2/;
for $/ -> $k is rw {
  ($k .= Str) ~~ m:g/'method' \s* (<[\w\-]>+)/;
  my @s = gather for $/ -> $m1 {
    $m1.Array.map({ take .[0].Str })
  }
  .say for @s.sort;
}
