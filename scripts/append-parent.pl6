use v6.d;

# Genericize this so that it can be added to Gtk scripts dir.
my ($classFound, $classEnd, $addLines, $add);

sub MAIN(*@files) {
  for @files {
    my ($f, @lines) = (.IO.slurp);
    next if $f ~~ /'Amazon::AWS::EC2::Base'/;
    .IO.rename("$_.bak");
    
    $classFound = False;
    for $f.lines {
      $classFound = True if /^class/;
      $addLines ~= "$_\n" if $classFound;      
      if $classFound && $addLines ~~ / \s* '{' $$/ {
        @lines.push: $addLines.chomp;
        @lines.push: "  also is Amazon::AWS::EC2::Base;\n";
        $classFound = False;
        $addLines = '';
      } else {
        @lines.push: $_ unless $classFound;
      }
    }
    .IO.spurt( @lines.join("\n") );
  }
}
