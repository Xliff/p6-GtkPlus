use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::TlsPassword;

sub g_tls_password_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_password_get_value (GTlsPassword $password, gsize $length)
  returns Str
  is native(gio)
  is export
{ * }

sub g_tls_password_new (GTlsPasswordFlags $flags, Str $description)
  returns GTlsPassword
  is native(gio)
  is export
{ * }

sub g_tls_password_set_value (
  GTlsPassword $password,
  Str $value,
  gssize $length
)
  is native(gio)
  is export
{ * }

sub g_tls_password_set_value_full (
  GTlsPassword $password,
  Str $value,
  gssize $length,
  GDestroyNotify $destroy
)
  is native(gio)
  is export
{ * }

sub g_tls_password_get_description (GTlsPassword $password)
  returns Str
  is native(gio)
  is export
{ * }

sub g_tls_password_get_flags (GTlsPassword $password)
  returns GTlsPasswordFlags
  is native(gio)
  is export
{ * }

sub g_tls_password_get_warning (GTlsPassword $password)
  returns Str
  is native(gio)
  is export
{ * }

sub g_tls_password_set_description (GTlsPassword $password, Str $description)
  is native(gio)
  is export
{ * }

sub g_tls_password_set_flags (GTlsPassword $password, GTlsPasswordFlags $flags)
  is native(gio)
  is export
{ * }

sub g_tls_password_set_warning (GTlsPassword $password, Str $warning)
  is native(gio)
  is export
{ * }
