use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::ObjectManagerClient;

sub g_dbus_object_manager_client_get_connection (
  GDBusObjectManagerClient $manager
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_get_flags (GDBusObjectManagerClient $manager)
  returns GDBusObjectManagerClientFlags
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_get_name (GDBusObjectManagerClient $manager)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_get_name_owner (
  GDBusObjectManagerClient $manager
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_new (
  GDBusConnection $connection,
  GDBusObjectManagerClientFlags $flags,
  Str $name,
  Str $object_path,
  &get_proxy_type_func (GDBusObjectManagerClient, Str, Str, gpointer --> GType),
  gpointer $get_proxy_type_user_data,
  GDestroyNotify $get_proxy_type_destroy_notify,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_new_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusObjectManager
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_new_for_bus (
  GBusType $bus_type,
  GDBusObjectManagerClientFlags $flags,
  Str $name,
  Str $object_path,
  &get_proxy_type_func (GDBusObjectManagerClient, Str, Str, gpointer --> GType),
  gpointer $get_proxy_type_user_data,
  GDestroyNotify $get_proxy_type_destroy_notify,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_new_for_bus_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusObjectManagerClient
  is native(gio)
  is export
{ * }

sub g_dbus_object_manager_client_new_for_bus_sync (
  GBusType $bus_type,
  GDBusObjectManagerClientFlags $flags,
  Str $name,
  Str $object_path,
  &get_proxy_type_func (GDBusObjectManagerClient, Str, Str, gpointer --> GType),
  gpointer $get_proxy_type_user_data,
  GDestroyNotify $get_proxy_type_destroy_notify,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusObjectManagerClient
  is native(gio)
  is export
{ * }

multi sub g_dbus_object_manager_client_new_sync (
  GDBusConnection $connection,
  GDBusObjectManagerClientFlags $flags,
  Str $name,
  Str $object_path,
  &get_proxy_type_func (GDBusObjectManagerClient, Str, Str, gpointer --> GType),
  gpointer $get_proxy_type_user_data,
  GDestroyNotify $get_proxy_type_destroy_notify,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusObjectManagerClient
  is native(gio)
  is export
{ * }
