use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::NetworkMonitor;

sub g_network_monitor_can_reach (
  GNetworkMonitor $monitor,
  GSocketConnectable $connectable,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_network_monitor_can_reach_async (
  GNetworkMonitor $monitor,
  GSocketConnectable $connectable,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_network_monitor_can_reach_finish (
  GNetworkMonitor $monitor,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_network_monitor_get_connectivity (GNetworkMonitor $monitor)
  returns GNetworkConnectivity
  is native(gio)
  is export
{ * }

sub g_network_monitor_get_default ()
  returns GNetworkMonitor
  is native(gio)
  is export
{ * }

sub g_network_monitor_get_network_available (GNetworkMonitor $monitor)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_network_monitor_get_network_metered (GNetworkMonitor $monitor)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_network_monitor_get_type ()
  returns GType
  is native(gio)
  is export
{ * }
