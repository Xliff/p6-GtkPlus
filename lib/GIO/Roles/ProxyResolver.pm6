use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Types;
use GIO::Raw::ProxyResolver;

use GTK::Raw::Utils;

role GIO::ProxyResolver {
  has GProxyResolver $!pr;

  submethod BUILD (:$proxy-resolver) {
    $!pr = $proxy-resolver;
  }

  method roleInit-ProxyResolver {
    my \i = findProperImplementor(self.^attributes);

    $!pr = cast( GProxyResolver, i.get-value(self) );
  }

  method GLib::Raw::Types::GProxyResolver
    is also<GProxyResolver>
  { $!pr }

  multi method new-proxyresolber-obj (GProxyResolver $proxy-resolver)
    is also<new_proxyresolver_obj>
  {
    self.bless( :$proxy-resolver );
  }

  method get_default is also<get-default> {
    self.bless( proxy-resolver => g_proxy_resolver_get_default() );
  }

  method proxyresolver_get_type is also<proxyresolver-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_proxy_resolver_get_type, $n, $t );
  }

  method is_supported is also<is-supported> {
    so g_proxy_resolver_is_supported($!pr);
  }

  method lookup (
    Str() $uri,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $sa = g_proxy_resolver_lookup($!pr, $uri, $cancellable, $error);
    set_error($error);

    CStringArrayToArray($sa);
  }

  method lookup_async (
    Str() $uri,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<lookup-async>
  {
    g_proxy_resolver_lookup_async(
      $!pr,
      $uri,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method lookup_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<lookup-finish>
  {
    clear_error;
    my $sa = g_proxy_resolver_lookup_finish($!pr, $result, $error);
    set_error($error);

    CStringArrayToArray($sa);
  }

}
