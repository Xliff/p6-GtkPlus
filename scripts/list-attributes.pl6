use v6.c;

my $c = @*ARGS[0].IO.slurp;
my $m =
$c ~~ m:g/"method " (<[-_\w]>+) " is rw"/;
my @a = gather for $m.Array {
  take .[0].Str
;}
for @a.sort {
  my $alias = "";
  $alias = S:g/\-/_/ if .contains("-");
  say "$_\t\t$alias"
}
