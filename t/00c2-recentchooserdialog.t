use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Dialog::RecentChooser;
use GTK::Raw::Types;

my $app = GTK::Application.new(
  title  => 'org.genex.test.recentchooser',
  width  => 400,
  height => 400
);

$app.activate.tap({
  # Should always do this.
  CATCH { default { .message.say; $app.exit } }

  my $box = GTK::Box.new-vbox(6);
  my $exit = GTK::Button.new_with_label: <exit>;
  my $button = GTK::Button.new_with_label: <Open Recent Dialog>;

  my $chooser = GTK::Dialog::RecentChooser.new(
    'Open Recent Item',
    $app.window

  );

  # $chooser.current-uri is currently unavailable due to an issue in
  # Method::Also
  $chooser.selection-changed.tap: {
    my $u = $chooser.get_current_uri;
    say "Selected: { $u }" with $u;
  };

  $button.clicked.tap({
    say "RESPONSE = " ~ $chooser.run;
  });

  $exit.clicked.tap: { $app.exit  };
  $app.window.destroy-signal.tap: { $app.exit };

  $box.pack_start($button, False, True, 0);
  $box.pack_start($exit, False, True, 0);
  $app.window.add($box);
  $app.window.show_all;
});

$app.run;
