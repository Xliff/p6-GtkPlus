use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::Raw::Timer;

class GLib::Timer {
  has GTimer $!t;

  submethod BUILD (:$timer) {
    $!t = $timer;
  }

  method GTK::Compat::Types::GTimer
    is also<GTimer>
  { $!t }

  multi method new(GTimer $timer) {
    return Nil unless $timer;

    self.bless( :$timer );
  }
  multi method new {
    my $t = g_timer_new();

    $t ?? self.bless( timer => $t ) !! Nil
  }

  method continue {
    g_timer_continue($!t);
  }

  method destroy {
    g_timer_destroy($!t);
  }

  method elapsed (Int() $microseconds = 0) {
    my gulong $us = $microseconds;

    g_timer_elapsed($!t, $us);
  }

  method val_add (
    GTK::Compat::Timer:U:
    GTimeVal $tv, Int() $microseconds
  )
    is also<
      g-time-val-add
      timeval_add_microsec
      timeval-add-microsec
      timeval_add-microseconds
      timeval-add-microseconds
      timeval_add_μs
      timeval-add-μs
    >
  {
    my gulong $us = $microseconds;

    g_time_val_add($tv, $us);
  }

  method val_from_iso8601 (
    GTK::Compat::Timer:U:
    Str() $t, GTimeVal $time
  )
    is also<
      g-time-val-from-iso8601
      str_to_timeval
      str-to-timeval
    >
  {
    g_time_val_from_iso8601($t, $time);
  }

  method val_to_iso8601 (
    GTK::Compat::Timer:U:
    GTimeVal $tv
  )
    is also<
      g-time-val-to-iso8601
      timeval_to-str
      timeval-to-str
    >
  {
    g_time_val_to_iso8601($tv);
  }

  method g_usleep(Int() $interval)
    is also<
      g-usleep
      usleep
      μsleep
    >
  {
    my gulong $i = $interval;

    g_usleep($i);
  }

  method reset {
    g_timer_reset($!t);
  }

  method start {
    g_timer_start($!t);
  }

  method stop {
    g_timer_stop($!t);
  }

}
