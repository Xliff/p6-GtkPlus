#!p6gtkexec -Iscripts
use v6;

use GTKScripts;

my $f = @*ARGS.head;
$f = %config<include-directory>.IO.add($f) unless $f.starts-with('/');
$f.IO.slurp.say;
