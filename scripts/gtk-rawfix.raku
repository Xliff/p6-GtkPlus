#!/usr/bin/env raku
use v6;

use File::Find;

multi sub MAIN ( :$clean is required ) {
  my @files = find(
    dir  => 'lib/GTK/Raw',
    name => / '.' [ :i 'rawfix.bak' ] $/
  );

  .unlink for @files;
.sort( *.basename );
  say "{ @files.elems } backup files removed.";
}

multi sub MAIN {
  my token raw-types { "\n"? 'use GTK::Raw::Types:ver<3.0.1146>;' }

  my @files = find(
    dir  => 'lib/GTK/Raw',
    name => / '.' [ :i 'pm6' ] $/
  ).sort( *.basename );

  my $fc = 0;
  for @files -> $f {
    next if $f.basename eq <
      Definitions.pm6
      Enums.pm6
      Exports.pm6
      Types.pm6
    >.any;

    print "Checking { $f.basename }...";

    my $c = $f.slurp.subst('gchar ', 'Str ', :g);

    if $c ~~ &raw-types -> $m {
      say 'needs fix!';
      $fc++;

      $c.substr-rw($m.from, $m.to - $m.from) = q:to/RAWFIX/.chomp;
        use GLib::Raw::Definitions;
        use GLib::Raw::Structs;
        use GTK::Raw::Definitions:ver<3.0.1146>;
        use GTK::Raw::Structs:ver<3.0.1146>;
        RAWFIX

      $f.rename($f.absolute ~ '.rawfix.bak');
      $f.spurt: $c;
    } else {
      say 'ok!';
    }
  }

  say "{ $fc } files needed fixing!";
}
