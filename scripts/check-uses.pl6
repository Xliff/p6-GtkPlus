#!/usr/bin/env perl6

use lib 'scripts';

use GTKScripts;

my token q             { <["'“”‘’«»「」‹›]>         }
my token mod           { [\w+]+ %% '::'            }
my rule  uses          { 'use' <mod>               }
my token m-new         { <mod> '.new'              }
my token class-or-role { 'class' | 'role'          }
my rule identity       { <class-or-role> <mod>     }
my token lateb         { '::(' <q> ~ <q> <mod> ')' }

sub get-list ($match, $token) {
  do {
    gather for $match.Array {
      take .{$token}<mod> => 1 if .{$token}
    }
  }
}

sub mq($s) {
  say $s;
  say '=' x $s.chars;
}

sub MAIN (:$filename, :$prefix is required) {

  parse-file(CONFIG-NAME);

  my @files = $filename ??
    $filename.Array
    !!
    get-module-files.grep({ ! / '.touch' | 'Raw' / });

  for @files {
    next if 'Builder' ∈ $*SPEC.splitdir(.dirname);
    
    my $contents = .IO.slurp;
    my $uses  = $contents ~~ m:g/ <uses>     /;
    my $m-new = $contents ~~ m:g/ <m-new>    /;
    my $class = $contents ~~ m:g/ <identity> /;
    my $lateb = $contents ~~ m:g/ <lateb>    /;

    my %u  = get-list($uses,      'uses');
    my %mn = get-list($m-new,    'm-new');
    my %c  = get-list($class, 'identity');
    my %lb = get-list($lateb,    'lateb');

    my @missing;

    for %mn.keys.sort -> $k {
      next unless $k.starts-with($prefix);
      next if %c{$k}:exists;
      unless [||]( %u{$k}:exists, %lb{$k}:exists ) {
        @missing.push: "use $k;";
      }
    }

    if @missing {
      mq("\nUse statements missing in $_:");
      .say for @missing;
    }

  }

}
