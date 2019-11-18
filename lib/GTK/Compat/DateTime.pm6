use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::DateTime;

class GTK::Compat::DateTime {
  has GDateTime $!dt is implementor;

  submethod BUILD (:$datetime) {
    $!dt = $datetime;
  }

  method GTK::Compat::Types::GDateTime
    is also<GDateTime>
  { $!dt }

  multi method new (GDateTime $datetime) {
    self.bless( :$datetime );
  }
  multi method new (DateTime $pdt) {
    ::?CLASS.new_from_unix($pdt.posix);
  }

  multi method new (
    DateTime $pdt,
    :$utc is required
  ) {
    ::?CLASS.new_from_unix_utc($pdt.utc.posix);
  }

  multi method new (
    GTimeZone() $tz,
    Int() $year,
    Int() $month,
    Int() $day,
    Int() $hour,
    Int() $minute,
    Num() $seconds
  ) {
    my gint ($y, $m, $d, $h, $mn) = ($year, $month, $day, $hour, $minute);
    my gdouble $s = $seconds;

    self.bless( datetime => g_date_time_new($tz, $y, $m, $d, $h, $mn, $s) )
  }

  multi method new (
    Str() $text,
    GTimeZone() $default_tz,
    :$iso8601 is required
  ) {
    ::?CLASS.new_from_iso8601($text, $default_tz);
  }
  method new_from_iso8601 (Str() $text, GTimeZone() $default_tz)
    is also<new-from-iso8601>
  {
    self.bless(
      datetime => g_date_time_new_from_iso8601($text, $default_tz)
    );
  }

  multi method new (
    GTimeVal() $tv,
    :timeval_local(:$timeval-local) is required
  ) {
    ::?CLASS.new_from_timeval_local($tv);
  }
  method new_from_timeval_local (GTimeVal() $tv)
    is also<new-from-timeval-local>
  {
    self.bless( datetime => g_date_time_new_from_timeval_local($tv) );
  }

  multi method new (
    GTimeVal() $tv,
    :timeval_utc(:$timeval-utc) is required,
  ) {
    ::?CLASS.new_from_timeval_utc($tv);
  }
  method new_from_timeval_utc (GTimeVal() $tv) is also<new-from-timeval-utc> {
    self.bless( datetime => g_date_time_new_from_timeval_utc($tv) );
  }

  multi method new (
    Int() $time,
    :unix_local(:$unix-local) is required
  ) {
    ::?CLASS.new_from_unix_local($time);
  }
  method new_from_unix_local (Int() $time) is also<new-from-unix-local> {
    my gint64 $t = $time;

    self.bless( datetime => g_date_time_new_from_unix_local($t) )
  }

  multi method new (
    Int() $time,
    :unix_utc(:$unix-utc)
  ) {
    ::?CLASS.new_from_unix_utc($time);
  }
  method new_from_unix_utc (Int() $time) is also<new-from-unix-utc> {
    my gint64 $t = $time;

    self.bless( datetime => g_date_time_new_from_unix_utc($t) )
  }

  multi method new (
    Int() $year,
    Int() $month,
    Int() $day,
    Int() $hour,
    Int() $minute,
    Num() $seconds,
    :$local is required
  ) {
    ::?CLASS.new_local($year, $month, $day, $hour, $minute, $seconds);
  }
  method new_local (
    Int() $year,
    Int() $month,
    Int() $day,
    Int() $hour,
    Int() $minute,
    Num() $seconds
  )
    is also<new-local>
  {
    my gint ($y, $m, $d, $h, $mn) = ($year, $month, $day, $hour, $minute);
    my gdouble $s = $seconds;

    self.bless( datetime => g_date_time_new_local($y, $m, $d, $h, $mn, $s) );
  }

  multi method new (:$now is required) {
    ::?CLASS.new_now;
  }
  method new_now (GTimeZone() $tz) is also<new-now> {
    self.bless( datetime => g_date_time_new_now($tz) );
  }

  multi method new (:now_local(:$now-local) is required) {
    ::?CLASS.new_local;
  }
  method new_now_local is also<new-now-local> {
    self.bless( datetime => g_date_time_new_now_local() );
  }

