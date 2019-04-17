use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Dialog::FileChooser;
use GTK::Raw::Types;

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
  my $button = GTK::Button.new_with_label: <Open File Dialog>;

  my $chooser = GTK::Dialog::FileChooser.new(
    'Open file...',
    $app.window,
    GTK_FILE_CHOOSER_ACTION_OPEN
  );

  $chooser.selection-changed.tap: {
    my $f = $chooser.filename;
    say "Selected: { $f }" with $f;
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
