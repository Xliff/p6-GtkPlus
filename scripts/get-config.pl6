#!/usr/bin/env raku

use lib <. scripts>;

use ScriptConfig;
#

sub MAIN ($entry) {
  say getConfigEntry($entry);
}
