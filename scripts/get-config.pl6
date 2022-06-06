#!/usr/bin/env raku

use lib <. scripts>;

use GTKScripts;

sub MAIN ($entry) {
  say getConfigEntry($entry);
}
