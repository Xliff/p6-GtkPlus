use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::Cursor;

sub gdk_cursor_get_cursor_type (GdkCursor $cursor)
  returns uint32 # GdkCursorType
  is native(gtk)
  is export
  { * }

sub gdk_cursor_get_display (GdkCursor $cursor)
  returns GdkDisplay
  is native(gtk)
  is export
  { * }

sub gdk_cursor_get_image (GdkCursor $cursor)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gdk_cursor_get_surface (
  GdkCursor $cursor,
  gdouble $x_hot,
  gdouble $y_hot
)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gdk_cursor_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gdk_cursor_new (
  uint32 $cursor_type           #  GdkCursorType $cursor_type
)
  returns GdkCursor
  is native(gtk)
  is export
  { * }

sub gdk_cursor_new_for_display (
  GdkDisplay $display,
  uint32 $cursor_type           #  GdkCursorType $cursor_type
)
  returns GdkCursor
  is native(gtk)
  is export
  { * }

sub gdk_cursor_new_from_name (GdkDisplay $display, gchar $name)
  returns GdkCursor
  is native(gtk)
  is export
  { * }

sub gdk_cursor_new_from_pixbuf (
  GdkDisplay $display,
  GdkPixbuf $pixbuf,
  gint $x,
  gint $y
)
  returns GdkCursor
  is native(gtk)
  is export
  { * }

sub gdk_cursor_new_from_surface (
  GdkDisplay $display,
  cairo_surface_t $surface,
  gdouble $x,
  gdouble $y
)
  returns GdkCursor
  is native(gtk)
  is export
  { * }

sub gdk_cursor_ref (GdkCursor $cursor)
  returns GdkCursor
  is native(gtk)
  is export
  { * }

sub gdk_cursor_unref (GdkCursor $cursor)
  is native(gtk)
  is export
  { * }
