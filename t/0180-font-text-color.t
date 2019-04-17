use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::ButtonBox;
use GTK::CSSProvider;
use GTK::Dialog::ColorChooser;
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
  # Create controls and dialogs.
  my $t   = GTK::TextView.new;
  my $bb  = GTK::ButtonBox.new-hbox;
  my $vb  = GTK::Box.new-vbox;
  my $fb  = GTK::Button.new_from_icon_name('gtk-select-font', GTK_ICON_SIZE_BUTTON);
  my $cb  = GTK::Button.new_from_icon_name('gtk-color-picker', GTK_ICON_SIZE_BUTTON);
  my $ob  = GTK::Button.new_from_icon_name('gtk-ok', GTK_ICON_SIZE_BUTTON);
  my $f   = GTK::Frame.new(' TextView ');
  my $bf  = GTK::Frame.new(' Buttons ' );
  my $s   = GTK::ScrolledWindow.new;
  my $fcd = GTK::Dialog::FontChooser.new("Select a font", $a.window);
  my $ccd = GTK::Dialog::ColorChooser.new("Select a background color", $a.window);

  # Create TextView and add it to Frame.
  $f.border_width = $bf.border_width = 10;
  $f.set_size_request(280, 380);
  $f.margins = 10;
  $bf.margins = 10;
  ($t.margin_left, $t.margin_right) = (10 xx 2);
  $t.name = 'tview';
  $t.text = 'This is a test of the dialog.';
  $t.wrap_mode = GTK_WRAP_WORD;
  ($t.margin_top, $t.margin_bottom) = (5, 15);
  $s.set_policy(GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);
  $s.add($t);
  $f.add($s);

  # Add buttons to button frame.
  ($fb.label, $cb.label, $ob.label) = <Font Color OK>;
  ($fb.margin_bottom, $cb.margin_bottom, $ob.margin_bottom) = 10 xx 3;
  ($bb.border_width, $bb.layout, $bb.spacing) = (5, GTK_BUTTONBOX_SPREAD, 20);
  $bb.add($_) for ($fb, $cb, $ob);
  $bf.add($bb);

  # OK Button Event
  $ob.clicked.tap({
    say $t.text;
    $a.exit;
  });
  # Font Button Event
  $fb.clicked.tap({
    my $rc = $fcd.run;
    say "Font Dialog Response: " ~ $rc;
    if $rc == GTK_RESPONSE_OK {
      say "Selected font: " ~ $fcd.font;
      $t.override_font( $fcd.font_desc );
    }
    $fcd.hide;
  });
  # Color Button Event
  $cb.clicked.tap({
    my $rc = $ccd.run;
    say "Color Dialog Response: " ~ $rc;
    if $rc == GTK_RESPONSE_OK {
      my $c = $ccd.rgba.to_string;
      my $css = GTK::CSSProvider.new;
      my $css-s = "#tview text \{ color: { $c }; \}";

      say "Selected color: " ~ $c;
      $css.load_from_data($css-s);
    };

    $ccd.hide;
  });

  $vb.pack_start($_, False, False, 0) for ($f, $bf);

  # === FOR REFERENCE! ===
  # What is a better place to put last minute, must run code.
  # Through GTK we have two methods, GTK::Application.shutdown and
  # GTK::Window.destroy-signal on the main window.
  #
  # Both pieces of shutdown code CANNOT run in the same code path.
  #
  # A pure Perl6 implementation may be necessary. (Phasers?)
  #
  # Proposed solution:
  my $shutdown-latch = False;
  $a.window.destroy-signal.tap({
    # If exited by corner close button.
    $shutdown-latch = True;
    $t.text;
  });
  $a.shutdown.tap({
    # If exited by OK Button
    unless $shutdown-latch {
      #...
    }
  });
  # Of course, an even simpler solution would be to put the shutdown logic
  # In the handler for the OK button AND in destroy-signal, and leave
  # application.shutdown for resource cleanup!!

  $a.window.add($vb);
  $a.window.show_all;
});

$a.run;
