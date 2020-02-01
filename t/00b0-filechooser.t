use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::FileChooser;

my $app = GTK::Application.new(
  title  => 'org.genex.test.filechooser',
  width  => 400,
  height => 400
);

$app.activate.tap({
  # Should always do this.
  CATCH { default { .message.say; $app.exit } }

  my $box = GTK::Box.new-vbox(6);
  my $exit = GTK::Button.new_with_label: <exit>;
  my $chooser = GTK::FileChooser.new(GTK_FILE_CHOOSER_ACTION_OPEN);
  $chooser.^name.say;

  $chooser.selection-changed.tap: {
    say "Selected: { $chooser.filename // $chooser.current_folder }"
  };

  $exit.clicked.tap: { $app.exit  };
  $app.window.destroy-signal.tap: { $app.exit };

  $box.pack_start($chooser, False, True, 0);
  $box.pack_start($exit, False, True, 0);
  $app.window.add($box);
  $app.window.show_all;
});

$app.run;
