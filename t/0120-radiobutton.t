use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::RadioButton;

my $a = GTK::Application.new(
  title => 'org.genex.radiobutton',
  width => 200,
  height => 100,
);

$a.activate.tap({
  my @group = GTK::RadioButton.new-group(
    'Radio Button 1',
    'Radio Button 2',
    'Radio Button 3'
  );

  # It's better to use a loop variable, not $_, in closures!
  for @group -> $r {
    $r.clicked.tap({ say "{ $r.label } set active." if $r.active })
  }

  # This will cause a MoarVM panic in current rakudo.
  # die 'Will this crash?';

  my $box = GTK::Box.new-vbox;
  for @group {
    ($_.margin_left, $_.margin_right) = 20 xx 2;
    $box.pack_start($_, False, False, 4);
  }
  $a.window.add($box);
  $a.window.show_all;
});

$a.run;
