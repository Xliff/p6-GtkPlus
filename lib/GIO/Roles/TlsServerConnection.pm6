use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Compat::Value;

role GIO::Roles::TlsServerConnection {
  has GTlsServerConnection $!tsc;

  submethod BUILD (:$server-connection) {
    $!tsc = $server-connection;
  }

  method roleInit-TlsServerConnection is also<roleInit_TlsServerConnection> {
    my \i = findProperImplementor(self.^attributes);

    $!tsc = cast( GTlsServerConnection, i.get_value(self) );
  }

  method GTK::Compat::Types::GTlsServerConnection
    is also<GTlsServerConnection>
  { $!tsc }

  proto method new-tlsserverconnection-obj (|)
      is also<new_tlsserverconnection_obj>
  { * }

  multi method new-tlsserverconnection-obj (
    GTlsServerConnection $server-connection
  ) {
    self.bless( :$server-connection )
  }
  multi method new-tlsserverconnection-obj (
    GIOStream() $base,
    GTlsCertificate() $certificate,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $server-connection = g_tls_server_connection_new(
      $base,
      $certificate,
      $error
    );
    set_error($error);
    self.bless( :$server-connection );
  }

  # Type: GTlsAuthenticationMode
  method authentication-mode is rw  is also<authentication_mode> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('authentication-mode', $gv)
        );
        GTlsAuthenticationModeEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('authentication-mode', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_server_connection_get_type, $n, $t );
  }

}

sub g_tls_server_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_tls_server_connection_new (
  GIOStream $base_io_stream,
  GTlsCertificate $certificate,
  CArray[Pointer[GError]] $error
)
  returns GIOStream
  is native(gio)
  is export
{ * }
