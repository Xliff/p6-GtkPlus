use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::ObjectSkeleton;

sub g_dbus_object_skeleton_add_interface (
  GDBusObjectSkeleton $object,
  GDBusInterfaceSkeleton $interface
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_skeleton_flush (GDBusObjectSkeleton $object)
  is native(gio)
  is export
{ * }

sub g_dbus_object_skeleton_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_object_skeleton_new (Str $object_path)
  returns GDBusObjectSkeleton
  is native(gio)
  is export
{ * }

sub g_dbus_object_skeleton_remove_interface (
  GDBusObjectSkeleton $object,
  GDBusInterfaceSkeleton $interface
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_skeleton_remove_interface_by_name (
  GDBusObjectSkeleton $object,
  Str $interface_name
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_skeleton_set_object_path (
  GDBusObjectSkeleton $object,
  Str $object_path
)
  is native(gio)
  is export
{ * }
