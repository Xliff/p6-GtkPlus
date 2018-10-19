use Find::Files;

my @files = find
  dir => 'lib',
  name => /^ 'LastBuildResults' /;

@files.map({ my $a = 0; s/ '.' (\d+) $//; [$_, $/0 // 0] });
for @files.sort( *[1] ).reverse {
  my ($old, $new) = (
    "{ $_[0] }.{ $_[1] }",
    "{ $_[0] }.{ $_[1] + 1 }"
  );

  if $_[1] {
    $old.IO.rename($new)
  } else {
    "{ $_[0] }".IO.rename($new);
  }
}
