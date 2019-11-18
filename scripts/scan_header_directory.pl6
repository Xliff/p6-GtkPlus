use v6.c;

sub get-files ($iop, $ext) {
  $iop.IO.dir( test => *.ends-with($ext) )
}

sub MAIN (
  Str :$headers-dir,
  Str :$scan-dir,
  Str :$prefix   = 'g',
  Str :$manifest = 'all-project-header-list',

  :$write-missing
) {
  die 'Cannot find manifest file!' unless $manifest.IO.e;

  my @completed-headers = $manifest.IO.slurp.lines.unique;
  my @existing-headers  = $headers-dir.&get-files('.h').map( *.absolute );
  my @existing-mods     = $scan-dir.&get-files('.pm6');

  for @existing-mods {
    my $contents = .slurp;

    my $hf;
    if $contents ~~ / ^ '### ' (.+?) $/ {
      $hf = $/[0];
    } else {
      my @path-nodes = $*SPEC.splitdir( .absolute );
      # HACK!
      @path-nodes[* - 3] = $prefix;

      next unless @path-nodes[* - 2] eq 'Raw';

      $hf = $prefix ~ @path-nodes[* - 3, * - 1].join('').lc;
      if $hf.IO.e {
        if $write-missing {
          # s/// as assignment! :)
          $contents ~~ s[^^ ( 'unit package ' <[ \w : ]>+ ) $$] =
            "\n\n### { $hf }\n{ $[0] }\n";
          .rename("{ $_ }.bak");
          .spurt($contents);
        } else {
          say qq[Would write "### { $hf }" to \$contents];
        }
      }
    }
    $hf = $headers-dir.IO.add($hf);
    next if $hf eq @completed-headers.any;
    unless $hf.IO.e {
      print "$hf directory does not exist! Skipping...";
      next;
    }
    @completed-headers.push( $hf );
  }

  $manifest.IO.rename( "{ $manifest }.bak" );
  $manifest.IO.spurt: @completed-headers.sort.unique.join("\n");
}
