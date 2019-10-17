use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

sub g_tls_connection_emit_accept_certificate (
  GTlsConnection $conn,
  GTlsCertificate $peer_cert,
  GTlsCertificateFlags $errors
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_error_quark ()
  returns GQuark
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_negotiated_protocol (GTlsConnection $conn)
  returns Str
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_peer_certificate (GTlsConnection $conn)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_peer_certificate_errors (GTlsConnection $conn)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_connection_handshake (
  GTlsConnection $conn,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_connection_handshake_async (
  GTlsConnection $conn,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_connection_handshake_finish (
  GTlsConnection $conn,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_certificate (GTlsConnection $conn)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_database (GTlsConnection $conn)
  returns GTlsDatabase
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_interaction (GTlsConnection $conn)
  returns GTlsInteraction
  is native(gio)
  is export
{ * }

# sub g_tls_connection_get_rehandshake_mode (GTlsConnection $conn)
#   returns GTlsRehandshakeMode
#   is native(gio)
#   is export
# { * }

sub g_tls_connection_get_require_close_notify (GTlsConnection $conn)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_connection_get_use_system_certdb (GTlsConnection $conn)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_connection_set_certificate (
  GTlsConnection $conn,
  GTlsCertificate $certificate
)
  is native(gio)
  is export
{ * }

sub g_tls_connection_set_database (
  GTlsConnection $conn,
  GTlsDatabase $database
)
  is native(gio)
  is export
{ * }

sub g_tls_connection_set_interaction (
  GTlsConnection $conn,
  GTlsInteraction $interaction
)
  is native(gio)
  is export
{ * }

# sub g_tls_connection_set_rehandshake_mode (
#   GTlsConnection $conn,
#   GTlsRehandshakeMode $mode
# )
#   is native(gio)
#   is export
# { * }

sub g_tls_connection_set_require_close_notify (
  GTlsConnection $conn,
  gboolean $require_close_notify
)
  is native(gio)
  is export
{ * }

sub g_tls_connection_set_use_system_certdb (
  GTlsConnection $conn,
  gboolean $use_system_certdb
)
  is native(gio)
  is export
{ * }

sub g_tls_connection_set_advertised_protocols (
  GTlsConnection  $conn,
  CArray[Str]     $protocols
)
  is native(gio)
  is export
{ * }
