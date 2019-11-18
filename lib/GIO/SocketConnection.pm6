use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::SocketConnection;

use GIO::Stream;
use GIO::Socket;
use GIO::SocketAddress;

our subset SocketConnectionAncestry is export of Mu
  where GSocketConnection | GIOStream;

class GIO::SocketConnection is GIO::Stream {
  has GSocketConnection $!sc is implementor;

  submethod BUILD (:$socket) {
    given $socket {
      when SocketConnectionAncestry {
        self.setSocketConnection($socket);
      }

      when GIO::SocketConnection {
      }

      default {
      }
    }
  }

  method setSocketConnection (SocketConnectionAncestry $_) {
    my $to-parent;

    $!sc = do {
      when GSocketConnection {
        $to-parent = cast(GIOStream, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GSocketConnection, $_);
      }
    }
    self.setStream($to-parent);
  }

  method GTK::Compat::Types::GSocketConnection
    is also<GSocketConnection>
  { $!sc }

  proto method new (|)
  { * }

  multi method new (SocketConnectionAncestry $connection) {
    self.bless( :$connection )
  }

  method connect (
    GSocketAddress() $address,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv =
      so g_socket_connection_connect($!sc, $address, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method connect_async (
    GSocketAddress() $address,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<connect-async>
  {
    g_socket_connection_connect_async(
      $!sc,
      $address,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method connect_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<connect-finish>
  {
    clear_error;
    my $rv = so g_socket_connection_connect_finish($!sc, $result, $error);
    set_error($error);
  }

  method factory_create_connection (
    GIO::SocketConnection:U:
    GSocket() $socket,
    :$raw = False
  )
    is also<factory-create-connection>
  {
    my $rv = g_socket_connection_factory_create_connection($socket);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method factory_lookup_type (
    GIO::SocketConnection:U:
    GSocketType $type,
    Int() $protocol_id
  )
    is also<factory-lookup-type>
  {
    my gint $p = $protocol_id;

    g_socket_connection_factory_lookup_type($!sc, $type, $p);
  }

  method factory_register_type (
    GSocketFamily $family,
    GSocketType $type,
    gint $protocol
  )
    is also<factory-register-type>
  {
    g_socket_connection_factory_register_type($!sc, $family, $type, $protocol);
  }

  method get_local_address (
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<get-local-address>
  {
    clear_error;
    my $rv = g_socket_connection_get_local_address($!sc, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketAddress.new($rv) )
      !!
      Nil;
  }

  method get_remote_address (
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<get-remote-address>
  {
    clear_error;
    my $rv = g_socket_connection_get_remote_address($!sc, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketAddress.new($rv) )
      !!
      Nil;
  }

  method get_socket (:$raw) is also<get-socket> {
    my $rv = g_socket_connection_get_socket($!sc);

    $rv ??
      ( $raw ?? $rv !! GIO::Socket.new($rv) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_connection_get_type, $n, $t );
  }

  method is_connected is also<is-connected> {
    so g_socket_connection_is_connected($!sc);
  }

}
