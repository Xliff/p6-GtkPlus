use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Calendar;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Calendar is GTK::Widget {
  has GtkCalendar $!cal;

  submethod BUILD(:$calendar) {
    given $calendar {
      when GtkCalendar | GtkWidget {
        $!cal = nativecast(GtkCalendar, $calendar);
        self.setWidget( $calendar );
      }
      when GTK::Calendar {

      }
      default {
      }
    }
  }

  method new () {
    my $calendar = gtk_calendar_new();
    self.bless(:$calendar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  #
  # All events take a ($calendar, $user_data) signature.
  method day-selected {
    self.connect($!cal, 'day_selected');
  }

  method day-selected-double-click {
    self.connect($!cal, 'day-selected-double-click');
  }

  method month-changed {
    self.connect($!cal, 'month-changed');
  }

  method next-month {
    self.connect($!cal, 'next-month');
  }

  method next-year {
    self.connect($!cal, 'next-year');
  }

  method prev-month {
    self.connect($!cal, 'prev-month');
  }

  method prev-year {
    self.connect($!cal, 'prev-year');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method detail_height_rows is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_calendar_get_detail_height_rows($!cal);
      },
      STORE => sub ($, $rows is copy) {
        gtk_calendar_set_detail_height_rows($!cal, $rows);
      }
    );
  }

  method detail_width_chars is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_calendar_get_detail_width_chars($!cal);
      },
      STORE => sub ($, $chars is copy) {
        gtk_calendar_set_detail_width_chars($!cal, $chars);
      }
    );
  }

  method display_options is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkCalendarDisplayOptions( gtk_calendar_get_display_options($!cal) );
      },
      STORE => sub ($, $flags is copy) {
        my uint32 $f = do given $flags {
          when GtkCalendarDisplayOptions | IntStr {
            $flags.Int;
          }
          when Int {
            $flags;
          }
          default {
            die "Invalid type ({ $flags.^name }) passed to GTK::Calendar.display_options";
          }
        }
        gtk_calendar_set_display_options($!cal, $f);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_marks () {
    gtk_calendar_clear_marks($!cal);
  }

  method get_date ($year is rw, $month is rw, $day is rw) {
    my $d = gtk_calendar_get_date($!cal, $year, $month, $day);
    $month++;
    $d;
  }

  method get_day_is_marked (guint $day) {
    gtk_calendar_get_day_is_marked($!cal, $day);
  }

  method get_type () {
    gtk_calendar_get_type();
  }

  method mark_day (guint $day) {
    gtk_calendar_mark_day($!cal, $day);
  }

  method select_day (guint $day) {
    gtk_calendar_select_day($!cal, $day);
  }

  method select_month (guint $month, guint $year) {
    gtk_calendar_select_month($!cal, $month, $year);
  }

  multi method set_detail_func (GtkCalendarDetailFunc $func, gpointer $data, GDestroyNotify $destroy) {
    gtk_calendar_set_detail_func($!cal, $func, $data, $destroy);
  }

  method unmark_day (guint $day) {
    gtk_calendar_unmark_day($!cal, $day);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
