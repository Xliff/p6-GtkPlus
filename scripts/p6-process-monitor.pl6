use v6.c;

use Terminal::Print <T>;

my %procs = (
  running => {},
  started => {},
  exited  => {},
);
my ($int, $l);

my grammar ProcGrammar {
  rule TOP {
    <procline>+
  }
  rule procline {
    <time> <event> <pid> <info>? <duration>? <process>
  }
  rule time {
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
  rule process {
    .+? $$
  }
}

class ProcGrammarActions {
  # Action classes should use $/ is copy as parameter if performing further
  # match operations.
  method procline($/ is copy) {
    my $pid = $/<pid>.Str.trim.Int;
    my $event = $/<event>.Str.trim;
    my $time = $/<time>.Str.trim;
    my $process = $/<process>.Str.trim;

    given $event.trim {
      when 'fork' | 'exec' | 'clone' {
        # cw: Replace this filter with one of your own!
        my $process-shortname = do given $process {
          when  / 'rakudobrew/bin/perl6' / {
            .split(/ \s+ /)[*-1] // 'Unknown P6 code'
          }
          when / 'rakudobrew/moar-master/install/bin/moar' / {
            / '(' ( (\w+)+ %% '::' ) ')' / ??
              $/[0].Str
              !!
              (.split(/ \s+ /)[*-1] // 'Unknown moar executable')
          }
          default {
            .split(/ \s+ /)[*-1];
          }
        }
        unless %procs<running>{$pid}:exists or %procs<started>{$pid}:exists {
          %procs<started>{$pid} = {
            pid     => $pid,
            process => $process-shortname,
            time    => $time
          };
        }
      }
      when 'exit' {
        %procs<exited>{$pid} = 1;
      }
    }
  }
}

sub mq($c, $r, $s, $chr = '=') {
  T.print-string($c,      $r, $s);
  T.print-string($c,  $r + 1, $chr x $s.chars);
}

sub showHeader {
  my $t = DateTime.now;
  T.clear-screen;
  T.print-string(
    0,
    0,
    "Checking GTK-Plus Processes every { $int } seconds"
  );
  T.print-string(T.columns - $t.Str.chars - 2, 0, $t.Str);
  $*row = 2;
  mq( 0, $*row, 'PID');
  mq(10, $*row, 'Time');
  mq(20, $*row, 'Process');
}

sub checkRunningProcs {
  my @rp = %procs<running>.keys;
  for @rp {
    %procs<running>{$_}:delete unless "/proc/{$_}".IO.d;
  }
}

sub displayProcesses {
  state $c = 0;
  $*row++;
  %procs<running>.append: %procs<started>.pairs if %procs<started>.elems;
  for %procs<running>.keys.sort {
    T.print-string(0, ++$*row, $_);
    T.print-string(10,  $*row, %procs<running>{$_}<time>);
    T.print-string(20,  $*row, %procs<running>{$_}<process> // 'Undefined');
  }
  $l.protect({
    for %procs<exited>.keys {
      %procs.<running>{$_}:delete;
    }
    %procs<started> = {};
    %procs<exited> = {};
  });
  checkRunningProcs unless $c++ % 3;
}

sub processList {
  my $*row;
  showHeader;
  displayProcesses if %procs<running>.elems || %procs<started>.elems;
}

sub MAIN (Int :$interval = 3) {
  my $proc = Proc::Async.new: :r, <forkstat -e exec,exit -l>;
  $int = $interval;
  T.initialize-screen;
  $l = Lock.new;

  $*SCHEDULER.cue(&processList, every => $int);
  react {
    # split input on \r\n, \n, and \r
    whenever $proc.stdout.lines {
      ProcGrammar.parse( $_, actions => ProcGrammarActions );
    }
    whenever $proc.start {
        say ‘Proc finished: exitcode=’, .exitcode, ‘ signal=’, .signal;
        # gracefully jump from the react block
        done
    }
    whenever signal(SIGTERM) | signal(SIGINT) {
      once {
        T.shutdown-screen;
        # sends SIGHUP, change appropriately
        $proc.kill;
      }
    }
  }
}
