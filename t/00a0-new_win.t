use v6.c;

use GTK::Application;
use GTK::Window;
use GTK::Box;
use GTK::Button;
use GTK::Raw::Types;

my $app = GTK::Application.new(
  title  => 'org.genex.test.widget',
  width  => 400,
  height => 400
);

sub new-win () {
	my $window = GTK::Window.new( GTK_WINDOW_TOPLEVEL, :title<NewWin> );
  $window.decorated = True;
	$window.show;
	$app.add_window: $window;
}

$app.activate.tap( SUB {
  my $box = GTK::Box.new-vbox(6);
  my GTK::Button $new-win .= new_with_label: <new-win>;

  $new-win.clicked.tap: SUB { new-win };
  $box.pack_start($new-win, False, True, 0);

  $app.window.destroy-signal.tap: SUB { $app.exit };

  $app.window.add: $box;
  $app.show_all;
});

$app.run;

INIT {
	.say for MY::.keys.sort;
}
	
