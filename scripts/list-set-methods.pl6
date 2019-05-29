use v6.c;

my $c = @*ARGS[0].IO.slurp;
my $m = $c ~~ m:g/"method set_" (<[-_\w]>+)/;
my @a = gather for $m.Array { take .[0].Str };
for @a.sort {
  my $alias = "";
  $alias = S:g/_/-/ if .contains("_"); say "$_\t\t$alias"
}
