use v6.c;

use File::Find;

my @files = find
  dir => "/proc",
  name => / \d+ $/,
  type => "dir",
  exclude => /
    "tty"  |  "fd" |  "map_files" |  "ns"   |  "lost+found" |
    "root" | "cwd" |  "net"       |  "task" |  "fs"         |
    "irq"  | "sys" |  "asound"    |  "bus"
  /;

for @files.sort({ .IO.dirname.split('/')[*-1] }) {
  my $c = "$_/cmdline".IO.open.slurp-rest;
  my $m = $c ~~ / ('GTK::' (\w+)+ % '::' | 'GTK.pm6') /;
  if $m {
    say "$_: { $/[0] }";
  } elsif $c ~~ / 'moar' / {
    say "$_: { $c.split("\0")[*-2] }";
  }
}
