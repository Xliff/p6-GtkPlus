use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::TlsBackend;

sub g_tls_backend_get_certificate_type (GTlsBackend $backend)
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_client_connection_type (GTlsBackend $backend)
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_default ()
  returns GTlsBackend
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_dtls_client_connection_type (GTlsBackend $backend)
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_dtls_server_connection_type (GTlsBackend $backend)
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_file_database_type (GTlsBackend $backend)
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_server_connection_type (GTlsBackend $backend)
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_backend_supports_dtls (GTlsBackend $backend)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_backend_supports_tls (GTlsBackend $backend)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_backend_get_default_database (GTlsBackend $backend)
  returns GTlsDatabase
  is native(gio)
  is export
{ * }

sub g_tls_backend_set_default_database (GTlsBackend $backend, GTlsDatabase $database)
  is native(gio)
  is export
{ * }
