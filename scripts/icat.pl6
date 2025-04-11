#!p6gtkexec -Iscripts
use v6;

use ScriptConfig;
use GTKScripts;

my $f = @*ARGS.head;

my $fio;

if $f.starts-with('/') {
  $fio = $f.IO;
} else {
  for %config<include-directory>[] {
    $fio = ($_ ~ '/' ~ $f).IO;
    last if $fio.r;
  }
}

if $fio.r {
	$fio.slurp.say;
} else {
	$*ERR.say: "File does not exist!"
}
