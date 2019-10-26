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

  multi method new (GDBusProxy $proxy) {
    self.bless( :$proxy );
  }

  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(
      $connection,
      $flags,
      GDBusInterfaceInfo,
      $name,
      $object_path,
      $interface_name,
      GCancellable,
      $error
    );
  }
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    GDBusInterfaceInfo $info,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GDBusProxyFlags $f = $flags;

    clear_error;
    my $p = g_dbus_proxy_new_sync(
      $connection,
      $f,
      $info,
      $name,
      $object_path,
      $interface_name,
      $cancellable,
      $error
    );
    set_error($error);

    $p ?? self.bless( proxy => $p ) !! Nil;
  }

  method new_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    &callback             = -> *@a { },
    gpointer $user_data   = gpointer
  ) {
    samewith(
      $connection,
      $flags,
      GDBusInterfaceInfo,
      $name,
      $object_path,
      $interface_name,
      GCancellable,
      &callback,
      $user_data
    );
  }
  method new_async (
    GDBusConnection() $connection,
    Int() $flags,
    GDBusInterfaceInfo $info,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GDBusProxyFlags $f = $flags;

    g_dbus_proxy_new(
      $connection,
      $f,
      $info,
      $name,
      $object_path,
      $interface_name,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method new_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_dbus_proxy_new_finish($res, $error);
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

  multi method call (
    Str()          $method_name,
    Int()          $flags,
    Int()          $timeout_msec  = -1,
    GVariant()     $parameters    = GVariant,
    &callback                     = -> *@a { },
    gpointer       $user_data     = gpointer,
    :$async is required
  ) {
    self.call_async(
      $method_name,
      $flags,
      $timeout_msec,
      $parameters,
      &callback,
      $user_data
    );
  }
  multi method call_async (
    Str()          $method_name,
    Int()          $flags,
    Int()          $timeout_msec  = -1,
    GVariant()     $parameters    = GVariant,
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
  multi method call (
    Str()          $method_name,
    GVariant()     $parameters,
    Int()          $flags,
    Int()          $timeout_msec,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data = gpointer,
    :$async is required
  ) {
    self.call_async(
      $method_name,
      $parameters,
      $f,
      $t,
      $cancellable,
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

  multi method call (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$finish is required
  ) {
    self.call_finish($res, $gerror)
  }s
  method call_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_dbus_proxy_call_finish($!dp, $res, $error);
  }

  multi method call (
    Int() $method_name,
    Int() $flags,
    GVariant() $parameters         = GVariant,
    Int() $timeout_msec            = -1,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      GCancellable,
      $gerror
    );
  }
  multi method call (
    Int() $method_name,
    GVariant() $parameters,
    Int() $flags,
    Int() $timeout_msec,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GDBusCallFlags $f = $flags;
    my gint $t = $timeout_msec;

    g_dbus_proxy_call_sync(
      $!dp,
      $method_name,
      $parameters,
      $f,
      $t,
      $cancellable,
      $error
    );
  }

  proto method call_with_unix_fd_list_async (|)
  { * }

  multi method call (
    Str() $method_name,
    Int() $flags,
    GUnixFDList() $fd_list,
    GVariant() $parameters = GVariant,
    Int() $timeout_msec    = -1,
    &callback              = -> *@a { },
    gpointer $user_data    = gpointer,
    :unix_fd_list_asynbc(
      :unix-fd-list-async(:unix_fd_async(:$unix-fd-async))
    ) is required
  ) {
    self.call_with_unix_fd_list(
      $method_name,
      $flags,
      $fd_list,
      $parameters,
      $timeout_msec,
      &callback,
      $user_data
    );
  }
  multi method call_with_unix_fd_list (
    Str() $method_name,
    Int() $flags,
    GUnixFDList() $fd_list,
    GVariant() $parameters = GVariant,
    Int() $timeout_msec    = -1,
    &callback              = -> *@a { },
    gpointer $user_data    = gpointer
  } (
    samewith(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      $fd_list,
      GCancellable,
      &callback,
      $user_data
    );
  }
  multi method call (
    Str() $method_name,
    GVariant() $parameters,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer,
    :unix_fd_list_asynbc(
      :unix-fd-list-async(:unix_fd_async(:$unix-fd-async))
    ) is required
  ) {
    self.call_with_unix_fd_list(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      $fd_list,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method call_with_unix_fd_list (
    Str() $method_name,
    GVariant() $parameters,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer
  ) {
    my GDBusCallFlags $f =  $flags;
    my gint $t = $timeout_msec;

    g_dbus_proxy_call_with_unix_fd_list(
      $!dp,
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      $fd_list,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method call_with_unix_fd_list_finish (|)
  { * }

  multi method call (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :unix_fd_list_finish(
      :unix-fd-list-finish(:unix_fd_finish(:$unix-fd-finish))
    ) is required,
    :$all = True,
    :$raw = False
  } (
    self.call_with_unix_fd_list($res, $error, :$all, :$false);
  }
  multi method call_with_unix_fd_list_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True,
    :$raw = False
  } (
    self.call_with_unix_fd_list_finish($, $res, $error, :$all, :$raw);
  }
  multi method call (
    $out_fd_list is rw,
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :unix_fd_list_finish(
      :unix-fd-list-finish(:unix_fd_finish(:$unix-fd-finish))
    ) is required,
    :$all = True,
    :$raw = False
  } (
    self.call_with_unix_fd_list($out_fd_list, $res, $error, :$all, :$false);
  }
  multi method call_with_unix_fd_list_finish (
    $out_fd_list is rw,
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False,
    :$raw = False
  ) {
    my $oca = CArray[Pointer[GUnixFDList]].new;
    $oca[0] = Pointer[GUnixFDList];

    clear_error;
    my $rv = g_dbus_proxy_call_with_unix_fd_list_finish(
      $!dp,
      $oca,
      $res,
      $error
    );
    set_error($error);
    $out_fd_list = $oca[0] ??
      ( $raw ?? $oca[0] !! GIO::UnixFDList.new( $oca[0] ) )
      !!
      Nil;

    $rv = $rv ??
      ( $raw ?? $rv !! GTK::Compat::Variant.new($_) )
      !!
      Nil;

    $all.not ?? $rv !! ($rv, $out_fd_list)
  }

  proto method call_with_unix_fd_list (|)
  { * }

  multi method call (
    Str() $method_name,
    Int() $flags,
    GUnixFDList() $fd_list,
    GVariant() $parameters        = GVariant,
    Int() $timeout_msec           = -1,
    Array[Pointer[GError]] $error = gerror,
    :unix_fd_list(:unix-fd-list(:unix_fd(:$unix-fd))) is required,
    :$all = True,
    :$raw = False
  ) {
    self.call_with_unix_fd_list(
      $method_name,
      $flags,
      $fd_list
      $parameters,
      $timeout_msec,
      $error,
      :$all,
      :$raw
    );
  }
  multi method call_with_unix_fd_list (
    Str() $method_name,
    Int() $flags,
    GUnixFDList() $fd_list,
    GVariant() $parameters        = GVariant,
    Int() $timeout_msec           = -1,
    Array[Pointer[GError]] $error = gerror,
    :$all = True,
    :$raw = False
  ) {
    self.call_with_unix_fd_list(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      $fd_list,
      $,
      GCancellable,
      :$all,
      :$raw
    );
  }
  multi method call (
    Str()                  $method_name,
    GVariant()             $parameters,
    Int()                  $flags,
    Int()                  $timeout_msec,
    GUnixFDList()          $fd_list,
                           $out_fd_list is rw,
    GCancellable()         $cancellable   = GCancellable,
    Array[Pointer[GError]] $error = gerror,
    :unix_fd_list(:unix-fd-list(:unix_fd(:$unix-fd))) is required,
    :$all = False,
    :$raw = False,
  ) {
    self.call_with_unix_fd_list(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      $fd_list,
      $out_fd_list,
      $cancellable,
      $error
    );
  }
  multi method call_with_unix_fd_list (
    Str()                  $method_name,
    GVariant()             $parameters,
    Int()                  $flags,
    Int()                  $timeout_msec,
    GUnixFDList()          $fd_list,
                           $out_fd_list is rw,
    GCancellable()         $cancellable   = GCancellable,
    Array[Pointer[GError]] $error = gerror,
    :$all = False,
    :$raw = False,
  ) {
    my GDBusCallFlags $f =  $flags;
    my gint $t = $timeout_msec;
    my $oca = CArray[Pointer[GUnixFDList]].new;
    $oca[0] = Pointer[GUnixFDList];

    clear_error;
    my $rv = g_dbus_proxy_call_with_unix_fd_list_sync(
      $!dp,
      $method_name,
      $parameters,
      $f,
      $t,
      $fd_list,
      $oca,
      $cancellable,
      $error
    );
    set_error($error);
    $out_fd_list = $oca[0] ??
      ( $raw ?? $oca[0] !! GIO::UnixFDList.new( $oca[0] ) )
      !!
      Nil;

    $rv = $rv ??
      ( $raw ?? $rv !! GTK::Compat::Variant.new($_) )
      !!
      Nil;

    $all.not ?? $rv !! ($rv, $out_fd_list)
  }

  method get_cached_property (Str() $property_name, :$raw = False) {
    my $v = g_dbus_proxy_get_cached_property($!dp, $property_name);

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil;
  }

  method get_cached_property_names (:$raw = False) {
    my $sa = g_dbus_proxy_get_cached_property_names($!dp)

    $raw ?? $sa !! CStringArrayToArray($sa);
  }

  method get_connection (:$raw = False) {
    my $c = g_dbus_proxy_get_connection($!dp);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  method get_flags {
    GDBusProxyFlagsEnum( g_dbus_proxy_get_flags($!dp) );
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
