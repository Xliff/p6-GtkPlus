use v6.c;

use Method::Also;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Timer;

class GTK::Compat::Timer {
  has GTimer $!t;
  
  submethod BUILD (:$timer) {
    $!t = $timer;
  }
  
  method GTK::Compat::Raw::Types::GTimer 
    is also<GTimer>
  { $!t }
  
  method new {
    self.bless( timer => g_timer_new() );
  }
  
  method continue {
    g_timer_continue($!t);
  }

  method destroy {
    g_timer_destroy($!t);
  }

  method elapsed (Int() $microseconds) {
    my gulong $us = resolve-ulong($microseconds);
    g_timer_elapsed($!t, $us);
  }

  method g_time_val_add (
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
    my gulong $us = resolve-long($microseconds);
    g_time_val_add($tv, $us);
  }

  method g_time_val_from_iso8601 (
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

  method g_time_val_to_iso8601 (
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

  method g_usleep is also<g-usleep> {
    g_usleep($!t);
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
