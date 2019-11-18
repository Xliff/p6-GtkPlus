use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Interface;

role GIO::DBus::Roles::Interface {
  has GDBusInterface $!di;

  submethod BUILD (:$interface) {
    $!di = $interface if $interface;
  }

  method roleInit-DBusInterface is also<roleInit_DBusInterface> {
    my \i = findProperImplementor(self.^attributes);

    $!di = cast( GDBusInterface, i.get_value(self) );
  }

  method GTK::Compat::Types::GDBusInterface
    is also<GDBusInterface>
  { $!di }

  method new_interface_obj (GDBusInterface $interface)
    is also<new-interface-obj>
  {
    self.bless( :$interface );
  }

  method object (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $o = g_dbus_interface_get_object($!di);

        $o ??
          ( $raw ?? $o !! ::('GIO::DBus::Roles::Object').new-dbusobject-obj($o) )
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
