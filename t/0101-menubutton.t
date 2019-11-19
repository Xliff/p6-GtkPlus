use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::HeaderBar;
use GTK::MenuButton;

my $a = GTK::Application.new(
  title  => 'org.genex.menubutton',
  width  => 400,
  height => 200
);

# Ported from the original Python from --
# https://gist.github.com/snj33v/8453ef1dfade33e26361
$a.activate.tap({
  $a.wait-for-init;

  my $hb = GTK::HeaderBar.new;
  $hb.show-close-button = True;
  $hb.title = 'Click me';
  $a.window.titlebar = $hb;

  my $box   = GTK::Box.new-hbox;
  my $pmenu = GTK::Menu.new;
  $pmenu.append( GTK::MenuItem.new('lp') );
  $pmenu.append( GTK::MenuItem.new('pl') );

  my $mb = GTK::MenuButton.new;
  $mb.popup = $pmenu;
  $box.add($mb);
  $hb.pack-end($box);

  my $count = 0;
  my $button = GTK::Button.new-with-label('count');
  $button.clicked.tap({
    $button.label = "Clicked: { ++$count } times";
  });

  my $vbox = GTK::Box.new-vbox;
  $vbox.add($button);
  $a.window.add($vbox);
  $a.window.show-all;
});

$a.run;
