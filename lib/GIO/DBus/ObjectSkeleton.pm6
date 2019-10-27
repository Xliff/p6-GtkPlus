use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::ObjectSkeleton;

use GTK::Roles::Properties;

class GIO::DBus::ObjectSkeleton {
  also does GTK::Roles::Properties;

  has GDBusObjectSkeleton $!dos;

  submethod BUILD (:$skeleton) {
    $!dos = $skeleton;

    self.roleInit-Object;
  }

  method GTK::Compat::TYpes::GDBusObjectSkeleton
  { * }

  method new (Str() $object_path) {
    my $s = g_dbus_object_skeleton_new($object_path);

    $s ?? self.bless( skeleton => $s ) !! Nil;
  }

  # Type: gchar
  method g-object-path is rw
    is also<
      g_object_path
      object_path
      object-path
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

  # Is originally:
  # GDBusObjectSkeleton, GDBusInterfaceSkeleton, GDBusMethodInvocation, gpointer --> gboolean
  method authorize-method is also<authorize_method> {
    self.connect-authorize-method($!dos);
  }

  method add_interface (GDBusInterfaceSkeleton() $interface)
    is also<add-interface>
  {
    g_dbus_object_skeleton_add_interface($!dos, $interface);
  }

  method flush {
    g_dbus_object_skeleton_flush($!dos);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_object_skeleton_get_type, $n, $t );
  }

  method remove_interface (GDBusInterfaceSkeleton() $interface)
    is also<remove-interface>
  {
    g_dbus_object_skeleton_remove_interface($!dos, $interface);
  }

  method remove_interface_by_name (Str() $interfacename)
    is also<remove-interface-by-name>
  {
    g_dbus_object_skeleton_remove_interface_by_name($!dos, $interfacename);
  }

  method set_object_path (Str() $object_path) is also<set-object-path> {
    g_dbus_object_skeleton_set_object_path($!dos, $object_path);
  }

}
