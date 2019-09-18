use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::InetAddressMask;

sub g_inet_address_mask_equal (GInetAddressMask $mask, GInetAddressMask $mask2)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_get_address (GInetAddressMask $mask)
  returns GInetAddress
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_get_family (GInetAddressMask $mask)
  returns GSocketFamily
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_get_length (GInetAddressMask $mask)
  returns guint
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_matches (GInetAddressMask $mask, GInetAddress $address)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_new (
  GInetAddress $addr,
  guint $length,
  CArray[Pointer[GError]] $error
)
  returns GInetAddressMask
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_new_from_string (
  Str $mask_string,
  CArray[Pointer[GError]] $error
)
  returns GInetAddressMask
  is native(gio)
  is export
{ * }

sub g_inet_address_mask_to_string (GInetAddressMask $mask)
  returns Str
  is native(gio)
  is export
{ * }
