use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Interface;

sub g_dbus_interface_dup_object (GDBusInterface $interface)
  returns GDBusObject
  is native(gio)
  is export
{ * }

sub g_dbus_interface_get_info (GDBusInterface $interface)
  returns GDBusInterfaceInfo
  is native(gio)
  is export
{ * }

sub g_dbus_interface_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_interface_get_object (GDBusInterface $interface)
  returns GDBusObject
  is native(gio)
  is export
{ * }

sub g_dbus_interface_set_object (
  GDBusInterface $interface,
  GDBusObject $object
)
  is native(gio)
  is export
{ * }
