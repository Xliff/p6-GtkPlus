use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::SocketClient;

use GLib::Roles::Object;

use GIO::SocketAddress;
use GIO::SocketConnection;

use GIO::Roles::ProxyResolver;

class GIO::SocketClient {
  also does GLib::Roles::Object;

  has GSocketClient $!sc is implementor;

  submethod BUILD (:$client) {
    $!sc = $client ~~ GSocketClient ?? $_ !! cast(GSocketClient, $_);

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GSocketClient
  { $!sc }

  multi method new (GSocketClient $client) {
    self.bless( :$client );
  }
  multi method new {
    self.bless( client => g_socket_client_new() );
  }

  method enable_proxy is rw is also<enable-proxy> {
    Proxy.new(
      FETCH => sub ($) {
        so g_socket_client_get_enable_proxy($!sc);
      },
      STORE => sub ($, Int() $enable is copy) {
        my gboolean $e = $enable;

        g_socket_client_set_enable_proxy($!sc, $e);
      }
    );
  }

  method family is rw {
    Proxy.new(
      FETCH => sub ($) {
        GSocketFamilyEnum( g_socket_client_get_family($!sc) );
      },
      STORE => sub ($, Int() $family is copy) {
        my GSocketFamily $f = $family;

        g_socket_client_set_family($!sc, $f);
      }
    );
  }

  method local_address (:$raw = False) is rw is also<local-address> {
    Proxy.new(
      FETCH => sub ($) {
        my $s = g_socket_client_get_local_address($!sc);

        $raw ?? $s !! GIO::SocketAddress.new($s);
      },
      STORE => sub ($, GSocketAddress() $address is copy) {
        g_socket_client_set_local_address($!sc, $address);
      }
    );
  }

  method protocol is rw {
    Proxy.new(
      FETCH => sub ($) {
        GSocketProtocolEnum( g_socket_client_get_protocol($!sc) );
      },
      STORE => sub ($, Int() $protocol is copy) {
        my GSocketProtocol $p = $protocol;

        g_socket_client_set_protocol($!sc, $p);
      }
    );
  }

  method proxy_resolver (:$raw = False) is rw is also<proxy-resolver> {
    Proxy.new(
      FETCH => sub ($) {
        my $pr = g_socket_client_get_proxy_resolver($!sc);

        $raw ?? $pr !! GIO::Roles::ProxyResolver.new-role-obj($pr);
      },
      STORE => sub ($, GProxyResolver() $proxy_resolver is copy) {
        g_socket_client_set_proxy_resolver($!sc, $proxy_resolver);
      }
    );
  }

  method socket_type is rw is also<socket-type> {
    Proxy.new(
      FETCH => sub ($) {
        GSocketTypeEnum( g_socket_client_get_socket_type($!sc) );
      },
      STORE => sub ($, Int() $type is copy) {
        my GSocketType $t = $type;

        g_socket_client_set_socket_type($!sc, $t);
      }
    );
  }

  method timeout is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_socket_client_get_timeout($!sc);
      },
      STORE => sub ($, Int() $timeout is copy) {
        my gint $t = $timeout;

        g_socket_client_set_timeout($!sc, $t);
      }
    );
  }

  method tls is rw {
    Proxy.new(
      FETCH => sub ($) {
        so g_socket_client_get_tls($!sc);
      },
      STORE => sub ($, Int() $tls is copy) {
        my gboolean $t = $tls;

        g_socket_client_set_tls($!sc, $t);
      }
    );
  }

  method tls_validation_flags is rw is also<tls-validation-flags> {
    Proxy.new(
      FETCH => sub ($) {
        GTlsCertificateFlagsEnum(
          g_socket_client_get_tls_validation_flags($!sc)
        );
      },
      STORE => sub ($, Int() $flags is copy) {
        my GTlsCertificateFlags $f = $flags;

        g_socket_client_set_tls_validation_flags($!sc, $f);
      }
    );
  }

  method add_application_proxy (Str() $protocol)
    is also<add-application-proxy>
  {
    g_socket_client_add_application_proxy($!sc, $protocol);
  }

  method connect (
    GSocketConnectable() $connectable,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $rv = g_socket_client_connect($!sc, $connectable, $cancellable, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_async (
    GSocketConnectable() $connectable,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<connect-async>
  {
    g_socket_client_connect_async(
      $!sc,
      $connectable,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method connect_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<connect-finish>
  {
    clear_error;
    my $rv = g_socket_client_connect_finish($!sc, $result, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_to_host (
    Str() $host_and_port,
    Int() $default_port,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  )
    is also<connect-to-host>
  {
    my guint16 $dp = $default_port;

    clear_error;
    my $rv = g_socket_client_connect_to_host(
      $!sc,
      $host_and_port,
      $dp,
      $cancellable,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_to_host_async (
    Str() $host_and_port,
    Int() $default_port,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<connect-to-host-async>
  {
    my guint16 $dp = $default_port;

    g_socket_client_connect_to_host_async(
      $!sc,
      $host_and_port,
      $dp,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method connect_to_host_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<connect-to-host-finish>
  {
    clear_error;
    my $rv = g_socket_client_connect_to_host_finish($!sc, $result, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_to_service (
    Str() $domain,
    Str() $service,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<connect-to-service>
  {
    clear_error;
    my $rv = g_socket_client_connect_to_service(
      $!sc,
      $domain,
      $service,
      $cancellable,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_to_service_async (
    Str() $domain,
    Str() $service,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<connect-to-service-async>
  {
    g_socket_client_connect_to_service_async(
      $!sc,
      $domain,
      $service,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method connect_to_service_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<connect-to-service-finish>
  {
    clear_error;
    my $rv = g_socket_client_connect_to_service_finish($!sc, $result, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_to_uri (
    Str() $uri,
    Int() $default_port,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error,
    :$raw = False
  )
    is also<connect-to-uri>
  {
    my guint16 $dp = $default_port;

    clear_error;
    my $rv = g_socket_client_connect_to_uri(
      $!sc,
      $uri,
      $dp,
      $cancellable,
      $error
    );
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method connect_to_uri_async (
    Str() $uri,
    Int() $default_port,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<connect-to-uri-async>
  {
    my guint16 $dp = $default_port;

    g_socket_client_connect_to_uri_async(
      $!sc,
      $uri,
      $dp,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method connect_to_uri_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<connect-to-uri-finish>
  {
    clear_error;
    my $rv = g_socket_client_connect_to_uri_finish($!sc, $result, $error);
    set_error($error);

    $rv ??
      ( $raw ?? $rv !! GIO::SocketConnection.new($rv) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_client_get_type, $n, $t )
  }

}
