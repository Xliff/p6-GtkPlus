use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::TlsInteraction;

sub g_tls_interaction_ask_password (
  GTlsInteraction $interaction,
  GTlsPassword $password,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsInteractionResult
  is native(gio)
  is export
{ * }

sub g_tls_interaction_ask_password_async (
  GTlsInteraction $interaction,
  GTlsPassword $password,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_interaction_ask_password_finish (
  GTlsInteraction $interaction,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GTlsInteractionResult
  is native(gio)
  is export
{ * }

sub g_tls_interaction_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_interaction_invoke_ask_password (
  GTlsInteraction $interaction,
  GTlsPassword $password,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsInteractionResult
  is native(gio)
  is export
{ * }

sub g_tls_interaction_invoke_request_certificate (
  GTlsInteraction $interaction,
  GTlsConnection $connection,
  GTlsCertificateRequestFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsInteractionResult
  is native(gio)
  is export
{ * }

sub g_tls_interaction_request_certificate (
  GTlsInteraction $interaction,
  GTlsConnection $connection,
  GTlsCertificateRequestFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsInteractionResult
  is native(gio)
  is export
{ * }

sub g_tls_interaction_request_certificate_async (
  GTlsInteraction $interaction,
  GTlsConnection $connection,
  GTlsCertificateRequestFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_interaction_request_certificate_finish (
  GTlsInteraction $interaction,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GTlsInteractionResult
  is native(gio)
  is export
{ * }
