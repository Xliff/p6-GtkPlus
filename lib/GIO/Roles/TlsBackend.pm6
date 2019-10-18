use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GIO::Raw::TlsBackend;

use GIO::TlsDatabase;

role GIO::Roles::TlsBackend {
  has GTlsBackend $!tb;

  submethod BUILD (:$backend) {
    $!tb = $backend;
  }

  method roleInit-TlsBackend is also<roleInit_TlsBackend> {
    $!tb = cast(
      GTlsBackend,
      self.^attributes(:local)[0].get_value(self)
    );
  }

  method GTK::Compat::Types::GTlsBackend
    is also<GTlsBackend>
  { $!tb }

  method new-tlsbackend-obj (GTlsBackend $backend)
    is also<new_tlsbackend_obj>
  {
    self.bless( :$backend );
  }

  method get_default (
    GIO::Roles::TlsBackend:U:
    :$raw = False;
  )
    is also<get-default>
  {
    my $backend = g_tls_backend_get_default($!tb);

    $backend ??
      ( $raw ?? $backend !! self.bless( :$backend ) )
      !!
      Nil;
  }

  method default_database (:$raw = False) is rw is also<default-database> {
    Proxy.new(
      FETCH => sub ($) {
        my $d = g_tls_backend_get_default_database($!tb);

        $d ??
          ( $raw ?? $d !! GIO::TlsDatabase.new($d) )
          !!
          Nil;
      },
      STORE => sub ($, GTlsDatabase() $database is copy) {
        g_tls_backend_set_default_database($!tb, $database);
      }
    );
  }

  # I would hope that these do NOT need unstable_get_type ↓↓↓
  method get_certificate_type is also<get-certificate-type> {
    g_tls_backend_get_certificate_type($!tb);
  }

  method get_client_connection_type is also<get-client-connection-type> {
    g_tls_backend_get_client_connection_type($!tb);
  }

  method get_dtls_client_connection_type
    is also<get-dtls-client-connection-type>
  {
    g_tls_backend_get_dtls_client_connection_type($!tb);
  }

  method get_dtls_server_connection_type
    is also<get-dtls-server-connection-type>
  {
    g_tls_backend_get_dtls_server_connection_type($!tb);
  }

  method get_file_database_type is also<get-file-database-type> {
    g_tls_backend_get_file_database_type($!tb);
  }

  method get_server_connection_type is also<get-server-connection-type> {
    g_tls_backend_get_server_connection_type($!tb);
  }
  # I would hope that these do NOT need unstable_get_type ↑↑↑

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_backend_get_type, $n, $t );
  }

  method supports_dtls is also<supports-dtls> {
    so g_tls_backend_supports_dtls($!tb);
  }

  method supports_tls is also<supports-tls> {
    so g_tls_backend_supports_tls($!tb);
  }

}