  multi method new (:now_utc(:$now-utc) is required) {
    ::?CLASS.new_now_utc;
  }
  method new_now_utc is also<new-now-utc> {
    self.bless( datetime => g_date_time_new_now_utc() );
  }

  multi method new (:now_utc(:$now-utc) is required) {
    ::?CLASS.new_utc;
  }
  method new_utc (
    Int() $year,
    Int() $month,
    Int() $day,
    Int() $hour,
    Int() $minute,
    Num() $seconds
  )
    is also<new-utc>
  {
    my gint ($y, $m, $d, $h, $mn) = ($year, $month, $day, $hour, $minute);
    my gdouble $s = $seconds;

    self.bless( datetime => g_date_time_new_utc($y, $m, $d, $h, $mn, $s) );
  }

  multi method add (
    $timespan where * ~~ (GTK::Compat::TimeSpan, GTimeSpan).any
  ) {
    g_date_time_add($!dt, $timespan);
  }

  multi method add ( Int() $d, :d(:$days) is required) {
    self.add_days($d);
  }
  method add_days (Int() $days) is also<add-days> {
    my gint $d = $days;

    g_date_time_add_days($!dt, $d);
  }

  multi method add (
    Int() $year,
    Int() $month,
    Int() $day,
    Int() $hour,
    Int() $minute,
    Num() $seconds,
    :f(:$full) is required
  ) {
    self.add_full($year, $month, $day, $hour, $minute, $seconds);
  }
  method add_full (
    Int() $year,
    Int() $month,
    Int() $day,
    Int() $hour,
    Int() $minute,
    Num() $seconds
  )
    is also<add-full>
  {
    my gint ($y, $m, $d, $h, $mn) = ($year, $month, $day, $hour, $minute);
    my gdouble $s = $seconds;

    g_date_time_add_full($!dt, $y, $m, $d, $h, $mn, $s)
  }

  multi method add (Int() $h, :h(:$hours) is required) {
    self.add_hours($h);
  }
  method add_hours (Int() $hours) is also<add-hours> {
    my gint $h = $hours;

    g_date_time_add_hours($!dt, $h);
  }

  multi method add (Int() $m, :min(:$minutes) is required) {
    self.add_minutes($m);
  }
  method add_minutes (Int() $minutes) is also<add-minutes> {
    my gint $m = $minutes;

    g_date_time_add_minutes($!dt, $m);
  }

  multi method add (Int() $m, :mon(:$months) is required) {
    self.add_months($m);
  }
  method add_months (Int() $months) is also<add-months> {
    my gint $m = $months;

    g_date_time_add_months($!dt, $m);
  }

  multi method add (Num() $s, :s(:sec(:$seconds)) is required)  {
    self.add_seconds($s);
  }
  method add_seconds (Num() $seconds) is also<add-seconds> {
    my gdouble $s = $seconds;

    g_date_time_add_seconds($!dt, $s);
  }

  multi method add (Int() $w, :w(:$weeks) is required) {
    self.add_weeks($w);
  }
  method add_weeks (Int() $weeks) is also<add-weeks> {
    my gint $w = $weeks;

    g_date_time_add_weeks($!dt, $w);
  }

  multi method add(Int() $y, :y(:$years) is required) {
    self.add_years($y);
  }
  method add_years (Int() $years) is also<add-years> {
    my gint $y = $years;

    g_date_time_add_years($!dt, $y);
  }

  method compare (GDateTime() $dt2) {
    g_date_time_compare($!dt, $dt2);
  }

  # GTimeSpan - NYI
  method difference (GDateTime() $begin) {
    g_date_time_difference($!dt, $begin);
  }

  method equal (GDateTime() $dt2) {
    so g_date_time_equal($!dt, $dt2);
  }

  method format (Str() $format) {
    g_date_time_format($!dt, $format);
  }

  method get_day_of_month
    is also<
      get-day-of-month
      day_of_month
      day-of-month
      dom
    >
  {
    g_date_time_get_day_of_month($!dt);
  }

  method get_day_of_week
    is also<
      get-day-of-week
      day_of_week
      day-of-week
      dow
    >
  {
    g_date_time_get_day_of_week($!dt);
  }

