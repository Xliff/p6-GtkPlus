use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::TlsClientConnection;

sub g_tls_client_connection_copy_session_state (
  GTlsClientConnection $conn,
  GTlsClientConnection $source
)
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_get_accepted_cas (GTlsClientConnection $conn)
  returns GList
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_new (
  GIOStream $base_io_stream,
  GSocketConnectable $server_identity,
  CArray[Pointer[GError]] $error
)
  returns GTlsClientConnection
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_get_server_identity (GTlsClientConnection $conn)
  returns GSocketConnectable
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_get_use_ssl3 (GTlsClientConnection $conn)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_get_validation_flags (GTlsClientConnection $conn)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_set_server_identity (
  GTlsClientConnection $conn,
  GSocketConnectable $identity
)
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_set_use_ssl3 (
  GTlsClientConnection $conn,
  gboolean $use_ssl3
)
  is native(gio)
  is export
{ * }

sub g_tls_client_connection_set_validation_flags (
  GTlsClientConnection $conn,
  GTlsCertificateFlags $flags
)
  is native(gio)
  is export
{ * }
