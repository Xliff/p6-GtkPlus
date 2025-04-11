use v6;

use GTKScripts;

sub fragments ($p) {
  my $ds = $p.SPEC.splitdir($p.absolute);
  my $frags = $p.dirname.split($ds);
  # Unix only. Windows will need a special case.
  $frags = $frags.skip(1) if $p.absolute.starts-with($ds);
  $frags;
}

sub MAIN (:$dir = 'lib') {

  my @files = find-files(
    $dir,
    extension => 'pm6',
    exclude   => -> $p { $p.&fragments.any eq 'Raw' }
  );

  my token       n { <[\w _\-]>+ }
  my rule has      { 'has' (\w+) '$!'<n>\s*';' }

  for @files {
    if .slurp ~~ &has -> $m {
      say "class { $m[0] } is repr<CPointer> is export does GLib::Roles::Pointers \{ \}";
    }
  }

}
