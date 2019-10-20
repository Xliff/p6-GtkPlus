use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Server;

sub g_dbus_server_get_client_address (GDBusServer $server)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_server_get_flags (GDBusServer $server)
  returns GDBusServerFlags
  is native(gio)
  is export
{ * }

sub g_dbus_server_get_guid (GDBusServer $server)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_server_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_server_is_active (GDBusServer $server)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_server_new_sync (
  Str $address,
  GDBusServerFlags $flags,
  Str $guid,
  GDBusAuthObserver $observer, 
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusServer
  is native(gio)
  is export
{ * }

sub g_dbus_server_start (GDBusServer $server)
  is native(gio)
  is export
{ * }

sub g_dbus_server_stop (GDBusServer $server)
  is native(gio)
  is export
{ * }
