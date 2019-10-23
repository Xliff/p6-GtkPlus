use v6.c;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Connection;

use GTK::Compat::Variant;

use GIO::DBus::Message;

use GTK::Compat::Roles::Object;

class GIO::DBus::Connection {
  also does GTK::Compat::Roles::Object;

  has GDbusConnection $!dc;

  submethod BUILD (:$connection) {
    $!dc = $connection;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDbusConnection
  { $!dc }

  multi method new (GDBusConnection $connection) {
    self.bless( :$connection );
  }

  method new (
    GIOStream() $io,
    Str() $guid,
    Int() $flags,
    GDBusAuthObserver() $observer,
    CArray[Pointer[GError]] $error = gerror
  ) {
    GIO::DBus::Connection.new(
      $io,
      $guid,
      $f,
      $observer,
      GCancellable,
      $error
    );
  }
  method new (
    GIOStream() $io,
    Str() $guid,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GDBusConnectionFlags $f = $flags;

    clear_error;
    my $c = g_dbus_connection_new_sync(
      $io,
      $guid,
      $f,
      $observer,
      $cancellable,
      $error
    );
    set_error($error);

    $c ?? self.bless( connection => $c ) !! Nil;
  }

  proto method new_async (|)
  { * }

  multi method new (
    GIOStream() $io,
    Str() $guid,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    GIO::DBus::Connection.new_async(
      $io,
      $guid,
      $flags,
      $observer,
      $callback,
      $user_data
    );
  }
  multi method new_async (
    GIOStream() $io,
    Str() $guid,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    GIO::DBus::Connection.new(
      $io,
      $guid,
      $flags,
      $observer,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method new (
    GIOStream() $io,
    Str() $guid,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    :$async is required
  ) {
    GIO::DBus::Connection.new_async(
      $io,
      $guid,
      $flags,
      $observer,
      $cancellable
      $callback,
      $user_data
    );
  }
  multi method new_async (
    GIOStream() $io,
    Str() $guid,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GDBusConnectionFlags $f = $flags;

    g_dbus_connection_new(
      $io,
      $guid,
      $f,
      $observer,
      $cancellable,
      $callback,
      $user_data
    );
  }

  multi method new (
    CArray[Pointer[GError]] $error = gerror,
    :$finish is required)
  {
    GIO::DBus::Connection.new_finish($error);
  }
  method new_finish (
    GSayncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $c = g_dbus_connection_new_finish($res, $error);
    set_error($error);

    $c ?? self.bless( connection => $c ) !! Nil;
  }

  proto method new_for_address (|)
  { * }

  multi method new (
    Str() $address,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :address_async(:$address-async) is required
  ) {
    GIO::DBus::Connection.new(
      $address,
      $flags,
      $observer,
      $callback,
      $user_data
    );
  }
  multi method new_for_address (
    Str() $address,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :address_async(:$address-async) is required
  ) {
    GIO::DBus::Connection.new_for_address(
      $address,
      $flags,
      $observer,
      GCancellable,
      $callback,
      $user_data
    );
  }
  method new (
    Str() $address,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :address_async(:$address-async) is required
  ) {
    GIO::DBus::Connection.new_for_address(
      $address,
      $flags,
      $observer,
      $cancellable,
      $callback,
      $user_data
    );
  }
  method new_for_address (
    Str() $address,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GDBusConnectionFlags $f = $flags;

    my $c = g_dbus_connection_new_for_address(
      $address,
      $f,
      $observer,
      $cancellable,
      $callback,
      $user_data
    );

    $c ?? self.bless( connection => $c ) !! Nil;
  }

  multi method new (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :address_finish(:$address-finish) is required
  ) {
    GIO::DBus::Connection.new_finish($res, $gerror);
  }
  method new_for_address_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $c = g_dbus_connection_new_for_address_finish($res, $error);
    set_error($error);

    $c ?? self.bless( connection => $c ) !! Nil;
  }

  multi method new (
    Str() $address,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$address is required
  ) {
    GIO::DBus::Connection.new_for_address_sync(
      $address,
      $flags,
      $observer,
      $cancellable,
      $error
    );
  }
  method new_for_address_sync (
    Str() $address,
    Int() $flags,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GDBusConnectionFlags $f = $flags;

    clear_error;
    my $c = g_dbus_connection_new_for_address_sync(
      $address,
      $flags,
      $observer,
      $cancellable,
      $error
    );
    set_error($error);

    $c ?? self.bless( connection => $c ) !! Nil;
  }

  method add_filter (
    GDBusMessageFilterFunction $filter_function,
    gpointer $user_data,
    GDestroyNotify $user_data_free_func = gpointer
  ) {
    g_dbus_connection_add_filter(
      $!dc,
      $filter_function,
      $user_data,
      $user_data_free_func
    );
  }

  proto method call_async (|)
  { * }

  # $timeout_msec can be -1
  multi method call(
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :$async is required
  ) {
    self.call_async(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $callback,
      $user_data
    );
  }
  multi method call_async (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method call(
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :$async is required
  ) {
    self.call_async(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $cancellable,
      $callback,
      $user_data
    );
  }
  multi method call_async (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GVariantType $r = $reply_type;
    my GDBusCallFlags $f = $flags;
    my gint $t = $timeout_msec;

    g_dbus_connection_call(
      $!dc,
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $r,
      $f,
      $t,
      $cancellable,
      $callback,
      $user_data
    );
  }

  multi method call(
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$finish is required,
    :$raw = False
  } (
    self.call_finish($res, $gerror);
  }
  method call_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $v = g_dbus_connection_call_finish($!dc, $res, $error);
    set_error($error)

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil
  }

  multi method call (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    self.call_sync(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $r,
      $f,
      $t,
      $cancellable,
      $error,
      :$raw
    );
  }
  method call_sync (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    my GVariantType $r = $reply_type;
    my GDBusCallFlags $f = $flags;
    my gint $t = $timeout_msec;

    clear_error;
    my $v = g_dbus_connection_call_sync(
      $!dc,
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $r,
      $f,
      $t,
      $cancellable,
      $error
    );
    set_error($error);

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil;
  }

  multi method call (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :unix_fd_async(
      :unix-fd-async(:unix_fd_list_async(:$unix-fd-list-async))
    ) is required
  ) {
    self.call_with_unix_fd_list(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      $callback,
      $user_data
    );
  }
  method call_with_unix_fd_list (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method call (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :unix_fd_async(
      :unix-fd-async(:unix_fd_list_async(:$unix-fd-list-async))
    ) is required
  ) {
    self.call_with_unix_fd_list(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      $cancellable,
      $callback,
      $user_data
    );
  }
  method call_with_unix_fd_list (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GVariantType   $r = $reply_type;
    my GDBusCallFlags $f = $flags;
    my gint           $t = $timeout_msec;

    g_dbus_connection_call_with_unix_fd_list(
      $!dc,
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $r,
      $f,
      $t,
      $fd_list,
      $cancellable,
      $callback,
      $user_data
    );
  }

  multi method call (
    GUnixFDList() $out_fd_list,
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :unix_fd_finish(
      :unix-fd-finish(:unix_fd_list_finish(:$unix-fd-list-finish))
    ) is required,
    :$raw = False
  ) {
    self.call_with_unix_fd_list_finish (
      $out_fd_list,
      $res,
      $error,
      :$raw
    )
  }
  method call_with_unix_fd_list_finish (
    GUnixFDList() $out_fd_list,
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $v = g_dbus_connection_call_with_unix_fd_list_finish(
      $!dc,
      $out_fd_list,
      $res,
      $error
    );
    set_error($error);

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil;
  }

  proto method call_with_unix_fd_list_sync (|)
  { * }

  multi method call (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    :unix_fd(:unix-fd(:unix_fd_list(:$unix-fd-list))) is required,
    :$all = True,
    :$raw = False,
  ) {
    my $r = self.call_with_unix_fd_list(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      $,
      GCancellable,
      gerror,
      :$all,
      :$raw
    );
  }
  multi method call_with_unix_fd_list_sync (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    :$all = True,
    :$raw = False
  ) {
    samewith(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      $,
      GCancellable,
      gerror,
      :$all,
      :$raw
    );
  }
  multi method call (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    $out_fd_list is rw,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :unix_fd(:unix-fd(:unix_fd_list(:$unix-fd-list))) is required,
    :$all = False,
    :$raw = False
  ) {
    self.call_with_unix_fd_list(
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      $out_fd_list,
      $cancellable,
      $error,
      :$all,
      :$raw
    );
  }
  multi method call_with_unix_fd_list_sync (
    Str() $bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $method_name,
    GVariant() $parameters,
    Int() $reply_type,
    Int() $flags,
    Int() $timeout_msec,
    GUnixFDList() $fd_list,
    $out_fd_list is rw,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False,
    :$raw = False
  ) {
    my $ofl = CArray[Pointer[GUnixFDList]].new;
    $ofl[0] = Pointer[GUnixFDList];

    clear_error;
    my $v = g_dbus_connection_call_with_unix_fd_list_sync(
      $!dc,
      $bus_name,
      $object_path,
      $interface_name,
      $method_name,
      $parameters,
      $reply_type,
      $flags,
      $timeout_msec,
      $fd_list,
      $ofl,
      $cancellable,
      $error
    );
    set_error($error);

    $out_fd_list = $ofl[0] ?? $ofl[0] !! Nil;
    $v = $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil;
    $all.not ?? $v !! ($v, $out_fd_list);
  }

  proto method close_async (|)
  { * }

  multi method close (
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    self.close_async(GCancellable, $callback, $user_data);
  }
  multi method close_async (
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
  ) {
    samewith(GCancellable, $callback, $user_data);
  }
  multi method close (
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    self.close_async($cancellable, $callback, $user_data);
  }
  multi method close_async (
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
  ) {
    g_dbus_connection_close($!dc, $cancellable, $callback, $user_data);
  }

  multi method close (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$finish is required
  ) {
    self.close_finish($res, $error);
  }
  method close_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so g_dbus_connection_close_finish($!dc, $res, $error);
    set_error($error);
    $rv;
  }

  multi method close (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_dbus_connection_close_sync($!dc, $cancellable, $error);
  }

  method emit_signal (
    Str() $destination_bus_name,
    Str() $object_path,
    Str() $interface_name,
    Str() $signal_name,
    GVariant() $parameters,
    CArray[Pointer[GError]] $error = gerror
  ) {
    so g_dbus_connection_emit_signal(
      $!dc,
      $destination_bus_name,
      $object_path,
      $interface_name,
      $signal_name,
      $parameters,
      $error
    );
  }

  proto method flush_async (|)
  { * }

  multi method flush (
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :$async is required
  ) {
    self.flush_async($callback, $user_data);
  }
  multi method flush_async (
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    self.flush_async(GCancellable, $callback, $user_data);
  }
  multi method flush (
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
    :$async is required
  ) {
    self.flush_async($cancellable, $callback, $user_data);
  }
  multi method flush_async (
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    g_dbus_connection_flush($!dc, $cancellable, $callback, $user_data);
  }

  multi method flush (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$finish is required
  ) {
    self.flush_finish($res, $error);
  }
  method flush_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_dbus_connection_flush_finish($!dc, $res, $error);
  }

  method flush (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    so g_dbus_connection_flush_sync($!dc, $cancellable, $error);
  }

  # Class methods. Returns a GDBusConnection
  multi method get (
    GIO::DBus::Connection:U:
    Int() $bus_type,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    GIO::DBus::Connection.get_sync($bus_type, $cancellable, $error);
  }
  method get_sync (
    GIO::DBus::Connection:U:
    Int() $bus_type,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GBusType $b = $bus_type;

    my $c = g_bus_get_sync($b, $cancellable, $error);

    $c ?? self.bless(connection => $c) !! Nil;
  }

  multi method get (
    GIO::DBus::Connection:U:
    Int() $bus_type,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    GIO::DBus::Connection.get_async(
      $bus_name,
      GCancellable,
      $callback,
      $user_data
    );
  }
  method get_async (
    GIO::DBus::Connection:U:
    Int() $bus_type,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GBusType $b = $bus_type;

    GIO::DBus::Connection.get_async(
      $bus_type,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method get (
    GIO::DBus::Connection:U:
    Int() $bus_type,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer,
    :$async is required
  ) {
    GIO::DBus::Connection.get_async(
      $bus_type,
      $cancellable,
      $callback,
      $user_data
    );
  }
  method get_async (
    GIO::DBus::Connection:U:
    Int() $bus_type,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my GBusType $b = $bus_type;

    g_bus_get($b, $cancellable, $callback, $user_data);
  }

  multi method get (
    GIO::DBus::Connection:U:
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
    :$finish is required
  ) {
    GIO::DBus::Connection.get_finish($res, $error);
  }
  method get_finish (
    GIO::DBus::Connection:U:
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my $c = g_bus_get_finish($res, $error);

    $c ?? self.bless( connection => $c ) !! Nil;
  }

  method get_capabilities {
    GBusConnectionFlagsEnum( g_dbus_connection_get_capabilities($!dc) );
  }

  method get_flags {
    GDbusConnectionFlagsEnum( g_dbus_connection_get_flags($!dc) );
  }

  method get_guid {
    g_dbus_connection_get_guid($!dc);
  }

  method get_last_serial {
    g_dbus_connection_get_last_serial($!dc);
  }

  method get_peer_credentials (:$raw = False) {
    my $c = g_dbus_connection_get_peer_credentials($!dc);

    $c ??
      ( $raw ?? $c !! GIO::Credentials.new($c) )
      !!
      Nil
  }

  method get_stream ($raw = False) {
    my $s = g_dbus_connection_get_stream($!dc);

    $s ??
      ( $raw ?? $s !! GIO::Stream.new($s) )
      !!
      Nil
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_connection_get_type, $n, $t );
  }

  method get_unique_name {
    g_dbus_connection_get_unique_name($!dc);
  }

  method is_closed {
    so g_dbus_connection_is_closed($!dc);
  }

  method register_object (Str $object_path, GDBusInterfaceInfo $interface_info, GDBusInterfaceVTable $vtable, gpointer $user_data, GDestroyNotify $user_data_free_func, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_connection_register_object($!dc, $object_path, $interface_info, $vtable, $user_data, $user_data_free_func, $error);
  }

  method register_object_with_closures (Str $object_path, GDBusInterfaceInfo $interface_info, GClosure $method_call_closure, GClosure $get_property_closure, GClosure $set_property_closure, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_connection_register_object_with_closures($!dc, $object_path, $interface_info, $method_call_closure, $get_property_closure, $set_property_closure, $error);
  }

  method register_subtree (Str $object_path, GDBusSubtreeVTable $vtable, GDBusSubtreeFlags $flags, gpointer $user_data, GDestroyNotify $user_data_free_func, CArray[Pointer[GError]] $error = gerror) {
    g_dbus_connection_register_subtree($!dc, $object_path, $vtable, $flags, $user_data, $user_data_free_func, $error);
  }

  method remove_filter (guint $filter_id) {
    g_dbus_connection_remove_filter($!dc, $filter_id);
  }

  proto method send_message_with_reply (|)
  { * }

  multi method send_message_with_reply (
    GDBusMessage()        $message,
    Int()                 $flags,
    Int()                 $timeout_msec,
    GAsyncReadyCallback   $callback,
    gpointer              $user_data = gpointer
  ) {
    self.send_message_with_reply(
      $message,
      $flags,
      $timeout_msec,
      $,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method send_message_with_reply (
    GDBusMessage()        $message,
    Int()                 $flags,
    Int()                 $timeout_msec,
                          $out_serial is rw,
    GCancellable()        $cancellable,
    GAsyncReadyCallback   $callback,
    gpointer              $user_data = gpointer
  ) {
    my GDBusSendMessageFlags $f = $flags;
    my gint $t = $timeout_msec;
    my guint $o = 0;

    g_dbus_connection_send_message_with_reply (
      $!dc,
      $message,
      $f,
      $t,
      $o,
      $cancellable,
      $callback,
      $user_data
    );
    $out_serial = $o;
  }

  method send_message_with_reply_finish (
    GAsyncResult() $res,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $m = g_dbus_connection_send_message_with_reply_finish(
      $!dc,
      $res,
      $error
    );
    set_error($error);

    $m ??
      ( $raw ?? $m !! GIO::DBus::Message.new($m) )
      !!
      Nil;
  }

  method signal_subscribe (Str $sender, Str $interface_name, Str $member, Str $object_path, Str $arg0, GDBusSignalFlags $flags, GDBusSignalCallback $callback, gpointer $user_data, GDestroyNotify $user_data_free_func) {
    g_dbus_connection_signal_subscribe($!dc, $sender, $interface_name, $member, $object_path, $arg0, $flags, $callback, $user_data, $user_data_free_func);
  }

  method signal_unsubscribe (guint $subscription_id) {
    g_dbus_connection_signal_unsubscribe($!dc, $subscription_id);
  }

  method start_message_processing {
    g_dbus_connection_start_message_processing($!dc);
  }

  method unregister_object (guint $registration_id) {
    g_dbus_connection_unregister_object($!dc, $registration_id);
  }

  method unregister_subtree (guint $registration_id) {
    g_dbus_connection_unregister_subtree($!dc, $registration_id);
  }

}
