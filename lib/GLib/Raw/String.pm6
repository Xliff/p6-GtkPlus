use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::String;

sub g_string_append (GString $string, Str $val)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_append_c (GString $string, Str $c)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_append_len (GString $string, Str $val, gssize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_append_unichar (GString $string, gunichar $wc)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_append_uri_escaped (GString $string, Str $unescaped, Str $reserved_chars_allowed, gboolean $allow_utf8)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_ascii_down (GString $string)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_ascii_up (GString $string)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_assign (GString $string, Str $rval)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_down (GString $string)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_equal (GString $v, GString $v2)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_string_erase (GString $string, gssize $pos, gssize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_free (GString $string, gboolean $free_segment)
  returns Str
  is native(glib)
  is export
{ * }

sub g_string_free_to_bytes (GString $string)
  returns GBytes
  is native(glib)
  is export
{ * }

sub g_string_hash (GString $str)
  returns guint
  is native(glib)
  is export
{ * }

sub g_string_insert (GString $string, gssize $pos, Str $val)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_insert_c (GString $string, gssize $pos, Str $c)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_insert_len (GString $string, gssize $pos, Str $val, gssize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_insert_unichar (GString $string, gssize $pos, gunichar $wc)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_new (Str $init)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_new_len (Str $init, gssize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_overwrite (GString $string, gsize $pos, Str $val)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_overwrite_len (GString $string, gsize $pos, Str $val, gssize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_prepend (GString $string, Str $val)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_prepend_c (GString $string, Str $c)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_prepend_len (GString $string, Str $val, gssize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_prepend_unichar (GString $string, gunichar $wc)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_set_size (GString $string, gsize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_sized_new (gsize $dfl_size)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_truncate (GString $string, gsize $len)
  returns GString
  is native(glib)
  is export
{ * }

sub g_string_up (GString $string)
  returns GString
  is native(glib)
  is export
{ * }
