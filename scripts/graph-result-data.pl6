use v6.c;

use JSON::Fast;
use RandomColor;
use SVG;

my %graph-data;

sub MAIN (*@filenames) {
  my @bl = "BuildList".IO.slurp.lines;
  my (%order, @points);
  my $idx = 0;
  for @bl {
    %order{$_} = $idx++ ;
    #"{$_}: $idx".say;
  }

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
      next if $_ eq <SUMMARY DEPENDENCIES>.any;

      # Remove outdated stat.
      next if $_ eq 'GTK::Plus';

      my $n = $_;

      # Fixes long standing bug with renamed file.
      $n = 'GTK::ShortcutsWindow'       if $n eq 'GTK::ShorcutsWindow';

      # Adjustment from 580d13887aaf1e4504ee719eca91f0786806c276 where
      # ::TreeRow was renamed to ::TreeRowReference
      $n = 'GTK::TreeRowReference'      if $n eq 'GTK::TreeRow';

      # Adjustment from e8c4c74070c5f00924e8e35949e8c52dfd3c9a34 where
      # ::Compat::Action was made into ::Compat::Roles::Action
      $n = 'GTK::Compat::Roles::Action' if $n eq 'GTK::Compat::Action';

      # Adjustment from ab3d879ddb303371fb1ca00d8d7d6446414420e7 where
      # ::Compat::File was replaced with ::Compat::Roles::GFile
      $n = 'GTK::Compat::Roles::GFile'  if $n eq 'GTK::Compat::File';

      without %order{$n} {
        $n.say;
        exit;
      }
      @points[%order{$n}] = %data{$n};
    }

    my $rgbh = @colors[$c].lighten(10).to-string('rgb');
    my $rgb = @colors[$c++].to-string('rgb');
    $idx = 0;
    (my $sname = $filename) ~~ s/ 'LastBuildResults-' //;
    for @bl -> $bl {
      if %graph-data<text>:!exists {
        my $p = text => [ :x(20), :y($yo + $idx * 30), :font-size(8), $bl ];
        @text-lines.push: $p;
      }

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
    my ($x0, $y1) = (200 + 25 * $avg-parse, $yo + @points.elems * 30);
    my $l-style = "stroke:{ $rgbh };stroke-width:1";
    my $pl-style = "fill:none;stroke:{ $rgb };stroke-width:3";
    %graph-data<series>.push: [
      line   => [
        :x1($x0), :y1(0), :x2($x0), :y2($y1), :style($l-style),
        title => [ "{ $sname } - Avg: { $avg-parse }s" ]
      ],
      polyline => [ :points(@polyline.join(' ')), :style($pl-style) ],
      |@dp
    ];
  }

  my $svg = [
    width => 900,
    height => 25 + @filenames.elems * 15 + @bl.elems * 30,
    style => [ 'svg { background-color: #333333; } text { fill: #cccccc; }' ],
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
