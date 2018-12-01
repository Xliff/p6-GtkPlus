use v6.c;

use JSON::Fast;
use RandomColor;
use SVG;

my %graph-data;

sub MAIN (*@filenames) {
  my @bl = "BuildList".IO.slurp.lines;
  my (%order, @points);
  my $idx = 0;
  %order{$_} = $idx++ for @bl;

  # Ascending order. Last results on top. Most of these files have a date
  # serial, although if we convert them to IO paths, we could use generation
  # date. I guess we can make these options if we want to get schmansy
  @filenames.sort;

  #  Generate random colors. Using date of initial completion as the current
  #  seed. This will change to something more presentable, if necessary.
  my @colors = RandomColor.new(
    seed   => 20181127,
    count  => +@filenames,
    format => 'color'
  ).list;

  my @legend;
  for @filenames.kv -> $k, $v {
    my $l = text => [
      :x(20),
      :y(10 + $k * 15),
      :font-size(6),
      :style("fill:{ @colors[$k].to-string('rgb') }"),
      $v.subst('.json', '')
    ];
    @legend.push: $l;
  }

  my ($c, $yo) = (0, 25 + 15 * @filenames.elems);
  die "Cannot load '$_'!" unless .IO.e for @filenames;
  for @filenames -> $filename {
    my (@text-lines, @polyline, @dp);
    my %data = from-json($filename.IO.slurp);

    for %data.keys {
      next if $_ eq 'SUMMARY';
      @points[%order{$_}] = %data{$_};
    }

    my $rgbh = @colors[$c].lighten(10).to-string('rgb');
    my $rgb = @colors[$c++].to-string('rgb');
    $idx = 0;
    for @bl -> $bl {
      if %graph-data<text>:!exists {
        my $p = text => [ :x(20), :y($yo + $idx * 30), :font-size(8), $bl ];
        @text-lines.push: $p;
      }

      (my $sname = $filename) ~~ s/ 'LastBuildResults-' //;
      with @points[$idx] {
        my ($px, $py) = ( (200 + @points[$idx]<parse> * 25).Int,
                          $yo + $idx * 30 );
        @polyline.push: "{$px},{$py}";
        @dp.push: (circle => [
          :cx($px), :cy($py), :r(4), :fill($rgb),
          title => [ "{ $sname } - { @points[$idx]<parse> }" ]
        ]);
      }
      $idx++;
    }

    %graph-data<text> //= @text-lines;

    my $avg-parse = %data.values.map( *<parse> ).sum / %data.keys.elems,
    my ($x0, $y1) = (200 + 25 * $avg-parse, 10 + @points.elems * 30);
    my $l-style = "stroke:{ $rgbh };stroke-width:1";
    my $pl-style = "fill:none;stroke:{ $rgb };stroke-width:3";
    %graph-data<series>.push: [
      line   => [ :x1($x0), :y1(0), :x2($x0), :y2($y1), :style($l-style) ],
      polyline => [ :points(@polyline.join(' ')), :style($pl-style) ],
      |@dp
    ];
  }

  my $svg = [
    width => 700,
    height => 10 + @bl.elems * 30,
    |@legend,
    |%graph-data<text>,
  ];

  # Labelling?
  $svg.push: |$_ for %graph-data<series>.values;

  my $outputname = @filenames[0];
  if @filenames.elems > 1 {
    my $ser = DateTime.now(
      formatter => {
        sprintf "%4d%02d%02d-%02d%02d", .year, .month, .day, .hour, .minute
      }
    );
    $outputname = "OutputGraph-{ $ser }";
  }

  my $f = "$outputname.svg".IO.open(:w);
  $f.say( SVG.serialize( svg => $svg ) );
  $f.close;
}
