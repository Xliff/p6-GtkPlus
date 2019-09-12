use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Base64;

sub g_base64_decode (Str $text, gsize $out_len is rw)
  returns Str
  is native(glib)
  is export
{ * }

sub g_base64_decode_inplace (Str $text, gsize $out_len is rw)
  returns Str
  is native(glib)
  is export
{ * }

sub g_base64_decode_step (
  Str $in,
  gsize $len,
  guchar $out is rw,
  gint $state is rw,
  guint $save is rw
)
  returns gsize
  is native(glib)
  is export
{ * }

sub g_base64_encode (Str $data, gsize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_base64_encode_close (
  gboolean $break_lines,
  Str $out    is rw,
  gint $state is rw,
  gint $save  is rw
)
  returns gsize
  is native(glib)
  is export
{ * }

sub g_base64_encode_step (
  Str $in,
  gsize $len,
  gboolean $break_lines,
  Str $out    is rw,
  gint $state is rw,
  gint $save  is rw
)
  returns gsize
  is native(glib)
  is export
{ * }
