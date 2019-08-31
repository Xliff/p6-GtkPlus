#!/usr/bin/env perl6

use File::Find;

my token mod   { [\w+]+ %% '::' }
my rule  uses  { 'use' <mod>    }
my token m-new { <mod> '.new'   }
my rule class  { 'class' <mod>  }

sub get-list ($match, $token) {
  do {
    gather for $match.Array {
      take .{$token}<mod> => 1 if .{$token}
    }
  }
}

sub mq($s) {
  say $s;
  say '=' x $s.chars;
}

sub MAIN (:$filename, :$prefix is required) {

  my @files = $filename ??
    $filename.Array
    !!
    find
      dir => 'lib',
      exclude => / '.touch' | 'Raw' /,
      name => /'.pm6' $/;

  for @files {
    my $contents = .IO.slurp;
    my $uses  = $contents ~~ m:g/ <uses>  /;
    my $m-new = $contents ~~ m:g/ <m-new> /;
    my $class = $contents ~~ m:g/ <class> /;

    my %u  = get-list($uses,  'uses');
    my %mn = get-list($m-new, 'm-new');
    my %c  = get-list($class, 'class');

    my @missing;

    for %mn.keys.sort -> $k {
      next unless $k.starts-with($prefix);
      next if %c{$k}:exists;
      unless %u{$k}:exists {
        @missing.push: "use $k;";
      }
    }

    if @missing {
      mq("\nUse statements missing in $_:");
      .say for @missing;
    }

  }

}
