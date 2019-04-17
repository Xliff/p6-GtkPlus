use v6.c;

# Example ported from:
# https://developer.gnome.org/gtk-tutorial/stable/x1390.html

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::ButtonBox;
use GTK::Frame;

# $cw and $ch are never used in the original.
sub create_box($h, $t, $s, $cw, $ch, $l) {
  my $f  = GTK::Frame.new($t);
  my $bb = $h ?? GTK::ButtonBox.new-hbox !! GTK::ButtonBox.new-vbox;
  my ($b-ok, $b-cancel, $b-help) = (
    GTK::Button.new_from_icon_name('gtk-ok', GTK_ICON_SIZE_BUTTON),
    GTK::Button.new_from_icon_name('gtk-cancel', GTK_ICON_SIZE_BUTTON),
    GTK::Button.new_from_icon_name('gtk-help', GTK_ICON_SIZE_BUTTON)
  );
  ($b-ok.label, $b-cancel.label, $b-help.label) = <OK Cancel Help>;
  $bb.add($_) for ($b-ok, $b-cancel, $b-help);
  ($bb.border_width, $bb.layout, $bb.spacing) = (5, $l, $s);
  $f.add($bb);
  $f;
}

my $a = GTK::Application.new( title => 'org.genex.buttonbox' );

$a.activate.tap({
  my ($fh, $fv, $mv, $v, $h, $b) = (
    GTK::Frame.new("Horizontal Button Boxes"),
    GTK::Frame.new("Vertical Button Boxes"),
    GTK::Box.new-vbox,
    GTK::Box.new-vbox,
    GTK::Box.new-hbox
  );

  ($v.border_width, $h.border_width) = 10 xx 2;
  $fh.add($v);
  $fv.add($h);
  $mv.pack_start($fh, True, True, 10);
  $mv.pack_start($fv, True, True, 10);
  $a.window.title = "Button Boxes";
  $a.window.border_width = 10;
  $a.window.add($mv);

  $b = create_box(True, 'Spread (spacing 40)', 40, 85, 20, GTK_BUTTONBOX_SPREAD);
  $v.pack_start($b, True, True, 0);
  $b = create_box(True, 'Edge (spacing 30)', 30, 85, 20, GTK_BUTTONBOX_EDGE);
  $v.pack_start($b, True, True, 5);
  $b = create_box(True, 'Start (spacing 20)', 20, 85, 20, GTK_BUTTONBOX_START);
  $v.pack_start($b, True, True, 5);
  $b = create_box(True, 'End (spacing 10)', 10, 85, 20, GTK_BUTTONBOX_END);
  $v.pack_start($b, True, True, 5);

  $b = create_box(False, 'Spread (spacing 5)', 5, 85, 20, GTK_BUTTONBOX_SPREAD);
  $h.pack_start($b, True, True, 0);
  $b = create_box(False, 'Edge (spacing 30)', 30, 85, 20, GTK_BUTTONBOX_EDGE);
  $h.pack_start($b, True, True, 5);
  $b = create_box(False, 'Start (spacing 20)', 20, 85, 20, GTK_BUTTONBOX_START);
  $h.pack_start($b, True, True, 5);
  $b = create_box(False, 'End (spacing 5)', 20, 85, 20, GTK_BUTTONBOX_END);
  $h.pack_start($b, True, True, 0);

  $a.window.show_all;
});

$a.run;
