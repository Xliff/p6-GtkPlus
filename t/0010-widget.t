use v6.c;

use Test;

use NativeCall;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Button;
use GTK::Box;

my $a = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

$a.activate.tap: SUB {
  my $box = GTK::Box.new-vbox(6);
  my ($b1, $b2, $b3) = (
    GTK::Button.new_with_label('Click Me'),
    GTK::Button.new_with_mnemonic('_Open'),
    GTK::Button.new_with_mnemonic('_Close')
  );

  $a.window.add($box);

  say "Button 1 CLICKED status: { $b1.is-connected('clicked') }";
  $b1.clicked.tap: SUB { say 'Click me button was clicked'; }
  say "Button 1 CLICKED status: { $b1.is-connected('clicked') }";
  say "Button 2 CLICKED status: { $b2.is-connected('clicked') }";
  $b2.clicked.tap: SUB { say 'Open button was clicked'; }
  say "Button 2 CLICKED status: { $b2.is-connected('clicked') }";
  say "Button 3 CLICKED status: { $b3.is-connected('clicked') }";
  $b3.clicked.tap: SUB { say 'Closing application.'; $a.exit; }
  say "Button 3 CLICKED status: { $b3.is-connected('clicked') }";
  $box.pack_start($b1, True, True, 0);
  $box.pack_start($b2, True, True, 0);
  $box.pack_start($b3, True, True, 0);
  $a.show_all;
};

$a.run;
