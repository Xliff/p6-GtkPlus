use v6.c;

use Method::Also;

use GLib::Source;
use GTK::Compat::Types;
use GTK::Compat::Raw::Main;

use GLib::Raw::Subs;

class GLib::Timeout {

  method new (|) {
    warn 'GLib::Timeout is a static class and cannot be instantiated';
    GLib::Timeout;
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
  )
    is also<add-full>
  {
    my gint $p = resolve-int($priority);
    my guint $i = resolve-uint($interval);

    g_timeout_add_full($p, $i, &function, $data, $notify);
  }

  method add_seconds (
    Int() $interval,
    &function,
    gpointer $data = gpointer
  )
    is also<add-seconds>
  {
    my guint $i = resolve-uint($interval);

    g_timeout_add_seconds($i, &function, $data);
  }

  method add_seconds_full (
    Int() $priority,
    Int() $interval,
    &function,
    gpointer $data         = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<add-seconds-full>
  {
    my gint $p = resolve-int($priority);
    my guint $i = resolve-uint($interval);

    g_timeout_add_seconds_full($p, $i, &function, $data, $notify);
  }

  # Lifted from GTK::Simple. Provided for compatibility.
  method simple_timeout(Cool $msecs) is also<simple-timeout> {
    use nqp;
    use NativeCall;

    my $s = Supplier.new;
    my $starttime = nqp::time_n();
    my $lasttime  = nqp::time_n();

    g_timeout_add(
        $msecs.Int,
        sub (*@) {
            my $dt = nqp::time_n() - $lasttime;
            $lasttime = nqp::time_n();
            $s.emit((nqp::time_n() - $starttime, $dt));

            return 1;
        },
        Pointer
    );
    return $s.Supply;
  }

  method simple_timeout_in_seconds(Cool $sec)
    is also<simple-timeout-in-seconds>
  {
    GLib::Timeout.simple-timeout($sec * 1000);
  }

  method cancel (Int() $tag) {
    GLib::Source.remove($tag);
  }

}
