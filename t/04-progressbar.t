use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::CheckButton;
use GTK::Entry;
use GTK::Label;
use GTK::ProgressBar;

# Arrange to update the progress bar every second once button is clicked:
my $a = GTK::Application.new( :title('org.genex.progress_bar') );

$a.activate.tap({
  my $title    = GTK::Label.new;
  my $label    = GTK::Label.new('Set step value: ');
  my $entry    = GTK::Entry.new;
  my $button   = GTK::Button.new_with_label('Start Count');
  my $progress = GTK::ProgressBar.new;
  my $showtext = GTK::CheckButton.new_with_label('Show Text');
  my $hbox     = GTK::Box.new-hbox(2);
  my $vbox     = GTK::Box.new-vbox(2);

  ($button.margin_left, $button.margin_right) = (20, 20);
  ($button.margin_top, $button.margin_bottom) = (15, 15);
  ($label.margin_left, $label.margin_right) = (20, 10);
  ($showtext.margin_left, $showtext.margin_top) = (18, 5);
  $label.set_size_request(-1, 40);
  ($progress.margin_left, $progress.margin_right) = (20, 20);
  $progress.set_size_request(30, 30);
  $entry.margin_right = 20;
  $entry.text = "1";
  $title.margin_bottom = 10;
  $title.set_markup(qq:to/MARK/.chomp);
<span font="Sawasdee 20" weight="bold" color="#660044">ProgressBar Example</span>
MARK

  $hbox.pack_start($label);
  $hbox.pack_start($entry);
  $vbox.pack_start($title, False, False, 0);
  $vbox.pack_start($hbox, True, False, 0);
  $vbox.pack_start($showtext, True, False, 0);
  $vbox.pack_start($progress, True, True, 0);
  $vbox.pack_start($button, True, True, 0);

  $showtext.clicked.tap({
    $progress.show_text = $showtext.active;
    if $showtext.active {
      $progress.text = 'Here is the text...';
    } else {
      $progress.text = Str;
    }
  });

  my $ticks;
  my $count = 0;
  my $c;
  $button.clicked.tap({
    given $button.label {
      when 'Start Count' {
        my $num;
        try {
           $num = $entry.text.Numeric;
           $ticks = $num / 100;
           CATCH { }
        }
        with $ticks {
          $c = $*SCHEDULER.cue({
            $progress.fraction = ($count += $ticks);
            if $count > 1 {
              $c.cancel;
              $button.label = 'Start Count';
              $count = 0;
              $ticks = Nil;
            }
          }, :every(1));

          $button.label = 'Cancel';
        }
      }

      when 'Cancel' {
        $c.cancel;
        $button.label = 'Start Count';
      }
    }
  });

  $a.window.destroy-signal.tap({ $a.exit; });
  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run;
