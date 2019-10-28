use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::DBus::Raw::GDBusObjectManagerServer;

sub g_dbus_object_manager_server_export (
  GDBusObjectManagerServer $manager,
  GDBusObjectSkeleton $object
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_export_uniquely (
  GDBusObjectManagerServer $manager,
  GDBusObjectSkeleton $object
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_is_exported (
  GDBusObjectManagerServer $manager,
  GDBusObjectSkeleton $object
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_new (Str $object_path)
  returns GDBusObjectManagerServer
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_unexport (
  GDBusObjectManagerServer $manager,
  Str $object_path
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_get_connection (
  GDBusObjectManagerServer $manager
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_server_set_connection (
  GDBusObjectManagerServer $manager,
  GDBusConnection $connection
)
  is native(gio)
  is export
{ * }
