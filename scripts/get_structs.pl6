#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;
use Data::Dump::Tree;

sub MAIN (
   $dir              = %config<include-directory>,
  :$file,
  :$only    is copy,
  :$exclude is copy,
  :$rw
) {
  my (%enums, @files);

  for $only, $exclude -> $l is rw {
    $l = $l.split(',').cache if $l;
  }

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

  my %new-classes;
  FILE: for @files -> $file {
    if $exclude {
      for $exclude[] {
        next FILE if $file.contains($_);
      }
    }

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
    $contents ~~ s:g/^^'#' .+? $$//;

    # Remove comments
    $contents ~~ s:g|'/*' .+? '*/'||;

    my $m = $contents ~~ m:g/<struct>/;

    sub resolveTypeName ($_) {
      do {
        when    .ends-with('Private') { 'gpointer' }
        when    'gchar'               { 'Str'      }
        default                       { $_         }
      }
    }

    for $m[] -> $l {
      my @s-entries;
      my $max-type-size = $l<struct><solo-struct><struct-entry>.map({
        # cw: This will have to be done TWICE! (1/2)
        resolveTypeName( .<type><n> ).Str.chars
      }).max;

      for $l<struct><solo-struct><struct-entry>[] -> $se {
        @s-entries.push: [
          resolveTypeName( $se<type><n> ).Str.fmt("%-{ $max-type-size }s"),
          .Str
        ] for $se<var>.map( *.<t><n> );
      }
      my $struct-name = $l<struct><rn> // $l<struct><solo-struct><sn>;

      unless $struct-name {
        $l.gist.say;
        next;
      }

      $struct-name = $struct-name.substr(1) if $struct-name.starts-with('_');
      %new-classes{ $struct-name } = @s-entries;
    }
  }


  for %new-classes.pairs.sort( *.key ) {
    my $max-member-size = .value.map({ .[1].chars }).max;
    say qq:to/CLASS/.chomp;
      class { .key } is repr<CStruct> is export \{
      \t{
        .value.map({
          my $RW = $rw;
          unless $RW.defined {
            $RW   = True  if .[0] ~~ / 'int' (\d+)? \s* $ /;
            $RW   = True  if .[0] eq <gfloat gdouble>.any;
            $RW //= False
          }

          my $sigil = $RW ?? '$.'     !! '$!';
          my $trait = $RW ?? ' is rw' !! '';

          "has { .[0] } { $sigil }{ .[1].fmt("%-{ $max-member-size }s") }{
          $trait };"
        }).join("\n\t")
      }
      \}

      CLASS
  }
}
