use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

use GLib::GList;

use GIO::DBus::Roles::Interface;

use GLib::Roles::ListData;

use GIO::DBus::Roles::Signals::Object;

role GIO::DBus::Roles::Object {
  also does GIO::DBus::Roles::Signals::Object;

  has GDBusObject $!do;

  submethod BUILD (:$object) {
    $!do = $object if $object;
  }

  method roleInit-DBusObject is also<roleInit_DBusObject> {
    my \i = findProperImplementor(self.^attributes);

    $!do = cast( GDBusObject, i.get_value(self) );
  }

  method GLib::Raw::Types::GDBusObject
    is also<GDBusObject>
  { $!do }

  method new_dbusobject_obj (GDBusObject $object) is also<new-dbusobject-obj> {
    self.bless(:$object);
  }

  # Is originally:
  # GDBusObject, GDBusInterface, gpointer --> void
  method interface-added {
    self.connect-interface($!do, 'interface-added');
  }

  # Is originally:
  # GDBusObject, GDBusInterface, gpointer --> void
  method interface-removed {
    self.connect-interface($!do, 'interface-removed');
  }

  method get_interface (Str() $interface_name, :$raw = False)
    is also<get-interface>
  {
    my $i = g_dbus_object_get_interface($!do, $interface_name);

    $i ??
      ( $raw ?? $i !! GIO::DBus::Roles::Interface.new-interface-obj($i) )
      !!
      Nil;
  }

  method get_interfaces (:$glist = False, :$raw = False) is also<get-interfaces> {
    my $il = g_dbus_object_get_interfaces($!do);

    return Nil unless $il;
    return $il if     $glist;

    $il = $il but GLib::Roles::ListData[GDBusInterface];
    $raw ??
      $il.Array
      !!
      $il.Array.map({ GIO::DBus::Roles::Interface.new-interface-obj($_) });
  }

  method get_object_path is also<get-object-path> {
    g_dbus_object_get_object_path($!do);
  }

  method dbusobject_get_type is also<dbusobject-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_object_get_type, $n, $t );
  }

}

sub g_dbus_object_get_interface (GDBusObject $object, Str $interface_name)
  returns GDBusInterface
  is native(gio)
  is export
{ * }

sub g_dbus_object_get_interfaces (GDBusObject $object)
  returns GList
  is native(gio)
  is export
{ * }

sub g_dbus_object_get_object_path (GDBusObject $object)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_object_get_type ()
  returns GType
  is native(gio)
  is export
{ * }
