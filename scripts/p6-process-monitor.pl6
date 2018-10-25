use v6.c;

use Terminal::Print <T>;
use Data::Dump;

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
        $process ~~ m/ 'rakudobrew/bin/perl6' /;
        if $/.defined {
          unless %procs<running>{$pid}:exists or %procs<started>{$pid}:exists {
            "$pid $process".say;
            %procs<started>{$pid} = {
              pid     => $pid,
              process => $process.Str.split(/ \s+ /)[*-1],
              time    => $time
            };
          }
        }
      }
      when 'exit' {
        %procs<ended>{$pid} = 1;
      }
    }
  }
}

sub showHeader {
  my $t = DateTime.now;
  #T.clear-screen;
  T.print-string(
    0,
    0,
    "Checking GTK-Plus Processes every { $*i } seconds"
  );
  T.print-string(T.columns - $t.Str.chars - 2, 0, $t.Str);
  $*row = 2;
  T.print-string(0,  $*row, 'PID');
  T.print-string(0,  $*row + 1,  '===');
  T.print-string(10, $*row, 'Time');
  T.print-string(10, $*row + 1,  '====');
  T.print-string(20, $*row , 'Process');
  T.print-string(20, $*row + 1, '=======');
}

sub displayProcesses {
  $*row++;
  %procs<running>.append: %procs<started> if %procs<started>.elems;
  for %procs<runnng>.keys.sort {
    T.print-string(0, ++$*row, $_);
    T.print-string(10,  $*row, $_<time>);
    T.print-string(20,  $*row, $_<process>);
  }
  for %procs<exited> {
    %procs.<running>{$_}:delete;
  }
  %procs<exited> = {};
}

sub processList {
  my $*row;
  #showHeader;
  #displayProcesses if %procs<running>.elems;
  Dump %procs;
}

sub MAIN (Int :$interval = 3) {
  #T.initialize-screen;
  my $proc = Proc::Async.new: :r, <forkstat -e exec,exit -l>;
  my $*i = $interval;

  $*SCHEDULER.cue({ say "PROCESSING!"; processList }, every => $*i);
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
        #T.shutdown-screen;
        #say ‘Signal received, asking the process to stop’;
        $proc.kill; # sends SIGHUP, change appropriately
        # whenever signal($_).zip: Promise.in(2).Supply {
        #     say ‘Kill it!’;
        #     $proc.kill: SIGKILL
        # }
      }
    }
  }
}
