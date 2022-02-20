use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Calendar:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

our subset CalendarAncestry is export where GtkCalendar | GtkWidgetAncestry;

class GTK::Calendar:ver<3.0.1146> is GTK::Widget {
  has GtkCalendar $!cal is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$calendar) {
    my $to-parent;
    given $calendar {
      when CalendarAncestry {
        $!cal = do {
          when GtkCalendar {
            $to-parent = nativecast(GtkWidget, $calendar);
            $_;
          }
          when GtkWidgetAncestry {
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

  method GTK::Raw::Definitions::GtkCalendar
    is also<
      Calendar
      GtkCalendar
    >
  { $!cal }

  multi method new (CalendarAncestry $calendar, :$ref = True) {
    return Nil unless $calendar;

    my $o = self.bless(:$calendar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $calendar = gtk_calendar_new();

    $calendar ?? self.bless(:$calendar) !! Nil;
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
        my gint $r = $rows;
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
        my gint $c = $chars;

        gtk_calendar_set_detail_width_chars($!cal, $c);
      }
    );
  }

  method display_options is rw is also<display-options> {
    Proxy.new(
      FETCH => sub ($) {
        GtkCalendarDisplayOptionsEnum(
          gtk_calendar_get_display_options($!cal)
        );
      },
      STORE => sub ($, Int() $flags is copy) {
        my uint32 $f = $flags;

        gtk_calendar_set_display_options($!cal, $f);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method clear_marks is also<clear-marks> {
    gtk_calendar_clear_marks($!cal);
  }

  proto method get_date (|)
    is also<
      get-date
      date
    >
  { * }

  multi method get_date {
    samewith($, $, $);
  }
  multi method get_date (
    $year  is rw,
    $month is rw,
    $day   is rw
  ) {
    my uint32 ($y, $m, $d) = 0 xx 3;

    gtk_calendar_get_date($!cal, $y, $m, $d);
    ($year, $month, $day) = ($y, ++$m, $d);
  }

  method get_day_is_marked (Int() $day) is also<get-day-is-marked> {
    my guint $d = $day;

    so gtk_calendar_get_day_is_marked($!cal, $d);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_calendar_get_type, $n, $t );
  }

  method mark_day (Int() $day) is also<mark-day> {
    my guint $d = $day;

    gtk_calendar_mark_day($!cal, $d);
  }

  method select_day (Int() $day) is also<select-day> {
    my guint $d = $day;

    gtk_calendar_select_day($!cal, $d);
  }

  method select_month (Int() $month, Int() $year) is also<select-month> {
    my guint ($m, $y) = ($month, $year);

    gtk_calendar_select_month($!cal, $m, $y);
  }

  multi method set_detail_func (
             &func,
    gpointer $data    = gpointer,
             &destroy = Callable
  )
    is also<set-detail-func>
  {
    gtk_calendar_set_detail_func($!cal, &func, $data, &destroy);
  }

  method unmark_day (Int() $day) is also<unmark-day> {
    my guint $d = $day;

    gtk_calendar_unmark_day($!cal, $d);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
