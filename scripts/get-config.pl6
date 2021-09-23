#!/usr/bin/env raku

use lib <. scripts>;

use GTKScripts;

my %defaults = (
  exec => 'p6gtkexec'
);

sub MAIN ($entry) {
  die "Project configuration file '{ $CONFIG-NAME }' doesn't exist!"
    unless $CONFIG-NAME.IO.e;
  parse-file;

  say %config{$entry} // %defaults{$entry} // '';
}
