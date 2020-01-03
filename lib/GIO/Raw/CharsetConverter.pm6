use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::CharsetConverter;

sub g_charset_converter_get_num_fallbacks (GCharsetConverter $converter)
  returns guint
  is native(gio)
  is export
{ * }

sub g_charset_converter_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_charset_converter_new (
  Str $to_charset,
  Str $from_charset,
  CArray[Pointer[GError]] $error
)
  returns GCharsetConverter
  is native(gio)
  is export
{ * }

sub g_charset_converter_get_use_fallback (GCharsetConverter $converter)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_charset_converter_set_use_fallback (
  GCharsetConverter $converter,
  gboolean $use_fallback
)
  is native(gio)
  is export
{ * }
