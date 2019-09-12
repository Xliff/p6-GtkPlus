use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Checksum;

sub g_checksum_copy (GChecksum $checksum)
  returns GChecksum
  is native(glib)
  is export
{ * }

sub g_checksum_free (GChecksum $checksum)
  is native(glib)
  is export
{ * }

sub g_compute_checksum_for_bytes (GChecksumType $checksum_type, GBytes $data)
  returns Str
  is native(glib)
  is export
{ * }

sub g_compute_checksum_for_data (
  GChecksumType $checksum_type,
  guchar $data,
  gsize $length
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_compute_checksum_for_string (
  GChecksumType $checksum_type,
  Str $str,
  gssize $length
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_checksum_get_digest (
  GChecksum $checksum,
  guint8 $buffer,
  gsize $digest_len
)
  is native(glib)
  is export
{ * }

sub g_checksum_get_string (GChecksum $checksum)
  returns Str
  is native(glib)
  is export
{ * }

sub g_checksum_new (GChecksumType $checksum_type)
  returns GChecksum
  is native(glib)
  is export
{ * }

sub g_checksum_reset (GChecksum $checksum)
  is native(glib)
  is export
{ * }

sub g_checksum_type_get_length (GChecksumType $checksum_type)
  returns gssize
  is native(glib)
  is export
{ * }

sub g_checksum_update (GChecksum $checksum, guchar $data, gssize $length)
  is native(glib)
  is export
{ * }
