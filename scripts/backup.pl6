#!/usr/bin/env perl6
use v6.d;

use lib 'scripts';

use GTKScripts;

my @valid-backups = qqx{git remote}.lines;
if CONFIG-NAME.IO.e {
  parse-file(CONFIG-NAME);
  if %config<backups> {
    for %config<backups>.Array {
      next unless $_ eq @valid-backups.any;
      my $proc = Proc::Async.new( |<git push>, $_ );
      $proc.stdout.tap(-> $o { $o.say; });
      await $proc.start;
    }
  } else {
    say 'No backup repositories specified in config!';
  }
}
unless %config<backups> {
  if @valid-backups.any eq 'backup' {
    my $proc = Proc::Async.new( |<git push backup> );
    $proc.stdout.tap(-> $o { $o.say; });
    await $proc.start;
  } else {
    say 'No backup repository configured!';
  }
}
