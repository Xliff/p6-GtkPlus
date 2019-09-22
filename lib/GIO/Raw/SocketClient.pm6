use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::SocketClient;

sub g_socket_client_add_application_proxy (
  GSocketClient $client,
  Str $protocol
)
  is native(gio)
  is export
{ * }

sub g_socket_client_connect (
  GSocketClient $client,
  GSocketConnectable $connectable,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_async (
  GSocketClient $client,
  GSocketConnectable $connectable,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_finish (
  GSocketClient $client,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_host (
  GSocketClient $client,
  Str $host_and_port,
  guint16 $default_port,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_host_async (
  GSocketClient $client,
  Str $host_and_port,
  guint16 $default_port,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_host_finish (
  GSocketClient $client,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_service (
  GSocketClient $client,
  Str $domain,
  Str $service,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_service_async (
  GSocketClient $client,
  Str $domain,
  Str $service,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_service_finish (
  GSocketClient $client,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_uri (
  GSocketClient $client,
  Str $uri,
  guint16 $default_port,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_uri_async (
  GSocketClient $client,
  Str $uri,
  guint16 $default_port,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_socket_client_connect_to_uri_finish (
  GSocketClient $client,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnection
  is native(gio)
  is export
{ * }

sub g_socket_client_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_client_new ()
  returns GSocketClient
  is native(gio)
  is export
{ * }

sub g_socket_client_get_enable_proxy (GSocketClient $client)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_client_get_family (GSocketClient $client)
  returns GSocketFamily
  is native(gio)
  is export
{ * }

sub g_socket_client_get_local_address (GSocketClient $client)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_socket_client_get_protocol (GSocketClient $client)
  returns GSocketProtocol
  is native(gio)
  is export
{ * }

sub g_socket_client_get_proxy_resolver (GSocketClient $client)
  returns GProxyResolver
  is native(gio)
  is export
{ * }

sub g_socket_client_get_socket_type (GSocketClient $client)
  returns GSocketType
  is native(gio)
  is export
{ * }

sub g_socket_client_get_timeout (GSocketClient $client)
  returns guint
  is native(gio)
  is export
{ * }

sub g_socket_client_get_tls (GSocketClient $client)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_client_get_tls_validation_flags (GSocketClient $client)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }

sub g_socket_client_set_enable_proxy (GSocketClient $client, gboolean $enable)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_family (GSocketClient $client, GSocketFamily $family)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_local_address (
  GSocketClient $client,
  GSocketAddress $address
)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_protocol (
  GSocketClient $client,
  GSocketProtocol $protocol
)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_proxy_resolver (
  GSocketClient $client,
  GProxyResolver $proxy_resolver
)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_socket_type (GSocketClient $client, GSocketType $type)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_timeout (GSocketClient $client, guint $timeout)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_tls (GSocketClient $client, gboolean $tls)
  is native(gio)
  is export
{ * }

sub g_socket_client_set_tls_validation_flags (
  GSocketClient $client,
  GTlsCertificateFlags $flags
)
  is native(gio)
  is export
{ * }
