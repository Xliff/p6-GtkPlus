use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::DtlsClientConnection;

use GLib::GList;

use GLib::ByteArray;

use GLib::Roles::ListData;
use GIO::Roles::SocketConnectable;

role GIO::Roles::DtlsClientConnection {
  also does GIO::Roles::SocketConnectable;

  has GDtlsClientConnection $!tdcc;

  submethod BUILD (:$client-connection) {
    $!tdcc = $client-connection;
  }

  method roleInit-DtlsClientConnection
    is also<roleInit_DtlsClientConnection>
  {
    my \i = findProperImplementor(self.^attributes);

    $!tdcc = cast( GDtlsClientConnection, i.get_value(self) );
  }

  method GTK::Compat::Types::GDtlsClientConnection
    is also<GDtlsClientConnection>
  { $!tdcc }

  proto method new-dtlsclientconnection-obj (|)
    is also<new_dtlsclientconnection_obj>
  { * }

  multi method new-dtlsclientconnection-obj (
    GDtlsClientConnection $client-connection
  ) {
    self.bless( :$client-connection );
  }
  multi method new-dtlsclientconnection-obj (
    GDatagramBased() $base,
    GSocketConnectable() $server_identity,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $cc = g_dtls_client_connection_new($base, $server_identity, $error);
    set_error($error);
    self.bless( client-connection => $cc );
  }

  method server_identity (:$raw = False) is rw is also<server-identity> {
    Proxy.new(
      FETCH => sub ($) {
        my $sc = g_dtls_client_connection_get_server_identity($!tdcc);

        $sc ??
          ( $raw ?? $sc !!
                    GIO::SocketConnectable.new-socketconnectable-obj($sc) )
          !!
          Nil;
      },
      STORE => sub ($, GSocketConnectable() $identity is copy) {
        g_dtls_client_connection_set_server_identity($!tdcc, $identity);
      }
    );
  }

  method validation_flags is rw is also<validation-flags> {
    Proxy.new(
      FETCH => sub ($) {
        GTlsCertificateFlagsEnum(
          g_dtls_client_connection_get_validation_flags($!tdcc)
        );
      },
      STORE => sub ($, Int() $flags is copy) {
        my GTlsCertificateFlags $f = $flags;

        g_dtls_client_connection_set_validation_flags($!tdcc, $f);
      }
    );
  }

  method get_accepted_cas (:$glist = False, :$raw = False)
    is also<
      get-accepted-cas
      accepted_cas
      accepted-cas
    >
  {
    my $cal = g_dtls_client_connection_get_accepted_cas($!tdcc);

    return Nil  unless $cal;
    return $cal if     $glist;

    $cal = GLib::GList.new($cal)
      but GLib::Roles::ListData[GByteArray];

    $raw ?? $cal.Array !! $cal.Array.map({ GLib::ByteArray.new($_) });
  }

  method dtlsclientconnection_get_type
    is also<dtlsclientconnection-get-type>
  {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dtls_client_connection_get_type, $n, $t );
  }

}
