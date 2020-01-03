use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::InterfaceSkeleton;

use GLib::Variant;
use GLib::GList;

use GLib::Roles::Object;
use GLib::Roles::ListData;

use GIO::DBus::Roles::Signals::InterfaceSkeleton;

class GIO::DBus::InterfaceSkeleton {
  also does GLib::Roles::Object;
  also does GIO::DBus::Roles::Signals::InterfaceSkeleton;

  has GDBusInterfaceSkeleton $!dis is implementor;

  submethod BUILD (:$skeleton) {
    $!dis = $skeleton;

    self.roleInit-Object;
  }

  method GLib::Raw::Types::GDBusInterfaceSkeleton
    is also<GDBusInterfaceSkeleton>
  { $!dis }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        GDBusInterfaceSkeletonFlagsEnum(
          g_dbus_interface_skeleton_get_flags($!dis)
        );
      },
      STORE => sub ($, Int() $flags is copy) {
        my GDBusInterfaceSkeletonFlags $f = $flags;

        g_dbus_interface_skeleton_set_flags($!dis, $f);
      }
    );
  }

  # Is originally:
  # GDBusInterfaceSkeleton, GDBusMethodInvocation, gpointer --> gboolean
  method g-authorize-method {
    self.connect-g-authorize-method($!dis);
  }

  method export (
    GDBusConnection() $connection,
    Str() $object_path,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so g_dbus_interface_skeleton_export(
      $!dis,
      $connection,
      $object_path,
      $error
    );
    set_error($error);
    $rv;
  }

  method flush {
    g_dbus_interface_skeleton_flush($!dis);
  }

  method get_connection (:$raw = False)
    is also<
      get-connection
      connection
    >
  {
    my $c = g_dbus_interface_skeleton_get_connection($!dis);

    $c ??
      ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
      !!
      Nil;
  }

  method get_connections (:$glist = False, :$raw = False)
    is also<
      get-connections
      connections
    >
  {
    my $cl = g_dbus_interface_skeleton_get_connections($!dis);

    return Nil unless $cl;
    return $cl if     $glist;

    $cl = GLib::GList.new($cl)
      but GLib::Roles::ListData[GDBusConnection];
    $raw ?? $cl.Array !! $cl.Array.map({ GIO::DBus::Connection.new($_) });
  }

  method get_info
    is also<
      get-info
      info
    >
  {
    g_dbus_interface_skeleton_get_info($!dis);
  }

  method get_object_path is also<get-object-path> {
    g_dbus_interface_skeleton_get_object_path($!dis);
  }

  method get_properties (:$raw = False)
    is also<
      get-properties
      properties
    >
  {
    my $v = g_dbus_interface_skeleton_get_properties($!dis);

    $v ??
      ( $raw ?? $v !! GLib::Variant.new($v, :!ref) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_dbus_interface_skeleton_get_type,
      $n,
      $t
    );
  }

  method get_vtable
    is also<
      get-vtable
      vtable
    >
  {
    g_dbus_interface_skeleton_get_vtable($!dis);
  }

  method has_connection (GDBusConnection() $connection) is also<has-connection> {
    so g_dbus_interface_skeleton_has_connection($!dis, $connection);
  }

  method unexport {
    g_dbus_interface_skeleton_unexport($!dis);
  }

  method unexport_from_connection (GDBusConnection() $connection)
    is also<unexport-from-connection>
  {
    g_dbus_interface_skeleton_unexport_from_connection($!dis, $connection);
  }

}
