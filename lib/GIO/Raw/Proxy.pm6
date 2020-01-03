use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Proxy;

sub g_proxy_connect (
  GProxy $proxy,
  GIOStream $connection,
  GProxyAddress $proxy_address,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GIOStream
  is native(gio)
  is export
{ * }

sub g_proxy_connect_async (
  GProxy $proxy,
  GIOStream $connection,
  GProxyAddress $proxy_address,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_proxy_connect_finish (
  GProxy $proxy,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GIOStream
  is native(gio)
  is export
{ * }

sub g_proxy_get_default_for_protocol (Str $protocol)
  returns GProxy
  is native(gio)
  is export
{ * }

sub g_proxy_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_proxy_supports_hostname (GProxy $proxy)
  returns uint32
  is native(gio)
  is export
{ * }
