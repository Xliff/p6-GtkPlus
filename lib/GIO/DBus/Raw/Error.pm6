use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Error;

sub g_dbus_error_encode_gerror (GError $error)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_error_get_remote_error (GError $error)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_error_is_remote_error (GError $error)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_error_new_for_dbus_error (
  Str $dbus_error_name,
  Str $dbus_error_message
)
  returns GError
  is native(gio)
  is export
{ * }

sub g_dbus_error_quark ()
  returns GQuark
  is native(gio)
  is export
{ * }

sub g_dbus_error_register_error (
  GQuark $error_domain,
  gint $error_code,
  Str $dbus_error_name
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_error_strip_remote_error (GError $error)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_error_unregister_error (
  GQuark $error_domain,
  gint $error_code,
  Str $dbus_error_name
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_error_set_dbus_error (
  CArray[Pointer[GError]] $error,
  Str $dbus_error_name,
  Str $dbus_error_message,
  Str $dbus_error_prefix,
  Str
)
  is native(gio)
  is export
{ * }

sub g_dbus_error_register_error_domain (
  Str     $error_domain_quark_name,
  gsize   $quark_volatile is rw,
  Pointer $entries,               # const GDBusErrorEntry *entries
  guint   $num_entries
)
  is native(gio)
  is export
{ * }
