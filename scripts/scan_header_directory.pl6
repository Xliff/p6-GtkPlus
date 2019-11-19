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
    if $contents ~~ / ^^ '### ' (.+?) $$ / {
      $hf = IO::Spec::Unix.splitdir($/[0])[* - 1];
    } else {
      my @path-nodes = $*SPEC.splitdir( .absolute );
      # HACK!
      @path-nodes[* - 3] = $prefix;

      next unless @path-nodes[* - 2] eq 'Raw';

      $hf = @path-nodes[* - 3, * - 1].join('').lc;
      $hf = $headers-dir.IO.add($hf).extension('h');
      next if $hf eq @completed-headers.any;

      if .IO.e {
        if $write-missing {
          if $hf.IO.e {
            # s/// as assignment! :)
            $contents ~~ s[^^ ( 'unit package ' <[ \w : ]>+ ) $$] =
              "\n\n### { $hf }\n{ $[0] }\n";
            .rename("{ $_ }.bak");
            .spurt($contents);
          } else {
            say "$hf directory does not exist! Skipping...";
            next;
          }
        } else {
          say qq[Would write "### { $hf }" to {$_}];
        }
      }
    }

    @completed-headers.push( $hf );
  }

  $manifest.IO.rename( "{ $manifest }.bak" );
  $manifest.IO.spurt: @completed-headers.sort.unique.join("\n");
}
