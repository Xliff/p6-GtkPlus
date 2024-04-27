#!/usr/bin/env perl6
use lib 'scripts';

use ScriptConfig;
use GTKScripts;

sub MAIN (
  :$extension is copy is required,   #= Extension to search on (ala 'pm6')
  :$prefix is copy,                  #= Name prefix (ala 'GTK', 'WebKit' or 'Clutter')
  :@module is copy = ()              #= Extra modules to load. More than one of this parameter can be specified.
) {
  my @files = find-files(
    'lib',
    extension => $extension,
    exclude => [ rx/ 'Types.pm6' $/, rx/ '.precomp' / ]
  );

  if CONFIG-NAME.IO.e {
    parse-file(CONFIG-NAME);
    $prefix = %config<typePrefix> // %config<prefix>;
    @module = %config<modules>.Array;
  }

  die "Missing prefix!\n\n{ &*USAGE }" unless $prefix.defined;

  my @modules.append: @module if +@module;
  my @blacklist = "{ $?FILE.IO.dirname }/.blacklisted_types".IO.slurp.lines;

  my @types;

  my %seen;
  my %seen-enum;
  for @files -> $filename {
    say "Checking { $filename }...";
    my $f = $filename.IO.slurp;
    for $f ~~ m:g/<!after '#' \s*> ({ $prefix }<[A..Za..z]>+)/ {
      next unless .Str.starts-with($prefix);
      my $prospect = $_[0].Str;
      next if [||] (
        $prospect eq @blacklist.any,
        %seen{$prospect},
        .ends-with('Ancestry'),
        $_ eq $prefix
      );
      %seen{$prospect} = True;
    }
  }

  say "\n\n------- MISSING CLASSES -------";
  for %seen.keys.sort -> $t {

    my $is-there = False;
    for @modules -> $m {
      try {
        CATCH { default { 1 } }
        require ::($m);
        my $a := ::("{$m}::{$t}");
        $is-there = True;
      }
    }
    say
      "class $t is repr('CPointer') does GTK::Roles::Pointers is export \{ \}"
    unless $is-there;
  }

  say "\n\n------- MISSING ENUMS -------";
  for %seen-enum.keys {
    my $is-there = False;
    try {
      my $a := ::($_);
      $is-there = True;
      CATCH { default { 1; } }
    }
    say "our enum $_ is export <\n>;" unless $is-there;
  }
}
