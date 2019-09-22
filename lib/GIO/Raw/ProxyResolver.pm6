use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::ProxyResolver;

sub g_proxy_resolver_get_default ()
  returns GProxyResolver
  is native(gio)
  is export
{ * }

sub g_proxy_resolver_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_proxy_resolver_is_supported (GProxyResolver $resolver)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_proxy_resolver_lookup (
  GProxyResolver $resolver,
  Str $uri,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_proxy_resolver_lookup_async (
  GProxyResolver $resolver,
  Str $uri,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_proxy_resolver_lookup_finish (
  GProxyResolver $resolver,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }
