use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;
use GIO::Raw::SimpleProxyResolver;

use GTK::Raw::Utils;

use GLib::Value;

use GTK::Roles::Properties;
use GIO::Roles::ProxyResolver;

class GIO::SimpleProxyResolver {
  also does GTK::Roles::Properties;

  has GSimpleProxyResolver $!spr is implementor;

  submethod BUILD (:$simple-resolver) {
    $!spr = $simple-resolver;

    self.roleInit-ProxyResolver;
  }

  method GLib::Raw::Types::GSimpleProxyResolver
    is also<GSimpleProxyResolver>
  { $!spr }

  multi method new (GSimpleProxyResolver $simple-resolver) {
    self.bless( :$simple-resolver );
  }
  multi method new (Str() $default_proxy, @ignore_hosts) {
    samewith( $default_proxy, resolve-gstrv(@ignore_hosts) );
  }
  multi method new (Str() $default_proxy, CArray[Str] $ignore_hosts) {
    g_simple_proxy_resolver_new($default_proxy, $ignore_hosts);
  }

  # Type: gchar
  method default-proxy is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('default-proxy', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('default-proxy', $gv);
      }
    );
  }

  # Type: GStrv
  method ignore-hosts is rw  {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('ignore-hosts', $gv)
        );

        CStringArrayToArray( cast(CArray[Str], $gv.pointer) );
      },
      STORE => -> $, @val is copy {
        $gv.pointer = resolve-gstrv(@val);
        self.prop_set('ignore-hosts', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_simple_proxy_resolver_get_type, $n, $t );
  }

  method set_default_proxy (Str() $default_proxy) is also<set-default-proxy> {
    g_simple_proxy_resolver_set_default_proxy($!spr, $default_proxy);
  }

  proto method set_ignore_hosts (|)
    is also<set-ignore-hosts>
  { * }

  multi method set_ignore_hosts (@ignore_hosts) {
    samewith( resolve-gstrv(@ignore_hosts) );
  }
  multi method set_ignore_hosts (CArray[Str] $ignore_hosts) {
    g_simple_proxy_resolver_set_ignore_hosts($!spr, $ignore_hosts);
  }

  method set_uri_proxy (Str() $uri_scheme, Str() $proxy)
    is also<set-uri-proxy>
  {
    g_simple_proxy_resolver_set_uri_proxy($!spr, $uri_scheme, $proxy);
  }

}
