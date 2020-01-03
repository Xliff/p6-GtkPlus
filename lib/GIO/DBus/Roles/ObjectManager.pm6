use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::ObjectManager;

role GIO::DBus::Roles::ObjectManager {
  has GDBusObjectManager $!dom;

  method roleInit-ObjectManager is also<roleInit_ObjectManager> {
    my \i = findProperImplementor(self.^attributes);

    $!dom = cast( GDBusObjectManager, i.get_value(self) );
  }

  method GLib::Raw::Types::GDBusObjectManager
    is also<GDBusObjectManager>
  { $!dom }

  # Is originally:
  # GDBusObjectManager, GDBusObject, GDBusInterface, gpointer --> void
  method interface-added is also<interface_added> {
    self.connect-interface($!dom, 'interface-added');
  }

  # Is originally:
  # GDBusObjectManager, GDBusObject, GDBusInterface, gpointer --> void
  method interface-removed is also<interface_removed> {
    self.connect-interface($!dom, 'interface-removed');
  }

  # Is originally:
  # GDBusObjectManager, GDBusObject, gpointer --> void
  method object-added is also<object_added> {
    self.connect-object($!dom, 'object-added');
  }

  # Is originally:
  # GDBusObjectManager, GDBusObject, gpointer --> void
  method object-removed is also<object_removed> {
    self.connect-object($!dom, 'object-removed');
  }

  method get_interface (
    Str() $object_path,
    Str() $interface_name,
    :$raw = False
  )
    is also<get-interface>
  {
    my $i = g_dbus_object_manager_get_interface(
      $!dom,
      $object_path,
      $interface_name
    );

    $i ??
      ( $raw ?? $i !! GIO::DBus::Roles::Interface.new-interface-obj($i) )
      !!
      Nil;
  }

  method get_object (Str() $object_path, :$raw = False) is also<get-object> {
    my $o = g_dbus_object_manager_get_object($!dom, $object_path);

    $o ??
      ( $raw ?? $o !! GIO::DBus::Roles::Object.new-dbusobject-obj($o) )
      !!
      Nil;
  }

  method get_object_path
    is also<
      get-object-path
      object_path
      object-path
    >
  {
    g_dbus_object_manager_get_object_path($!dom);
  }

  method get_objects (:$glist = False, :$raw = False)
    is also<
      get-objects
      objects
    >
  {
    my $ol = g_dbus_object_manager_get_objects($!dom);

    return Nil unless $ol;
    return $ol if     $glist;

    $ol = GLib::GList.new($ol)
      but GTK::Compat::Raw::ListData[GDBusObject];

    $raw ??
      $ol.Array
      !!
      $ol.Array.map({ GIO::DBus::Roles::Object.new-dbusobject-obj($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_object_manager_get_type, $n, $t );
  }

}
