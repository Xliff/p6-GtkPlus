use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::InetSocketAddress;

use GIO::InetAddress;
use GIO::SocketAddress;

our subset InetSocketAddressAncestry is export
  where GInetSocketAddress | SocketAddressAncestry;

class GIO::InetSocketAddress is GIO::SocketAddress {
  has GInetSocketAddress $!isa is implementor;

  submethod BUILD (:$inetsocketaddr) {
    self.setInetSocketAddr($inetsocketaddr);
  }

  method setInetSocketAddr(InetSocketAddressAncestry $_) {
    my $to-parent;
    $!isa = do {
      when GInetSocketAddress {
        $to-parent = cast(GSocketAddress, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GInetSocketAddress, $_);
      }
    };
    self.setSocketAddress($to-parent);
  }

  method GTK::Compat::Types::GInetSocketAddress
    is also<GInetSocketAddress>
  { $!isa }

  multi method new (InetSocketAddressAncestry $inetsocketaddr) {
    self.bless( :$inetsocketaddr );
  }
  multi method new (
    GInetAddress() $address,
    Int() $port,
    Int() $flowinfo = 0,
    Int() $scope_id = 0
  ) {
    my guint16 ($p, $f, $s) = ($port, $flowinfo, $scope_id);

    my $a = $flowinfo || $scope_id ??
      g_object_new_inet_socket_address(
        self.get-type,
        'address',  $address,
        'port',     $p,
        'flowinfo', $f,
        'scope-id', $s,
        Str
      )
      !!
      g_inet_socket_address_new($address, $p);

    self.bless( inetsocketaddr =>  $a);
  }

  method new_from_string (Str() $addr, Int() $port) is also<new-from-string> {
    my guint $p = $port;

    self.bless(
      inetaddr => g_inet_socket_address_new_from_string($addr, $port)
    );
  }

  method get_address (:$raw = False)
    is also<
      get-address
      address
    >
  {
    my $a = g_inet_socket_address_get_address($!isa);

    $a ??
      ( $raw ?? $a !! GIO::InetAddress.new($a) )
      !!
      Nil;
  }

  method get_flowinfo
    is also<
      get-flowinfo
      flowinfo
    >
  {
    g_inet_socket_address_get_flowinfo($!isa);
  }

  method get_port
    is also<
      get-port
      port
    >
  {
    g_inet_socket_address_get_port($!isa);
  }

  method get_scope_id
    is also<
      get-scope-id
      scope_id
      scope-id
    >
  {
    g_inet_socket_address_get_scope_id($!isa);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_inet_socket_address_get_type, $n, $t );
  }

}
