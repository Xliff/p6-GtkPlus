use v6.c;

use Grammar::Tracer;
use Data::Dump::Tree;

my %procs = (
  running => {},
  started => {},
  exited  => {},
);
my $int;

my grammar ProcGrammar {
  rule TOP {
    <procline>+
  }
  rule procline {
    <time> <event> <pid> <info>? <duration>? <process>
  }
  token time {
    (\d+)+ %% ':'
  }
  rule event {
    'fork' | 'exec' | 'clone' | 'exit'
  }
  rule pid {
    \d+
  }
  rule info {
    '0' | 'parent' | 'child' | 'thread'
  }
  rule duration {
    \d+ '.' \d+['s' | 'm' | 'h' | 'd']
  }
  regex process {
    .+? $$
  }
}

class ProcAction {
  method procline($/) {
    my $pid = $/<pid>.Str.trim.Int;
    my $event = $/<event>.Str.trim;
    my $time = $/<time>.Str.trim;

    # cw: Replace this filter with one of your own!
    if $/<process> ~~ / 'moar' | 'perl6' / {
      given $event.trim {
        when 'fork' | 'exec' | 'clone' {
          unless %procs<running>{$pid}:exists or %procs<started>{$pid}:exists {
            %procs<started>{$pid} = {
              pid     => $pid,
              process => $/<process>.made,
              time    => $time
            };
          }
        }
        when 'exit' {
          %procs<ended>{$pid} = 1;
        }
      }
    }
  }
  method process($/) {
    my $proc = $/.Str.trim;
    make $proc.Str.split(/ \s+ /)[*-1];
  }
}

my $procstr = qq:to/PROC/;
13:43:17 exec   6000                 /home/cbwood/Projects/rakudobrew/moar-master/install/bin/moar --execname=/home/cbwood/Projects/rakudobrew/bin/../moar-master/install/bin/perl6 --libpath=/home/cbwood/Projects/rakudobrew/moar-master/install/share/nqp/lib --libpath=/home/cbwood/Projects/rakudobrew/moar-master/install/share/nqp/lib --libpath=/home/cbwood/Projects/rakudobrew/moar-master/install/share/perl6/lib --libpath=/home/cbwood/Projects/rakudobrew/moar-master/install/share/perl6/runtime /home/cbwood/Projects/rakudobrew/moar-master/install/share/perl6/runtime/perl6.moarvm --stagestats -Ilib -e use GTK::Roles::Orientable
PROC

my $pg = ProcGrammar.parse($procstr, actions => ProcAction);
ddt $pg;
ddt %procs;
