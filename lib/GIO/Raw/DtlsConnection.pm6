use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::DtlsConnection;

sub g_dtls_connection_close (
  GDtlsConnection $conn,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_close_async (
  GDtlsConnection $conn,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dtls_connection_close_finish (
  GDtlsConnection $conn,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_emit_accept_certificate (
  GDtlsConnection $conn,
  GTlsCertificate $peer_cert,
  GTlsCertificateFlags $errors
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_negotiated_protocol (GDtlsConnection $conn)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_peer_certificate (GDtlsConnection $conn)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_peer_certificate_errors (GDtlsConnection $conn)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dtls_connection_handshake (
  GDtlsConnection $conn,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_handshake_async (
  GDtlsConnection $conn,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dtls_connection_handshake_finish (
  GDtlsConnection $conn,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_shutdown (
  GDtlsConnection $conn,
  gboolean $shutdown_read,
  gboolean $shutdown_write,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_shutdown_async (
  GDtlsConnection $conn,
  gboolean $shutdown_read,
  gboolean $shutdown_write,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dtls_connection_shutdown_finish (
  GDtlsConnection $conn,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_certificate (GDtlsConnection $conn)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_database (GDtlsConnection $conn)
  returns GTlsDatabase
  is native(gio)
  is export
{ * }

sub g_dtls_connection_get_interaction (GDtlsConnection $conn)
  returns GTlsInteraction
  is native(gio)
  is export
{ * }

# sub g_dtls_connection_get_rehandshake_mode (GDtlsConnection $conn)
#   returns GTlsRehandshakeMode
#   is native(gio)
#   is export
# { * }

sub g_dtls_connection_get_require_close_notify (GDtlsConnection $conn)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dtls_connection_set_certificate (
  GDtlsConnection $conn,
  GTlsCertificate $certificate
)
  is native(gio)
  is export
{ * }

sub g_dtls_connection_set_database (
  GDtlsConnection $conn,
  GTlsDatabase $database
)
  is native(gio)
  is export
{ * }

sub g_dtls_connection_set_interaction (
  GDtlsConnection $conn,
  GTlsInteraction $interaction
)
  is native(gio)
  is export
{ * }

# sub g_dtls_connection_set_rehandshake_mode (
#   GDtlsConnection $conn,
#   GTlsRehandshakeMode $mode
# )
#   is native(gio)
#   is export
# { * }

sub g_dtls_connection_set_require_close_notify (
  GDtlsConnection $conn,
  gboolean $require_close_notify
)
  is native(gio)
  is export
{ * }

sub g_dtls_connection_set_advertised_protocols (
  GDtlsConnection $conn,
  CArray[Str] $protocols
)
  is native(gio)
  is export
{ * }
