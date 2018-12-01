use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;

use GTK::Application;
use GTK::Button;
use GTK::ColorChooser;
use GTK::CSSProvider;

my $a = GTK::Application.new( :title('org.genex.color_choose_test') );

$a.activate.tap({
  my $cc = GTK::ColorChooser.new;
  my $vbox = GTK::Box.new-vbox(10);
  my $button = GTK::Button.new_with_label('Switch');
  # Needed for CSS.
  $vbox.name = 'box';

  $cc.color-activated.tap({
    my $color = $cc.rgba;
    my $css = GTK::CSSProvider.new;
    my $css-s = "#box \{ background-color: { $color.to_string }; \}";

    $css.load_from_data($css-s);
  });
  $button.clicked.tap({ $cc.show-editor = $cc.show-editor.not });

  $vbox.pack_start($cc, False, True, 2);
  $vbox.pack_start($button, False, True, 2);

  $a.window.add($vbox);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.show_all;
});

$a.run;
