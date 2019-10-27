use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Proxy;

sub g_dbus_proxy_call (
  GDBusProxy $proxy,
  Str $method_name,
  GVariant $parameters,
  GDBusCallFlags $flags,
  gint $timeout_msec,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_call_finish (
  GDBusProxy $proxy,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_call_sync (
  GDBusProxy $proxy,
  Str $method_name,
  GVariant $parameters,
  GDBusCallFlags $flags,
  gint $timeout_msec,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_call_with_unix_fd_list (
  GDBusProxy $proxy,
  Str $method_name,
  GVariant $parameters,
  GDBusCallFlags $flags,
  gint $timeout_msec,
  GUnixFDList $fd_list,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_call_with_unix_fd_list_finish (
  GDBusProxy $proxy,
  GUnixFDList $out_fd_list,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_call_with_unix_fd_list_sync (
  GDBusProxy $proxy,
  Str $method_name,
  GVariant $parameters,
  GDBusCallFlags $flags,
  gint $timeout_msec,
  GUnixFDList $fd_list,
  GUnixFDList $out_fd_list,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_cached_property (GDBusProxy $proxy, Str $property_name)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_cached_property_names (GDBusProxy $proxy)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_connection (GDBusProxy $proxy)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_flags (GDBusProxy $proxy)
  returns GDBusProxyFlags
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_interface_name (GDBusProxy $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_name (GDBusProxy $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_name_owner (GDBusProxy $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_object_path (GDBusProxy $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_new (
  GDBusConnection $connection,
  GDBusProxyFlags $flags,
  GDBusInterfaceInfo $info,
  Str $name,
  Str $object_path,
  Str $interface_name,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_new_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusProxy
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_new_for_bus (
  GBusType $bus_type,
  GDBusProxyFlags $flags,
  GDBusInterfaceInfo $info,
  Str $name,
  Str $object_path,
  Str $interface_name,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_new_for_bus_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusProxy
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_new_for_bus_sync (
  GBusType $bus_type,
  GDBusProxyFlags $flags,
  GDBusInterfaceInfo $info,
  Str $name,
  Str $object_path,
  Str $interface_name,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusProxy
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_new_sync (
  GDBusConnection $connection,
  GDBusProxyFlags $flags,
  GDBusInterfaceInfo $info,
  Str $name,
  Str $object_path,
  Str $interface_name,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusProxy
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_set_cached_property (
  GDBusProxy $proxy,
  Str $property_name,
  GVariant $value
)
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_default_timeout (GDBusProxy $proxy)
  returns gint
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_get_interface_info (GDBusProxy $proxy)
  returns GDBusInterfaceInfo
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_set_default_timeout (GDBusProxy $proxy, gint $timeout_msec)
  is native(gio)
  is export
{ * }

sub g_dbus_proxy_set_interface_info (
  GDBusProxy $proxy,
  GDBusInterfaceInfo $info
)
  is native(gio)
  is export
{ * }
