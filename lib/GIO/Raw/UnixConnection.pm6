use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::UnixConnection;

sub g_unix_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_unix_connection_receive_credentials (
  GUnixConnection $connection,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GCredentials
  is native(gio)
  is export
{ * }

sub g_unix_connection_receive_credentials_async (
  GUnixConnection $connection,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_unix_connection_receive_credentials_finish (
  GUnixConnection $connection,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GCredentials
  is native(gio)
  is export
{ * }

sub g_unix_connection_receive_fd (
  GUnixConnection $connection,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gio)
  is export
{ * }

sub g_unix_connection_send_credentials (
  GUnixConnection $connection,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_connection_send_credentials_async (
  GUnixConnection $connection,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_unix_connection_send_credentials_finish (
  GUnixConnection $connection,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_connection_send_fd (
  GUnixConnection $connection,
  gint $fd,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
