use v6.c;

use SVG;
use JSON::Fast;

sub MAIN ($filename) {
  my @bl = "BuildList".IO.slurp.lines;
  my (%order, @points, @dp);
  my $idx = 0;
  %order{$_} = $idx++ for @bl;

  my %data = from-json($filename.IO.slurp);
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
  my $avg-parse = %data.values.map( *<parse> ).sum / %data.keys.elems;  
  my ($x0, $y1) = (200 + 25 * $avg-parse, 10 + @points.elems * 30);
  my $s = SVG.serialize('svg' => [
    :width(700), :height(10 + @bl.elems * 30),
    |@text-lines,
    polyline => [
      :points(@polyline.join(' ')),
      :style<fill:none;stroke:red;stroke-width:3>
    ],
    line => [
      :x1($x0), :y1(0), :x2($x0), :y2($y1),
      :style<stroke:red;stroke-width:1>
    ],
    |@dp
  ]);

  my $f = "$filename.svg".IO.open;
  $f.put($s);
  $f.close;
}
