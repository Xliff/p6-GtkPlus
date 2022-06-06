#!/usr/bin/env perl6
use v6.c;

use lib 'scripts';

use GTKScripts;
use Data::Dump::Tree;

sub MAIN ($dir?, :$file, :$rw = False) {
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

  my %new-classes;
  for @files -> $file {
    $*ERR.say: "Checking { $file } ...";
    my $contents = $file.IO.slurp;

    # Remove preprocessor directives.
    $contents ~~ s:g/^^'#' .+? $$//;

    # Remove comments
    $contents ~~ s:g|'/*' .+? '*/'||;

    my $m = $contents ~~ m:g/<struct>/;

    for $m[] -> $l {
      my @s-entries;
      my $max-type-size = $l<struct><solo-struct><struct-entry>.map(
        *<type><n>.Str.chars
      ).max;
      for $l<struct><solo-struct><struct-entry>[] -> $se {
        @s-entries.push: [
          $se<type><n>.Str.fmt("%-{ $max-type-size }s"),
          .Str
        ] for $se<var>.map( *.<t><n> );
      }
      my $struct-name = $l<struct><solo-struct><sn>;
      $struct-name = $struct-name.substr(1) if $struct-name.starts-with('_');
      %new-classes{ $struct-name } = @s-entries;
    }
  }

  for %new-classes.pairs.sort( *.key ) {
    my $sigil = $rw ?? '$.'     !! '$!';
    my $trait = $rw ?? ' is rw' !! '';
    my $max-member-size = .value.map({ .[1].chars }).max;
    say qq:to/CLASS/.chomp;
      class { .key } is repr<CStruct> is export \{
      \t{
        .value.map({
          "has { .[0] } { $sigil }{ .[1].fmt("%-{ $max-member-size }s") }{
          $trait };"
        }).join("\n\t")
      }
      \}

      CLASS
  }
}
