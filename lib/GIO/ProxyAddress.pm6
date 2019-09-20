use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::ProxyAddress;

use GIO::InetSocketAddress;

our subset ProxyAddressAncestry is export of Mu
  where GProxyAddress | InetSocketAddressAncestry;

class GIO::ProxyAddress is GIO::InetSocketAddress {
  has GProxyAddress $!pa;

  submethod BUILD (:$proxy-address) {
    given $proxy-address {
      when ProxyAddressAncestry {
        self.setProxyAddress($proxy-address);
      }

      when GIO::ProxyAddress {
      }

      default {
      }
    }
  }

  method setProxyAddress(ProxyAddressAncestry $_) {
    my $to-parent;

    $!pa = do {
      when GProxyAddress {
        $to-parent = cast(GInetSocketAddress, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GProxyAddress, $_);
      }
    }
    self.setInetSocketAddr($to-parent);
  }

  method GTK::Compat::Types::GProxyAddress
  { $!pa }

  method new (
    GInetAddress() $inetaddr,
    Int() $port,
    Str() $protocol,
    Str() $dest_hostname,
    Int() $dest_port,
    Str() $username,
    Str() $password
  ) {
    my guint16 ($p, $dp) = ($port, $dest_port);

    self.bless(
      proxy-address => g_proxy_address_new(
        $inetaddr,
        $p,
        $protocol,
        $dest_hostname,
        $dp,
        $username,
        $password
      )
    );
  }

  method get_destination_hostname
    is also<
      get-destination-hostname
      destination_hostname
      destination-hostname
      dest_host
      dest-host
    >
  {
    g_proxy_address_get_destination_hostname($!pa);
  }

  method get_destination_port
    is also<
      get-destination-port
      destination_port
      destination-port
      dest_port
      dest-port
    >
  {
    g_proxy_address_get_destination_port($!pa);
  }

  method get_destination_protocol
    is also<
      get-destination-protocol
      destination_protocol
      destination-protocol
      dest_proto
      dest-proto
    >
  {
    g_proxy_address_get_destination_protocol($!pa);
  }

  method get_password
    is also<
      get-password
      password
      pass
    >
  {
    g_proxy_address_get_password($!pa);
  }

  method get_protocol
    is also<
      get-protocol
      protocol
      proto
    >
  {
    g_proxy_address_get_protocol($!pa);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_proxy_address_get_type, $n, $t );
  }

  method get_uri
    is also<
      get-uri
      uri
    >
  {
    g_proxy_address_get_uri($!pa);
  }

  method get_username
    is also<
      get-username
      username
      user
    >
  {
    g_proxy_address_get_username($!pa);
  }

}
