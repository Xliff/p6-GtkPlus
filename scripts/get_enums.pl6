#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use ScriptConfig;
use GTKScripts;

my %values;

sub MAIN (
   $dir = %config<include-directory>,
  :$file,
  :$only     is copy,
  :$exclude
) {
  my (%enums, @files);

  $only = $only.split(',').cache if $only;

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

    @files = find-files( $dir, :$exclude, extension => 'h' );
  }

  my (%etype, %values);
  FILE: for @files -> $file {
    if $only {
      TOCONT: for 1 {
        for $only[] {
          last TOCONT if $file.contains($_);
        }
        next FILE;
      }
    }
    $*ERR.say: "Checking { $file } ...";

    # cw: Hardcoded skip of file that crashes Raku with 'Makformed UTF-8' error
    next if $file.ends-with('Xge.h');

    my $contents = $file.IO.slurp;

    # Remove preprocessor directives.
    $contents ~~ s:g| ^^ '#'  .+?      $$ ||;
    # Remove comments
    $contents ~~ s:g|    '//' .+?      $$ ||;
    $contents ~~ s:g|    '/*' .+? '*/'    ||;

    my $m = $contents ~~ m:g/<enum>/;
    for $m.Array -> $l {
      my @e;
      my ($etype, $neg, $long, $enum-rn, $named) =
        (32, False, False, $l<enum><rn> // $l<enum><solo-enum><n>, False);

      next unless $enum-rn;

      $enum-rn = $enum-rn.split('_').map( *.lc.tc ).join('')
        if $enum-rn.contains('_');

      for $l<enum><solo-enum><enum-entry> -> $el {
        for $el -> $e {
          $named = False;
          # Handle 32 vs 64 bit by literal.
          if $e[1][0] && $e[1][0].Numeric !~~ Failure {
            $long = True if $e[1]<L> || $e[1][0].Int > 31;
          } else {
            # Value is a named constant.
            $named = True;
          }
          # Handle signed vs unsigned.
          $neg  = True if $e[1]<m>;

          ((my $n = $e[1].Str.trim) ~~ s/'='//);
          $n ~~ s/ '<<' / +< /;
          $n ~~ s/  '|' / +| /;

          my $ee;
          $ee.push: $e[0].Str.trim;

          # if $n.chars {
          #   if $named {
          #     $n ~~ s:g/ ( <{ %values.keys }> ) /{ %values{ $/[0] } }/;
          #   }
          #   $ee.push: $n;
          # }
          #
          # %values{ $ee.head } = $ee.tail;

          @e.push: $ee;
        }
        %enums{$enum-rn} = @e;
      }
      $etype = 64      if $long;
      $etype = -$etype if $neg;
      %etype{$enum-rn} =  $etype;
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
