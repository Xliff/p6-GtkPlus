use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::NetworkAddress;

sub g_network_address_get_hostname (GNetworkAddress $addr)
  returns Str
  is native(gio)
  is export
{ * }

sub g_network_address_get_port (GNetworkAddress $addr)
  returns guint16
  is native(gio)
  is export
{ * }

sub g_network_address_get_scheme (GNetworkAddress $addr)
  returns Str
  is native(gio)
  is export
{ * }

sub g_network_address_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_network_address_new (Str $hostname, guint16 $port)
  returns GNetworkAddress
  is native(gio)
  is export
{ * }

sub g_network_address_new_loopback (guint16 $port)
  returns GNetworkAddress
  is native(gio)
  is export
{ * }

sub g_network_address_parse (
  Str $host_and_port,
  guint16 $default_port,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnectable
  is native(gio)
  is export
{ * }

sub g_network_address_parse_uri (
  Str $uri,
  guint16 $default_port,
  CArray[Pointer[GError]] $error
)
  returns GSocketConnectable
  is native(gio)
  is export
{ * }
