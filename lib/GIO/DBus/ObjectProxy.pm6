use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Connection;

use GTK::Roles::Properties;

class GIO::DBus::ObjectProperty {
  also does GTK::Roles::Properties;

  has GDBusObjectProxy $!dop;

  submethod BUILD (:$object-proxy) {
    $!dop = $object-proxy;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDBusObjectProxy
    is also<GDBusObjectProxy>
  { $!dop }

  method new (GDBusConnection() $connection, Str() $object_path) {
    my $c = g_dbus_object_proxy_new($connection, $object_path);

    $c ?? self.bless( object-proxy => $c ) !! Nil;
  }

  # Type: gchar
  method g-object-path is rw
    is also<
      g_object_path
      object-path
      object_path
    >
  {
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

  method get_connection (:$raw = False)
    is also<
      get-connection
      connection
    >
  {
    my $c = g_dbus_object_proxy_get_connection($!dop);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_object_proxy_get_type, $n, $t );
  }

}

sub g_dbus_object_proxy_get_connection (GDBusObjectProxy $proxy)
  returns GDBusConnection
  is native(gio)
  is export
{ * }

sub g_dbus_object_proxy_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_object_proxy_new (GDBusConnection $connection, Str $object_path)
  returns GDBusObjectProxy
  is native(gio)
  is export
{ * }
