#!/usr/bin/env raku
use v6;

use File::Find;

my token method-name { <[\w] + [_-]>+ }
my rule prop-regex { 'method' <method-name> 'is rw' ['is also<'<method-name>'>']? }

my @files = find(
  dir  => '.',
  name => / '.' [ :i 'pm6' | 'raku' ] $/
);

for @files -> $f {
  my $property-names = $f.slurp ~~ m:g/<prop-regex>/;

  if $property-names {
    say "--- { $f } ---";
    .<prop-regex><method-name>[0].Str.say for $property-names[];
  }
}
