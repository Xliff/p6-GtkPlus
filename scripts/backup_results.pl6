use File::Find;

my @files = find
  dir     => '.',
  name    => /^ 'LastBuildResults' /,
  exclude => / '.json' $/;

@files .= map({
  s/ '.' (\d+) $//;
  [ $_, $/[0].Int // 0 ];
});
for @files.sort( *[1] ).reverse {
  my ($old, $new) = (
    "{ $_[0] }.{ $_[1] // '' }",
    "{ $_[0] }.{ ($_[1] // 0) + 1 }"
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
