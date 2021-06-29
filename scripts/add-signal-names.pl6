#!/usr/bin/env raku
use v6;

use lib 'scripts';

use GTKScripts;

grammar ClassParser {
  rule  TOP    { .+? 'class' <name> [ <traits> | <roles> ]* <nestedBraces> }
  rule  name         { <[a..zA..Z0..9\-_]>+ }
  token open-delim   { <[\<\(]> }
  token close-delim  { <[\>\)]> }
  rule  trait        { 'is' <name>[<open-delim>$<value>=[ .+? ]<close-delim>]? }
  regex traits      { <trait>+ %% \s+ }
  rule  role         { 'does' <name>+ %% '::' }
  regex roles       { <role>+ %% \s+ }

  regex nestedBraces {
    :ratchet
      <-[{}]>*
      [ '{' ( <nestedBraces> ) '}' <nestedBraces> ]?
      <-[{}]>*
  }
}

my @class-files = find-files(
  'lib',
  extension => 'pm6',
  exclude   => rx/ 'Compat' | 'Raw' | 'Roles' /
);

my $file-count = 0;
for @class-files {
  next if .absolute.ends-with(
    'GTK.pm6'           |
    'GTKNonWidgets.pm6' |
    'GTKWidgets.pm6'    |
    'GTKAll.pm6'        |
    'WidgetMRO.pm6'     |
    'MRO.pm6'
  );
  # say "File: { .absolute } ==================================";
  my $contents = .IO.slurp;

  #say $contents;

  my $parsed-class = ClassParser.subparse($contents);

  #$parsed-class.gist.say;

  my $class-contents = $parsed-class<nestedBraces>[0];

  my $match = $class-contents ~~ m:g/
    'self.connect' [ '-' ( <-[\(]>+ ) ]?
    '(' $<params>=[ <-[\)]>+ ] ')'
  /;

  if $match {
    my %signal-data = (gather for $match.Array {
      #say "MA: { .gist } =============";
      my $params = .<params> ?? .<params>.split(/','\s*/) !! ();
      # This should now be a pair containing:
      #   <SignalName> => <Closure>
      # This only does Signal name.
      # It should take the connect sub name and the parameter list as the second
      # parameter
      take Pair.new(
        ( $params.elems > 1 ?? $params.Array.tail.subst("'", '', :g) !! .[0] ).Str,
        "sub \{ \${ .Str } \}"
      );
    }).Hash;

    my $sig-name-padding = %signal-data.keys.map( *.chars ).max;


    (my $replace-contents = $class-contents.Str) ~= qq:to/CODE/;
        method signal-data \{
          my \$self = self;
          (
            callsame.append: (
              {
                %signal-data.pairs.sort( *.key ).map({
                  "{ .key.fmt("%-{ $sig-name-padding }s") } => { .value }"
                }).join(",\n        ");
              }
            ).Hash
          ).Map;
        \}

        method signal-names \{
          state \@signal-names = self.signal-data.keys;

          { '@' }signal-names;
        \}
      CODE

    #say "Range: { $match.from } - { $match.to }";

    my $to-replace := $contents.substr-rw( .from, .to - .from )
      given $class-contents;

    $to-replace = $replace-contents;

    $contents.say;

    last;

  } else {
    say "{ .absolute.IO.basename }: --- NO SIGNALS FOUND ---";
  }
}
