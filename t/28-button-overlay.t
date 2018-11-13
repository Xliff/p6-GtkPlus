use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Entry;
use GTK::Grid;
use GTK::Label;
use GTK::Overlay;

my $a = GTK::Application.new( title => 'org.gtk.numbers-overlay' );

$a.activate.tap({
  my ($o, $g, @b, $v, $l, $e);

  $a.window.set_default_size(500, 510);
  $a.window.title = 'Interactive Overlay';

  $o = GTK::Overlay.new;
  $g = GTK::Grid.new;
  $e = GTK::Entry.new;
  $o.add($g);
  $e.placeholder_text = 'Your Lucky Number';

  for (^5) -> $j {
    for (^5) -> $i {
      my $b = GTK::Button.new_with_label(5 * $j + $i);

      $b.hexpand = $b.vexpand = True;
      $g.attach($b, $i, $j, 1, 1);
      $b.clicked.tap({
        $e.text = $b.label;
      });
      @b.push: $b;
    }
  }

  $v = GTK::Box.new-vbox(10);
  $o.add_overlay($v);
  $o.set_overlay_pass_through($v, True);
  $v.halign = $v.valign = GTK_ALIGN_CENTER;

  $l = GTK::Label.new(qq:to/L/.chomp);
<span foreground='blue' weight='ultrabold' font='40'>Numbers</span>
L

  $l.use_markup = True;
  $v.pack_start($l, False, False, 8);
  $v.pack_start($e, False, False, 8);
  $a.window.add($o);
  $a.window.show_all;
});

$a.run;
