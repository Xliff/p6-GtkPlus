use v6.c;

use GTK::Application;
use GTK::ComboBoxText;

my $a = GTK::Application.new(
  title => 'org.genex.comboboxtext',
  width  => 150,
  height => 100
);

$a.activate.tap({
  my @options = ('something', 'something else', 'something or other');
  my $c = GTK::ComboBoxText.new(@options);
  $c.active = 1;
  $c.changed.tap({ say 'Combo changed: ' ~ $c.get_active_text; });
  $a.window.add($c);
  $a.window.show_all;
});

$a.run;
