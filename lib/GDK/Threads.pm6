use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Threads;

use GLib::Roles::StatiClass;

class GDK::Threads {
  also does GLib::Roles::StaticClass;

  method add_idle (
    &function,
    gpointer $data = Pointer
  )
    is also<add-idle>
  {
    gdk_threads_add_idle(&function, $data);
  }

  method add_idle_full (
    Int() $priority,
    &function,
    gpointer $data = Pointer,
    GDestroyNotify $notify = Pointer
  )
    is also<add-idle-full>
  {
    my gint $p = $priority;

    gdk_threads_add_idle_full($p, &function, $data, $notify);
  }

  method add_timeout (
    Int() $interval,
    &function,
    gpointer $data = Pointer
  )
    is also<add-timeout>
  {
    my guint $i = $interval;

    gdk_threads_add_timeout($interval, &function, $data);
  }

  method add_timeout_full (
    Int() $priority,
    Int() $interval,
    &function, gpointer $data = Pointer,
    GDestroyNotify $notify = Pointer
  )
    is also<add-timeout-full>
  {
    my gint $p = $priority;
    my guint $i = $interval;

    gdk_threads_add_timeout_full($p, $i, &function, $data, $notify);
  }

  method add_timeout_seconds (
    Int() $interval,
    &function,
    gpointer $data = Pointer
  )
    is also<add-timeout-seconds>
  {
    my guint $i = $interval;

    gdk_threads_add_timeout_seconds($i, &function, $data);
  }

  method add_timeout_seconds_full (
    Int() $priority,
    Int() $interval,
    &function,
    gpointer $data = Pointer,
    GDestroyNotify $notify = Pointer
  )
    is also<add-timeout-seconds-full>
  {
    my gint $p = $priority;
    my guint $i = $interval;

    gdk_threads_add_timeout_seconds_full($p, $i, &function, $data, $notify);
  }

}
