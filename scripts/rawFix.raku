#!/usr/bin/env raku

use lib <scripts .>;

use JSON::Fast;
use GTKScripts;

use GLib::Raw::Definitions;

use GLib::TypeClass;
use GIO::TypeClass;
use Pango::TypeClass;
use GDK::TypeClass;
use GTK::TypeClass;

my rule uses { ^^ 'use' ([\w+]+ % '::') [':' .+?]? ';' }

my token name { \w+ }

my token sigil {
  '$' | '@' | '%' | \\
}

my token typename {
  <[\w\[\]]>+
}

my rule param {
  <typename> [ <sigil> <var=name> ]?
}

my rule paramlist {
  <param>* %% [ ',' ]
}

my rule subtrait {
  'returns' <returnType=name> |
  'is export'                 |
  'is native(' <lib=name> ')'
}

my rule subtraits {
  <subtrait>+ %% \s*
}

my rule subdef {
  'sub' <name> [ '(' <paramlist> ')' ]?
  <subtraits>
  \s* '{ * }'
}

my $manifest = from-json('META6.json'.IO.slurp)<provides>;

my $col0 = $manifest.map( *.key.chars ).max;

for $manifest.pairs.sort( *.key ) {
  next unless .key.contains('::Raw::');

  my $contents = .value.IO.slurp;
  my $subs     = $contents ~~ m:g/ <subdef> /;

  my %need;
  for $subs[] -> $s {

    for $s<subdef><paramlist><param>[] -> $p {
      $p.gist.say;

      if %typeClass{ $p<typename>.Str } -> $cu {
        %need{$cu}++;
      }
    }
    %need.gist.say;
    exit;
    for $s<subtraits> -> $st {
      next unless $st<returnType>;
      if %typeClass{ $st<returnType>.Str } -> $cu {
        %need{$cu}++
      }
    }
  }

  #$subs.gist.say;
  if %need.elems {
    my $uses = $contents ~~ m:g/ <uses> /;
    %need{ .[0].Str }:delete for $uses;

    if %need.elems {
      %need.gist.say;

      $contents.substr-rw($uses.tail.to, 0) =
        %need.keys.map( 'use ' ~ * ~ ';' ).join("\n");

      $contents[^10].say;
    }
  }

  last;
}

#say "Processed { $manifest.elems } compunits";
