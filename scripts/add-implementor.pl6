use v6.c;

use File::Find;

sub MAIN ($filename = '.') {
  my @files;

  if $filename eq '.' {
    @files = find dir => 'lib', name => /'.pm6' $/;
  } else {
    @files.push: $filename;
  }

  for @files {
    my $bak-file = "{ $_ }.imp-bak";
    my @nodes = $*SPEC.splitdir: .absolute;

    next if @nodes[* - 2] eq ('Raw', 'Signals', 'Roles').any;
    next if $bak-file.IO.e;

    my $contents = .IO.slurp;
    .IO.rename: $bak-file;

    $contents ~~ s[^^ (\s+ 'has' \s+ \w+ \s+ '$!' <[\w \- _ ]>+ ) ] =
      "$0 is implementor";
    .IO.spurt: $contents;

    say "$_ replaced.";
  }
}
