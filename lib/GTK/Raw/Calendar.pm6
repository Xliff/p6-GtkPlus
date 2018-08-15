use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Calendar;

sub gtk_calendar_clear_marks (GtkCalendar $calendar)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_get_date (
  GtkCalendar $calendar,
  guint $year is rw,
  guint $month is rw,
  guint $day is rw
)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_get_day_is_marked (GtkCalendar $calendar, guint $day)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_mark_day (GtkCalendar $calendar, guint $day)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_select_day (GtkCalendar $calendar, guint $day)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_select_month (GtkCalendar $calendar, guint $month, guint $year)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_set_detail_func (GtkCalendar $calendar, GtkCalendarDetailFunc $func, gpointer $data, GDestroyNotify $destroy)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_unmark_day (GtkCalendar $calendar, guint $day)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_get_display_options (GtkCalendar $calendar)
  returns uint32 # GtkCalendarDisplayOptions
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_get_detail_height_rows (GtkCalendar $calendar)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_get_detail_width_chars (GtkCalendar $calendar)
  returns gint
  is native('gtk-3')
  is export
  { * }

# (GtkCalendar $calendar, GtkCalendarDisplayOptions $flags)
sub gtk_calendar_set_display_options (GtkCalendar $calendar, uint32 $flags)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_set_detail_height_rows (GtkCalendar $calendar, gint $rows)
  is native('gtk-3')
  is export
  { * }

sub gtk_calendar_set_detail_width_chars (GtkCalendar $calendar, gint $chars)
  is native('gtk-3')
  is export
  { * }
