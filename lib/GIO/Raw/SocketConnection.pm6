use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::SocketConnection;

sub g_socket_connection_connect (
  GSocketConnection $connection,
  GSocketAddress $address,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_connection_connect_async (
  GSocketConnection $connection,
  GSocketAddress $address,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_socket_connection_connect_finish (
  GSocketConnection $connection,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_connection_factory_create_connection (GSocket $socket)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_connection_factory_lookup_type (
  GSocketFamily $family,
  GSocketType $type,
  gint $protocol_id
)
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_connection_factory_register_type (
  GType $g_type,
  GSocketFamily $family,
  GSocketType $type,
  gint $protocol
)
  is native(gio)
  is export
{ * }

sub g_socket_connection_get_local_address (
  GSocketConnection $connection,
  CArray[Pointer[GError]] $error
)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_socket_connection_get_remote_address (
  GSocketConnection $connection,
  CArray[Pointer[GError]] $error
)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_socket_connection_get_socket (GSocketConnection $connection)
  returns GSocket
  is native(gio)
  is export
{ * }

sub g_socket_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_connection_is_connected (GSocketConnection $connection)
  returns uint32
  is native(gio)
  is export
{ * }
