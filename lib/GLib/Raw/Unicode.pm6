use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Unicode;

sub g_unichar_break_type (gunichar $c)
  returns GUnicodeBreakType
  is native(glib)
  is export
{ * }

sub g_unichar_combining_class (gunichar $uc)
  returns gint
  is native(glib)
  is export
{ * }

sub g_unichar_compose (gunichar $a, gunichar $b, gunichar $ch is rw)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_decompose (gunichar $ch, gunichar $a is rw, gunichar $b is rw)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_digit_value (gunichar $c)
  returns gint
  is native(glib)
  is export
{ * }

sub g_unichar_fully_decompose (
  gunichar $ch,
  gboolean $compat,
  gunichar $result is rw,
  gsize $result_len
)
  returns gsize
  is native(glib)
  is export
{ * }

sub g_ucs4_to_utf16 (
  Str $str,
  glong $len,
  glong $items_read    is rw,
  glong $items_written is rw,
  CArray[Pointer[GError]] $error
)
  returns gunichar2
  is native(glib)
  is export
{ * }

sub g_ucs4_to_utf8 (
  Str $str,
  glong $len,
  glong $items_read    is rw,
  glong $items_written is rw,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_unicode_canonical_decomposition (gunichar $ch, gsize $result_len)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_unicode_canonical_ordering (gunichar $string, gsize $len)
  is native(glib)
  is export
{ * }

sub g_unicode_script_from_iso15924 (guint32 $iso15924)
  returns GUnicodeScript
  is native(glib)
  is export
{ * }

sub g_unicode_script_to_iso15924 (GUnicodeScript $script)
  returns guint32
  is native(glib)
  is export
{ * }

sub g_utf16_to_ucs4 (
  Str $str,
  glong $len,
  glong $items_read    is rw,
  glong $items_written is rw,
  CArray[Pointer[GError]] $error
)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_utf16_to_utf8 (
  Str $str,
  glong $len,
  glong $items_read    is rw,
  glong $items_written is rw,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_casefold (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_collate (Str $str1, Str $str2)
  returns gint
  is native(glib)
  is export
{ * }

sub g_utf8_collate_key (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_collate_key_for_filename (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_find_next_char (Str $p, Str $end)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_find_prev_char (Str $str, Str $p)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_get_char (Str $p)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_utf8_get_char_validated (Str $p, gssize $max_len)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_utf8_make_valid (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_normalize (Str $str, gssize $len, GNormalizeMode $mode)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_offset_to_pointer (Str $str, glong $offset)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_pointer_to_offset (Str $str, Str $pos)
  returns glong
  is native(glib)
  is export
{ * }

sub g_utf8_prev_char (Str $p)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_strchr (Str $p, gssize $len, gunichar $c)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_strdown (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_strlen (Str $p, gssize $max)
  returns glong
  is native(glib)
  is export
{ * }

sub g_utf8_strncpy (Str $dest, Str $src, gsize $n)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_strrchr (Str $p, gssize $len, gunichar $c)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_strreverse (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_strup (Str $str, gssize $len)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_substring (Str $str, glong $start_pos, glong $end_pos)
  returns Str
  is native(glib)
  is export
{ * }

sub g_utf8_to_ucs4 (
  Str $str,
  glong $len,
  glong $items_read    is rw,
  glong $items_written is rw,
  CArray[Pointer[GError]] $error
)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_utf8_to_ucs4_fast (Str $str, glong $len, glong $items_written is rw)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_utf8_to_utf16 (
  Str $str,
  glong $len,
  glong $items_read    is rw,
  glong $items_written is rw,
  CArray[Pointer[GError]] $error
)
  returns gunichar2
  is native(glib)
  is export
{ * }

sub g_utf8_validate (Str $str, gssize $max_len, CArray[Str] $end)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_utf8_validate_len (Str $str, gsize $max_len, CArray[Str] $end)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_get_mirror_char (gunichar $ch, gunichar $mirrored_ch is rw)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_get_script (gunichar $ch)
  returns GUnicodeScript
  is native(glib)
  is export
{ * }

sub g_unichar_isalnum (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isalpha (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_iscntrl (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isdefined (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isdigit (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isgraph (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_islower (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_ismark (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isprint (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_ispunct (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isspace (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_istitle (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isupper (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_iswide (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_iswide_cjk (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_isxdigit (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_iszerowidth (gunichar $c)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_to_utf8 (gunichar $c, Str $outbuf)
  returns gint
  is native(glib)
  is export
{ * }

sub g_unichar_tolower (gunichar $c)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_unichar_totitle (gunichar $c)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_unichar_toupper (gunichar $c)
  returns gunichar
  is native(glib)
  is export
{ * }

sub g_unichar_type (gunichar $c)
  returns GUnicodeType
  is native(glib)
  is export
{ * }

sub g_unichar_validate (gunichar $ch)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_unichar_xdigit_value (gunichar $c)
  returns gint
  is native(glib)
  is export
{ * }