  method get_day_of_year
    is also<
      get-day-of-year
      day_of_year
      day-of-year
      doy
    >
  {
    g_date_time_get_day_of_year($!dt);
  }

  method get_hour
    is also<
      get-hour
      hour
      hr
    >
  {
    g_date_time_get_hour($!dt);
  }

  method get_microsecond
    is also<
      get-microsecond
      microsecond
      ms
      μs
    >
  {
    g_date_time_get_microsecond($!dt);
  }

  method get_minute
    is also<
      get-minute
      minute
      min
    >
  {
    g_date_time_get_minute($!dt);
  }

  method get_month
    is also<
      get-month
      month
      mon
    >
  {
    g_date_time_get_month($!dt);
  }

  method get_second
    is also<
      get-second
      second
      sec
      s
    >
  {
    g_date_time_get_second($!dt);
  }

  method get_seconds
    is also<
      get-seconds
      seconds
      secs
    >
  {
    g_date_time_get_seconds($!dt);
  }

  method get_timezone (:$raw = False)
    is also<
      get-timezone
      timezone
      tz
    >
  {
    my $tz = g_date_time_get_timezone($!dt);

    $tz ??
      ( $raw ?? $tz !! GTK::Compat::TimeZone.new($tz) )
      !!
      Nil;
  }

  method get_timezone_abbreviation
    is also<
      get-timezone-abbreviation
      timezone-abbreviation
      tz_abbr
      tz-abb
      tz_abv
      tz-abv
    >
  {
    g_date_time_get_timezone_abbreviation($!dt);
  }

  method get_utc_offset
    is also<
      get-utc-offset
      utc_offset
      utc-offset
    >
  {
    g_date_time_get_utc_offset($!dt);
  }

  method get_week_numbering_year
    is also<
      get-week-numbering-year
      week_numbering_year
      week-numbering-year
      wny
    >
  {
    g_date_time_get_week_numbering_year($!dt);
  }

  method get_week_of_year
    is also<
      get-week-of-year
      week_of_year
      week-of-year
      woy
    >
  {
    g_date_time_get_week_of_year($!dt);
  }

  method get_year
    is also<
      get-year
      year
      y
    >
  {
    g_date_time_get_year($!dt);
  }

  proto method get_ymd (|)
      is also<
        get-ymd
        ymd
      >
  { * }

  multi method get_ymd {
    samewith($, $, $);
  }
  multi method get_ymd ($year is rw, $month is rw, $day is rw) {
    my gint ($y, $m, $d) = 0 xx 3;

    g_date_time_get_ymd($!dt, $y, $m, $d);
    ($year, $month, $day) = ($y, $m, $d);
  }

  method hash {
    g_date_time_hash($!dt);
  }

  method is_daylight_savings is also<is-daylight-savings> {
    so g_date_time_is_daylight_savings($!dt);
  }

  method ref {
    g_date_time_ref($!dt);
    self;
  }

  method to_local is also<to-local> {
    GTK::Compat::DateTime.new( g_date_time_to_local($!dt) );
  }

  # GTimeVal object NYI
  proto method to_timeval (|)
      is also<to-timeval>
  { * }

  # GTimeVal is deprecated. See: https://tecnocode.co.uk/2019/08/24/gtimeval-deprecation-in-glib-2-61-2/
  # So there will be no object representation. These methods are provided for
  # compatibility purposes, only.
  multi method to_timeval (:$all = False) {
    samewith($, :$all);
  }
  multi method to_timeval (GTimeVal() $tv, :$all = False) {
    my $rc = g_date_time_to_timeval($!dt, $tv);

    $rc ??
      ( $all ?? $tv !! ($tv, $rc) )
      !!
      Nil;
  }

  method to_timezone (GTimeZone() $tz) is also<to-timezone> {
    GTK::Compat::DateTime.new( g_date_time_to_timezone($!dt, $tz) );
  }

  method to_unix is also<to-unix> {
    g_date_time_to_unix($!dt);
  }

  method to_utc is also<to-utc> {
    GTK::Compat::DateTime.new( g_date_time_to_utc($!dt) );
  }

  method unref {
    g_date_time_unref($!dt);
  }

}
