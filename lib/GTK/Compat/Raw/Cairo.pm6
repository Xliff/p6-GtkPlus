use v6.c;

use Cairo;
use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Compat::Raw::Cairo;

sub gdk_cairo_create (GdkWindow $window)
  returns Cairo::cairo_t
  is native(gdk)
  is export
  { * }

sub gdk_cairo_draw_from_gl (
  Cairo::cairo_t $cr,
  GdkWindow $window,
  gint $source,
  gint $source_type,
  gint $buffer_scale,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_get_clip_rectangle (Cairo::cairo_t $cr, GdkRectangle $rect)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_cairo_get_drawing_context (Cairo::cairo_t $cr)
  returns GdkDrawingContext
  is native(gdk)
  is export
  { * }

sub gdk_cairo_rectangle (Cairo::cairo_t $cr, GdkRectangle $rectangle)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_region (Cairo::cairo_t $cr, cairo_region_t $region)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_region_create_from_surface (Cairo::cairo_surface_t $surface)
  returns cairo_region_t
  is native(gdk)
  is export
  { * }

sub gdk_cairo_set_source_color (Cairo::cairo_t $cr, GdkColor $color)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_set_source_pixbuf (
  Cairo::cairo_t $cr,
  GdkPixbuf $pixbuf,
  gdouble $pixbuf_x,
  gdouble $pixbuf_y
)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_set_source_rgba (Cairo::cairo_t $cr, GdkRGBA $rgba)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_set_source_window (
  Cairo::cairo_t $cr,
  GdkWindow $window,
  gdouble $x,
  gdouble $y
)
  is native(gdk)
  is export
  { * }

sub gdk_cairo_surface_create_from_pixbuf (
  GdkPixbuf $pixbuf,
  gint $scale,
  GdkWindow $for_window
)
  returns Cairo::cairo_surface_t
  is native(gdk)
  is export
  { * }
