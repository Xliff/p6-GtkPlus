use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GIO::SocketAddressEnumerator;

role GIO::Roles::SocketConnectable {
  has GSocketConnectable $!sc;

  submethod BUILD (:$connectable) {
    $!sc = $connectable;
  }

  method GTK::Compat::Types::GSocketConnectable
    is also<GSocketConnectable>
  { $!sc }

  method roleInit-SocketConnectable (GSocketConnectable :$role) {
    $!sc = $role ??
      $role !! cast(GSocketConnectable, self.GObject);
  }

  method new-role-obj (GSocketConnectable $connectable) {
    self.bless( :$connectable );
  }

  method enumerate (:$raw = False) {
    my $se = g_socket_connectable_enumerate($!sc);

    $raw ?? $se !! GIO::GSocketAddressEnumerator.new($se);
  }

  method socketconnectable_get_type is also<socketconnectable-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_connectable_get_type, $n, $t );
  }

  method proxy_enumerate (:$raw = False) is also<proxy-enumerate> {
    my $se = g_socket_connectable_proxy_enumerate($!sc);

    $raw ?? $se !! GIO::GSocketAddressEnumerator.new($se);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    g_socket_connectable_to_string($!sc);
  }

}

sub g_socket_connectable_enumerate (GSocketConnectable $connectable)
  returns GSocketAddressEnumerator
  is native(gio)
  is export
{ * }

sub g_socket_connectable_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_connectable_proxy_enumerate (GSocketConnectable $connectable)
  returns GSocketAddressEnumerator
  is native(gio)
  is export
{ * }

sub g_socket_connectable_to_string (GSocketConnectable $connectable)
  returns Str
  is native(gio)
  is export
{ * }
