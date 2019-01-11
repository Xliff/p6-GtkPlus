use v6.c;

my @cmd = <find . -name *.pm6 -exec grep -l -->;
@cmd.push: 'constant forced';
@cmd.append: <{} ;>;

my @files = (run @cmd, :out).out.slurp(:close).lines;
for @files -> $f {
  my @lines = $f.IO.slurp.lines;
  for @lines {
    if /'constant' \s+ 'forced' \s* '=' \s* (\d+) \s* ';' (.+)? $ / {
      (my $nv =  $0.Int)++;
      my $m = $/.Str;
      s/"{ $m }"/constant forced = { $nv };{ $1 // '' }/;
      say "$f force count bumped to { $nv }";
      last;
    }
  }

  # Can't write directly, so have to play the shell game.
  "{ $f }.lock".IO.open(:w).spurt(@lines.join("\n"), :close);
  $f.IO.rename("{ $f }.bump");
  "{ $f }.lock".IO.rename($f);
}
