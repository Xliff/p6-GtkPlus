use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::DtlsConnection;

use GLib::Value;
use GIO::TlsCertificate;
use GIO::TlsDatabase;
use GIO::TlsInteraction;

use GIO::Roles::Signals::DtlsConnection;
use GIO::Roles::DatagramBased;

role GIO::Roles::DtlsConnection {
  also does GIO::Roles::Signals::DtlsConnection;

  has GDtlsConnection $!dtc;

  submethod BUILD ( :$dtls-connection ) {
    $!dtc = $dtls-connection if $dtls-connection;
  }

  method roleInit-DtlsConnection is also<roleInit_DtlsConnection> {
    my \i = findProperImplementor(self.^attributes);

    $!dtc = cast( GDtlsConnection, i.get_value(self) );
  }

  method GLib::Raw::Types::GDtlsConnection
    is also<GDtlsConnection>
  { $!dtc }

  method new-dtlsconnection-obj (GDtlsConnection $dtls-connection)
    is also<new_dtlsconnection_obj>
  {
    self.bless( :$dtls-connection );
  }

  method certificate (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $c = g_dtls_connection_get_certificate($!dtc);

        $c ??
          ( $raw ?? $c !! GIO::TlsCertificate.new($c) )
          !!
          Nil;
      },
      STORE => sub ($, GTlsCertificate() $certificate is copy) {
        g_dtls_connection_set_certificate($!dtc, $certificate);
      }
    );
  }

  method database (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $d = g_dtls_connection_get_database($!dtc);

        $d ??
          ( $raw ?? $d !! GIO::TlsDatabase.new($d) )
          !!
          Nil;
      },
      STORE => sub ($, GTlsDatabase() $database is copy) {
        g_dtls_connection_set_database($!dtc, $database);
      }
    );
  }

  method interaction (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $i = g_dtls_connection_get_interaction($!dtc);

        $i ??
          ( $raw ?? $i !! GIO::TlsInteraction.new($i) )
          !!
          Nil;
      },
      STORE => sub ($, GTlsInteraction() $interaction is copy) {
        g_dtls_connection_set_interaction($!dtc, $interaction);
      }
    );
  }

  # method rehandshake_mode is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       g_dtls_connection_get_rehandshake_mode($!dtc);
  #     },
  #     STORE => sub ($, $mode is copy) {
  #       g_dtls_connection_set_rehandshake_mode($!dtc, $mode);
  #     }
  #   );
  # }

  method require_close_notify is rw is also<require-close-notify> {
    Proxy.new(
      FETCH => sub ($) {
        so g_dtls_connection_get_require_close_notify($!dtc);
      },
      STORE => sub ($, Int() $require_close_notify is copy) {
        my gboolean $r = $require_close_notify;

        g_dtls_connection_set_require_close_notify($!dtc, $r);
      }
    );
  }

  # Type: GStrv
  method advertised-protocols is rw  {
    my GLib::Value $gv .= new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('advertised-protocols', $gv)
        );
        CStringArrayToArray( cast(CArray[Str], $gv.pointer) );
      },
      STORE => -> $, $val is copy {
        $val = resolve-gstrv($val) if $val ~~ Array;

        die qq:to/DIE/ unless $val ~~ CArray[Str];
          Invalid value passed to .advertised-protocols. Wanted CArray[Str]{''
          } got { $val.^name }
          DIE

        $gv.pointer = $val;
        self.prop_set('advertised-protocols', $gv);
      }
    );
  }

  # Type: GDatagramBased
  method base-socket (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('base-socket', $gv)
        );
        return Nil unless $gv.object;

        my $d = cast(GDatagramBased, $gv.object);
        $raw ?? $d !! GIO::Roles::DatagramBased.new-datagrambased-obj($d);
      },
      STORE => -> $, $val is copy {
        warn 'base-socked can only be set at construction time.'
      }
    );
  }

  # Is originally:
  # GDtlsConnection, GTlsCertificate, GTlsCertificateFlags, gpointer --> gboolean
  method accept-certificate {
    self.connect-accept-certificate($!dtc);
  }

  method close (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_dtls_connection_close($!dtc, $cancellable, $error);
  }

  proto method close_async (|)
    is also<close-async>
  { * }

  multi method close_async (
    Int() $io_priority,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith($io_priority, GCancellable, $callback, $user_data);
  }
  multi method close_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my gint $i = $io_priority;

    g_dtls_connection_close_async(
      $!dtc,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method close_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<close-finish>
  {
    clear_error;
    my $rv = so g_dtls_connection_close_finish($!dtc, $result, $error);
    set_error($error);
    $rv;
  }

  method emit_accept_certificate (
    GTlsCertificate() $peer_cert,
    Int() $errors
  )
    is also<emit-accept-certificate>
  {
    my GTlsCertificateFlags $e = $errors;

    g_dtls_connection_emit_accept_certificate($!dtc, $peer_cert, $e);
  }

  method get_negotiated_protocol is also<
    get-negotiated-protocol
    negotiated_protocol
    negotiated-protocol
  > {
    g_dtls_connection_get_negotiated_protocol($!dtc);
  }

  method get_peer_certificate (:$raw = False)
    is also<
      get-peer-certificate
      peer_certificate
      peer-certificate
    >
  {
    my $pc = g_dtls_connection_get_peer_certificate($!dtc);

    $pc ??
      ( $raw ?? $pc !! GIO::TlsCertificate.new($pc) )
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
    GTlsCertificateFlags(
      g_dtls_connection_get_peer_certificate_errors($!dtc)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dtls_connection_get_type, $n, $t );
  }

  method handshake (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so g_dtls_connection_handshake($!dtc, $cancellable, $error);
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
    my gint $i = $io_priority;

    g_dtls_connection_handshake_async(
      $!dtc,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method handshake_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<handshake-finish>
  {
    clear_error;
    my $rv = so g_dtls_connection_handshake_finish($!dtc, $result, $error);
    set_error($error);
    $rv;
  }

  proto method set_advertised_protocols (|)
    is also<set-advertised-protocols>
  { * }

  multi method set_advertised_protocols (@protocols) {
    samewith( resolve-gstrv( |@protocols ) );
  }
  multi method set_advertised_protocols (CArray[Str] $protocols) {
    g_dtls_connection_set_advertised_protocols($!dtc, $protocols);
  }

  multi method shutdown (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(True, True, $cancellable, $error);
  }
  multi method shutdown (
    Int() $shutdown_read,
    Int() $shutdown_write,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gboolean ($sr, $sw) = ($shutdown_read, $shutdown_write);

    g_dtls_connection_shutdown($!dtc, $sr, $sw, $cancellable, $error);
  }

  proto method shutdown_async (|)
    is also<shutdown-async>
  { * }

  multi method shutdown_async (
    Int() $io_priority,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      True,
      True,
      $io_priority,
      GCancellable,
      $callback,
      $user_data
    );
  }
  multi method shutdown_async (
    Int() $shutdown_read,
    Int() $shutdown_write,
    Int() $io_priority,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    samewith(
      $shutdown_read,
      $shutdown_write,
      $io_priority,
      GCancellable,
      $callback,
      $user_data
    )
  }
  multi method shutdown_async (
    Int() $shutdown_read,
    Int() $shutdown_write,
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) {
    my gboolean ($sr, $sw) = ($shutdown_read, $shutdown_write);
    my gint $i = $io_priority;

    g_dtls_connection_shutdown_async(
      $!dtc,
      $sr,
      $sw,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method shutdown_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<shutdown-finish>
  {
    clear_error;
    my $rv = so g_dtls_connection_shutdown_finish($!dtc, $result, $error);
    set_error($error);
    $rv;
  }

}
