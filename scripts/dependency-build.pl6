#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;
use Dependency::Sort;

my (%nodes, @threads);

sub MAIN (
  :$force,            #= Force dependency generation
  :$prefix is copy,   #= Module prefix
  :$start-at,
  :$log = True,
  :$no-save = False,
  :$variant is copy = '',
  :$max-concurrency = %*ENV<P6_GLIB_CONCURRENCY_LEVEL> // $*KERNEL.cpu-cores
) {
  my @build-exclude;
  my $dep_file = '.build-deps'.IO;

  if $CONFIG-NAME.IO.e {
    parse-file;
    $prefix //= %config<prefix> // '';
    @build-exclude = (%config<build_exclude> // '').split(',') // ();
  }

  my @files = get-module-files.sort( *.IO.modified );
  unless $force {
    if $dep_file.e && $dep_file.modified >= @files[*-1].modified {
      say 'No change in dependencies.';
      exit;
    }
  }

  my @modules = @files.map( *.path )
                      .map({
                        my $mn = $_;
                        my $a = [
                          $mn,
                          .subst('.pm6', '').split('/').Array[1..*].join('::')
                        ];
                        $a;
                      })
                      # Remove modules excluded via project file.
                      .grep( *.[1] ne @build-exclude.any )
                      .sort( *[1] );

  for @modules {
    %nodes{$_[1]} = (
      itemid   => $++,
      filename => $_[0],
      edges    => [],
      name     => $_[1]
    ).Hash;
  }

  my $s = Dependency::Sort.new;
  my @others;
  my @other-provided = (%config<other_provided> // '').split(',');
  for %nodes.pairs.sort( *.key ) -> $p {
    say "Processing requirements for module { $p.key }...";

    my token useneed { 'use' | 'need' }
    my $f = $p.value<filename>;

    my $m = $f.IO.open.slurp-rest ~~ m:g/^^<useneed>  \s+ $<m>=((\w+)+ % '::') \s* ';'/;
    for $m.list -> $mm {
      my $mn = $mm;
      $mn ~~ s/<useneed> \s+//;
      $mn ~~ s/';' $//;
      $mn .= trim;
      unless $mn.starts-with( ($prefix // '').split(',').any ) {
        next if $mn ~~ / 'v6''.'? (.+)? /;
        @others.push: $mn;
        next;
      }

      %nodes{$p.key}<edges>.push: $mn unless $mn eq @other-provided.any;
      %nodes{$mn}<kids>.push: $p.key;

      if $mn eq @other-provided.any {
        @others.push: $mn;
      } else {
        die qq:to/DIE/ unless %nodes{$mn}:exists;
          { $mn }, used by { $p.key }, does not exist!
          DIE

        $s.add_dependency(%nodes{$p.key}, %nodes{$mn});
      }
    }
    #say "P: {$p.key} / { %nodes{$p.key}.gist }";
  }

  if %*ENV<P6_GTK_DEBUG> {
    for %nodes.keys.sort -> $k {
      for %nodes{$k}<edges> -> $e {
        say "{$k}:";
        for $e.list {
          my $p = $_;
          s:g/'::'/\//;
          $_ = "lib/{$_}.pm6";
          say "\t{$_} -- { .IO.e } -- { %nodes{$p}:exists }";
        }
      }
    }
  }

  say "\nA resolution order is:";

  my @module-order;
  if !$s.serialise {
    die $s.error_message;
  } else {
    @module-order.push( $_<name> => $++ ) for $s.result;
  }
  my %module-order = @module-order.Hash;
  my @buildList <== @others
                <== @others.unique.sort.grep( * ne <NativeCall nqp>.any );

  @buildList.append: @module-order.map( *.key );
  "BuildList".IO.open(:w).say( my $list = @buildList.join("\n") );
  say $list;

  # Add module order to modules.
  .push( %module-order{$_[1]} ) for @modules;

  say "\nOther dependencies are:\n";
  say @others.unique.sort.join("\n");

  sub space($a) {
    ' ' x ($a.chars % 8);
  }

  {
    # Not an optimal solution, but it will work with editing.
    # Want to take the longest of $_[0], add a number of spaces
    # equal the difference between the size plus the previous number modulo 8
    use Text::Table::Simple;
    say "\nProvides section:\n";
    my $table = lol2table(
      @modules.sort({
        ($^a[2] // 0).Int <=> ($^b[2] // 0).Int
      }).map({
        .reverse.map({ qq["{ $_ // '' }"] })[1..2]
      }),
      rows => {
        column_separator => ': ',
        corner_marker    => ' ',
        bottom_border    => ''
      },
      headers => {
        top_border       => '',
        column_separator => '',
        corner_marker    => '',
        bottom_border    => ''
      },
      footers => {
        column_separator => '',
        corner_marker    => '',
        bottom_border    => ''
      }
    ).join("\n");
    $table ~~ s:g/^^':'/    /;
    $table ~~ s:g/':' \s* $$/,/;
    $table ~~ s/',' \s* $//;

    my $extra = 'META6.json';
    if $extra.IO.e {
      my $meta = $extra.IO.slurp;
      $meta ~~ s/ '"provides": ' '{' ~ '}' <-[\}]>+ /"provides": \{\n{$table}\n    }/;
      $extra.IO.rename("{ $extra }.bak");
      my $fh = $extra.IO.open(:w);
      $fh.printf: $meta;
      $fh.close;

      say 'New provides section written to META6.json.';
    } else {
      say $table;
    }

    sub waitForThreads {
      await Promise.anyof(@threads);
      #exit 1 if @threads.grep({ .status ~~ Broken });
      @threads .= grep({ .status ~~ Planned });
    }

    my $*ERROR = False;
    # Build code begins here.
    my $*SKIP = $start-at ??
      ( $start-at.Int ~~ Failure ??
        do {
          my $i = @buildList.first($start-at, :k);
          unless $i {
            my @c = @buildList.map({ $_ => levenshtein($_, $start-at).abs })
                              .sort( *.value );
            my $cm = @c[0].key;

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
    my $remaining = @buildList.elems - $*SKIP;

    my ($*I, $*LOG, $start) = (0, '', DateTime.now);
    while +@buildList && $*ERROR.not {
      my $n = @buildList.shift;

      # Wait out jobs until the next set of dependencies are cleared.
      while %nodes{$n}<edges> && @threads.elems {
        await Promise.anyof(@threads);
        @threads .= grep({ .status ~~ Planned });
        say "W: »»»»»»»»»»»»»» { @threads.elems }";
      }

      # If no more compile jobs and still dependencies, then something is
      # very wrong!
      if %nodes{$n} && %nodes{$n}<edges>.elems && !@threads {
        die "Cannot start $n due to missed dependencies {
             %nodes{$n}<edges>.join(', ') }";
      }

      # Start threads until we have a blocker...or we run out of threads.
      if !%nodes{$n} || %nodes{$n}<edges>.elems.not {
        say "A ({ $n }): »»»»»»»»»»»»»» { @threads.elems + 1 } R: { --$remaining }";
        my $t = start { run-compile($n, $t); }
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

    my $name = getName;
    if $name.IO.e {
      if $name ~~ /'ParallelBuildResults-' [ ( \w ) + '-' ]? \d+/ {
        $variant = $0 ?? $0.Str.succ !! 'a';
      }
      $name = getName;
    }

    if $log && $no-save.not {
      'stats'.IO.add($name).spurt($*LOG);
      # Also write to the historical default for error checking purposes!
      $*CWD.add('LastBuildResults').spurt($*LOG);
    }
  }
}

sub run-compile ($module, $thread) {
  if ++$*I > $*SKIP {
    my $cs = DateTime.now;
    my $exec = qqx{scripts/get-config.pl6 exec}.chomp;
    my $proc = run "./{ $exec }", '-e',  "use $module", :out, :err;
    #my $proc = run "./p6gtkexec", '-e',  "use $module", :out, :err;

    if $proc.exitcode {
      say $proc.out;
      say $proc.err;
      $*ERROR = True;
    }

    output(
      $module,
      $proc.err.slurp ~ "\n{ $module } compile time: { DateTime.now - $cs }"
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
  output('', $data);
}
multi sub output ($module, $data) {
  $lock.protect({
    say ($*LOG ~= " === {$module} === ") if $module;
    $*LOG ~= "\n";
    ($*LOG ~= $data).say;
    $*LOG ~= "\n";
  });
}


my $lock2 = Lock.new;
sub prune ($node, $module) {
  state %locks;

  $lock2.protect({ %locks{$_} //= Lock.new });
  %locks{$_}.protect({
    # Prunning should be behind a lock as well!
    #say "Pruning {$node}...";
    %nodes{$node}<edges> .= grep({ $_ ne $module });
  });
}
