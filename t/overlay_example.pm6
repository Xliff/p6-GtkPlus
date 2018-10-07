use v6.c;

use NativeCall;

use GTK::Compat::Types;

sub cairo_create(cairo_surface_t $target)
  returns cairo_t
  is export
  is native(libcairo)
  { * }

sub cairo_image_surface_create (
  uint32 $format                # cairo_format_t $format,
  gint $width,
  gint $height
);
  returns cairo_surface_t
  is export
  is native(libcairo)
  { * }

sub cairo_stroke (cairo_t $cr)
  is export
  is native(libcairo)
  { * }

sub cairo_paint (cairo_t $cr)
  is export
  is native(libcairo)
  { * }

sub cairo_set_source_rgba (
  cairo_t $cr,
  gdouble $red,
  gdouble $green,
  gdouble $blue,
  gdouble $alpha
)
  is export
  is native(libcairo)
  { * }

sub cairo_set_operator (
  cairo_t $cr,
  cairo_operator_t $op
)
  is export
  is native(libcairo)
  { * }

sub cairo_set_source_surface (
  cairo_t $cr,
  cairo_surface_t $surface,
  gdouble $x,
  gdouble $y
)
  is export
  is native(libcairo)
  { * }

sub cairo_move_to (
  cairo_t $cr,
  gdouble $x,
  gdouble $y
)
  is export
  is native(libcairo)
  { * }

sub cairo_line_to (
  cairo_t $cr,
  gdouble $x,
  gdouble $y
)
  is export
  is native(libcairo)
  { * }
