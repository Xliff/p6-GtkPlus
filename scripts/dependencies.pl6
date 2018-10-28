use v6.c;

use File::Find;
use Dependency::Sort;

my %nodes;

my @files = find
  dir => 'lib',
  name => /'.pm6' $/,
  exclude => / 'lib/GTK.pm6' | 'lib/GTK/Compat/GFile.pm6' /;

my @modules = @files
  .map( *.path )
  .map({ my $mn = $_; [ $mn, S/ '.pm6' // ] })
  .map({ $_[1] = $_[1].split('/').Array[1..*].join('::'); $_ })
  .sort( *[1] );

for @modules {
  %nodes{$_[1]} = (
    itemid => $++,
    filename => $_[0],
    edges => [],
    name => $_[1]
  ).Hash;
}

my $s = Dependency::Sort.new;
my @others;
for %nodes.pairs.sort( *.key ) -> $p {
  say "Processing requirements for module { $p.key }...";

  my $f = $p.value<filename>;
  my $m = $f.IO.open.slurp-rest ~~ m:g/'use' \s+ $<m>=((\w+)+ % '::') \s* ';'/;
  for $m.list -> $mm {
    my $mn = $mm;
    $mn ~~ s/'use' \s+//;
    $mn ~~ s/';' $//;
    unless $mn ~~ /^ 'GTK'/ {
      @others.push: $mn;
      next;
    }
    %nodes{$p.key}<edges>.push: $mn;
    $s.add_dependency(%nodes{$p.key}, %nodes{$mn}) unless $mn eq 'GTK';
  }
}

say "\nA resolution order is:";

my @module-order;
if !$s.serialise {
  die $s.error_message;
} else {
  @module-order.push($_<name>) for $s.result;
}
my $list = @module-order.grep(* ne 'GTK::Builder').join("\n");
"BuildList".IO.open(:w).say($list);
say $list;

say "\nOther dependencies are:\n";
say @others.unique.sort.join("\n");

sub space($a) {
  ' ' x ($a.chars % 8);
}

{
  # Not an optimal solution, but it will work with editing.
  # Want to take the longest of $_[0], add a number of spaces
  # equal the difference between the size plus the previous number modulo 8
  use Text::Table::Simple;
  say "\nProvides section:\n";
  my $table = lol2table(@modules.map({ $_.reverse.map({ qq["$_"] }) }),
    rows => {
      column_separator => ': ',
      corner_marker    => ' ',
      bottom_border    => ''
    },
    headers => {
      top_border       => '',
      column_separator => '',
      corner_marker    => '',
      bottom_border    => ''
    },
    footers => {
      column_separator => '',
      corner_marker    => '',
      bottom_border    => ''
    }
  ).join("\n");
  $table ~~ s:g/^^':'//;
  $table ~~ s:g/':' \s* $$/,/;
  $table ~~ s/',' \s* $//;
  say $table;
}
