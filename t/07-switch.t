use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Label;
use GTK::Switch;

my $a = GTK::Application.new(
  :title('org.genex.switch_example'),
  :width(200),
  :height(60)
);

$a.activate.tap({
  my $vbox   = GTK::Box.new-vbox(4);
  my $hbox   = GTK::Box.new-hbox(6);
  my $title  = GTK::Label.new;
  my $slabel = GTK::Label.new;
  my $switch = GTK::Switch.new;

  $a.window.set_size_request(150, 40);

  $slabel.margin_left = 40;
  $slabel.margin_right = 20;
  $switch.state-changed.tap({
    $slabel.label = $switch.active.Str.uc;
  });

  $title.label = 'GTK::Switch Example';
  $hbox.pack_start($slabel, False, False, 0);
  $hbox.pack_start($switch, False, False, 0);
  $vbox.pack_start($title, False, False, 0);
  $vbox.pack_start($hbox, False, False, 0);


  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run;
