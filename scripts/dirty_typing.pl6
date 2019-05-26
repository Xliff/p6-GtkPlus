#!/usr/bin/env perl6

use File::Find;

#use GTK::Raw::Types;

sub MAIN ( $pattern is copy, :$prefix!, :@module = () ) {
  $pattern ~~ s/\*//;
  my @files = find
    dir     => 'lib',
    name    => /{$pattern}/,
    type    => 'file',
    exclude => /'Types.pm6'$/,
    exclude => /'.precomp'/;
    
 my @modules := @module;
 my @blacklist = "{ $?FILE.IO.dirname }/.blacklisted_types".IO.slurp.lines;
 
 my @types;
 
 # Don't work coz LEXICAL!
 # for @modules -> $m {
 #   CATCH { default { say "Cannot load module '{ $m }'!\n { .message }"; exit; } }
 #   require ::("$m");
 #   # Append all defined types to @types -- So nice, but...alas... unnecessary
 #   # @types.append: ::("$m")::EXPORT::DEFAULT::.values.grep( *.defined.not )
 # }

  my %seen;
  my %seen-enum;
  for @files -> $filename {
    say "Checking { $filename }...";
    my $f = $filename.IO.slurp;
    for $f ~~ m:g/<!after '#' \s*> ({ $prefix }<[A..Za..z]>+)/ {
      next unless $_.Str.starts-with($prefix);
      my $prospect = $_[0].Str;
      next if $prospect eq @blacklist.any;
      next if %seen{$prospect};
      #if / 'Mode' | 'Result' | 'Flags' | 'Reason' / {
      #  %seen-enum{$prospect} = True;
      #} else {
        %seen{$prospect} = True;
      #}
    }
  }

  say "\n\n------- MISSING CLASSES -------";
  for %seen.keys.sort -> $t {
    my $is-there = False;
    try {
      for @modules -> $m {
        CATCH { default { 1; } }
        require ::($m);
        my $a = ::("{$m}::{$t}");
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
