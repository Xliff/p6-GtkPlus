#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;

my regex name {
  <[_ A..Z a..z]>+
}

# my rule enum_entry {
#   <[A..Z]>+ [ '=' [ \d+ | \d+ '<<' \d+ ] ]? ','
# }

my token d { <[0..9 x]> }
my token m { '-' }
my token L { 'L' }
my token w { <[A..Za..z0..9 _]> }

my rule comment {
  '/*' .+? '*/'
}

my rule enum-entry {
  \s* ( <w>+ ) (
    [ '=' '('?
      [
        <m>?<d>+<L>?
        |
        <w>+
      ]
      [ '<<' ( [<d>+ | <w>+] ) ]?
      ')'?
    ]?
  ) ','?
  <comment>?
  \v*
}

my rule solo-enum {
  'enum' <n=name>? <comment>? \v* '{'
  <comment>? \v* [ <comment> | <enum-entry> ]+ \v*
  '}'
}

my rule enum {
  'typedef' <solo-enum> <rn=name> | <solo-enum>
}

sub MAIN ($dir = %config<include-directory>, :$file) {
  my (%enums, @files);

  unless $dir ^^ $file {
    say qq:to/SAY/;
    Specify a directory as the only argument, or use --file to process a{ ''
    } single file.
    SAY

    $*USAGE.say;
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

  my %etype;
  for @files -> $file {
    say "Checking { $file } ...";

    # cw: Hardcoded skip of file that crashes Raku with 'Makformed UTF-8' error
    next if $file.ends-with('Xge.h');

    my $contents = $file.IO.slurp;

    # Remove preprocessor directives.
    $contents ~~ s:g/^^'#' .+? $$//;

    my $m = $contents ~~ m:g/<enum>/;
    for $m.Array -> $l {
      my @e;
      my ($etype, $neg, $long, $enum-rn) =
        (32, False, False, $l<enum><rn> // $l<enum><solo-enum><n>);

      next unless $enum-rn;

      $enum-rn = $enum-rn.split('_').map( *.lc.tc ).join('')
        if $enum-rn.contains('_');

      for $l<enum><solo-enum><enum-entry> -> $el {

        for $el -> $e {
          # Handle 32 vs 64 bit by literal.
          if $e[1][0] && $e[1][0].Numeric !~~ Failure {
            $long = True if $e[1]<L> || $e[1][0].Int > 31;
          }
          # Handle signed vs unsigned.
          $neg  = True if $e[1]<m>;

          ((my $n = $e[1].Str.trim) ~~ s/'='//);
          $n ~~ s/'<<'/+</;
          my $ee;
          $ee.push: $e[0].Str.trim;
          $ee.push: $n if $n.chars;
          @e.push: $ee;
        }
        %enums{$enum-rn} = @e;
      }
      $etype = 64      if $long;
      $etype = -$etype if $neg;
      %etype{$enum-rn} = $etype;
    }
  }

  for %enums.keys.sort -> $k {
    #say %enums{$k}.gist;
    my $m = %enums{$k}.map( *.map( *.elems ) ).max;
    my $etype = %etype{$k};

    say "constant {$k} is export := g{ $etype > 1 ?? 'u' !! '' }int{$etype.abs};";
    say "our enum {$k}Enum is export { $m == 2 ?? '(' !! '<' }";
    for %enums{$k} -> $ek {
      for $ek -> $el {
        my $max = $el.map( *[0].chars ).max;
        my $mv = $el.map({ ( $_[1] // '' ).trim.chars }).max;
        for $el.List -> $eel {
          my $s = $max - $eel[0].chars;
          given $m {
            when 1 {
              say "  { $eel[0] }{ $m == 2 ?? ',' !! '' }";
            }
            when 2 {
              with $eel[1] {
                say "  { $eel[0] }{ ' ' x $s } => {
                             $eel[1].trim.fmt("%{ $mv }s") },";
              } else {
                say "  '{ $eel[0] }{ ($eel eqv $el.Array[*-1]).not ??
                  "'," !! "'" }";
              }
            }
          }
        }
      }
    }
    say "{ $m == 2 ?? ')' !! '>' };\n";
  }
}
