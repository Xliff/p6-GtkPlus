use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Compat::Raw::Main;

use GTK::Raw::Utils;

class GTK::Compat::Timeout {

  method new (|) {
    warn 'GTK::Compat::Timeout is a static class and cannot be instantiated';
    GTK::Compat::Timeout;
  }

  method add (
    Int() $interval,
    &function,
    gpointer $data = gpointer;
  ) {
    my guint $i = resolve-uint($interval);
    g_timeout_add($i, &function, $data);
  }

  method add_full (
    Int() $priority,
    Int() $interval,
    &function,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
    my gint $p = resolve-int($priority);
    my guint $i = resolve-uint($interval);
    g_timeout_add_full($p, $i, &function, $data, $notify);
  }

  method add_seconds (
    Int() $interval,
    &function,
    gpointer $data = gpointer
  ) {
    my guint $i = resolve-uint($interval);
    g_timeout_add_seconds($i, &function, $data);
  }

  method add_seconds_full (
    Int() $priority,
    Int() $interval,
    &function,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
    my gint $p = resolve-int($priority);
    my guint $i = resolve-uint($interval);
    g_timeout_add_seconds_full($p, $i, &function, $data, $notify);
  }

}
