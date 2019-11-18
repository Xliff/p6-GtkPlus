use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::NetworkService;

use GTK::Compat::Roles::Object;
use GIO::Roles::SocketConnectable;

class GIO::NetworkService {
  also does GTK::Compat::Roles::Object;
  also does GIO::Roles::SocketConnectable;

  has GNetworkService $!s is implementor;

  submethod BUILD (:$service) {
    $!s = $service;

    self.roleInit-SocketConnectable;
  }

  method GTK::Compat::Types::GNetworkService
  { $!s }

  method new (Str() $service, Str() $protocol, Str() $domain) {
    self.bless(
      service => g_network_service_new($service, $protocol, $domain)
    );
  }

  method scheme is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_network_service_get_scheme($!s);
      },
      STORE => sub ($, Str() $scheme is copy) {
        g_network_service_set_scheme($!s, $scheme);
      }
    );
  }

  method get_domain
    is also<
      get-domain
      domain
    >
  {
    g_network_service_get_domain($!s);
  }

  method get_protocol
    is also<
      get-protocol
      protocol
    >
  {
    g_network_service_get_protocol($!s);
  }

  method get_service
    is also<
      get-service
      service
    >
  {
    g_network_service_get_service($!s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_network_service_get_type(), $n, $t );
  }

}
