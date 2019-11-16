use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Connection;

sub g_dbus_connection_add_filter (
  GDBusConnection $connection,
  &filter (GDBusConnection, GDBusMessage, gboolean, Pointer --> GDBusMessage),
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_call (
  GDBusConnection $connection,
  Str $bus_name,
  Str $object_path,
  Str $interface_name,
  Str $method_name,
  GVariant $parameters,
  GVariantType $reply_type,
  GDBusCallFlags $flags,
  gint $timeout_msec,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_call_finish (
  GDBusConnection $connection,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_connection_call_sync (
  GDBusConnection $connection,
  Str $bus_name,
  Str $object_path,
  Str $interface_name,
  Str $method_name,
  GVariant $parameters,
  GVariantType $reply_type,
  GDBusCallFlags $flags,
  gint $timeout_msec,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_connection_call_with_unix_fd_list (
  GDBusConnection $connection,
  Str $bus_name,
  Str $object_path,
  Str $interface_name,
  Str $method_name,
  GVariant $parameters,
  GVariantType $reply_type,
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

sub g_dbus_connection_call_with_unix_fd_list_finish (
  GDBusConnection $connection,
  GUnixFDList $out_fd_list,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_connection_call_with_unix_fd_list_sync (
  GDBusConnection $connection,
  Str $bus_name,
  Str $object_path,
  Str $interface_name,
  Str $method_name,
  GVariant $parameters,
  GVariantType $reply_type,
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

sub g_dbus_connection_close (
  GDBusConnection $connection,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_close_finish (
  GDBusConnection $connection,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_close_sync (
  GDBusConnection $connection,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_emit_signal (
  GDBusConnection $connection,
  Str $destination_bus_name,
  Str $object_path,
  Str $interface_name,
  Str $signal_name,
  GVariant $parameters,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_flush (
  GDBusConnection $connection,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_flush_finish (
  GDBusConnection $connection,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_flush_sync (
  GDBusConnection $connection,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_bus_get (
  GBusType $bus_type,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_bus_get_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_bus_get_sync (
  GBusType $bus_type,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_capabilities (GDBusConnection $connection)
  returns GDBusCapabilityFlags
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_flags (GDBusConnection $connection)
  returns GDBusConnectionFlags
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_guid (GDBusConnection $connection)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_last_serial (GDBusConnection $connection)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_peer_credentials (GDBusConnection $connection)
  returns GCredentials
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_stream (GDBusConnection $connection)
  returns GIOStream
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_unique_name (GDBusConnection $connection)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_connection_is_closed (GDBusConnection $connection)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_new (
  GIOStream $stream,
  Str $guid,
  GDBusConnectionFlags $flags,
  GDBusAuthObserver $observer,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_new_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_connection_new_for_address (
  Str $address,
  GDBusConnectionFlags $flags,
  GDBusAuthObserver $observer,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_new_for_address_finish (
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_connection_new_for_address_sync (
  Str $address,
  GDBusConnectionFlags $flags,
  GDBusAuthObserver $observer,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_connection_new_sync (
  GIOStream $stream,
  Str $guid,
  GDBusConnectionFlags $flags,
  GDBusAuthObserver $observer,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_connection_register_object (
  GDBusConnection $connection,
  Str $object_path,
  GDBusInterfaceInfo $interface_info,
  GDBusInterfaceVTable $vtable,
  gpointer $user_data,
  GDestroyNotify $user_data_free_func,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_register_object_with_closures (
  GDBusConnection $connection,
  Str $object_path,
  GDBusInterfaceInfo $interface_info,
  GClosure $method_call_closure,
  GClosure $get_property_closure,
  GClosure $set_property_closure,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_register_subtree (
  GDBusConnection $connection,
  Str $object_path,
  GDBusSubtreeVTable $vtable,
  GDBusSubtreeFlags $flags,
  gpointer $user_data,
  GDestroyNotify $user_data_free_func,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_remove_filter (
  GDBusConnection $connection,
  guint $filter_id
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_send_message_with_reply_finish (
  GDBusConnection $connection,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_connection_signal_subscribe (
  GDBusConnection $connection,
  Str $sender,
  Str $interface_name,
  Str $member,
  Str $object_path,
  Str $arg0,
  GDBusSignalFlags $flags,
  &callback (GDBusConnection, Str, Str, Str, Str, GVariant, Pointer),
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_signal_unsubscribe (
  GDBusConnection $connection,
  guint $subscription_id
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_start_message_processing (GDBusConnection $connection)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_unregister_object (
  GDBusConnection $connection,
  guint $registration_id
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_unregister_subtree (
  GDBusConnection $connection,
  guint $registration_id
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_get_exit_on_close (GDBusConnection $connection)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_connection_set_exit_on_close (
  GDBusConnection $connection,
  gboolean $exit_on_close
)
  is native(gio)
  is export
{ * }

sub g_dbus_connection_send_message_with_reply (
  GDBusConnection       $connection,
  GDBusMessage          $message,
  GDBusSendMessageFlags $flags,
  gint                  $timeout_msec,
  guint32               $out_serial is rw,
  GCancellable          $cancellable,
  GAsyncReadyCallback   $callback,
  gpointer              $user_data
)
  is native(gio)
  is export
{ * }


### gio/gmenuexporter.h

sub g_dbus_connection_export_menu_model (
  GDBusConnection $connection,
  Str $object_path,
  GMenuModel $menu,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_unexport_menu_model (
  GDBusConnection $connection,
  guint $export_id
)
  is native(gio)
  is export
{ * }


### gio/gactiongroupexporter.h

sub g_dbus_connection_export_action_group (GDBusConnection $connection, Str $object_path, GActionGroup $action_group, CArray[Pointer[GError]] $error)
  returns guint
  is native(gio)
  is export
{ * }

sub g_dbus_connection_unexport_action_group (GDBusConnection $connection, guint $export_id)
  is native(gio)
  is export
{ * }
