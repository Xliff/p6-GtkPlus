use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Interface;

#use GIO::DBus::Object;

role GIO::DBus::Roles::Interface {
  has GDBusInterface $!di;

  method roleInit-DBusInterface is also<roleInit_DBusInterface> {
    $!di = cast(
      GDBusInterface,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method GTK::Compat::Types::GDBusInterface
    is also<GDBusInterface>
  { $!di }

  method object (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $o = g_dbus_interface_get_object($!di);

        $o ??
          ( $raw ?? $o !! GIO::DBus::Object.new($o) )
          !!
          Nil;
      },
      STORE => sub ($, GDBusObject() $object is copy) {
        g_dbus_interface_set_object($!di, $object);
      }
    );
  }

  method dup_object () is also<dup-object> {
    g_dbus_interface_dup_object($!di);
  }

  method get_info () is also<get-info> {
    g_dbus_interface_get_info($!di);
  }

  method dbusinterface_get_type is also<dbusinterface-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_interface_get_type, $n, $t );
  }

}
