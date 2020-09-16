#!/usr/bin/env perl6
use GLib::Raw::Definitions;

# cw: XXX - Should also handle the situation where the compunits reside in
#           Compunit itself!

my ($n, $cu) = @*ARGS[0,1];
require ::(my $o = "{$n}::{$cu}");
$o = ::("$o");

my $r = "{$n}::Raw::{$cu}";
my $raw-loaded = False;
try {
  CATCH { default { } }

  require ::($r);
  $r = ::("{ $r }::EXPORT::DEFAULT");
  $raw-loaded = True;
}
unless $raw-loaded {
  say "Sorry! No raw definitions found for '{$n}::{$cu}'";
  exit;
}

my @methods = do gather for $o.^methods(:local) {
  my @rw-params;
  my $m = $_;

  # Grab multi with most parameters. This SHOULD be our implementor.
  my @c = .candidates.map({
    next unless .signature.arity;

    do with .signature {
      [
        .arity,
        .params.kv.rotor(2).grep({ .[1].rw && .[1].positional })
      ]
    }
  }).sort( -*.[0] );

  take [ $m, @c[0][1] ] if @c[0][1]
}

my %raw-subs := $r.WHO;
my $prefix = get-longest-prefix(%raw-subs.keys);
for @methods -> ($m, @rw) {
  my $sub-name = "{ $prefix }_{ $m.name }";
  my $raw-sub = %raw-subs{$sub-name};

  for @rw {
    my $sp = $raw-sub.signature.params[ .[0] - 1 ];

    unless .[1].name eq $sp.name {
      say "Potential parameter mismatch, since '{ .[1].name }' != '{
           $sp.name }'";
    }
    unless $raw-sub.signature.params[ .[0] - 1 ].rw {
      say "{ $m.name } -- '{ $sub-name }' parameter '{
           .[ 1 ].name }' should be rw!'"
    }
  }
}
