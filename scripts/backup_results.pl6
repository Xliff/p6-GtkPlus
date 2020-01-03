use v6.c;

use lib 'scripts';

use GTKScripts;

my @files = find-files(
  '.',
  pattern    => "{$*CWD}/LastBuildResults",
  exclude    => rx/ '.json' $/,
  depth      => 1
);

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

  if $_[1] eq '0' || $_[1] {
    if $old.IO.e {
      $old.IO.rename($new);
    } else {
      # 'LastBuildResults'.IO.rename('LastBuildResults.0');
    }
  } elsif 'LastBuildResults'.IO.e {
    'LastBuildResults'.IO.rename('LastBuildResults.0');
  }
}

# Ugly, HORRIBLE fix...but it's still a fix!
my $lbr = 'LastBuildResults'.IO;
$lbr.rename('LastBuildResults.1') if $lbr.e;
