use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::DtlsClientConnection;

sub g_dtls_client_connection_get_accepted_cas (GDtlsClientConnection $conn)
  returns GList
  is native(gio)
  is export
{ * }

sub g_dtls_client_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dtls_client_connection_new (
  GDatagramBased $base_io_stream,
  GSocketConnectable $server_identity,
  CArray[Pointer[GError]] $error
)
  returns GDtlsClientConnection
  is native(gio)
  is export
{ * }

sub g_dtls_client_connection_get_server_identity (GDtlsClientConnection $conn)
  returns GSocketConnectable
  is native(gio)
  is export
{ * }

sub g_dtls_client_connection_get_validation_flags (GDtlsClientConnection $conn)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }

sub g_dtls_client_connection_set_server_identity (
  GDtlsClientConnection $conn,
  GSocketConnectable $identity
)
  is native(gio)
  is export
{ * }

sub g_dtls_client_connection_set_validation_flags (
  GDtlsClientConnection $conn,
  GTlsCertificateFlags $flags
)
  is native(gio)
  is export
{ * }
