use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Addresses;

sub g_dbus_address_escape_value (Str $string)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_address_get_for_bus_sync (
  GBusType $bus_type,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_address_get_stream (
  Str $address,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_address_get_stream_finish (
  GAsyncResult $res,
  Str $out_guid,
  CArray[Pointer[GError]] $error
)
  returns GIOStream
  is native(gio)
  is export
{ * }

sub g_dbus_address_get_stream_sync (
  Str $address,
  Str $out_guid,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GIOStream
  is native(gio)
  is export
{ * }

sub g_dbus_is_address (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_supported_address (Str $string, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
{ * }
