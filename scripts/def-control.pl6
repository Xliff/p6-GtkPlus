use v6;

use lib 'scripts';

use GTKScripts;

sub line ($m) {
  ( $m.prematch ~~ m:g[ (\n) ] // () ).elems + 1;
}

sub get-dots ($afn) {
  my $parts = ($afn.absolute.comb: '.').elems;
  $parts-- if $parts > 0;
  $parts;
}

sub MAIN (
  Bool :$enable,
  Bool :$disable,
  Bool :$clean,
  Bool :$restore,
  Bool :$debug
) {
  if $restore {
    # Restore all .defs-bak files
    say 'Restoring...';
    for get-lib-files( pattern => / '.defs-bak' $ / ) -> $db {
      my $orig-path = $db.extension('', parts => get-dots($db) );
      say "Restoring { $orig-path }...";
      $db.rename( $orig-path );
    }
    exit 1;
  }
  if $clean {
    .unlink for get-lib-files( pattern => / '.defs-bak' (\d+)? $/ );
    exit;
  }
  if ($enable && $disable) {
    say 'Cannot set both --enabled and --disabled!';
    exit;
  }
  if !($enable || $disable) {
    say 'Must set one of --enabled or --disabled!';
    exit;
  }

  # Try to be forward thinking with respect to the extension:
  # Count the number of dots and return one less, the idea behind this
  # is that we ONLY want to replace the last 'token' of the extension

  # If there are files ending in .defs-bak#, replace them with # + 1
  for get-lib-files( pattern => / '.defs-bak' (\d+) $/ ) -> $dbn {
    my $parts = &get-dots($dbn);
    $dbn.rename( .extension( 'defs-bak' ~ ($0 + 1), :$parts ) );
  }

  # If there is already a .defs-bak, then rename it to .defs-bak0
  for get-lib-files( pattern => / '.defs-bak' $ / ) -> $db {
    my $parts = &get-dots($db);
    $db.rename( $db.extension( 'defs-bak0', :$parts ) );
  }

  for get-module-files.grep( *.contains('/Raw/').not ) -> $f {
    my $contents = $f.slurp;
    next unless ( my $m = $contents ~~ / 'our %' .+? '::RAW-DEFS' / );

    my $l = $m.&line;

    say "Found REFS definition in { $f.absolute } at line { $l } (char offset {
         $m.from })" if $debug;

    my @block = $contents.lines[ $l - 1 .. * ];
    next if @block.grep({ / ^ \s* '# '/  }).elems == @block.elems  &&
            $disable;
    next if @block.grep({ !/ ^ \s* '# '/ }).elems == @block.elems  &&
            $enable;

    say "{ $f.absolute } RAW-DEFS code { $enable ?? 'enabled' !! 'disabled' }";

    @block .= map({
      $enable ?? S/ ^ \s* '# ' //
              !! '# ' ~ $_
    });

    $contents = ($contents.lines[ ^($l - 1) ], @block).flat.join("\n");

    # Rename current file by appending .defs-bak
    $f.rename( $f.extension('defs-bak', parts => 0) );

    # Output new file.
    $f.spurt: $contents
  }
}
