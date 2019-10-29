use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::ObjectManagerClient;

use GIO::DBus::Connection;

use GTK::Roles::Properties;

class GIO::DBus::ObjectManagerClient {
  also does GTK::Roles::Properties;

  has GDBusObjectManagerClient $!domc;

  submethod BUILD (:$client) {
    $!domc = $client;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDBusObjectManagerClient
  { $!domc }

  multi method new (GDBusObjectManagerClient $client) {
    self.bless( :$client );
  }
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path
  ) {
    self.new($connection, $flags, $name, $object_path, -> *@a { } );
  }
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    $get_proxy_type_func,
    gpointer $get_proxy_type_user_data            = gpointer,
    GDestroyNotify $get_proxy_type_destroy_notify = gpointer,
    GCancellable() $cancellable                   = GCancellable,
    CArray[Pointer[GError]] $error                = gerror
  ) {
    my GDBusObjectManagerClientFlags $f = $flags;

    clear_error;
    my $omc = g_dbus_object_manager_client_new_sync(
      $connection,
      $f,
      $name,
      $object_path,
      $get_proxy_type_func,
      $get_proxy_type_user_data,
      $get_proxy_type_destroy_notify,
      $cancellable,
      $error
    );
    set_error($error);

    $omc ?? self.bless( client => $omc ) !! Nil;
  }

  proto method new_async (|)
    is also<new-async>
  { * }

  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    &callback,
    gpointer $user_data = gpointer,
    GDestroyNotify $get_proxy_type_destroy_notify = gpointer,
    GCancellable() $cancellable = GCancellable,
    :$async is required
  ) {
    self.new_async(
      $connection,
      $flags,
      $object_path,
      &callback,
      $user_data,
      $get_proxy_type_destroy_notify,
      $cancellable
    );
  }
  multi method new_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    &callback,
    gpointer $user_data = gpointer,
    GDestroyNotify $get_proxy_type_destroy_notify = gpointer,
    GCancellable() $cancellable = GCancellable
  ) {
    self.new_async(
      $connection,
      $flags,
      $name,
      $object_path,
      gpointer,
      gpointer,
      $get_proxy_type_destroy_notify,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    $get_proxy_type_func,
    gpointer $get_proxy_type_user_data,
    GDestroyNotify $get_proxy_type_destroy_notify,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    self.new_async(
      $connection,
      $flags,
      $name,
      $object_path,
      $get_proxy_type_func,
      $get_proxy_type_user_data,
      $get_proxy_type_destroy_notify,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    $get_proxy_type_func,
    gpointer $get_proxy_type_user_data,
    GDestroyNotify $get_proxy_type_destroy_notify,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer
  ) {
    my GDBusObjectManagerClientFlags $f = $flags;

    g_dbus_object_manager_client_new(
      $connection,
      $f,
      $name,
      $object_path,
      $get_proxy_type_func,
      $get_proxy_type_user_data,
      $get_proxy_type_destroy_notify,
      $cancellable,
      &callback,
      $user_data
    );
  }

  multi method new (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$finish is required
  ) {
    self.new_finish($res, $error);
  }
  method new_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) is also<new-finish> {
    clear_error;
    my $omc = g_dbus_object_manager_client_new_finish($res, $error);
    set_error($error);
    $omc ?? self.bless( client => $omc ) !! Nil;
  }

  proto method new_for_bus (|)
    is also<new-for-bus>
  { * }

  multi method new_for_bus (
    Int() $bus_type,
    Int() $flags,
    Str() $name,
    Str() $object_path,
  ) {
    self.new_for_bus($bus_type, $flags, $name, $object_path, gpointer);
  }
  multi method new_for_bus (
    Int() $bus_type,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    $get_proxy_type_func,
    gpointer $get_proxy_type_user_data            = gpointer,
    GDestroyNotify $get_proxy_type_destroy_notify = gpointer,
    GCancellable() $cancellable                   = GCancellable,
    CArray[Pointer[GError]] $error                = gerror
  ) {
    my GBusType $b = $bus_type;
    my GDBusObjectManagerClientFlags $f = $flags;

    g_dbus_object_manager_client_new_for_bus_sync(
      $!domc,
      $flags,
      $name,
      $object_path,
      $get_proxy_type_func,
      $get_proxy_type_user_data,
      $get_proxy_type_destroy_notify,
      $cancellable,
      $error
    );
  }

  proto method new_for_bus_async (|)
    is also<new-for-bus-async>
  { * }

  multi method new_for_bus_async (
    GDBusObjectManagerClientFlags $flags,
    Str $name,
    Str $object_path,
    $get_proxy_type_func,
    gpointer $get_proxy_type_user_data,
    GDestroyNotify $get_proxy_type_destroy_notify,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback ,
    gpointer $user_data = gpointer
  ) {
    g_dbus_object_manager_client_new_for_bus(
      $!domc,
      $flags,
      $name,
      $object_path,
      $get_proxy_type_func,
      $get_proxy_type_user_data,
      $get_proxy_type_destroy_notify,
      $cancellable,
      $callback,
      $user_data
    );
  }

  multi method new (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :bus_finish(:$bus-finish) is required
  ) {
    self.new_for_bus_finish($res, $error);
  }
  method new_for_bus_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-for-bus-finish>
  {
    g_dbus_object_manager_client_new_for_bus_finish($res, $error);
  }

  method get_connection (:$raw = False)
    is also<
      get-connection
      connection
    >
  {
    my $c = g_dbus_object_manager_client_get_connection($!domc);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  # Type: gchar
  method object-path is rw  is also<object_path> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('object-path', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'object-path is a CONSTRUCT-ONLY property' if $DEBUG;
      }
    );
  }

  # Is originally:
  # GDBusObjectManagerClient, GDBusObjectProxy, GDBusProxy, GVariant, GStrv, gpointer --> void
  method interface-proxy-properties-changed is also<interface_proxy_properties_changed> {
    self.connect-interface-proxy-properties-changed($!domc);
  }

  # Is originally:
  # GDBusObjectManagerClient, GDBusObjectProxy, GDBusProxy, gchar, gchar, GVariant, gpointer --> void
  method interface-proxy-signal is also<interface_proxy_signal> {
    self.connect-interface-proxy-signal($!domc);
  }

  method get_flags
    is also<
      get-flags
      flags
    >
  {
    GDBusObjectManagerClientFlagsEnum(
      g_dbus_object_manager_client_get_flags($!domc)
    );
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    g_dbus_object_manager_client_get_name($!domc)
  }

  method get_name_owner
    is also<
      get-name-owner
      name_owner
      name-owner
    >
  {
    g_dbus_object_manager_client_get_name_owner($!domc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_dbus_object_manager_client_get_type,
      $n,
      $t
    );
  }

}
