use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::TlsClientConnection;

use GLib::GList;

use GLib::ByteArray;

use GLib::Roles::ListData;
use GIO::Roles::SocketConnectable;

role GIO::Roles::TlsClientConnection {
  also does GIO::Roles::SocketConnectable;

  has GTlsClientConnection $!tcc;

  submethod BUILD (:$client-connection) {
    $!tcc = $client-connection;
  }

  method roleInit-TlsClientConnection
    is also<roleInit_TlsClientConnection>
  {
    my \i = findProperImplementor(self.^attributes);

    $!tcc = cast( GTlsClientConnection, i.get_value(self) );
  }

  method GLib::Raw::Types::GTlsClientConnection
    is also<GTlsClientConnection>
  { $!tcc }

  proto method new-tlsclientconnection-obj (|)
    is also<new_tlsclientconnection_obj>
  { * }

  multi method new-tlsclientconnection-obj (
    GTlsClientConnection $client-connection
  ) {
    self.bless( :$client-connection );
  }
  multi method new-tlsclientconnection-obj (
    GIOStream() $base,
    GSocketConnectable() $server_identity,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $cc = g_tls_client_connection_new($base, $server_identity, $error);
    set_error($error);
    self.bless( client-connection => $cc );
  }

  method server_identity (:$raw = False) is rw is also<server-identity> {
    Proxy.new(
      FETCH => sub ($) {
        my $sc = g_tls_client_connection_get_server_identity($!tcc);

        $sc ??
          ( $raw ?? $sc !!
                    GIO::SocketConnectable.new-socketconnectable-obj($sc) )
          !!
          Nil;
      },
      STORE => sub ($, GSocketConnectable() $identity is copy) {
        g_tls_client_connection_set_server_identity($!tcc, $identity);
      }
    );
  }

  method use_ssl3 is rw is also<use-ssl3> {
    Proxy.new(
      FETCH => sub ($) {
        so g_tls_client_connection_get_use_ssl3($!tcc);
      },
      STORE => sub ($, Int() $use_ssl3 is copy) {
        my gboolean $u = $use_ssl3;

        g_tls_client_connection_set_use_ssl3($!tcc, $u);
      }
    );
  }

  method validation_flags is rw is also<validation-flags> {
    Proxy.new(
      FETCH => sub ($) {
        GTlsCertificateFlagsEnum(
          g_tls_client_connection_get_validation_flags($!tcc)
        );
      },
      STORE => sub ($, Int() $flags is copy) {
        my GTlsCertificateFlags $f = $flags;

        g_tls_client_connection_set_validation_flags($!tcc, $f);
      }
    );
  }

  method copy_session_state (GTlsClientConnection() $source)
    is also<copy-session-state>
  {
    g_tls_client_connection_copy_session_state($!tcc, $source);
  }

  method get_accepted_cas (:$glist = False, :$raw = False)
    is also<
      get-accepted-cas
      accepted_cas
      accepted-cas
    >
  {
    my $cal = g_tls_client_connection_get_accepted_cas($!tcc);

    return Nil  unless $cal;
    return $cal if     $glist;

    $cal = GLib::GList.new($cal)
      but GLib::Roles::ListData[GByteArray];

    $raw ?? $cal.Array !! $cal.Array.map({ GLib::ByteArray.new($_) });
  }

  method tlsclientconnection_get_type  is also<tlsclientconnection-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_client_connection_get_type, $n, $t );
  }

}
