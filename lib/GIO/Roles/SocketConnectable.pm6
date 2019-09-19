use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

role GIO::Roles::SocketConnectable {
  has GSocketConnectable $!sc;

  method GTK::Compat::Types::GSocketConnectable
    is also<GSocketConnectable>
  { $!sc }

  method roleInit-SockedConnectable {
    cast(GSocketConnectable, self.GObject);
  }

  method enumerate {
    g_socket_connectable_enumerate($!sc);
  }

  method socketconnectable_get_type is also<socketconnectable-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_connectable_get_type, $n, $t );
  }

  method proxy_enumerate is also<proxy-enumerate> {
    g_socket_connectable_proxy_enumerate($!sc);
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
