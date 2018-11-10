use File::Find;

my @files = find
  dir     => '.',
  name    => /^ 'LastBuildResults' /,
  exclude => / '.json' $/;

@files .= map({
  s/ '.' (\d+) $//;
  [ $_, ($/[0] // 0).Int ];
});
my $max;
for @files.sort( *[1] ).reverse {
  FIRST { $max = $_[1].chars }

  my $nc = sprintf( "\%0{ $max }d", ($_[1] // 0) + 1);
  my ($old, $new) = (
    "{ $_[0] }.{ $_[1] // '' }",
    "{ $_[0] }.{ $nc }"
  );

  if $_[1] {
    if $old.IO.e {
      $old.IO.rename($new);
    } else {
      'LastBuildResults'.IO.rename('LastBuildResults.0');
    }
  } else {
    'LastBuildResults'.IO.rename('LastBuildResults.0');
  }
}
