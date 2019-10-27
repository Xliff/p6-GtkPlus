use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Proxy;

use GTK::Compat::Roles::Object;
use GIO::DBus::Roles::Object;

use GIO::DBus::Roles::Signals::Proxy;

class GIO::DBus::Proxy {
  also does GTK::Compat::Roles::Object;
  also does GIO::DBus::Roles::Object;
  also does GIO::DBus::Roles::Signals::Proxy;


  has GDBusProxy $!dp;

  submethod BUILD (:$proxy) {
    $!dp = $proxy;

    self.roleInit-Object;
    self.roleInit-DBusObject;
  }

  method GTK::Compat::Types::GDBusProxy
    is also<GDBusProxy>
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
    GIO::DBus::Proxy.new(
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

  proto method new_async (|)
      is also<new-async>
  { * }

  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GDBusInterfaceInfo $info = GDBusInterfaceInfo,
    :$async is required
  ) {
    self.new_async(
      $connection,
      $flags,
      $object_path,
      $interface_name,
      $info
    );
  }
  multi method new_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GDBusInterfaceInfo $info = GDBusInterfaceInfo,
    :$async is required
  ) {
    my $s = Supplier::Preserving.new;
    self.new_async(
      $connection,
      $flags,
      $info,
      $name,
      $object_path,
      $interface_name,
      GCancellable,
      -> *@a { $s.emit( @a[1] ) },
      gpointer,
    );
    $s.Supply;
  }
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    &callback,
    gpointer $user_data   = gpointer,
    :$async is required
  ) {
    self.new_async(
      $connection,
      $flags,
      $object_path,
      $interface_name,
      &callback,
      $user_data
    );
  }
  multi method new_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    &callback,
    gpointer $user_data   = gpointer
  ) {
    GIO::DBus::Proxy.new_async(
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
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    GDBusInterfaceInfo $info,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    self.new_async(
      $connection,
      $flags,
      $info,
      $name,
      $object_path,
      $interface_name,
      $cancellable,
      &callback,
      $user_data,
    );
  }
  multi method new_async (
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

  multi method new (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    self.new_finish($res, $error);
  }
  method new_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-finish>
  {
    clear_error;
    my $p = g_dbus_proxy_new_finish($res, $error);
    set_error($error);

    $p ?? self.bless( proxy => $p ) !! Nil;
  }

  proto method new_for_bus (|)
      is also<new-for-bus>
  { * }

  multi method new_for_bus(
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    CArray[Pointer[GError]] $error = gerror
  ) {
    GIO::DBus::Proxy.new_for_bus(
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
  multi method new_for_bus (
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
    my $p = g_dbus_proxy_new_for_bus_sync(
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

  proto method new_for_bus_async (|)
    is also<new-for-bus-async>
  { * }

  # Add Supplier::Preserving variants!
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GDBusInterfaceInfo $info = GDBusInterfaceInfo,
    :bus_async(:$bus-async) is required
  ) {
    self.new_for_bus_async(
      $connection,
      $flags,
      $name,
      $object_path,
      $interface_name,
      $info,
    );
  }
  multi method new_for_bus_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GDBusInterfaceInfo $info = GDBusInterfaceInfo
  ) {
    my $s = Supplier::Preserving.new;
    self.new_for_bus_async(
      $connection,
      $flags,
      $info,
      $name,
      $object_path,
      $interface_name,
      GCancellable,
      -> *@a { $s.emit( @a[1] ) },
      gpointer,
    );
    $s.Supply;
  }
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    &callback,
    gpointer $user_data = gpointer,
    :bus_async(:$bus-async) is required
  ) {
    self.new_for_bus_async(
      $connection,
      $flags,
      $name,
      $object_path,
      $interface_name,
      &callback,
      $user_data,
    );
  }
  multi method new_for_bus_async (
    GDBusConnection() $connection,
    Int() $flags,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    &callback,
    gpointer $user_data = gpointer
  ) {
    GIO::DBus::Proxy.new(
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
  multi method new (
    GDBusConnection() $connection,
    Int() $flags,
    GDBusInterfaceInfo $info,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer,
    :bus_async(:$bus-async) is required
  ) {
    self.new_for_bus_async(
      $connection,
      $flags,
      $info,
      $name,
      $object_path,
      $interface_name,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method new_for_bus_async (
    GDBusConnection() $connection,
    Int() $flags,
    GDBusInterfaceInfo $info,
    Str() $name,
    Str() $object_path,
    Str() $interface_name,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer
  ) {
    my GDBusProxyFlags $f = $flags;

    g_dbus_proxy_new_for_bus(
      $connection,
      $f,
      $info,
      $name,
      $object_path,
      $interface_name,
      $cancellable,
      &callback,
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
    clear_error;
    my $p = g_dbus_proxy_new_for_bus_finish($res, $error);
    set_error($error);

    $p ?? self.bless( proxy => $p ) !! Nil;
  }

  method default_timeout is rw is also<default-timeout> {
    Proxy.new(
      FETCH => sub ($) {
        g_dbus_proxy_get_default_timeout($!dp);
      },
      STORE => sub ($, $timeout_msec is copy) {
        g_dbus_proxy_set_default_timeout($!dp, $timeout_msec);
      }
    );
  }

  method interface_info is rw is also<interface-info> {
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
  method g-properties-changed
    is also<
      g_properties_changed
      properties_changed
      properties-changed
    >
  {
    self.connect-g-properties-changed($!dp);
  }

  # Is originally:
  # GDBusProxy, gchar, gchar, GVariant, gpointer --> void
  method g-signal
    is also<
      g_signal
      signal
    >
  {
    self.connect-g-signal($!dp);
  }

  proto method call_async (|)
      is also<call-async>
  { * }

  multi method call (
    Str()          $method_name,
    GVariant()     $parameters,
    Int()          $flags,
    Int()          $timeout_msec  = -1,
    :$async is required
  ) {
    self.call_async(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
    );
  }
  multi method call_async (
    Str()          $method_name,
    GVariant()     $parameters,
    Int()          $flags,
    Int()          $timeout_msec  = -1,
    :$async is required
  ) {
    my $s = Supplier::Preserving.new;
    self.call_async(
      $method_name,
      $flags,
      $timeout_msec,
      $parameters,
      -> *@a { $s.emit( @a[1] ) },
      gpointer
    );
    $s.Supply;
  }
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
      $flags,
      $timeout_msec,
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
    self.call_finish($res, $error)
  }
  method call_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<call-finish>
  {
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
      $error
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
      is also<call-with-unix-fd-list-async>
  { * }

  multi method call (
    Str() $method_name,
    Int() $flags,
    GUnixFDList() $fd_list,
    GVariant() $parameters = GVariant,
    Int() $timeout_msec    = -1,
    :unix_fd_list_async(
      :unix-fd-list-async(:unix_fd_async(:$unix-fd-async))
    ) is required
  ) {
    self.call_with_unix_fd_list(
      $method_name,
      $flags,
      $fd_list,
      $parameters,
      $timeout_msec
    );
  }
  multi method call_with_unix_fd_list (
    Str() $method_name,
    Int() $flags,
    GUnixFDList() $fd_list,
    GVariant() $parameters = GVariant,
    Int() $timeout_msec    = -1
  ) {
    my $s = Supplier::Preserving.new;
    self.call_with_unix_fd_list(
      $method_name,
      $parameters,
      $flags,
      $timeout_msec,
      $fd_list,
      GCancellable,
      -> *@a { $s.emit( @a[1] ) },
      gpointer
    );
    $s.Supply;
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
    :unix_fd_list_async(
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
  multi method call_with_unix_fd_list_async (
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
      is also<call-with-unix-fd-list-finish>
  { * }

  multi method call (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :unix_fd_list_finish(
      :unix-fd-list-finish(:unix_fd_finish(:$unix-fd-finish))
    ) is required,
    :$all = True,
    :$raw = False
  ) {
    self.call_with_unix_fd_list($res, $error, :$all, :$raw);
  }
  multi method call_with_unix_fd_list_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True,
    :$raw = False
  ) {
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
  ) {
    self.call_with_unix_fd_list($out_fd_list, $res, $error, :$all, :$raw);
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
      is also<call-with-unix-fd-list>
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
      $fd_list,
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
    Str()                   $method_name,
    GVariant()              $parameters,
    Int()                   $flags,
    Int()                   $timeout_msec,
    GUnixFDList()           $fd_list,
                            $out_fd_list is rw,
    GCancellable()          $cancellable   = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
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

  method get_cached_property (Str() $property_name, :$raw = False)
    is also<get-cached-property>
  {
    my $v = g_dbus_proxy_get_cached_property($!dp, $property_name);

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil;
  }

  method get_cached_property_names (:$raw = False)
    is also<
      get-cached-property-names
      cached_property_names
      cached-property-names
    >
  {
    my $sa = g_dbus_proxy_get_cached_property_names($!dp);

    $raw ?? $sa !! CStringArrayToArray($sa);
  }

  method get_connection (:$raw = False)
    is also<
      get-connection
      connection
    >
  {
    my $c = g_dbus_proxy_get_connection($!dp);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  method get_flags
    is also<
      get-flags
      flags
    >
  {
    GDBusProxyFlagsEnum( g_dbus_proxy_get_flags($!dp) );
  }

  method get_interface_name
    is also<
      get-interface-name
      interface_name
      interface-name
    >
  {
    g_dbus_proxy_get_interface_name($!dp);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    g_dbus_proxy_get_name($!dp);
  }

  method get_name_owner
    is also<
      get-name-owner
      name_owner
      name-owner
    >
  {
    g_dbus_proxy_get_name_owner($!dp);
  }

  method get_object_path
    is also<
      get-object-path
      object_path
      object-path
    >
  {
    g_dbus_proxy_get_object_path($!dp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_proxy_get_type, $n, $t );
  }

  method set_cached_property (Str() $property_name, GVariant() $value)
    is also<set-cached-property>
  {
    g_dbus_proxy_set_cached_property($!dp, $property_name, $value);
  }

}
