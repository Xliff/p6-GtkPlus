use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Utils;

sub g_dbus_generate_guid ()
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_gvalue_to_gvariant (GValue $gvalue, GVariantType $type)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_gvariant_to_gvalue (GVariant $value, GValue $out_gvalue)
  is native(gio)
  is export
{ * }

sub g_dbus_is_guid (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_interface_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_member_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_is_unique_name (Str $string)
  returns uint32
  is native(gio)
  is export
{ * }

# GDBus Name Owning
sub g_bus_own_name (
  GBusType $bus_type,
  Str $name,
  GBusNameOwnerFlags $flags,
  &bus_acquired_handler (GDBusConnection, Str, Pointer),
  &name_acquired_handler (GDBusConnection, Str, Pointer),
  &name_lost_handler (GDBusConnection, Str, Pointer),
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_own_name_on_connection (
  GDBusConnection $connection,
  Str $name,
  GBusNameOwnerFlags $flags,
  &name_acquired_handler (GDBusConnection, Str, Pointer),
  &name_lost_handler (GDBusConnection, Str, Pointer),
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_own_name_on_connection_with_closures (
  GDBusConnection $connection,
  Str $name,
  GBusNameOwnerFlags $flags,
  GClosure $name_acquired_closure,
  GClosure $name_lost_closure
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_own_name_with_closures (
  GBusType $bus_type,
  Str $name,
  GBusNameOwnerFlags $flags,
  GClosure $bus_acquired_closure,
  GClosure $name_acquired_closure,
  GClosure $name_lost_closure
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_unown_name (guint $owner_id)
  is native(gio)
  is export
{ * }

sub g_bus_unwatch_name (guint $watcher_id)
  is native(gio)
  is export
{ * }

# GDBus Name watching
sub g_bus_watch_name (
  GBusType $bus_type,
  Str $name,
  GBusNameWatcherFlags $flags,
  &name_appeared_handler (GDBusConnection, Str, Str, Pointer),
  &name_vanished_handler (GDBusConnection, Str, Pointer),
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_watch_name_on_connection (
  GDBusConnection $connection,
  Str $name,
  GBusNameWatcherFlags $flags,
  &name_appeared_handler (GDBusConnection, Str, Str, Pointer),
  &name_vanished_handler (GDBusConnection, Str, Pointer),
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_watch_name_on_connection_with_closures (
  GDBusConnection $connection,
  Str $name,
  GBusNameWatcherFlags $flags,
  GClosure $name_appeared_closure,
  GClosure $name_vanished_closure
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_bus_watch_name_with_closures (
  GBusType $bus_type,
  Str $name,
  GBusNameWatcherFlags $flags,
  GClosure $name_appeared_closure,
  GClosure $name_vanished_closure
)
  returns guint
  is native(gio)
  is export
{ * }
