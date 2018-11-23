use v6.c;

use SVG;
use JSON::Fast;

my @bl = "BuildList".IO.slurp.lines;
my (%order, @points, @dp);
my $idx = 0;
%order{$_} = $idx++ for @bl;

my %data = from-json('stats/LastBuildResults-20181123.json'.IO.slurp);
@points[%order{$_}] = %data{$_} for %data.keys;

my @text-lines;
my @polyline;
$idx = 0;
for @bl {
  my $a = text => [ :x(20), :y(10 + $idx * 30), :font-size(8), $_ ];
  my ($px, $py) = ( (200 + @points[$idx]<parse> * 25).Int, 6 + $idx * 30);
  my $c = circle => [
    :cx($px), :cy($py), :r(4), :fill<red>,
    title => [ @points[$idx++]<parse> ]
  ];
  @polyline.push: "{$px},{$py}";
  @text-lines.push: $a;
  @dp.push: $c;
}

my $s = SVG.serialize('svg' => [
  :width(700), :height(10 + @bl.elems * 30),
  |@text-lines,
  polyline => [
    :points(@polyline.join(' ')),
    :style<fill:none;stroke:red;stroke-width:3>
  ],
  |@dp
]);

say $s;
