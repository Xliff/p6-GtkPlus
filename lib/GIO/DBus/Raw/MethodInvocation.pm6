use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::MethodInvocation;

sub g_dbus_method_invocation_get_connection (
  GDBusMethodInvocation $invocation
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_interface_name (
  GDBusMethodInvocation $invocation
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_message (
  GDBusMethodInvocation $invocation
)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_method_info (
  GDBusMethodInvocation $invocation
)
  returns GDBusMethodInfo
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_method_name (
  GDBusMethodInvocation $invocation
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_object_path (
  GDBusMethodInvocation $invocation
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_parameters (
  GDBusMethodInvocation $invocation
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_property_info (
  GDBusMethodInvocation $invocation
)
  returns GDBusPropertyInfo
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_sender (GDBusMethodInvocation $invocation)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_get_user_data (GDBusMethodInvocation $invocation)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_return_dbus_error (
  GDBusMethodInvocation $invocation,
  Str $error_name,
  Str $error_message
)
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_return_error_literal (
  GDBusMethodInvocation $invocation,
  GQuark $domain,
  gint $code,
  Str $message
)
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_return_gerror (
  GDBusMethodInvocation $invocation,
  CArray[Pointer[GError]] $error
)
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_return_value (
  GDBusMethodInvocation $invocation,
  GVariant $parameters
)
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_return_value_with_unix_fd_list (
  GDBusMethodInvocation $invocation,
  GVariant $parameters,
  GUnixFDList $fd_list
)
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_take_error (
  GDBusMethodInvocation $invocation,
  CArray[Pointer[GError]] $error
)
  is native(gio)
  is export
{ * }

sub g_dbus_method_invocation_return_error (
  GDBusMethodInvocation $invocation,
  GQuark                $domain,
  gint                  $code,
  Str                   $error_msg,
  Str
)
  is native(gio)
  is export
{ * }
