use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;

use GLib::Roles::Object;
use GIO::DBus::Roles::Signals::AuthObserver;

class GIO::DBus::AuthObserver {
  also does GLib::Roles::Object;
  also does GIO::DBus::Roles::Signals::AuthObserver;

  has GDBusAuthObserver $!dao is implementor;

  submethod BUILD (:$observer) {
    $!dao = $observer;

    self.roleInit-Object;
  }

  method GLib::Raw::Types::GDbusAuthObserver
    is also<GDBusAuthObserver>
  { $!dao }

  multi method new (GDBusAuthObserver $observer) {
    self.bless( :$observer );
  }
  multi method new {
    my $o = g_dbus_auth_observer_new();

    $o ?? self.bless( observer => $o ) !! Nil;
  }

  # Is originally:
  # GDBusAuthObserver, gchar, gpointer --> gboolean
  method allow-mechanism is also<allow_mechanism> {
    self.connect-allow-mechanism($!dao);
  }

  # Is originally:
  # GDBusAuthObserver, GIOStream, GCredentials, gpointer --> gboolean
  method authorize-authenticated-peer is also<authorize_authenticated_peer> {
    self.connect-authorize-authenticated-peer($!dao);
  }

  method emit_allow_mechanism (Str() $mechanism) is also<emit-allow-mechanism> {
    g_dbus_auth_observer_allow_mechanism($!dao, $mechanism);
  }

  method emit_authorize_authenticated_peer (
    GIOStream() $stream,
    GCredentials() $credentials
  )
    is also<emit-authorize-authenticated-peer>
  {
    g_dbus_auth_observer_authorize_authenticated_peer($!dao, $stream, $credentials);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_auth_observer_get_type, $n, $t );
  }

}

sub g_dbus_auth_observer_allow_mechanism (GDBusAuthObserver $observer, Str $mechanism)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_auth_observer_authorize_authenticated_peer (
  GDBusAuthObserver $observer,
  GIOStream $stream,
  GCredentials $credentials
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_auth_observer_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_auth_observer_new ()
  returns GDBusAuthObserver
  is native(gio)
  is export
{ * }
