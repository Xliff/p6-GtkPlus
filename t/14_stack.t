use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::RadioButton;
use GTK::Stack;
use GTK::TextView;

# Converted from:
# https://github.com/gotk3/gotk3-examples/blob/master/gtk-examples/stack/stack.go

my $a = GTK::Application.new(
  title  => 'org.genex.stack_example',
  width  => 400,
  height => 300
);

$a.activate.tap({
  CATCH { default { .message.say; $a.exit } }
  
  sub newBoxText($string) {
    my $box = GTK::Box.new-vbox;
    my $tv = GTK::TextView.new;
    my $b = GTK::Button.new_with_label('Submit');
    $b.clicked.tap({ $tv.text.say; });
    $tv.buffer.set_text($string);
    $box.pack_start($tv, True, True, 0);
    $box.add($b);
    $box;
  }

  # All positionals in one place with @group
  sub newBoxRadio(*@group) {
    my $vbox = GTK::Box.new-vbox;
    my @radios = GTK::RadioButton.new-group(@group);
    my $c = 0;
    for @radios -> $r {
      # Must have closure var in loop.
      my $i = $c;
      $r.toggled.tap({ say "{ $i }: { $r.label } is active" if $r.active });
      $vbox.pack_start($r, False, False, 0);
      $c++;
    }
    $vbox;
  }

  # Top-level widgets
  my $stack = GTK::Stack.new;
  my $box = GTK::Box.new-vbox;

  # Page 1
  $stack.add_titled( newBoxText('Hello there!'), 'key1', 'First Page' );
  # Page 2
  $stack.add_titled(
    newBoxRadio('choice 1', 'choice 2', 'choice 3', 'choice 42'),
    'key2',
    'Second Page'
  );
  # Page 3
  $stack.add_titled( newBoxText('third page'), 'key3', 'Third Page' );

  # Now the controls.
  $box.pack_start($stack.control, False, False, 0);
  $box.pack_start($stack, True, True, 0);
  $a.window.add($box);
  $a.window.show_all;
});

$a.run;
