#!/usr/bin/env perl6
use v6.d;

use lib 'scripts';

use GTKScripts;

parse-file(CONFIG-NAME) if CONFIG-NAME.IO.e;

for %config<backups>.Array {
  my $proc = Proc::Async.new( |<git push>, $_ );
  $proc.stdout.tap(-> $o { $o.say; });
  await $proc.start;
}
