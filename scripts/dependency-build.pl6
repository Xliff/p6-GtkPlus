#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;
use Dependency::Sort;

my (%nodes, @threads);

sub MAIN (
  :$force,           #= Force dependency generation
  :$prefix is copy   #= Module prefix
) {
  my @build-exclude;
  my $dep_file = '.build-deps'.IO;

  if CONFIG-NAME.IO.e {
    parse-file(CONFIG-NAME);
    $prefix //= %config<prefix>;
    @build-exclude = %config<build_exclude> // ();
  }

  my @files = get-module-files.sort( *.IO.modified );
  unless $force {
    if $dep_file.e && $dep_file.modified >= @files[*-1].modified {
      say 'No change in dependencies.';
      exit;
    }
  }

  my @modules = @files
    .map( *.path )
    .map({
      my $mn = $_;
      my $a = [
        $mn,
        .subst('.pm6', '').split('/').Array[1..*].join('::')
      ];
      $a;
    })
    # Remove modules excluded via project file.
    .grep( *[1] ne @build-exclude.any )
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
      unless $mn.starts-with( $prefix.split(',').any ) {
        next if $mn ~~ / 'v6''.'? (.+)? /;
        @others.push: $mn;
        next;
      }

      %nodes{$p.key}<edges>.push: $mn;
      %nodes{$mn}<kids>.push: $p.key;

      die qq:to/DIE/ unless %nodes{$mn}:exists;
        { $mn }, used by { $p.key }, does not exist!
        DIE

      $s.add_dependency(%nodes{$p.key}, %nodes{$mn});
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
  @others = @others.unique.sort.grep( * ne <NativeCall nqp>.any );
  my $list = @others.join("\n") ~ "\n";
  $list ~= @module-order.map({ $_.key }).join("\n");
  "BuildList".IO.open(:w).say($list);
  say $list;

  # Add module order to modules.
  $_.push( %module-order{$_[1]} ) for @modules;

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
        $_.reverse.map({ qq["{ $_ // '' }"] })[1..2]
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

    # Build code begins here.
    my @buildOrder = 'BuildList'.IO.slurp.lines;
    my $start = DateTime.now;
    while +@buildOrder {
      my $n = @buildOrder.shift;

      # Wait out jobs until the next set of dependencies are cleared.
      while %nodes{$n}<edges> && @threads.elems {
        await Promise.anyof(@threads);
        @threads .= grep({ .status ~~ Planned });
        # say "W: »»»»»»»»»»»»»» { @threads.elems }";
      }

      # If no more compile jobs and still dependencies, then something is
      # very wrong!
      if %nodes{$n} && %nodes{$n}<edges>.elems && !@threads {
        die "Cannot start $n due to missed dependencies {
             %nodes{$n}<edges>.join(', ') }";
      }

      # Start threads until we have a blocker...or we run out of threads.
      if !%nodes{$n} || %nodes{$n}<edges>.elems.not {
        # say "A ({ $n }): »»»»»»»»»»»»»» { @threads.elems + 1 }";
        @threads.push: start { run-compile($n) };
      }

      # Wait until we free up some threads.
      if +@threads >= $*KERNEL.cpu-cores {
        await Promise.anyof(@threads);
        @threads .= grep({ .status ~~ Planned });
        # say "C: »»»»»»»»»»»»»» { @threads.elems }";
      }

    }
    say "Total compile time: { DateTime.now - $start }s";
  }
}

sub run-compile ($module) {
  my $cs = DateTime.Now;
  my $proc = run 'p6gtkexec', '-e',  "use $module", :out, :err;
  output(
    $module,
    $proc.err.slurp ~ "\n{ $module } compile time: { DateTime.now - $cs }"
  );
  if %nodes{$module} {
    for %nodes{$module}<kids>[] {
      # Mute all until we are sure there are no more Nils!
      quietly {
        next unless $_ && %nodes{$_} && %nodes{$_}<edges>:exists;
        %nodes{$_}<edges> .= grep({ $_ ne $module });
      }
    }
  }
}

my $lock = Lock.new;
sub output ($module, $data) {
  $lock.protect({
    say " === {$module} === ";
    $data.say
  });
}