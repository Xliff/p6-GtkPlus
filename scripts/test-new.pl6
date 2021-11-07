#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;



die 'Cannot find BuildList file in current directory.'
  unless 'BuildList'.IO.e;

my @buildlist = 'BuildList'.IO.open.slurp-rest.split(/\r?\n/).map( *.chomp );

sub MAIN(
  $rev = 'HEAD',          #= Revision to test against
  :$deps-output = False,  #= Display output of dependency calculation
  :$skip                  #= Comma separated list of CompUnits to be skipped
) {
  my $p = run q[scripts/dependencies.pl6], :out;
  if $p.exitcode {
    # $p.exitcode.say;
    # my $depcontents = $p.out.slurp;
    #
    # given $depcontents {
    #   when .contains('circular reference found!') {
    #     .say;
    #   }
    #
    #   default {
    #     .say;
    #     exit;
    #   }
    # }
    exit;
  }
  if $deps-output {
    .say for $p.out.lines;
  }

  #chdir '/home/cbwood/Projects/p6-GtkPlus';
  mkdir '.touch' unless '.touch'.IO.d;
  my @files = qqx{git diff --name-only $rev}.chomp;
  @files = @files.split("\n").map({
    next if / ^ 't/' /;
    next unless / '.pm6' $/;
    my $a = S/ '.pm6' //;
    $a = ( $a .= split("\/") )[1..*].join('::');
    [ $_, $a, @buildlist.first(* eq $a, :k) // Inf ];
  });

  my @to-be-skipped = ($skip // '').split(/','\s*/);
  for @files.grep({ .[2] !~~ Inf }).sort( *[2] ) {
    unless .[2] {
      say "{ $_[0] } is not in the BuildList.";
      next;
    }
    if .[1] eq @to-be-skipped.any {
      say "Skipping { .[1] } by request...";
      next;
    }

    # Move out to project specific settings file.
    next if .[1] ~~ /^ 'BuilderWidgets' | 'GTK::Builder::' /;

    my $rel = $_[0].IO.dirname.split('/')[1..*].join('/');
    mkdir ".touch/{ $rel }";
    my $tf = ".touch/{ $rel }/{ $_[0].IO.basename }";
    next unless ! $tf.IO.e || .[0].IO.modified > $tf.IO.modified;

  # Deprecated
  #   my @extradirs;
  #   parse-file(CONFIG-NAME);
  #   if %config<libdirs> {
	# @extradirs.push( "-I $_" ) for %config<libdirs>.split(',');
  #   }

    say "===== { .[1] } =====";
    my $proc = Proc::Async.new(
      "./{ %config<exec> // 'p6gtkexec' }",
      '-e',
      'use '~ $_[1]
    );

    $proc.stdout.tap(-> $o { $o.say; });
    try {
      CATCH {
        default { $proc.stderr.tap( -> $err { $err.say }) }
      }
      await $proc.start;
    }
    qqx{touch $tf};
  }
}
