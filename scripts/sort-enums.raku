#!/usr/bin/env raku

use lib <scripts .>;

use GTKScripts;

my rule enumBlock {
  'constant' (\w+) 'is export :=' (\w+)';'
  'our enum' (\w+)' is export' <[(<]>
     .+?
  <[>)]>';'
}

sub MAIN (
  $filename = "lib/{ %config<prefix> }/Raw/Enums.pm6"
) {
  my $fio = $filename.IO;
  die "Could not find { $filename }!" unless $fio.r;

  my $contents = $fio.slurp;

  $filename.IO.rename($filename ~ '.enum-sort.bak');

  my $m = $contents ~~ m:g/<enumBlock>/;

  $m = $m.reverse.cache.Array;

  my @sorted-m = $m[].sort(-> $a, $b {
    $b<enumBlock>[0].Str.lc cmp $a<enumBlock>[0].Str.lc
  });

  for @sorted-m.kv -> $k, $v {
    #say "{ $k }: { .from } - { .to }" given $m[$k]<enumBlock>;

    my $r := $contents.substr-rw(
      $m[$k]<enumBlock>.from,
      $m[$k]<enumBlock>.to - $m[$k]<enumBlock>.from
    );

    $r = $v.Str;
  }

  $filename.IO.spurt: $contents;
}
