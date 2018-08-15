use v6.c;

use GTK::Application;
use GTK::ColorChooser;

my $a = GTK::Application.new( :title('org.genex.color_choose_test') );

$a.activate.tap({
  my $cc = GTK::ColorChooser.new();
  $a.window.add($cc);
  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.show_all;
});

$a.run;
