use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::RecentChooserWidget;
use GTK::Raw::Types;

my $app = GTK::Application.new(
  title  => 'org.genex.test.recentchooser.widget',
  width  => 400,
  height => 400
);

$app.activate.tap({
  # Should always do this.
  CATCH { default { .message.say; $app.exit } }

  my $box = GTK::Box.new-vbox(6);
  my $exit = GTK::Button.new_with_label: <exit>;
  my $chooser = GTK::RecentChooserWidget.new;

  # $chooser.current_uri currently unavailable due to issues with Method::Also
  $chooser.selection-changed.tap: {
    say "Selected: { $_ }" with $chooser.get_current_uri;
  };

  $exit.      clicked       .tap: { $app.exit };
  $app.window.destroy-signal.tap: { $app.exit };

  $box.pack_start($chooser, False, True, 0);
  $box.pack_start($exit, False, True, 0);
  $app.window.add($box);
  $app.window.show_all;
});

$app.run;
