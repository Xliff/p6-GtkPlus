use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Pattern;

### /usr/include/glib-2.0/glib/gpattern.h

sub g_pattern_match (
  GPatternSpec $pspec,
  guint $string_length,
  Str $string,
  Str $string_reversed
)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_pattern_match_simple (Str $pattern, Str $string)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_pattern_match_string (GPatternSpec $pspec, Str $string)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_pattern_spec_equal (GPatternSpec $pspec1, GPatternSpec $pspec2)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_pattern_spec_free (GPatternSpec $pspec)
  is native(glib)
  is export
{ * }

sub g_pattern_spec_new (Str $pattern)
  returns GPatternSpec
  is native(glib)
  is export
{ * }
