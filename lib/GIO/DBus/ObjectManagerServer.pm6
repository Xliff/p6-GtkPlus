use v6.c;

use GLib::Raw::Types;

use GIO::DBus::Raw::ObjectManagerServer;

use GIO::DBus::Connection;

use GLib::Roles::Object;

class GIO::DBus::ObjectManagerServer {
  also does GLib::Roles::Object;

  has GDBusObjectManagerServer $!doms is implementor;

  submethod BUILD (:$server) {
    $!doms = $server;

    self.roleInit-Object;
  }

  method GLib::Raw::Types::GDBusObjectManagerServer
  { $!doms }

  multi method new (GDBusObjectManagerServer $server) {
    self.bless( :$server );
  }
  multi method new (Str() $object_path) {
    my $s = g_dbus_object_manager_server_new($object_path);

    $s ?? self.bless( server => $s ) !! Nil;
  }

  method connection (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $c = g_dbus_object_manager_server_get_connection($!doms);

        $c ??
          ( $raw ?? $c !! GIO::DBus::Connection.new($c) )
          !!
          Nil;
      },
      STORE => sub ($, GDBusConnection() $connection is copy) {
        g_dbus_object_manager_server_set_connection($!doms, $connection);
      }
    );
  }

  method export (GDBusObjectSkeleton() $object) {
    g_dbus_object_manager_server_export($!doms, $object);
  }

  method export_uniquely (GDBusObjectSkeleton() $object) {
    g_dbus_object_manager_server_export_uniquely($!doms, $object);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_dbus_object_manager_server_get_type,
      $n,
      $t
    );
  }

  method is_exported (GDBusObjectSkeleton() $object) {
    so g_dbus_object_manager_server_is_exported($!doms, $object);
  }

  method unexport (Str() $object_path) {
    so g_dbus_object_manager_server_unexport($!doms, $object_path);
  }

}
