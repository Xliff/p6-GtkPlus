use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::InterfaceSkeleton;

sub g_dbus_interface_skeleton_export (
  GDBusInterfaceSkeleton $interface,
  GDBusConnection $connection,
  Str $object_path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_flush (GDBusInterfaceSkeleton $interface)
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_connection (
  GDBusInterfaceSkeleton $interface
)
  returns GDBusConnection
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_connections (
  GDBusInterfaceSkeleton $interface
)
  returns GList
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_info (GDBusInterfaceSkeleton $interface)
  returns GDBusInterfaceInfo
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_object_path (
  GDBusInterfaceSkeleton $interface
)
  returns Str
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_properties (
  GDBusInterfaceSkeleton $interface
)
  returns GVariant
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_vtable (GDBusInterfaceSkeleton $interface)
  returns GDBusInterfaceVTable
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_has_connection (
  GDBusInterfaceSkeleton $interface,
  GDBusConnection $connection
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_unexport (GDBusInterfaceSkeleton $interface)
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_unexport_from_connection (
  GDBusInterfaceSkeleton $interface,
  GDBusConnection $connection
)
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_get_flags (GDBusInterfaceSkeleton $interface)
  returns GDBusInterfaceSkeletonFlags
  is native(gtk)
  is export
{ * }

sub g_dbus_interface_skeleton_set_flags (
  GDBusInterfaceSkeleton $interface,
  GDBusInterfaceSkeletonFlags $flags
)
  is native(gtk)
  is export
{ * }
