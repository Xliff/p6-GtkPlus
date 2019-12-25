use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GLib::Value;

role GIO::Roles::DtlsServerConnection {
  has GDtlsServerConnection $!dtsc;

  submethod BUILD (:$server-connection) {
    $!dtsc = $server-connection;
  }

  method roleInit-DtlsServerConnection is also<roleInit_DtlsServerConnection> {
    my \i = findProperImplementor(self.^attributes);

    $!dtsc = cast( GDtlsServerConnection, i.get_value(self) );
  }

  method GTK::Compat::Types::GDtlsServerConnection
    is also<GDtlsServerConnection>
  { $!dtsc }

  proto method new-dtlsserverconnection-obj (|)
      is also<new_Dtlsserverconnection_obj>
  { * }

  multi method new-dtlsserverconnection-obj (
    GDtlsServerConnection $server-connection
  ) {
    self.bless( :$server-connection )
  }
  multi method new-dtlsserverconnection-obj (
    GDatagramBased() $base,
    GTlsCertificate() $certificate,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $server-connection = g_dtls_server_connection_new(
      $base,
      $certificate,
      $error
    );
    set_error($error);
    self.bless( :$server-connection );
  }

  # Type: GDtlsAuthenticationMode
  method authentication-mode is rw  is also<authentication_mode> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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

    unstable_get_type( self.^name, &g_dtls_server_connection_get_type, $n, $t );
  }

}

sub g_dtls_server_connection_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dtls_server_connection_new (
  GIOStream $base_io_stream,
  GTlsCertificate $certificate,
  CArray[Pointer[GError]] $error
)
  returns GDtlsServerConnection
  is native(gio)
  is export
{ * }
