#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use ScriptConfig;
use GTKScripts;
use Dependency::Sort;

constant DEFAULT_MAX_THREADS = %*ENV<P6_GLIB_CONCURRENCY_LEVEL> //
                               $*KERNEL.cpu-cores;

my ($nodes, @threads, @broken, @free);

sub space($a) {
  ' ' x ($a.chars % 8);
}

my atomicint $c = 1;

my ($LOG, $runningLog);

sub checkForFreeThreads {
  @threads = gather for @threads {
    if .status ~~ Kept {
      .result.say;
      @free.push: $_;
    } elsif .status ~~ Planned {
      take $_;
    } else {
      @broken.push: $_;
    }
  }
}

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

  @free.push: [$_, Nil] for ^$max-concurrency;

  my ($*I, $start, $idx) = (0, DateTime.now, 0);

  $runningLog = 'ParallelBuildResults'.IO.open(:w);

  signal($_).tap({ exit }) for SIGINT, SIGTERM;

  my @files = get-module-files.sort( *.modified );

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

  output(
    :log,
    "Parallel build started for Raku { $*RAKU.compiler.version } on MoarVM {
     $*VM.version }"
  );

  {
    my $*name;

    sub waitForThreads {
      await Promise.anyof(@threads);
      #exit 1 if @threads.grep({ .status ~~ Broken });
      checkForFreeThreads;
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
        checkForFreeThreads;
        #say "W: »»»»»»»»»»»»»» { @threads.elems }";
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
        # say "A ({ $n }): »»»»»»»»»»»»»» { @threads.elems + 1 } R: {
        #      --$remaining }";
        die "No free threads encountered! That should not happen!";
          unless +@free;

        my $tt = @free.pop;
        $tt.tail = start { run-compile($n, $t, $build-count) }
        @threads.push: $tt
      }

      # Wait until we free up some threads.
      if +@threads >= $max-concurrency {
        await Promise.anyof(@threads);
        checkForFreeThreads;
        # say "C: »»»»»»»»»»»»»» { @threads.elems }";
      }

    }

    # Take care of any remaining threads.
    await Promise.allof(@threads);

    # Note total compile time.
    output("Errors detected!", :log) if $*ERROR;
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
sub run-compile ($module, $thread, $num = 0) {
  my $ct;

  if ++$*I > $*SKIP {
    my $cs = DateTime.now;
    # cw: get-config handles default values.
    my $exec = qqx{scripts/get-config.pl6 exec}.chomp;
    my $cmd = "use $module";
    $cmd = "use experimental :rakuast; { $cmd }" if $*rakuast;
    my $proc = run "./{ $exec }", '-e',  $cmd, :out, :err;
    #my $proc = run "./p6gtkexec", '-e',  "use $module", :out, :err;

    unless $ERROR {
      output(
        :log,
        $module,
        $num,
        $proc.out.slurp( :close )                          ~ "\n" ~
        $proc.err.slurp( :close )                          ~ "\n",
      );

      $ct = "{ $module } compile time: { DateTime.now - $cs }")
    }

    if $proc.exitcode {
      $ERROR = True;
      .break for @threads;
      await Promise.allof(@threads);
    }
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

  $ct;
}

my @locks = Lock.new xx 2;

#my $buffer = '';
multi sub output ($data, :$log = False) {
  @locks.head.protect: {
    my $saying = "\n{ $data }\n";

    # cw: Add to UI.
    #$buffer ~= $saying;
    $runningLog.say($saying);
  };
}

multi sub output (
   $module,
   $n,
   $data is copy,
  :$log  is required where *.so
) {
  @locks.tail.protect: {
    $data = " === {$module} ({$c⚛++}/{$n}) === \n{ $data }" if $module;
    output($data, :log);
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
