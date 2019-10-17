use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::TlsDatabase;

sub g_tls_database_create_certificate_handle (
  GTlsDatabase $self,
  GTlsCertificate $certificate
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_tls_database_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificate_for_handle (
  GTlsDatabase $self,
  Str $handle,
  GTlsInteraction $interaction,
  GTlsDatabaseLookupFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificate_for_handle_async (
  GTlsDatabase $self,
  Str $handle,
  GTlsInteraction $interaction,
  GTlsDatabaseLookupFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificate_for_handle_finish (
  GTlsDatabase $self,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificate_issuer (
  GTlsDatabase $self,
  GTlsCertificate $certificate,
  GTlsInteraction $interaction,
  GTlsDatabaseLookupFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificate_issuer_async (
  GTlsDatabase $self,
  GTlsCertificate $certificate,
  GTlsInteraction $interaction,
  GTlsDatabaseLookupFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificate_issuer_finish (
  GTlsDatabase $self,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificates_issued_by (
  GTlsDatabase $self,
  GByteArray $issuer_raw_dn,
  GTlsInteraction $interaction,
  GTlsDatabaseLookupFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificates_issued_by_async (
  GTlsDatabase $self,
  GByteArray $issuer_raw_dn,
  GTlsInteraction $interaction,
  GTlsDatabaseLookupFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_database_lookup_certificates_issued_by_finish (
  GTlsDatabase $self,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_tls_database_verify_chain (
  GTlsDatabase $self,
  GTlsCertificate $chain,
  Str $purpose,
  GSocketConnectable $identity,
  GTlsInteraction $interaction,
  GTlsDatabaseVerifyFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }

sub g_tls_database_verify_chain_async (
  GTlsDatabase $self,
  GTlsCertificate $chain,
  Str $purpose,
  GSocketConnectable $identity,
  GTlsInteraction $interaction,
  GTlsDatabaseVerifyFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_tls_database_verify_chain_finish (
  GTlsDatabase $self,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }
