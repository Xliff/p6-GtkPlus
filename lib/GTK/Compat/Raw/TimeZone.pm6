use v6.c;

use NativeCall;

use GTK::Compat::Types;

sub g_time_zone_adjust_time (GTimeZone $tz, GTimeType $type, gint64 $time)
  returns gint
  is native(glib)
  is export
{ * }

sub g_time_zone_find_interval (GTimeZone $tz, GTimeType $type, gint64 $time)
  returns gint
  is native(glib)
  is export
{ * }

sub g_time_zone_get_abbreviation (GTimeZone $tz, gint $interval)
  returns Str
  is native(glib)
  is export
{ * }

sub g_time_zone_get_identifier (GTimeZone $tz)
  returns Str
  is native(glib)
  is export
{ * }

sub g_time_zone_get_offset (GTimeZone $tz, gint $interval)
  returns gint32
  is native(glib)
  is export
{ * }

sub g_time_zone_is_dst (GTimeZone $tz, gint $interval)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_time_zone_new (Str $identifier)
  returns GTimeZone
  is native(glib)
  is export
{ * }

sub g_time_zone_new_local ()
  returns GTimeZone
  is native(glib)
  is export
{ * }

sub g_time_zone_new_offset (gint32 $seconds)
  returns GTimeZone
  is native(glib)
  is export
{ * }

sub g_time_zone_new_utc ()
  returns GTimeZone
  is native(glib)
  is export
{ * }

sub g_time_zone_ref (GTimeZone $tz)
  returns GTimeZone
  is native(glib)
  is export
{ * }

sub g_time_zone_unref (GTimeZone $tz)
  is native(glib)
  is export
{ * }
