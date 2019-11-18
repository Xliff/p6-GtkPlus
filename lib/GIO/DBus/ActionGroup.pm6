use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Compat::Roles::Object;
# Only need this role, since it includes ActionGroup
use GIO::Roles::RemoteActionGroup;

our subset DBusActionGroupAncestry is export of Mu
  where GDBusActionGroup | GRemoteActionGroup | GActionGroup | GObject;

class GIO::DBus::ActionGroup {
  also does GIO::Roles::RemoteActionGroup;

  has GDBusActionGroup $!dag is implementor;

  submethod BUILD (:$dbus-action-group) {
    given $dbus-action-group {
      when DBusActionGroupAncestry {
        self.setDBusActionGroup($_);
      }

      when GIO::DBus::ActionGroup {
      }

      default {
      }
    }
  }

  method setDBusActionGroup (DBusActionGroupAncestry $dag) {
    my $to-parent;

    $!dag = do given $dag {
      when GDBusActionGroup    { $_ }
      when GRemoteActionGroup  { $!rag = $_; proceed }
      when GActionGroup        { $!ag  = $_; proceed }

      when GRemoteActionGroup | GActionGroup | GObject {
        cast(GDBusActionGroup, $_)
      }
    }

    self.roleInit-Object;
    self.roleInit-ActionGroup       unless $!ag;
    self.roleInit-RemoteActionGroup unless $!dag;
  }

  multi method new (GDBusActionGroup $dbus-action-group) {
    self.bless( :$dbus-action-group );
  }
  multi method new (
    GDBusConnection() $conn,
    Str() $bus_name,
    Str() $object_path
  ) {
    self.get($bus_name, $object_path);
  }

  method get (GDBusConnection() $conn, Str() $bus_name, Str() $object_path) {
    my $dag = g_dbus_action_group_get($conn, $bus_name, $object_path);

    $dag ?? self.bless( dbus-action-group => $dag ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_action_group_get_type, $n, $t );
  }

}



### /usr/include/glib-2.0/gio/gdbusactiongroup.h

sub g_dbus_action_group_get (
  GDBusConnection $connection,
  Str $bus_name,
  Str $object_path
)
  returns GDBusActionGroup
  is native(gio)
  is export
{ * }

sub g_dbus_action_group_get_type ()
  returns GType
  is native(gio)
  is export
{ * }
