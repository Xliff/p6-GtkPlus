use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::InetAddress;

sub g_inet_address_equal (GInetAddress $address, GInetAddress $other_address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_family (GInetAddress $address)
  returns GSocketFamily
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_any (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_link_local (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_loopback (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_mc_global (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_mc_link_local (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_mc_node_local (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_mc_org_local (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_mc_site_local (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_multicast (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_is_site_local (GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_get_native_size (GInetAddress $address)
  returns gsize
  is native(gio)
  is export
{ * }

sub g_inet_address_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_inet_address_new_any (GSocketFamily $family)
  returns GInetAddress
  is native(gio)
  is export
{ * }

sub g_inet_address_new_from_bytes (CArray[uint8] $bytes, GSocketFamily $family)
  returns GInetAddress
  is native(gio)
  is export
{ * }

sub g_inet_address_new_from_string (Str $string)
  returns GInetAddress
  is native(gio)
  is export
{ * }

sub g_inet_address_new_loopback (GSocketFamily $family)
  returns GInetAddress
  is native(gio)
  is export
{ * }

sub g_inet_address_to_bytes (GInetAddress $address)
  returns CArray[guint8]
  is native(gio)
  is export
{ * }

sub g_inet_address_to_string (GInetAddress $address)
  returns Str
  is native(gio)
  is export
{ * }
