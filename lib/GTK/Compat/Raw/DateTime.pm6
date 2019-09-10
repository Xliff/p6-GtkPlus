use v6.c;

use NativeCall;

use GTK::Compat::Types;

sub g_date_time_add (GDateTime $datetime, GTimeSpan $timespan)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_days (GDateTime $datetime, gint $days)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_full (
  GDateTime $datetime,
  gint $years,
  gint $months,
  gint $days,
  gint $hours,
  gint $minutes,
  gdouble $seconds
)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_hours (GDateTime $datetime, gint $hours)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_minutes (GDateTime $datetime, gint $minutes)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_months (GDateTime $datetime, gint $months)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_seconds (GDateTime $datetime, gdouble $seconds)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_weeks (GDateTime $datetime, gint $weeks)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_add_years (GDateTime $datetime, gint $years)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_compare (GDateTime $dt1, GDateTime $dt2)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_difference (GDateTime $end, GDateTime $begin)
  returns GTimeSpan
  is native(glib)
  is export
{ * }

sub g_date_time_equal (GDateTime $dt1, GDateTime $dt2)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_date_time_format (GDateTime $datetime, Str $format)
  returns Str
  is native(glib)
  is export
{ * }

sub g_date_time_get_day_of_month (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_day_of_week (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_day_of_year (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_hour (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_microsecond (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_minute (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_month (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_second (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_seconds (GDateTime $datetime)
  returns gdouble
  is native(glib)
  is export
{ * }

sub g_date_time_get_timezone (GDateTime $datetime)
  returns GTimeZone
  is native(glib)
  is export
{ * }

sub g_date_time_get_timezone_abbreviation (GDateTime $datetime)
  returns Str
  is native(glib)
  is export
{ * }

sub g_date_time_get_utc_offset (GDateTime $datetime)
  returns GTimeSpan
  is native(glib)
  is export
{ * }

sub g_date_time_get_week_numbering_year (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_week_of_year (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_year (GDateTime $datetime)
  returns gint
  is native(glib)
  is export
{ * }

sub g_date_time_get_ymd (
  GDateTime $datetime,
  gint $year  is rw,
  gint $month is rw,
  gint $day   is rw
)
  is native(glib)
  is export
{ * }

sub g_date_time_hash (GDateTime $datetime)
  returns guint
  is native(glib)
  is export
{ * }

sub g_date_time_is_daylight_savings (GDateTime $datetime)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_date_time_new (
  GTimeZone $tz,
  gint $year,
  gint $month,
  gint $day,
  gint $hour,
  gint $minute,
  gdouble $seconds
)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_from_iso8601 (Str $text, GTimeZone $default_tz)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_from_timeval_local (GTimeVal $tv)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_from_timeval_utc (GTimeVal $tv)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_from_unix_local (gint64 $t)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_from_unix_utc (gint64 $t)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_local (
  gint $year,
  gint $month,
  gint $day,
  gint $hour,
  gint $minute,
  gdouble $seconds
)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_now (GTimeZone $tz)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_now_local ()
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_now_utc ()
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_new_utc (
  gint $year,
  gint $month,
  gint $day,
  gint $hour,
  gint $minute,
  gdouble $seconds
)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_ref (GDateTime $datetime)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_to_local (GDateTime $datetime)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_to_timeval (GDateTime $datetime, GTimeVal $tv)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_date_time_to_timezone (GDateTime $datetime, GTimeZone $tz)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_to_unix (GDateTime $datetime)
  returns gint64
  is native(glib)
  is export
{ * }

sub g_date_time_to_utc (GDateTime $datetime)
  returns GDateTime
  is native(glib)
  is export
{ * }

sub g_date_time_unref (GDateTime $datetime)
  is native(glib)
  is export
{ * }
