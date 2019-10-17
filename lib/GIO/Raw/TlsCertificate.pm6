use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::TlsCertificate;

sub g_tls_certificate_get_issuer (GTlsCertificate $cert)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_certificate_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_certificate_is_same (
  GTlsCertificate $cert_one,
  GTlsCertificate $cert_two
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_tls_certificate_list_new_from_file (
  Str $file,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_tls_certificate_new_from_file (Str $file, CArray[Pointer[GError]] $error)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_certificate_new_from_files (
  Str $cert_file,
  Str $key_file,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_certificate_new_from_pem (
  Str $data,
  gssize $length,
  CArray[Pointer[GError]] $error
)
  returns GTlsCertificate
  is native(gio)
  is export
{ * }

sub g_tls_certificate_verify (
  GTlsCertificate $cert,
  GSocketConnectable $identity,
  GTlsCertificate $trusted_ca
)
  returns GTlsCertificateFlags
  is native(gio)
  is export
{ * }
