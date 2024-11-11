#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use ScriptConfig;
use GTKScripts;
use Dependency::Sort;

constant DEFAULT_MAX_THREADS = %*ENV<P6_GLIB_CONCURRENCY_LEVEL> //
                               $*KERNEL.cpu-cores;

my ($nodes, @threads, $tc);

sub space($a) {
  ' ' x ($a.chars % 8);
}

class ProcHolder {
  has $.num;
  has $.name;
  has $.timer;
  has $.thread;
}

my atomicint $c = 1;

my ($LOG, $runningLog);

sub MAIN (
  :$force,                                          #= Force dependency generation
  :$prefix          is copy  = %config<prefix>,     #= Module prefix
  :$start-at,
  :$log                      = True,
  :$no-save                  = False,
  :$variant         is copy  = '',
  :$max-concurrency          = DEFAULT_MAX_THREADS,
  :$date                     = DateTime.now.yyyy-mm-dd(''),
  :$rakuast                  = False
) {
  my @build-exclude;
  my $dep_file = '.build-deps'.IO;

  my $*rakast = $rakuast;

  my ($*I, $start, $idx) = (0, DateTime.now, 0);

  $runningLog = 'ParallelBuildResults'.IO.open(:w);

  signal($_).tap({ exit }) for SIGINT, SIGTERM;

  my @files = get-module-files.sort( *.modified );

  sub mod-to-file ($m) {
    my $l = $m.split('::').Array;
    $l.tail ~= '.pm6';

    my $f = 'lib'.IO;
    $f .= add($_) for $l[];
    $f;
  }

  # if %config<build-additional> {
  #   for %config<build-additional>[] {
  #     if .IO.slurp ~~ m:g/ <use-module> / {
  #       for $/[] {
  #         my $mod = .<use-module><modulename>.Str;
  #         @files.push: mod-to-file($mod.Str) unless $mod eq 'v6';
  #       }
  #     }
  #   }
  #   @files .= unique;
  # }

  my ($nodes, @others) = |compute-module-dependencies(@files).map( |* );

  my $build-count = $nodes.elems;
  my $*ERROR      = False;
  my $*SKIP       = $start-at ??
    ( $start-at.Int ~~ Failure ??
      do {
        my $i = $nodes.first($start-at, :k);
        unless $i {
          my @c = $nodes.map({ $_ => levenshtein($_, $start-at).abs })
                        .sort( *.value );
          my $cm = @c[0] .key;

          die "Could not find module '$start-at' did you mean '{$cm}'!"
            unless $i;
        }
        #$i.say;
        $i;
      }
      !!
      $start-at
    )
    !!
    0;

  my $remaining = $nodes.elems - $*SKIP;

  my $tc = Channel.new;

  $tc.send( ProcHolder.new( num => $_ ) ) for ^$*KERNEL.cpu-cores;

  output(
    "Parallel build started for Raku { $*RAKU.compiler.version } on MoarVM {
     $*VM.version }"
  );

  {
    my $*name;

    sub waitForThreads {
      await Promise.anyof(@threads);
      #exit 1 if @threads.grep({ .status ~~ Broken });
      @threads .= grep({ .status ~~ Planned });
    }

    WHILE: while $nodes.elems && $*ERROR.not {
      my $node = $nodes.shift;
      my $n    = $node<name>;

      if $n.contains('::Deprecated::') {
        $c⚛++;

        next WHILE
      }

      # Wait out jobs until the next set of dependencies are cleared.
      while $node<edges> && @threads.elems {
        await Promise.anyof(@threads);
        @threads .= grep({ .status ~~ Planned });
        say "W: »»»»»»»»»»»»»» { @threads.elems }";
      }

      # If no more compile jobs and still dependencies, then something is
      # very wrong!
      if $node && $node<edges>.elems && !@threads {
        $nodes.unshift: $_ for $node<edges>[];
        $node<recompiles>++;
        my $remaining-nodes = $node<edges>.join(', ');
        if ($node<recompiles> // 0) < 5 {
          say "Attempting to recompile missed dependencies for $n:\n{
                $remaining-nodes }";
        } else {
          die "Could not satisfy dependencies for {
               $n }. The following compunits would not compile {
               $remaining-nodes }";
        }
      }

      # Start threads until we have a blocker...or we run out of threads.
      if !$node || $node<edges>.elems.not {
        say "A ({ $n }): »»»»»»»»»»»»»» { @threads.elems + 1 } R: {
             --$remaining }";
        my $np = $tc.receive;
        my $t = start { run-compile($n, $t, $nc, $build-count) }
        @threads.push: $t;
      }

      # Wait until we free up some threads.
      if +@threads >= $max-concurrency {
        await Promise.anyof(@threads);
        @threads .= grep({ .status ~~ Planned });
        say "C: »»»»»»»»»»»»»» { @threads.elems }";
      }

    }

    # Take care of any remaining threads.
    await Promise.allof(@threads);

    # Note total compile time.
    output("Errors detected!") if $*ERROR;
    output("Total compile time: { DateTime.now - $start }s");

    sub getName {
      'ParallelBuildResults-' ~ ( $variant ?? "{ $variant }-" !! '' )
                              ~ $date;
    }

    $*name = getName;
    if $*name.IO.e {
      if $*name ~~ /'ParallelBuildResults-' [ ( \w ) + '-' ]? \d+/ {
        $variant = $0 ?? $0.Str.succ !! 'a';
      }
      $*name = getName;
    }
  }
}

my $ERROR;
sub run-compile ($module, $thread, $ph, $num = 0) {
  if ++$*I > $*SKIP {
    my $cs = DateTime.now;

    $ph.name   = $module;
    $ph.timer  = Supply.interval(1).tap: {
      heartbeat($ph.num, $_);
    }
    $ph.thread = $thread;

    # cw: get-config handles default values.
    my $exec = qqx{scripts/get-config.pl6 exec}.chomp;
    my $cmd = "use $module";
    $cmd = "use experimental :rakuast; { $cmd }" if $*rakuast;
    my $proc = run "./{ $exec }", '-e',  $cmd, :out, :err;
    #my $proc = run "./p6gtkexec", '-e',  "use $module", :out, :err;

    unless $ERROR {
      output(
        $module,
        $num,
        $proc.out.slurp( :close )                          ~ "\n" ~
        $proc.err.slurp( :close )                          ~ "\n" ~
        "{ $module } compile time: { DateTime.now - $cs }"
      );
    }

    if $proc.exitcode {
      $ERROR = True;
      .break for @threads;
      await Promise.allof(@threads);
    }

    $tc.send($ph)
  }


  if $nodes{$module} {
    #say "Checking { $module }...";
    for $nodes{$module}<kids>[] {
      # Mute all until we are sure there are no more Nils!
      quietly {
        next unless [&&](
          $_,
          $nodes{$_},
          $nodes{$_}<edges>:exists
        );
        prune($_, $module);
      }
    }
  }
}

my @locks = Lock.new xx 2;
multi sub output ($data) {
  @locks.head.protect: {
    my $saying = "\n{ $data }\n";

    .say($saying) for $*OUT, $runningLog;
  };
}

multi sub output ($module, $n, $data is copy) {
  @locks.tail.protect: {
    $data = " === {$module} ({$c⚛++}/{$n}) === \n{ $data }" if $module;
    output($data);
  };
}


my $lock2 = Lock.new;
sub prune ($_, $module) {
  state %locks;

  $lock2.protect({ %locks{$_} //= Lock.new });
  %locks{$_}.protect({
    # Prunning should be behind a lock as well!
    #say "Pruning {$node}...";
    $nodes{$_}<edges> .= grep({ $_ ne $module });
  });
}
