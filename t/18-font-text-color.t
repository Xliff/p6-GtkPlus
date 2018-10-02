use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::ButtonBox;
use GTK::Dialog::FontChooser;
use GTK::Frame;
use GTK::ScrolledWindow;
use GTK::TextBuffer;
use GTK::TextView;

my $a = GTK::Application.new(
  :title('org.genex.font-text-color'),
  :width(300),
  :height(500)
);

$a.activate.tap({
  my $t  = GTK::TextView.new();
  my $bb = GTK::ButtonBox.new-hbox;
  my $vb = GTK::Box.new-vbox;
  my $fb = GTK::Button.new_from_icon_name('gtk-select-font', GTK_ICON_SIZE_BUTTON);
  my $cb = GTK::Button.new_from_icon_name('gtk-color-picker', GTK_ICON_SIZE_BUTTON);
  my $ob = GTK::Button.new_from_icon_name('gtk-ok', GTK_ICON_SIZE_BUTTON);
  my $f  = GTK::Frame.new(' TextView ');
  my $bf = GTK::Frame.new(' Buttons ' );
  my $s  = GTK::ScrolledWindow.new;

  $f.border_width = $bf.border_width = 10;
  ($f.margin_top, $f.margin_bottom, $f.margin_left, $f.margin_right) =
  ($bf.margin_top, $bf.margin_bottom, $bf.margin_left, $bf.margin_right) =
    (10 xx 4);
  ($t.margin_left, $t.margin_right) = (10 xx 2);
  $t.name = 'tbox';
  $f.set_size_request(280, 380);
  $t.wrap_mode = GTK_WRAP_WORD;
  ($t.margin_top, $t.margin_bottom) = (5, 15);
  $s.set_policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
  $s.add($t);
  $f.add($s);

  ($fb.label, $cb.label, $ob.label) = <Font Color OK>;
  ($fb.margin_bottom, $cb.margin_bottom, $ob.margin_bottom) = 10 xx 3;
  ($bb.border_width, $bb.layout, $bb.spacing) = (5, GTK_BUTTONBOX_SPREAD, 20);
  $bb.add($_) for ($fb, $cb, $ob);
  $bf.add($bb);

  $ob.clicked.tap({ $a.exit; });
  $fb.clicked.tap({
    my $fcd = GTK::Dialog::FontChooser.new("Select a font", $a.window);

    $fcd.font-activated.tap({
      say "Selected font: " ~ $fcd.font;
      $t.override_font( $fcd.font_desc );
    });

    $fcd.run;
  });
  $cb.clicked.tap({
    my $ccd = GTK::Dialog::ColorChooser.new("Select a background color", $a.window);

    $ccd.color-activated.tap({
      my $c = $ccd.rgba.to_string;
      my $css = GTK::CSSProvider.new;
      my $css-s = "#tbox \{ background-color: { $c }; \}";

      say "Selected color: " ~ $c;
      $css.load_from_data($css-s);
    });

    $ccd.run;
  });

  $vb.pack_start($_, False, False, 0) for ($f, $bf);

  $a.window.destroy-signal.tap({
    say $t.text;
  });

  $a.window.add($vb);
  $a.window.show_all;
});

$a.run;
