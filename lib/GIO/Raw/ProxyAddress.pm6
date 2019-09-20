use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::ProxyAddress;

sub g_proxy_address_get_destination_hostname (GProxyAddress $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_destination_port (GProxyAddress $proxy)
  returns guint16
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_destination_protocol (GProxyAddress $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_password (GProxyAddress $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_protocol (GProxyAddress $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_uri (GProxyAddress $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_proxy_address_get_username (GProxyAddress $proxy)
  returns Str
  is native(gio)
  is export
{ * }

sub g_proxy_address_new (
  GInetAddress $inetaddr,
  guint16 $port,
  Str $protocol,
  Str $dest_hostname,
  guint16 $dest_port,
  Str $username,
  Str $password
)
  returns GProxyAddress
  is native(gio)
  is export
{ * }
