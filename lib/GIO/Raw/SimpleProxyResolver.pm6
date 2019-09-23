use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::SimpleProxyResolver;

sub g_simple_proxy_resolver_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_simple_proxy_resolver_new (Str $default_proxy, CArray[Str] $ignore_hosts)
  returns GSimpleProxyResolver
  is native(gio)
  is export
{ * }

sub g_simple_proxy_resolver_set_default_proxy (
  GSimpleProxyResolver $resolver,
  Str $default_proxy
)
  is native(gio)
  is export
{ * }

sub g_simple_proxy_resolver_set_ignore_hosts (
  GSimpleProxyResolver $resolver,
  CArray[Str] $ignore_hosts
)
  is native(gio)
  is export
{ * }

sub g_simple_proxy_resolver_set_uri_proxy (
  GSimpleProxyResolver $resolver,
  Str $uri_scheme,
  Str $proxy
)
  is native(gio)
  is export
{ * }
