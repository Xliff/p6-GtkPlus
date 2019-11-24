use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Markup;

### /usr/include/glib-2.0/glib/gmarkup.h

sub g_markup_error_quark ()
  returns GQuark
  is native(glib)
  is export
{ * }

sub g_markup_escape_text (Str $text, gssize $length)
  returns Str
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_end_parse (
  GMarkupParseContext $context,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_free (GMarkupParseContext $context)
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_get_element (GMarkupParseContext $context)
  returns Str
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_get_element_stack (GMarkupParseContext $context)
  returns GSList
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_get_position (
  GMarkupParseContext $context,
  gint $line_number,
  gint $char_number
)
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_get_user_data (GMarkupParseContext $context)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_new (
  GMarkupParser $parser,
  GMarkupParseFlags $flags,
  gpointer $user_data,
  GDestroyNotify $user_data_dnotify
)
  returns GMarkupParseContext
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_parse (
  GMarkupParseContext $context,
  Str $text,
  gssize $text_len,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_pop (GMarkupParseContext $context)
  returns Pointer
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_push (
  GMarkupParseContext $context,
  GMarkupParser $parser,
  gpointer $user_data
)
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_ref (GMarkupParseContext $context)
  returns GMarkupParseContext
  is native(glib)
  is export
{ * }

sub g_markup_parse_context_unref (GMarkupParseContext $context)
  is native(glib)
  is export
{ * }

sub g_markup_vprintf_escaped (Str $format, va_list $args)
  returns Str
  is native(glib)
  is export
{ * }
