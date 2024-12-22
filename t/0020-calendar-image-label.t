use v6.c;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Box;
use GTK::Calendar;
use GTK::Entry;
use GTK::Image;
use GTK::Label;

my $a = GTK::Application.new( :title('org.genex.calendar_example') );

$a.activate.tap: SUB {
  my $vbox = GTK::Box.new-vbox();
  my $hbox = GTK::Box.new-hbox();
  my $label = GTK::Label.new();
  my $image = GTK::Image.new_from_file('resources/Calendar-icon.png');
  my $calendar = GTK::Calendar.new();
  my $entry = GTK::Entry.new();

  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.set_size_request(500, 250);
  $image.set_size_request(200, 200);
  ($entry.margin_left, $entry.margin_right) = (10, 10);

  sub format_date {
    $calendar.get_date.map( *.fmt('%02d') ).join(' / ');
  }

  $calendar.day-selected.tap: SUB { 
    $entry.text = "(click) { &format_date() }";
  }

  $calendar.day-selected-double-click.tap: SUB {
    $entry.text = "(dbl-click) { &format_date() }";
  }

  $label.set_markup(qq:to/MARK/);
  <span font="Liberation Sans Narrow 24" weight="bold" color="#0066ff">
    Calendar/Image/Label Example
  </span>
  MARK

  $hbox.pack_start($image, True);
  $hbox.pack_start($calendar, True);
  $vbox.pack_start($label);
  $vbox.pack_start($hbox, False, True, 10);
  $vbox.pack_start($entry, False, True, 10);
  $a.window.add($vbox);

  $a.window.show_all;
}

$a.run;
