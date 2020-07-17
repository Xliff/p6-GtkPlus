use v6;

use lib '.';

use GTKScripts;

my $tot = gather for get-module-files -> $m {
  my $contents = $m.slurp;
  my $lines = 0;
  for $contents.lines.kv -> $k, $v {
    ++$lines if .ends-with(';' | '{')
    if .ends-with('}') {
      ++$lines;
      ++$lines unless $k == 0 || $contents.lines[$k - 1].ends-with(';' | '{')
    }
  }
  say "{ $m.basename } -- { $lines }"
  take $lines;
}).sum;

say "Total lines of code in { $*PWD.absolute }: $tot";
