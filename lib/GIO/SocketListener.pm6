use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::SocketListener;

use GTK::Compat::Value;

use GIO::Socket;
use GIO::SocketConnection;

use GTK::Roles::Properties;

class GIO::SocketListener {
  also does GTK::Roles::Properties;

  has GSocketListener $!sl is implementor;

  submethod BUILD (:$listener) {
    self.setSocketListener($listener);
  }

  method setSocketListener(GSocketListener $_) {
    $!sl = $_ ~~ GSocketListener ?? $_ !! cast(GSocketListener, $_);

    self.roleInit-Properties;
  }

  method GTK::Compat::Types::GSocketListener
    is also<GSocketListener>
  { $!sl }

  method new {
    self.bless( listener => g_socket_listener_new() );
  }

  # Type: gint
  method listen-backlog is rw  is also<listen_backlog> {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('listen-backlog', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('listen-backlog', $gv);
      }
    );
  }

  method accept (
    GObject() $source_object,
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $rv =
      g_socket_listener_accept($!sl, $source_object, $cancellable, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method accept_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<accept-async>
  {
    g_socket_listener_accept_async($!sl, $cancellable, $callback, $user_data);
  }

  method accept_finish (
    GAsyncResult() $result,
    GObject() $source_object,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<accept-finish>
  {
    clear_error;
    my $rv =
      g_socket_listener_accept_finish($!sl, $result, $source_object, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method accept_socket (
    GObject() $source_object,
    GCancellable $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<accept-socket>
  {
    clear_error;
    my $rv = g_socket_listener_accept_socket(
      $!sl,
      $source_object,
      $cancellable,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::Socket.new($rv) )
      !!
      Nil;
  }

  method accept_socket_async (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<accept-socket-async>
  {
    g_socket_listener_accept_socket_async(
      $!sl,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method accept_socket_finish (
    GAsyncResult() $result,
    GObject() $source_object,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<accept-socket-finish>
  {
    clear_error;
    my $rv = g_socket_listener_accept_socket_finish(
      $!sl,
      $result,
      $source_object,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::Socket.new($rv) )
      !!
      Nil;
  }

  method add_address (
    GSocketAddress() $address,
    Int() $type,
    Int() $protocol,
    GObject() $source_object,
    GSocketAddress() $effective_address,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<add-address>
  {
    my GSocketType $t = $type;
    my GSocketProtocol $p = $protocol;

    clear_error;
    my $rv = so g_socket_listener_add_address(
      $!sl,
      $address,
      $t,
      $p,
      $source_object,
      $effective_address,
      $error
    );
    set_error($error);
    $rv;
  }

  method add_any_inet_port (
    GObject() $source_object,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<add-any-inet-port>
  {
    clear_error;
    my $rv =
      so g_socket_listener_add_any_inet_port($!sl, $source_object, $error);
    set_error($error);
    $rv;
  }

  method add_inet_port (
    Int() $port,
    GObject() $source_object,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<add-inet-port>
  {
    my guint16 $p = $port;

    clear_error;
    my $rv =
      so g_socket_listener_add_inet_port($!sl, $p, $source_object, $error);
    set_error($error);
    $rv;
  }

  method add_socket (
    GSocket() $socket,
    GObject() $source_object,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<add-socket>
  {
    clear_error;
    my $rv =
      so g_socket_listener_add_socket($!sl, $socket, $source_object, $error);
    set_error($error);
    $rv;
  }

  method close {
    g_socket_listener_close($!sl);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_listener_get_type, $n, $t );
  }

  method set_backlog (Int() $listen_backlog) is also<set-backlog> {
    my gint $lb = $listen_backlog;

    g_socket_listener_set_backlog($!sl, $lb);
  }

}
