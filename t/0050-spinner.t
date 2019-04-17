use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Button;
use GTK::Label;
use GTK::Spinner;

my $a = GTK::Application.new( :title('org.genex.spinner_example') );

$a.activate.tap({
  my $title  = GTK::Label.new;
  my $button = GTK::Button.new_with_label('Start');
  my $vbox   = GTK::Box.new-vbox(6);
  my $spin   = GTK::Spinner.new;

  $title.set_markup(do { (my $mark = qq:to/MARK/) ~~ s:g/\n//; $mark });
<span font="URW Gothic 24" color="#22cc11">Spinner Example</span>
MARK

  ($title.margin_left, $title.margin_right)   = (20, 20);
  ($button.margin_left, $button.margin_right) = (20, 20);
  ($button.margin_top, $button.margin_bottom) = (15, 15);
  $title.margin_bottom = 20;
  $spin.set_size_request(64, 64);
  $vbox.pack_start($title, True, True, 0);
  $vbox.pack_start($spin, True, False, 0);
  $vbox.pack_start($button, True, True, 0);

  $button.clicked.tap({
    given $button.label {
      when 'Start' {
        $spin.start;
        $button.label = 'Stop';
      }
      when 'Stop' {
        $spin.stop;
        $button.label = 'Start';
      }
    }
  });

  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.add($vbox);
  $a.window.show_all;
});

$a.run
