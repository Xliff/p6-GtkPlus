use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Bytes;

sub g_bytes_compare (GBytes $bytes1, GBytes $bytes2)
  returns gint
  is native(glib)
  is export
{ * }

sub g_bytes_equal (GBytes $bytes1, GBytes $bytes2)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_bytes_get_data (GBytes $bytes, gsize $size)
  returns gconstpointer
  is native(glib)
  is export
{ * }

sub g_bytes_get_size (GBytes $bytes)
  returns gsize
  is native(glib)
  is export
{ * }

sub g_bytes_hash (GBytes $bytes)
  returns guint
  is native(glib)
  is export
{ * }

sub g_bytes_new (Blob $data, gsize $size)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_bytes_new_from_bytes (GBytes $bytes, gsize $offset, gsize $length)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_bytes_new_static (Blob $data, gsize $size)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_bytes_new_take (Blob $data, gsize $size)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_bytes_new_with_free_func (
  Blob $data,
  gsize $size,
  GDestroyNotify $free_func,
  gpointer $user_data
)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_bytes_ref (GBytes $bytes)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_bytes_unref (GBytes $bytes)
  is native(glib)
  is export
{ * }

sub g_bytes_unref_to_array (GBytes $bytes)
  returns GByteArray
  is native(glib)
  is export
{ * }

sub g_bytes_unref_to_data (GBytes $bytes, gsize $size)
  returns Pointer
  is native(glib)
  is export
{ * }
