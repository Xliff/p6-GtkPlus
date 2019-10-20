use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;
use GIO::DBus::Raw::Types;

use GIO::DBus::Raw::Server;

# use GIO::DBus::AuthObserver

use GTK::Roles::Properties;
use GIO::DBus::Roles::Signals::Server;

class GIO::DBus::Server {
  also does GTK::Roles::Properties;
  also does GIO::DBus::Roles::Signals::Server;

  has GDBusServer $!ds;

  submethod BUILD (:$server) {
    $!ds = $server;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GDBusServer
    is also<GDBusServer>
  { $!ds }

  method new_sync (
    Str() $address,
    Int() $flags,
    Str() $guid,
    GDBusAuthObserver() $observer,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-sync>
  {
    my GDBusServerFlags $f = $flags;

    clear_error;
    my $s = g_dbus_server_new_sync(
      $address,
      $f,
      $guid,
      $observer,
      $cancellable,
      $error
    );
    set_error($error);

    $s ?? self.bless( server => $s ) !! Nil;
  }

  # Type: gchar
  method address is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('address', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'GIO::DBus::Server.address is read/only.';
      }
    );
  }

  # Type: GDBusAuthObserver
  method authentication-observer (:$raw = False) is rw is also<authentication_observer> {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('authentication-observer', $gv)
        );
        return Nil unless $gv.object;

        my $ao = cast(GDBusAuthObserver, $gv.object);
        $raw ?? $ao !! GIO::DBus::AuthObserver.new($ao);
      },
      STORE => -> $, GDBusAuthObserver() $val is copy {
        warn 'GIO::DBus::Server.authentication-observer is read/only.';
      }
    );
  }

  # Is originally:
  # GDBusServer, GDBusConnection, gpointer --> gboolean
  method new-connection is also<new_connection> {
    self.connect-new-connection($!ds);
  }

  method get_client_address
    is also<
      get-client-address
      client_address
      client-address
    >
  {
    g_dbus_server_get_client_address($!ds);
  }

  method get_flags
    is also<
      get-flags
      flags
    >
  {
    g_dbus_server_get_flags($!ds);
  }

  method get_guid
    is also<
      get-guid
      guid
    >
  {
    g_dbus_server_get_guid($!ds);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_server_get_type, $n, $t );
  }

  method is_active
    is also<
      is-active
      active
    >
  {
    so g_dbus_server_is_active($!ds);
  }

  method start {
    g_dbus_server_start($!ds);
  }

  method stop {
    g_dbus_server_stop($!ds);
  }

}
