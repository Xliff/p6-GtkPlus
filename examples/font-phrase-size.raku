use v6.c;

use GLib::Raw::Subs;

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
    $l.text = $e.text.chars ?? "{ $w } X { $h }" !! ''
  }

  $f.font-set.tap: SUB {
    $pl.font-desc = $f.font-desc;
    update-size;
  }

  $e.changed.tap: SUB {
    $pl.set-markup( "<span foreground=\"white\">{ $e.text }</span>" );
    update-size
  }

  $s.add($d);
  $h.pack-start($f);
  $h.pack-start($e, True, True);
  $v.pack_start($h);
  $v.pack_start($s, True, True);
  $v.pack-start($l);

  $app.window.add($v);
  $app.window.show-all;
}

$app.run;
