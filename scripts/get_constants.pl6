#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;

# This grammar, brought to you by the letter r, the number 10 and the #raku
# member known as raydiak!
grammar G {
  token ws { \h* } # redefine whitespace to disallow newline
  token dd   { <[0..9]> } # dec digit
  token hd { <[0..9 A..F a..f]> } # hex digit
  token m   { '-' }
  token L   { 'L' }
  token decimal-number     { <m>? <dd>+ <L>?    }
  token hexadecimal-number { '0'? 'x' <hd>+  } # correctly spell "hexadecimal"
  token number             { <decimal-number> | <hexadecimal-number> }

  token comment { '/*' .*? '*/' }
  token name   { <[_ A..Z a..z]>+ }
  token q      { '"' | "'" }
  token string { (<q>) ~ $0 [.*?] } # ensure closing quote matches opening quote, and allow empty strings
  token value { <number> | <string> }

  rule constant-def {
    '#define' <name> <value>
  }

  token unrecognized { \N* }

  rule TOP {
    [^^[ <constant-def> || <comment> || <unrecognized> ] [\n|$]]*
  }
}

sub MAIN ($dir?, :$file) {
  my (%enums, @files);

  unless $dir ^^ $file {
    $*ERR.say: qq:to/SAY/;
    Specify a directory as the only argument, or use --file to process a{ ''
    } single file.
    SAY

    $*ERR.say: $*USAGE;
    exit 1;
  }

  die 'Cannot specify a directory if using --file'
    if $dir.defined && $file.defined;

  if $file.defined {
    die "File '$file' does not exist"
      unless $file.IO.e;
    @files = ($file);
  } else {
    die "Directory '$dir' either does not exist, or is not a directory"
      unless $dir.IO.e && $dir.IO.d;

    @files = find-files($dir, extension => 'h');
  }

  my %constants;
  for @files -> $file {
    $*ERR.print: "Checking { $file } ... ";
    my $contents = $file.IO.slurp;

    my $m = G.parse($contents)<constant-def>;

    for $m.Array -> $l {
      %constants{ $l<name> } = $l<value>;
    }

    $*ERR.say: $m.Array.elems ~ " found.";
  }

  my $max-key = %constants.keys.map( *.chars ).max;
  for %constants.pairs.sort( *.key ) {
    say "constant { .key.fmt("%-{ $max-key }s") } is export := { .value };";
  }
}
