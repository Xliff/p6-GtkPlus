use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::HMAC;

sub g_hmac_copy (GHmac $hmac)
  returns GHmac
  is native(glib)
  is export
{ * }

sub g_compute_hmac_for_bytes (
  GChecksumType $digest_type,
  GBytes $key,
  GBytes $data
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_compute_hmac_for_data (
  GChecksumType $digest_type,
  Str $key,
  gsize $key_len,
  Str $data,
  gsize $length
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_compute_hmac_for_string (
  GChecksumType $digest_type,
  Str $key,
  gsize $key_len,
  Str $str,
  gssize $length
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_hmac_get_digest (
  GHmac $hmac,
  CArray[uint8] $buffer,
  gsize $digest_len is rw
)
  is native(glib)
  is export
{ * }

sub g_hmac_get_string (GHmac $hmac)
  returns Str
  is native(glib)
  is export
{ * }

sub g_hmac_new (GChecksumType $digest_type, Str $key, gsize $key_len)
  returns GHmac
  is native(glib)
  is export
{ * }

sub g_hmac_ref (GHmac $hmac)
  returns GHmac
  is native(glib)
  is export
{ * }

sub g_hmac_unref (GHmac $hmac)
  is native(glib)
  is export
{ * }

sub g_hmac_update (GHmac $hmac, Str $data, gssize $length)
  is native(glib)
  is export
{ * }
