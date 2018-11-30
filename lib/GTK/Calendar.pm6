use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Calendar;
use GTK::Raw::Types;

use GTK::Widget;

my subset Ancestry where GtkCalendar | GtkBuildable | GtkWidget;

class GTK::Calendar is GTK::Widget {
  has GtkCalendar $!cal;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Calendar');
    $o;
  }

  submethod BUILD(:$calendar) {
    my $to-parent;
    given $calendar {
      when Ancestry {
        $!cal = do {
          when GtkCalendar {
            $to-parent = nativecast(GtkWidget, $calendar);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkCalendar, $calendar);
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Calendar {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $calendar) {
    my $o = self.bless(:$calendar);
    $o.upref;
    $o;
  }
  multi method new {
    my $calendar = gtk_calendar_new();
    self.bless(:$calendar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkCalendar, gpointer --> void
  method day-selected is also<day_selected> {
    self.connect($!cal, 'day-selected');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method day-selected-double-click is also<day_selected_double_click> {
    self.connect($!cal, 'day-selected-double-click');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method month-changed is also<month_changed> {
    self.connect($!cal, 'month-changed');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method next-month is also<next_month> {
    self.connect($!cal, 'next-month');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method next-year is also<next_year> {
    self.connect($!cal, 'next-year');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method prev-month is also<prev_month> {
    self.connect($!cal, 'prev-month');
  }

  # Is originally:
  # GtkCalendar, gpointer --> void
  method prev-year is also<prev_year> {
    self.connect($!cal, 'prev-year');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method detail_height_rows is rw is also<detail-height-rows> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_calendar_get_detail_height_rows($!cal);
      },
      STORE => sub ($, Int() $rows is copy) {
        my gint $r = self.RESOLVE-INT($rows);
        gtk_calendar_set_detail_height_rows($!cal, $r);
      }
    );
  }

  method detail_width_chars is rw is also<detail-width-chars> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_calendar_get_detail_width_chars($!cal);
      },
      STORE => sub ($, Int() $chars is copy) {
        my gint $c = self.RESOLVE-INT($chars);
        gtk_calendar_set_detail_width_chars($!cal, $c);
      }
    );
  }

  method display_options is rw is also<display-options> {
    Proxy.new(
      FETCH => sub ($) {
        GtkCalendarDisplayOptions(
          gtk_calendar_get_display_options($!cal)
        );
      },
      STORE => sub ($, Int() $flags is copy) {
        my uint32 $f = self.RESOLVE-UINT($flags);
        gtk_calendar_set_display_options($!cal, $f);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_marks is also<clear-marks> {
    gtk_calendar_clear_marks($!cal);
  }

  multi method get-date (
    Int() $year is rw,
    Int() $month is rw,
    Int() $day is rw
  ) {
    self.get_date($year, $month, $day);
  }
  multi method get_date (
    Int() $year is rw,
    Int() $month is rw,
    Int() $day is rw
  ) {
    my @u = ($year, $month, $day);
    my uint32 ($y, $m, $d) = self.RESOLVE-UINT(@u);
    gtk_calendar_get_date($!cal, $y, $m, $d);
    $m++;
    ($year, $month, $day) = ($y, $m, $d);
  }
  multi method get-date {
    self.get_date;
  }
  multi method get_date {
    my ($y, $m, $d) = (0 xx 3);
    samewith($y, $m, $d);
  }


  method get_day_is_marked (Int() $day) is also<get-day-is-marked> {
    my guint $d = self.RESOLVE-UINT($day);
    Bool( gtk_calendar_get_day_is_marked($!cal, $d) );
  }

  method get_type is also<get-type> {
    gtk_calendar_get_type();
  }

  method mark_day (Int() $day) is also<mark-day> {
    my guint $d = self.RESOLVE-UINT($day);
    gtk_calendar_mark_day($!cal, $d);
  }

  method select_day (Int() $day) is also<select-day> {
    my guint $d = self.RESOLVE-UINT($day);
    gtk_calendar_select_day($!cal, $d);
  }

  method select_month (Int() $month, Int() $year) is also<select-month> {
    my @u = ($month, $year);
    my guint ($m, $y) = self.RESOLVE-UINT(@u);
    gtk_calendar_select_month($!cal, $m, $y);
  }

  multi method set_detail_func (
    GtkCalendarDetailFunc $func,
    gpointer $data,
    GDestroyNotify $destroy
  )
    is also<set-detail-func>
  {
    gtk_calendar_set_detail_func($!cal, $func, $data, $destroy);
  }

  method unmark_day (Int() $day) is also<unmark-day> {
    my guint $d = self.RESOLVE-UINT($day);
    gtk_calendar_unmark_day($!cal, $d);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
