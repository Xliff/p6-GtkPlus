use v6.c;

use File::Find;
use Dependency::Sort;

my %nodes;

my @files = find
  dir => 'lib',
  name => /'.pm6' $/,
  exclude => / 'lib/GTK/Compat/GFile.pm6' /;

my @modules = @files
  .map( *.path )
  .map({
    my $mn = $_;
    my $a = [ $mn, S/ '.pm6' // ];
    $a[1] = do given $a[1] {
      when 'lib/GTK.pm6' { 'GTK' }
      default            { .split('/').Array[1..*].join('::') }
    }
    $a;
  })
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

  my token useneed { 'use' | 'need' }
  my $f = $p.value<filename>;
  my $m = $f.IO.open.slurp-rest ~~ m:g/<useneed>  \s+ $<m>=((\w+)+ % '::') \s* ';'/;
  for $m.list -> $mm {
    my $mn = $mm;
    $mn ~~ s/<useneed> \s+//;
    $mn ~~ s/';' $//;
    unless $mn ~~ /^ 'GTK'/ {
      @others.push: $mn;
      next;
    }

    #%nodes{$p.key}<edges>.push: $mn;
    #say "P: {$p.key} / { %nodes{$p.key}.gist }";

    $s.add_dependency(%nodes{$p.key}, %nodes{$mn});
  }
}

say "\nA resolution order is:";

my @module-order;
if !$s.serialise {
  die $s.error_message;
} else {
  @module-order.push( $_<name> => $++ ) for $s.result;
}
my %module-order = @module-order.Hash;
my $list = @module-order.map({ $_.key }).join("\n");
"BuildList".IO.open(:w).say($list);
say $list;

# Add module order to modules.
$_.push( %module-order{$_[1]} ) for @modules;

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
  my $table = lol2table(
    @modules.sort({
      ($^a[2] // 0).Int <=> ($^b[2] // 0).Int
    }).map({
      $_.reverse.map({ qq["{ $_ // '' }"] })[1..2]
    }),
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
  $table ~~ s:g/^^':'/    /;
  $table ~~ s:g/':' \s* $$/,/;
  $table ~~ s/',' \s* $//;

  my $extra = 'META6.json';
  if $extra.IO.e {
    my $meta = $extra.IO.slurp;
    $meta ~~ s/ '"provides": ' '{' ~ '}' <-[\}]>+ /"provides": \{\n{$table}\n    }/;
    $extra.IO.rename("{ $extra }.bak");
    my $fh = $extra.IO.open(:w);
    $fh.say: $meta;
    $fh.close;

    say 'New provides section written to META6.json.';
  } else {
    say $table;
  }
}
