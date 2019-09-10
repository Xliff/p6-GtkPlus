use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Compat::Raw::TimeZone;

class GTK::Compat::TimeZone {
  has GTimeZone $!tz;

  submethod BUILD (:$timezone) {
    $!tz = $timezone;
  }

  method GTK::Compat::Types::GTimeZone
    is also<GTimeZone>
  { * }

  multi method new (GTimeZone $timezone) {
    self.bless( :$timezone );
  }
  multi method new (Str() $identifier) {
    self.bless( timezone => g_time_zone_new($identifier) );
  }

  multi method new(:$local is required) {
    ::?CLASS.new_local;
  }
  method new_local is also<new-local> {
    self.bless( timezone => g_time_zone_new_local() );
  }

  multi method new (Int() $o, :$offset is required) {
    ::?CLASS.new_offset($o);
  }
  method new_offset (Int() $offset) is also<new-offset> {
    my guint $o = $offset;

    self.bless( timezone => g_time_zone_new_offset($o) );
  }

  multi method new (:$utc is required) {
    ::?CLASS.new_utc;
  }
  method new_utc is also<new-utc> {
    self.bless( timezone => g_time_zone_new_utc() );
  }

  method adjust_time (
    Int() $type,
    Int() $time
  )
    is also<adjust-time>
  {
    my GTimeType $ty = $type;
    my gint64 $t = $time;

    g_time_zone_adjust_time($!tz, $ty, $t);
  }

  method find_interval (
    Int() $type,
    Int() $time
  )
    is also<find-interval>
  {
    my GTimeType $ty = $type;
    my gint64 $t = $time;

    g_time_zone_find_interval($!tz, $type, $time);
  }

  method get_abbreviation (Int() $interval) is also<get-abbreviation> {
    my gint $i = $interval;

    g_time_zone_get_abbreviation($!tz, $i);
  }

  method get_identifier is also<get-identifier> {
    g_time_zone_get_identifier($!tz);
  }

  method get_offset (Int() $interval) is also<get-offset> {
    my gint $i = $interval;

    g_time_zone_get_offset($!tz, $i);
  }

  method is_dst (Int() $interval) is also<is-dst> {
    my gint $i = $interval;

    so g_time_zone_is_dst($!tz, $i);
  }

  method ref {
    g_time_zone_ref($!tz);
    self;
  }

  method unref {
    g_time_zone_unref($!tz);
  }

}
