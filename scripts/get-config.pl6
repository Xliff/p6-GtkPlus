#!/usr/bin/env raku

use lib <. scripts>;

use ScriptConfig;
use GTKScripts;

sub MAIN ($entry) {
  say getConfigEntry($entry);
}
