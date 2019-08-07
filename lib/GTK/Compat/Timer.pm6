use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Timer;

class GTK::Compat::Timer {
  has GTimer $!t;
  
  submethod BUILD (:$timer) {
    $!t = $timer;
  }
  
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
  ) {
    my gulong $us = resolve-long($microseconds);
    g_time_val_add($tv, $us);
  }

  method g_time_val_from_iso8601 (
    GTK::Compat::Timer:U:
    Str() $t, GTimeVal $time
  ) {
    g_time_val_from_iso8601($t, $time);
  }

  method g_time_val_to_iso8601 (
    GTK::Compat::Timer:U:
    GTimeVal $tv
  ) {
    g_time_val_to_iso8601($tv);
  }

  method g_usleep {
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
