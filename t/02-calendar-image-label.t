use v6.c;

use GTK::Application;
use GTK::Box;
use GTK::Calendar;
use GTK::Entry;
use GTK::Image;
use GTK::Label;

use GTK::Compat::Types;

my $a = GTK::Application.new( :title('org.genex.calendar_example') );

$a.activate.tap({
  my $vbox = GTK::Box.new-vbox();
  my $hbox = GTK::Box.new-hbox();
  my $label = GTK::Label.new();
  my $image = GTK::Image.new_from_file('resource/Calendar-icon.png');
  my $calendar = GTK::Calendar.new();
  my $entry = GTK::Entry.new();

  $a.window.destroy-signal.tap({ $a.exit });
  $a.window.set_size_request(500, 250);
  $image.set_size_request(200, 200);

  sub format_date {
    my guint $day;
    my guint $month;
    my guint $year;

    $calendar.get_date($year, $month, $day);
    ($year, $month + 1, $day).map( *.fmt('%02d') ).join(' / ');
  };

  $calendar.day-selected.tap({
    $entry.text = "(click) { &format_date() }";
  });

  $calendar.day-selected-double-click.tap({
    $entry.text = "(dbl-click) { &format_date() }";
  });

  $label.set_markup(qq:to/MARK/);
  <span font="Libberation Sans Narrow 18" color="#0066ff">
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
});

$a.run;
