use v6.c;

use GTK::Raw::Types;

use GDK::RGBA;
use GTK::Application;
use GTK::Button;
use GTK::ColorButton;
use GTK::Grid;
use GTK::Label;
use GTK::TextTag;
use GTK::TextTagTable;
use GTK::TextView;

my $app = GTK::Application.new( title => 'org.genex.grid' );

$app.activate.tap: SUB {
  my $g = GTK::Grid.new( column-spacing => 8 );

  my $r = 0;
  for ^5 {
    my $n     = "Rule { $_ }";
    my $tag   = GTK::TextTag.new($_);
    my $table = GTK::TextTagTable.new;
    $table.add($tag);

    my ($fgc, $bgc) = sprintf('#%02x%02x%02x', |( (40..200).pick xx 3 )) xx 2;
    my ($fg,  $bg ) = GDK::RGBA.new xx 2;
    .head.parse( .tail ) for ($fg, $bg) Z ($fgc, $bgc);

    my $l = GTK::Label.new($n);

    ( .background-set, .foreground-set, .foreground-rgba, .background-rgba ) =
      (True, True, $fg, $bg) given $tag;

    my $b = GTK::TextBuffer.new($table);
    my $e = GTK::TextView.new($b);
    $e.buffer.append-with-tag(' @@@ ', $tag);

    my ($b1, $b2) = ($fgc, $bgc).map({ GTK::ColorButton.new-from-hex($_) });

    $g.attach(.tail, .head, $r) for ($l, $e, $b1, $b2).kv.rotor(2);
    $r++;
  }

  $app.window.add($g);
  $app.window.show_all;
}

$app.run;
