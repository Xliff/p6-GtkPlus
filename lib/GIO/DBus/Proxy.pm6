use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Proxy;

use GTK::Roles::Properties;

use GIO::DBus::Roles::Signals::Proxy;

class GIO::DBus::Proxy {
  also does GTK::Roles::Properties;
  also does GIO::DBus::Roles::Signals::Proxy;

  has GDBusProxy $!dp;

  submethod BUILD (:$proxy) {
    $!dp = $proxy;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDBusProxy
  { $!dp }

  method new (GDBusProxyFlags $flags, GDBusInterfaceInfo $info, Str $name, Str $object_path, Str $interface_name, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    g_dbus_proxy_new($!dp, $flags, $info, $name, $object_path, $interface_name, $cancellable, $callback, $user_data);
  }

  method new_finish (CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_new_finish($!dp, $error);
  }

  method new_for_bus (GDBusProxyFlags $flags, GDBusInterfaceInfo $info, Str $name, Str $object_path, Str $interface_name, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    g_dbus_proxy_new_for_bus($!dp, $flags, $info, $name, $object_path, $interface_name, $cancellable, $callback, $user_data);
  }

  method new_for_bus_finish (CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_new_for_bus_finish($!dp, $error);
  }

  method new_for_bus_sync (GDBusProxyFlags $flags, GDBusInterfaceInfo $info, Str $name, Str $object_path, Str $interface_name, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_new_for_bus_sync($!dp, $flags, $info, $name, $object_path, $interface_name, $cancellable, $error);
  }

  method new_sync (GDBusProxyFlags $flags, GDBusInterfaceInfo $info, Str $name, Str $object_path, Str $interface_name, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_new_sync($!dp, $flags, $info, $name, $object_path, $interface_name, $cancellable, $error);
  }

  method default_timeout is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_proxy_get_default_timeout($!dp);
      },
      STORE => sub ($, $timeout_msec is copy) {
        g_dbus_proxy_set_default_timeout($!dp, $timeout_msec);
      }
    );
  }

  # Type: GBusType
  method g-bus-type is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        warn 'g-bus-type does not allow reading' if $DEBUG;
0;

      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('g-bus-type', $gv);
      }
    );
  }

  # Type: GDBusConnection
  method g-connection is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-connection', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('g-connection', $gv);
      }
    );
  }

  # Type: gint
  method g-default-timeout is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-default-timeout', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('g-default-timeout', $gv);
      }
    );
  }

  # Type: GDBusProxyFlags
  method g-flags is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-flags', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('g-flags', $gv);
      }
    );
  }

  # Type: GDBusInterfaceInfo
  method g-interface-info is rw  {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-interface-info', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $,  $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('g-interface-info', $gv);
      }
    );
  }

  # Type: gchar
  method g-interface-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-interface-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('g-interface-name', $gv);
      }
    );
  }

  # Type: gchar
  method g-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('g-name', $gv);
      }
    );
  }

  # Type: gchar
  method g-name-owner is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-name-owner', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'g-name-owner does not allow writing'
      }
    );
  }

  # Type: gchar
  method g-object-path is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('g-object-path', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('g-object-path', $gv);
      }
    );
  }

  method interface_info is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_proxy_get_interface_info($!dp);
      },
      STORE => sub ($, $info is copy) {
        g_dbus_proxy_set_interface_info($!dp, $info);
      }
    );
  }

  # Is originally:
  # GDBusProxy, GVariant, GStrv, gpointer --> void
  method g-properties-changed {
    self.connect-g-properties-changed($!dp);
  }

  # Is originally:
  # GDBusProxy, gchar, gchar, GVariant, gpointer --> void
  method g-signal {
    self.connect-g-signal($!dp);
  }

  proto method call_async (|)
  { * }

  multi method call_async (
    Str()          $method_name,
    Int()          $flags,
    GVariant()     $parameters    = GVariant,
    Int()          $timeout_msec  = -1,
    &callback                     = -> *@a { },
    gpointer       $user_data     = gpointer
  ) {
    samewith(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      GCancellable,
      &callback,
      $user_data
    );
  }
  multi method call_async (
    Str()          $method_name,
    GVariant()     $parameters,
    Int()          $flags,
    Int()          $timeout_msec,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer
  ) {
    my GDBusCallFlags $f = $flags;
    my gint $t = $timeout_msec;

    g_dbus_proxy_call(
      $!dp,
      $method_name,
      $parameters,
      $f,
      $t,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method call_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_dbus_proxy_call_finish($!dp, $res, $error);
  }

  method call_sync (Str $method_name, GVariant $parameters, GDBusCallFlags $flags, gint $timeout_msec, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_call_sync($!dp, $method_name, $parameters, $flags, $timeout_msec, $cancellable, $error);
  }

  method call_with_unix_fd_list (Str $method_name, GVariant $parameters, GDBusCallFlags $flags, gint $timeout_msec, GUnixFDList $fd_list, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
    g_dbus_proxy_call_with_unix_fd_list($!dp, $method_name, $parameters, $flags, $timeout_msec, $fd_list, $cancellable, $callback, $user_data);
  }

  method call_with_unix_fd_list_finish (GUnixFDList $out_fd_list, GAsyncResult $res, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_call_with_unix_fd_list_finish($!dp, $out_fd_list, $res, $error);
  }

  method call_with_unix_fd_list_sync (Str $method_name, GVariant $parameters, GDBusCallFlags $flags, gint $timeout_msec, GUnixFDList $fd_list, GUnixFDList $out_fd_list, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_proxy_call_with_unix_fd_list_sync($!dp, $method_name, $parameters, $flags, $timeout_msec, $fd_list, $out_fd_list, $cancellable, $error);
  }

  method get_cached_property (Str $property_name) {
    g_dbus_proxy_get_cached_property($!dp, $property_name);
  }

  method get_cached_property_names {
    g_dbus_proxy_get_cached_property_names($!dp);
  }

  method get_connection {
    g_dbus_proxy_get_connection($!dp);
  }

  method get_flags {
    g_dbus_proxy_get_flags($!dp);
  }

  method get_interface_name {
    g_dbus_proxy_get_interface_name($!dp);
  }

  method get_name {
    g_dbus_proxy_get_name($!dp);
  }

  method get_name_owner {
    g_dbus_proxy_get_name_owner($!dp);
  }

  method get_object_path {
    g_dbus_proxy_get_object_path($!dp);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_proxy_get_type, $n, $t );
  }

  method set_cached_property (Str() $property_name, GVariant() $value) {
    g_dbus_proxy_set_cached_property($!dp, $property_name, $value);
  }

}
