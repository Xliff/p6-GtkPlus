use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::MethodInvocation;

use GIO::DBus::Connection;
use GIO::DBus::Message;

use GLib::Roles::Object;

class GIO::DBus::MethodInvocation {
  also does GLib::Roles::Object;

  has GDBusMethodInvocation $!dmi is implementor;

  submethod BUILD (:$invocation) {
    $!dmi = $invocation;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDBusMethodInvocation
    is also<GDBusMethodInvocation>
  { $!dmi }

  method get_connection (:$raw = False)
    is also<
      get-connection
      connection
    >
  {
    my $c = g_dbus_method_invocation_get_connection($!dmi);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  method get_interface_name
    is also<
      get-interface-name
      interface_name
      interface-name
    >
  {
    g_dbus_method_invocation_get_interface_name($!dmi);
  }

  method get_message (:$raw = False)
    is also<
      get-message
      message
    >
  {
    my $m = g_dbus_method_invocation_get_message($!dmi);

    $m ??
      ( $raw ?? $m !! GIO::DBus::Message.new($m) )
      !!
      Nil;
  }

  method get_method_info
    is also<
      get-method-info
      method_info
      method-info
    >
  {
    g_dbus_method_invocation_get_method_info($!dmi);
  }

  method get_method_name
    is also<
      get-method-name
      method_name
      method-name
    >
  {
    g_dbus_method_invocation_get_method_name($!dmi);
  }

  method get_object_path
    is also<
      get-object-path
      object_path
      object-path
    >
  {
    g_dbus_method_invocation_get_object_path($!dmi);
  }

  method get_parameters
    is also<
      get-parameters
      parameters
    >
  {
    g_dbus_method_invocation_get_parameters($!dmi);
  }

  method get_property_info
    is also<
      get-property-info
      property_info
      property-info
    >
  {
    g_dbus_method_invocation_get_property_info($!dmi);
  }

  method get_sender
    is also<
      get-sender
      sender
    >
  {
    g_dbus_method_invocation_get_sender($!dmi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_method_invocation_get_type, $n, $t );
  }

  method get_user_data
    is also<
      get-user-data
      user_data
      user-data
    >
  {
    g_dbus_method_invocation_get_user_data($!dmi);
  }

  method return_dbus_error (Str() $error_name, Str() $error_message)
    is also<return-dbus-error>
  {
    g_dbus_method_invocation_return_dbus_error($!dmi, $error_name, $error_message);
  }

  method return_error(
    GQuark() $domain,
    Int()    $code,
    Str()    $error_msg
  )
    is also<return-error>
  {
    my gint $c = $code;

    g_dbus_method_invocation_return_error(
      $!dmi,
      $domain,
      $c,
      $error_msg,
      Str
    );
  }

  method return_error_literal (GQuark() $domain, Int() $code, Str() $message)
    is also<return-error-literal>
  {
    my gint $c = $code;

    g_dbus_method_invocation_return_error_literal($!dmi, $domain, $code, $message);
  }

  method return_gerror (GError() $error) is also<return-gerror> {
    g_dbus_method_invocation_return_gerror($!dmi, $error);
  }

  method return_value (GVariant() $parameters) is also<return-value> {
    g_dbus_method_invocation_return_value($!dmi, $parameters);
  }

  method return_value_with_unix_fd_list (
    GVariant() $parameters,
    GUnixFDList() $fd_list
  )
    is also<return-value-with-unix-fd-list>
  {
    g_dbus_method_invocation_return_value_with_unix_fd_list(
      $!dmi,
      $parameters,
      $fd_list
    );
  }

  method take_error (GError() $error) is also<take-error> {
    g_dbus_method_invocation_take_error($!dmi, $error);
  }

}
