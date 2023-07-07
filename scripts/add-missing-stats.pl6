#!/usr/bin/env raku

use v6;

my @stats-files = 'stats'.IO.dir( test => / '2022' \d ** 4 $/ )
                            .sort( *.basename );

my rule version-stamp {
  [
    "Build started for:" \s* 'Welcome to Rakudo™' ('v2022' .+? '.')
    |
    'Parallel build started for Raku' (<[0..9a..g\.']>+) 'on'
  ]
}

my %date-version-stamp;
my @commit-files = gather for @stats-files {
  my $p = run :!out, «git ls-files --error-unmatch { .Str }»;
  unless $p.exitcode {
    say "Skipping { .Str } because it is already being tracked!";
    next
  }

  my $ds = .basename.substr(* - 8);
  print "Checking for version stamp in { .basename }... ";
  my $contents = .slurp;

  unless %date-version-stamp{$ds} {
    unless $contents ~~ / <version-stamp> / {
      say 'skipping, since no stamp found!';
      next;
    }
  }

  my $version = %date-version-stamp{$ds} // $/<version-stamp>[0].Str;
  $version .= chop if $version.ends-with('.');
  %date-version-stamp{$ds} //= $version;
  say "found { $version }";
  take [$_, $version];
}

for @commit-files {
  say "Adding { .head.Str }";
  qqx«git add { .head.Str }»;
  my $p = .head.basename.starts-with('Parallel');
  my $m = "Build Results for Rakudo { .tail }";
  $m = "Parallel $m" if $p;
  qqx«git commit -m '- { $m }'»;
}
