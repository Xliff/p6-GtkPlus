use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::Raw::Proxy;

use GIO::Stream;

role GIO::Roles::Proxy {
  has GProxy $!p;

  submethod BUILD (:$proxy) {
    $!p = $proxy if $proxy;
  }

  submethod GLib::Raw::Types::GProxy
  { $!p }

  method roleInit-Proxy {
    my \i = findProperImplementor(self.^attributes);

    $!p = cast( GProxy, i.get_vale(self) );
  }

  method newProxy (GProxy $proxy) {
    self.bless( :$proxy );
  }

  method get_default_for_protocol (Str() $protocol) {
    self.bless( proxy => g_proxy_get_default_for_protocol($protocol) );
  }

  method connect (
    GIOStream() $connection,
    GProxyAddress() $proxy_address,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $ios =
      g_proxy_connect($!p, $connection, $proxy_address, $cancellable, $error);
    set_error($error);
    $raw ?? $ios !! GIO::Stream.new($ios);
  }

  method connect_async (
    GIOStream() $connection,
    GProxyAddress() $proxy_address,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = Pointer
  ) {
    g_proxy_connect_async(
      $!p,
      $connection,
      $proxy_address,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method connect_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  ) {
    clear_error;
    my $ios = g_proxy_connect_finish($!p, $result, $error);
    set_error($error);
    $raw ?? $ios !! GIO::Stream.new($ios);
  }

  method proxy_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_proxy_get_type, $n, $t );
  }

  method supports_hostname {
    g_proxy_supports_hostname($!p);
  }

}
