use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::Value;

use GTK::Roles::Properties;

use GIO::Roles::ProxyResolver;
use GIO::Roles::SocketConnectable;

class GIO::ProxyAddressEnumerator {
  also does GTK::Roles::Properties;

  has GProxyAddressEnumerator $!pae is implementor;

  submethod BUILD (:$proxy-enumerator) {
    $!pae = $proxy-enumerator;

    self.roleInit-Properties;
  }

  method GTK::Compat::Types::GProxyAddressEnumerator
    is also<GProxyAddressEnumerator>
  { $!pae }

  method new (GProxyAddressEnumerator $proxy-enumerator) {
    self.bless( :$proxy-enumerator );
  }

  # Type: GSocketConnectable
  method connectable (:$raw = False) is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('connectable', $gv)
        );

        my $o = $gv.object;

        $o ??
          ( $raw ??
            $o !!
            GIO::Roles::SocketConnectable.new-socketconnectable-obj($o)
          )
          !!
          Nil;
      },
      STORE => -> $, GSocketConnectable() $val is copy {
        $gv.object = $val;
        self.prop_set('connectable', $gv);
      }
    );
  }

  # Type: guint
  method default-port is rw  is also<default_port> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('default-port', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('default-port', $gv);
      }
    );
  }

  # Type: GProxyResolver
  method proxy-resolver (:$raw = False) is rw is also<proxy_resolver> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('proxy-resolver', $gv)
        );

        my $o = cast(GProxyResolver, $gv.object);

        $o ??
          ( $raw ??
            $o !!
            GIO::Roles::ProxyResolver.new-proxyresolver-obj($o)
          )
          !!
          Nil;
      },
      STORE => -> $, GProxyResolver() $val is copy {
        $gv.TYPE = $val;
        self.prop_set('proxy-resolver', $gv);
      }
    );
  }

  # Type: gchar
  method uri is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('uri', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('uri', $gv);
      }
    );
  }

}
