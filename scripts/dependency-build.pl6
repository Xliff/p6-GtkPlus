#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;
use Dependency::Sort;

constant DEFAULT_MAX_THREADS = %*ENV<P6_GLIB_CONCURRENCY_LEVEL> //
                               $*KERNEL.cpu-cores;

my (%nodes, @threads);

sub space($a) {
  ' ' x ($a.chars % 8);
}

my atomicint $c = 1;

sub MAIN (
  :$force,                                          #= Force dependency generation
  :$prefix          is copy,                        #= Module prefix
  :$start-at,
  :$log                      = True,
  :$no-save                  = False,
  :$variant         is copy  = '',
  :$max-concurrency          = DEFAULT_MAX_THREADS
) {
  my @build-exclude;
  my $dep_file = '.build-deps'.IO;

  sub writeLog {
    if $*name && $log && $no-save.not {
      'stats'.IO.add($*name).spurt($*LOG);
      # Also write to the historical default for error checking purposes!
      $*CWD.add(
        ($log ~~ Bool && $log) ?? 'LastBuildResults' !! $log
      ).spurt($*LOG);
    }
  }

  if $CONFIG-NAME.IO.e {
    parse-file;
    $prefix        = %config<prefix>;
    @build-exclude = %config<build_exclude>;
  }

  {
    my $*name;

    sub waitForThreads {
      await Promise.anyof(@threads);
      #exit 1 if @threads.grep({ .status ~~ Broken });
      @threads .= grep({ .status ~~ Planned });
    }

    signal($_).tap({ writeLog; exit }) for SIGINT, SIGTERM;

    my ($buildList) = compute-module-dependencies(get-module-files);
    $buildList      = $buildList.map( *<name> ).cache.Array;
    my $build-count = $buildList.elems;
    my $*ERROR      = False;
    my $*SKIP       = $start-at ??
      ( $start-at.Int ~~ Failure ??
        do {
          my $i = $buildList.first($start-at, :k);
          unless $i {
            my @c = $buildList.map({ $_ => levenshtein($_, $start-at).abs })
                              .sort( *.value );
            my $cm = @c[0] .key;

            die "Could not find module '$start-at' did you mean '{$cm}'!"
              unless $i;
          }
          $i.say;
          $i;
        }
        !!
        $start-at
      )
      !!
      0;
    my $remaining = $buildList.elems - $*SKIP;

    my ($*I, $*LOG, $start, $idx) = (0, '', DateTime.now, 0);
    output(
      "Parallel build started for Raku { $*RAKU.compiler.version } on MoarVM {
       $*VM.version }"
    );
    while +$buildList && $*ERROR.not {
      my $n = $buildList.shift;

      # Wait out jobs until the next set of dependencies are cleared.
      while %nodes{$n}<edges> && @threads.elems {
        await Promise.anyof(@threads);
        @threads .= grep({ .status ~~ Planned });
        say "W: »»»»»»»»»»»»»» { @threads.elems }";
      }

      # If no more compile jobs and still dependencies, then something is
      # very wrong!
      if %nodes{$n} && %nodes{$n}<edges>.elems && !@threads {
        $buildList.unshift: $_ for %nodes{$n}<edges>[];
        %nodes{$n}<recompiles>++;
        my $remaining-nodes = %nodes{$n}<edges>.join(', ');
        if (%nodes{$n}<recompiles> // 0) < 5 {
          say "Attempting to recompile missed dependencies for $n:\n{
                $remaining-nodes }";
        } else {
          die "Could not satisfy dependencies for {
               $n }. The following compunits would not compile {
               $remaining-nodes }";
        }
      }

      # Start threads until we have a blocker...or we run out of threads.
      if !%nodes{$n} || %nodes{$n}<edges>.elems.not {
        say "A ({ $n }): »»»»»»»»»»»»»» { @threads.elems + 1 } R: { --$remaining }";
        my $t = start { run-compile($n, $t, $build-count) }
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
                              ~ now.DateTime.yyyy-mm-dd.subst('-', '', :g);
    }

    $*name = getName;
    if $*name.IO.e {
      if $*name ~~ /'ParallelBuildResults-' [ ( \w ) + '-' ]? \d+/ {
        $variant = $0 ?? $0.Str.succ !! 'a';
      }
      $*name = getName;
    }

    LEAVE writeLog;
  }
}

sub run-compile ($module, $thread, $num = 0) {
  if ++$*I > $*SKIP {
    my $cs = DateTime.now;
    # cw: get-config handles default values.
    my $exec = qqx{scripts/get-config.pl6 exec}.chomp;
    my $proc = run "./{ $exec }", '-e',  "use $module", :out, :err;
    #my $proc = run "./p6gtkexec", '-e',  "use $module", :out, :err;

    say (my $err = $proc.err.get).slurp if $proc.exitcode;

    output(
      $module,
      $num,
      $proc.out.slurp                           ~ "\n" ~
      $proc.err.slurp                           ~ "\n" ~
      "{ $module } compile time: { DateTime.now - $cs }"
    ) if $*ERROR.not or $proc.exitcode;
  }

  if %nodes{$module} {
    #say "Checking { $module }...";
    for %nodes{$module}<kids>[] {
      # Mute all until we are sure there are no more Nils!
      quietly {
        next unless [&&](
          $_,
          %nodes{$_},
          %nodes{$_}<edges>:exists
        );
        prune($_, $module);
      }
    }
  }
}

my $lock = Lock.new;
multi sub output ($data) {
  $*LOG ~= "\n";
  ($*LOG ~= $data).say;
  $*LOG ~= "\n";
}

multi sub output ($module, $n, $data) {
  $lock.protect({
    say ($*LOG ~= " === {$module} ({$c⚛++}/{$n}) === ") if $module;
    output($data);
  });
}


my $lock2 = Lock.new;
sub prune ($_, $module) {
  state %locks;

  $lock2.protect({ %locks{$_} //= Lock.new });
  %locks{$_}.protect({
    # Prunning should be behind a lock as well!
    #say "Pruning {$node}...";
    %nodes{$_}<edges> .= grep({ $_ ne $module });
  });
}
