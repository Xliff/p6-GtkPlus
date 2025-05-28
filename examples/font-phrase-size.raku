use v6.c;

use GLib::Raw::Subs;

use Cairo;
use Pango::Cairo;
use Pango::FontDescription;
use GTK::Application;
use GTK::Box;
use GTK::DrawingArea;
use GTK::Entry;
use GTK::FontButton;
use GTK::Label;
use GTK::ScrolledWindow;

my $app = GTK::Application.new(
  title  => 'org.genex.gtk.font.measure',
  width  => 1024,
  height => 450
);

$app.activate.tap: SUB {
  my $f  = GTK::FontButton.new;
  my $d  = GTK::DrawingArea.new;
  my $e  = GTK::Entry.new;
  my $s  = GTK::ScrolledWindow.new;
  my $h  = GTK::Box.new-hbox;
  my $v  = GTK::Box.new-vbox;
  my $l  = GTK::Label.new;
  my $pl = $d.create-pango-layout;

  $l.pango-context.font-desc =
    Pango::FontDescription.new-from-string("Sans 24");

  sub update-size {
    my ($w, $h) = $pl.pixel-size;
    $l.text = $e.text.chars ?? "{ $w } X { $h }" !! '';
    $d.invalidate;
  }

  $f.font-set.tap: SUB {
    $pl.font-desc = $f.font-desc;
    update-size;
  }

  $e.changed.tap: SUB {
    $pl.text = $e.text;
    update-size;
  }

  $d.draw.tap: SUB {
    my ($c, $pc) = ( $_, Pango::Cairo.new($_) ) given $*A[1];

    $c.rgba(0, 0, 0, 0);
    $c.operator = CAIRO_OPERATOR_CLEAR;
    $c.paint;
    $c.rgba(1, 1, 1, 1);
    $c.operator = CAIRO_OPERATOR_SOURCE;
    $pc.show-layout($pl);
    $*A.tail.r = 1;
  }

  #$s.add($d);
  $h.pack-start($f);
  $h.pack-start($e, True, True);
  $v.pack_start($h);
  $v.pack_start($d, True, True);
  $v.pack-start($l);

  $app.window.add($v);
  $app.window.show-all;
}

$app.run;
