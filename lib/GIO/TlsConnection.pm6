use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

use GTK::Raw::Utils;
use GIO::Raw::TlsConnection;

use GLib::Value;
use GIO::Stream;
use GIO::TlsDatabase;

use GIO::Roles::Signals::TlsConnection;

our subset TlsConnectionAncestry is export of Mu
  where GTlsConnection | GIOStream;

class GIO::TlsConnection is GIO::Stream {
  also does GIO::Roles::Signals::TlsConnection;

  has GTlsConnection $!tc is implementor;

  submethod BUILD (:$tls-connection) {
    given $tls-connection {
      when TlsConnectionAncestry {
        self.setTlsConnection($tls-connection);
      }

      when GIO::TlsConnection {
      }

      default {
      }
    }
  }

  method setTlsConnection (TlsConnectionAncestry $tls) {
    my $to-parent;

    $!tc = do {
      when GTlsConnection {
        $to-parent = cast(GIOStream, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GTlsConnection, $_);
      }
    }
    self.setIOStream($to-parent);
  }

  method GLib::Raw::Types::GTlsConnection
    is also<GTlsConnection>
  { $!tc }

  proto method new(|)
  { * }

  multi method new (TlsConnectionAncestry $tls-connection) {
    self.bless( :$tls-connection );
  }

  # Type: GStrv
  method advertised-protocols is rw  is also<advertised_protocols> {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('advertised-protocols', $gv)
        );
        return Nil unless $gv.pointer;

        CStringArrayToArray( cast(CArray[Str], $gv.pointer) );
      },
      STORE => -> $, $val is copy { self.set_advertised_protocols($val) }
    );
  }

  # Type: GIOStream
  method base-io-stream (:$raw = False) is rw is also<base_io_stream> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('base-io-stream', $gv)
        );
        return Nil unless $gv.object;

        my $b = cast(GIOStream, $gv.object);
        $raw ?? $b !! GIO::Stream.new($b);
      },
      STORE => -> $, $val is copy {
        warn 'base-io-stream is does not allow writing (construct-only)!'
      }
    );
  }

  method certificate (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $c = g_tls_connection_get_certificate($!tc);

        $c ??
          ( $raw ?? $c !! GIO::TlsCertificate.new($c) )
          !!
          Nil;
      },
      STORE => sub ($, $certificate is copy) {
        g_tls_connection_set_certificate($!tc, $certificate);
      }
    );
  }

  method database (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $d = g_tls_connection_get_database($!tc);

        $d ??
          ( $raw ?? $d !! GIO::TlsDatabase.new($d) )
          !!
          Nil;
      },
      STORE => sub ($, GTlsDatabase() $database is copy) {
        g_tls_connection_set_database($!tc, $database);
      }
    );
  }

  method interaction (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $i = g_tls_connection_get_interaction($!tc);

        $i ??
          ( $raw ?? $i !! GIO::TlsInteraction.new($i) )
          !!
          Nil;
      },
      STORE => sub ($, GTlsInteraction() $interaction is copy) {
        g_tls_connection_set_interaction($!tc, $interaction);
      }
    );
  }

  # Deprecated
  # method rehandshake_mode is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       g_tls_connection_get_rehandshake_mode($!tc);
  #     },
  #     STORE => sub ($, $mode is copy) {
  #       g_tls_connection_set_rehandshake_mode($!tc, $mode);
  #     }
  #   );
  # }

  method require_close_notify is rw is also<require-close-notify> {
    Proxy.new(
      FETCH => sub ($) {
        g_tls_connection_get_require_close_notify($!tc);
      },
      STORE => sub ($, $require_close_notify is copy) {
        g_tls_connection_set_require_close_notify($!tc, $require_close_notify);
      }
    );
  }

  # Deprecated
  # method use_system_certdb is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       g_tls_connection_get_use_system_certdb($!tc);
  #     },
  #     STORE => sub ($, $use_system_certdb is copy) {
  #       g_tls_connection_set_use_system_certdb($!tc, $use_system_certdb);
  #     }
  #   );
  # }

  # Is originally:
  # GTlsConnection, GTlsCertificate, GTlsCertificateFlags, gpointer --> gboolean
  method accept-certificate is also<accept_certificate> {
    self.connect-accept-certificate($!tc);
  }

  method emit_accept_certificate (
    GTlsCertificate() $peer_cert,
    Int() $errors
  )
    is also<emit-accept-certificate>
  {
    my GTlsCertificateFlags $e = $errors;

    g_tls_connection_emit_accept_certificate($!tc, $peer_cert, $e);
  }

  method g_tls_error_quark (GIO::TlsConnection:U:) is also<g-tls-error-quark> {
    g_tls_error_quark();
  }

  method get_negotiated_protocol
    is also<
      get-negotiated-protocol
      negotiated_protocol
      negotiated-protocol
    >
  {
    g_tls_connection_get_negotiated_protocol($!tc);
  }

  method get_peer_certificate (:$raw = False)
    is also<
      get-peer-certificate
      peer_certificate
      peer-certificate
    >
  {
    my $c = g_tls_connection_get_peer_certificate($!tc);

    $c ??
      ( $raw ?? $c !! GIO::TlsCertificate.new($c) )
      !!
      Nil;
  }

  method get_peer_certificate_errors
    is also<
      get-peer-certificate-errors
      peer_certificate_errors
      peer-certificate-errors
    >
  {
    GTlsCertificateFlagsEnum(
      g_tls_connection_get_peer_certificate_errors($!tc)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_tls_connection_get_type, $n, $t );
  }

  method handshake (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so g_tls_connection_handshake($!tc, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method handshake_async (|)
      is also<handshake-async>
  { * }

  multi method handshake_async (
    Int() $io_priority,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($io_priority, GCancellable, $callback, $user_data);
  }
  multi method handshake_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my guint $i = $io_priority;

    g_tls_connection_handshake_async(
      $!tc,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method handshake_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<handshake-finish>
  {
    clear_error;
    my $rv = so g_tls_connection_handshake_finish($!tc, $result, $error);
    set_error($error);
    $rv;
  }

  proto method set_advertised_protocols (|)
      is also<set-advertised-protocols>
  { * }

  multi method set_advertised_protocols (@p) {
    samewith( resolve-gstrv(|@p) );
  }
  multi method set_advertised_protocols (CArray[Str] $p) {
    $p[$p.elems] = Str unless $p[* - 1] =:= Str;
    g_tls_connection_set_advertised_protocols($!tc, $p)
  }

}
