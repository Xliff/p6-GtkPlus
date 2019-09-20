use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::UnixSocketAddress;

use GIO::SocketAddress;

our subset UnixSocketAddressAncestry is export of Mu
  where GUnixSocketAddress | SocketAddressAncestry;

class GIO::UnixSocketAddress is GIO::SocketAddress {
  has GUnixSocketAddress $!us;

  submethod BUILD (:$unix-socket) {
    given $unix-socket {
      when UnixSocketAddressAncestry {
        self.setUnixSocket($unix-socket);
      }

      when GIO::UnixSocketAddress {
      }

      default {
      }
    }
  }

  method setUnixSocketAddress(UnixSocketAddressAncestry $_) {
    my $to-parent;
    $!us = do {
      when GUnixSocketAddress {
        $to-parent = cast(GSocketAddress, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GUnixSocketAddress, $_);
      }
    }
    self.setSocketAddress($to-parent);
  }

  method GTK::Compat::Types::GUnixSocketAddress
    is also<GUnixSocketAddress>
  { $!us }

  method new (Str() $path) {
    self.bless( unix-socket => g_unix_socket_address_new($path) );
  }

  method new_with_type (
    Str() $path,
    Int() $path_len,
    Int() $type
  ) is also<new-with-type> {
    my gint $pl = $path_len;
    my GUnixSocketAddressType $t = $type;

    self.bless(
      unix-socket => g_unix_socket_address_new_with_type($path, $pl, $t)
    );
  }

  method abstract_names_supported is also<abstract-names-supported> {
    so g_unix_socket_address_abstract_names_supported();
  }

  method get_address_type
    is also<
      get-address-type
      address_type
      address-type
    >
  {
    GUnixSocketAddressTypeEnum( g_unix_socket_address_get_address_type($!us) );
  }

  method get_is_abstract
    is also<
      get-is-abstract
      is_abstract
      is-abstract
    >
  {
    so g_unix_socket_address_get_is_abstract($!us);
  }

  method get_path
    is also<
      get-path
      path
    >
  {
    g_unix_socket_address_get_path($!us);
  }

  method get_path_len
    is also<
      get-path-len
      path_len
      path-len
    >
  {
    g_unix_socket_address_get_path_len($!us);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_unix_socket_address_get_type, $n, $t );
  }

}
