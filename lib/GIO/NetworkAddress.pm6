use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::NetworkAddress;

use GTK::Compat::Roles::Object;
use GIO::Roles::SocketConnectable;

class GIO::NetworkAddress {
  also does GTK::Compat::Roles::Object;
  also does GIO::Roles::SocketConnectable;

  has GNetworkAddress $!a;

  submethod BUILD (:$address) {
    $!a = $address;

    self.roleInit-SocketConnectable;
  }

  method GTK::Compat::Types::GNetworkAddress
    is also<GNetworkAddress>
  { $!a }

  multi method new (GNetworkAddress $address, :$ref = True) {
    my $o = self.bless( :$address );
    #$o.ref if $ref
  }
  multi method new (Str() $hostname, Int() $port) {
    my guint16 $p = $port;

    self.bless( address => g_network_address_new($hostname, $p) );
  }

  method new_loopback (Int() $port) is also<new-loopback> {
    my guint16 $p = $port;

    self.bless( address => g_network_address_new_loopback($p) );
  }

  method get_hostname
    is also<
      get-hostname
      hostname
    >
  {
    g_network_address_get_hostname($!a);
  }

  method get_port
    is also<
      get-port
      port
    >
  {
    g_network_address_get_port($!a);
  }

  method get_scheme
    is also<
      get-scheme
      scheme
    >
  {
    g_network_address_get_scheme($!a);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_network_address_get_type, $n, $t );
  }

  method parse (GIO::NetworkAddress:U:
    Str() $host_port,
    Int() $default_port,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    my guint16 $dp = $default_port;

    clear_error;
    my $a = g_network_address_parse($host_port, $dp, $error);
    set_error($error);

    # This is basically an identity construction WITHOUT the need for an
    # uptick in the reference count!
    $a ??
      ( $raw ?? $a !! GIO::NetworkAddress.new($a, :!ref) )
      !!
      Nil;
  }

  method parse_uri (
    GIO::NetworkAddress:U:
    Str() $host_port,
    Int() $default_port,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<parse-uri>
  {
    my guint16 $dp = $default_port;

    clear_error;
    my $a = g_network_address_parse_uri($host_port, $dp, $error);
    set_error($error);

    # This is basically an identity construction WITHOUT the need for an
    # uptick in the reference count!
    $a ??
      ( $raw ?? $a !! GIO::NetworkAddress.new($a, :!ref) )
      !!
      Nil;
  }

}
