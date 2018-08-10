use v6.c;

use Test;

use NativeCall;

use GTK::Application;
use GTK::Button;
use GTK::Box;

my $a = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

$a.activate.tap({
  my $box = GTK::Box.new-vbox(6);
  my ($b1, $b2, $b3) = (
    GTK::Button.new_with_label('Click Me'),
    GTK::Button.new_with_mnemonic('_Open'),
    GTK::Button.new_with_mnemonic('_Close')
  );

  $a.window.add($box);
  $b1.clicked.tap({ say 'Click me button was clicked'; });
  $b2.clicked.tap({ say 'Open button was clicked'; });
  $b3.clicked.tap({ say 'Closing application.'; $a.exit; });
  $box.pack_start($b1, True, True, 0);
  $box.pack_start($b2, True, True, 0);
  $box.pack_start($b3, True, True, 0);
  $a.show_all;
});

$a.run;
