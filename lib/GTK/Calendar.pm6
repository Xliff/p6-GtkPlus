use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Calendar;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Calendar is GTK::Widget {
  has GtkCalendar $!cal;

  submethod BUILD(:$calendar) {
    my $to-parent;
    given $calendar {
      when GtkCalendar | GtkWidget {
        $!cal = do {
          when GtkWidget   {
            $to-parent = $_;
            nativecast(GtkCalendar, $calendar);
          }
          when GtkCalendar {
            $to-parent = nativecast(GtkWidget, $calendar);
            $_;
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Calendar {
      }
      default {
      }
    }
    self.setType('GTK::Calendar');
  }

  method new {
    my $calendar = gtk_calendar_new();
    self.bless(:$calendar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCalendar, gpointer --> void
  method day-selected {
    self.connect($!cal, 'day-selected');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method day-selected-double-click {
    self.connect($!cal, 'day-selected-double-click');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method month-changed {
    self.connect($!cal, 'month-changed');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method next-month {
    self.connect($!cal, 'next-month');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method next-year {
    self.connect($!cal, 'next-year');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method prev-month {
    self.connect($!cal, 'prev-month');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
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
      STORE => sub ($, Int() $chars is copy) {
        my gint $c = self.RESOLVE-INT($chars, &?ROUTINE.name);
        gtk_calendar_set_detail_width_chars($!cal, $c);
      }
    );
  }

  method display_options is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkCalendarDisplayOptions( gtk_calendar_get_display_options($!cal) );
      },
      STORE => sub ($, Int() $flags is copy) {
        my uint32 $f = self.RESOLVE-UINT($flags, &?ROUTINE.name);
        gtk_calendar_set_display_options($!cal, $f);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_marks {
    gtk_calendar_clear_marks($!cal);
  }

  multi method get_date (Int() $year is rw, Int() $month is rw, Int() $day is rw) {
    my @u = ($year, $month, $day);
    my uint32 ($y, $m, $d) = self.RESOLVE-UINT(@u, &?ROUTINE.name);
    gtk_calendar_get_date($!cal, $y, $m, $d);
    $m++;
    ($year, $month, $day) = ($y, $m, $d);
  }
  multi method get_date {
    my ($y, $m, $d) = (0 xx 3);
    samewith($y, $m, $d);
  }

  method get_day_is_marked (Int() $day) {
    my guint $d = self.RESOLVE-UINT($day, &?ROUTINE.name);
    Bool( gtk_calendar_get_day_is_marked($!cal, $d) );
  }

  method get_type {
    gtk_calendar_get_type();
  }

  method mark_day (Int() $day) {
    my guint $d = self.RESOLVE-UINT($day, &?ROUTINE.name);
    gtk_calendar_mark_day($!cal, $d);
  }

  method select_day (Int() $day) {
    my guint $d = self.RESOLVE-UINT($day, &?ROUTINE.name);
    gtk_calendar_select_day($!cal, $d);
  }

  method select_month (Int() $month, Int() $year) {
    my @u = ($month, $year);
    my guint ($m, $y) = self.RESOLVE-UINT(@u, &?ROUTINE.name);
    gtk_calendar_select_month($!cal, $m, $y);
  }

  multi method set_detail_func (
    GtkCalendarDetailFunc $func,
    gpointer $data,
    GDestroyNotify $destroy
  ) {
    gtk_calendar_set_detail_func($!cal, $func, $data, $destroy);
  }

  method unmark_day (Int() $day) {
    my guint $d = self.RESOLVE-UINT($day, &?ROUTINE.name);
    gtk_calendar_unmark_day($!cal, $d);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
