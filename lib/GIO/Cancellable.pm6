use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::Cancellable;

use GTK::Compat::Source;

use GTK::Compat::Roles::Object;
use GTK::Roles::Signals::Generic;

class GIO::Cancellable {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Signals::Generic;

  has GCancellable $!c;

  submethod BUILD (:$cancellable) {
    $!c = $cancellable;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GCancellable
    is also<GCancellable>
  { $!c }

  multi method new (GCancellable $cancellable) {
    self.bless( :$cancellable );
  }
  multi method new {
    self.bless( cancellable => g_cancellable_new() );
  }

  # Is default signal.
  method cancelled {
    self.connect($!c, 'cancelled');
  }

  multi multi method cancel {
    GIO::Cancellable.cancel($!c);
  }
  multi method cancel (
    GIO::Cancellable:U:
    GCancellable $cancel = GCancellable
  ) {
    g_cancellable_cancel($cancel);
  }

  method connect (
    &callback,
    gpointer $data = gpointer,
    GDestroyNotify $data_destroy_func = GDestroyNotify
  ) {
    g_cancellable_connect($!c, &callback, $data, $data_destroy_func);
  }

  method disconnect (gulong $handler_id) {
    my gulong $h = $handler_id;

    g_cancellable_disconnect($!c, $h);
  }

  method get_current (:$raw = False) is also<get-current> {
    my $c = g_cancellable_get_current();

    $c ??
      ( $raw ?? $c !! GIO::Cancellable.new($c) )
      !!
      Nil;
  }

  method get_fd is also<get-fd> {
    g_cancellable_get_fd($!c);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_cancellable_get_type, $n, $t );
  }

  method is_cancelled is also<is-cancelled> {
    so g_cancellable_is_cancelled($!c);
  }

  method make_pollfd (GPollFD() $pollfd) is also<make-pollfd> {
    so g_cancellable_make_pollfd($!c, $pollfd);
  }

  method pop_current is also<pop-current> {
    g_cancellable_pop_current($!c);
  }

  method push_current is also<push-current> {
    g_cancellable_push_current($!c);
  }

  method release_fd is also<release-fd> {
    g_cancellable_release_fd($!c);
  }

  method reset {
    g_cancellable_reset($!c);
  }

  method set_error_if_cancelled (CArray[Pointer[GError]] $error = gerror)
    is also<set-error-if-cancelled>
  {
    clear_error;
    my $rv = g_cancellable_set_error_if_cancelled($!c, $error);
    set_error($error);
    $rv;
  }

  method source_new (:$raw = False) is also<source-new> {
    my $s = g_cancellable_source_new($!c);

    $s ??
      ( $raw ?? $s !! GTK::Compat::Source.new($s) )
      !!
      Nil;
  }

}
