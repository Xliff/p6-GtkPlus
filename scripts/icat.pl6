#!p6gtkexec -Iscripts
use v6;

use GTKScripts;

%config<include-directory>.IO.add( @*ARGS.head ).IO.slurp.say;
