#!/usr/bin/env perl6
use v6.d;

use lib 'scripts';

use GTKScripts;

if CONFIG-NAME.IO.e {
  parse-file(CONFIG-NAME);
  if %config<backups> {
    for %config<backups>.Array {
      my $proc = Proc::Async.new( |<git push>, $_ );
      $proc.stdout.tap(-> $o { $o.say; });
      await $proc.start;
    }
  }
}
unless %config<backups> {
  my $proc = Proc::Async.new( |<git push backup> );
  $proc.stdout.tap(-> $o { $o.say; });
  await $proc.start;
}
