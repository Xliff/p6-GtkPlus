use v6.c;

use NativeCall;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Button;
use GTK::ColorChooser;
use GTK::CSSProvider;

my $a = GTK::Application.new( :title('org.genex.color_choose_test') );

$a.activate.tap: SUB {
  my $cc = GTK::ColorChooser.new;
  my $vbox = GTK::Box.new-vbox(10);
  my $sel-b = GTK::Button.new_with_label('Select');
  my $sw-b = GTK::Button.new_with_label('Switch');
  # Needed for CSS.
  $vbox.name = 'box';
  $sel-b.no-show-all = True;

  sub change-color ($color) {
    state $css = GTK::CSSProvider.new;
    $css.load_from_data("#box \{ background-color: { $color.to_string }; \}");
  }

  $cc.color-activated.tap: SUB {
    change-color($cc.rgba);
  }

  $sw-b.clicked.tap: SUB {
    ($cc.show-editor = $cc.show-editor.not) ?? $sel-b.show !! $sel-b.hide;
  }

  $sel-b.clicked.tap: SUB {
    # Add to the palette.
    change-color($cc.rgba = $cc.rgba);
    $cc.show-editor = False;
    $sel-b.hide;
  }

  $vbox.pack_start($_, False, True, 2) for $cc, $sel-b, $sw-b;

  $a.window.add($vbox);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.show_all;
}

$a.run;
