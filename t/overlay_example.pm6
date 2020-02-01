use v6.c;

use NativeCall;

use GTK::Raw::Types;

sub image_surface_create(Int() $format, Int() $width, Int() $height)
  is export
{
  my gint ($f, $w, $h) = ($format, $width, $height);
  cairo_image_surface_create($f, $w, $h);
}

sub set_source_rgb (
  cairo_t $cr,
  Num() $red,
  Num() $green,
  Num() $blue,
)
  is export
{
  my gdouble ($r, $g, $b) = ($red, $green, $blue);
  cairo_set_source_rgb($cr, $r, $g, $b);
}

sub set_source_rgba (
  cairo_t $cr,
  Num() $red,
  Num() $green,
  Num() $blue,
  Num() $alpha
)
  is export
{
  my gdouble ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);
  cairo_set_source_rgba($cr, $r, $g, $b, $a);
}

sub set_operator (cairo_t() $cr, Int() $op) is export {
  my guint $o = $op;
  cairo_set_operator($cr, $o);
}

sub set_source_surface (
  cairo_t() $cr,
  cairo_surface_t $surface,
  Num() $x,
  Num() $y
)
  is export
{
  my gdouble ($xx, $yy) = ($x, $y);
  cairo_set_source_surface($cr, $surface, $xx, $yy);
}

sub move_to (cairo_t() $cr, Num() $x, Num() $y)
  is export
{
  my gdouble ($xx, $yy) = ($x, $y);
  cairo_move_to($cr, $xx, $yy);
}

sub line_to (cairo_t() $cr, Num() $x, Num() $y)
  is export
{
  my gdouble ($xx, $yy) = ($x, $y);
  cairo_line_to($cr, $xx, $yy);
}

sub cairo_create(cairo_surface_t $target)
  returns cairo_t
  is export
  is native(cairo)
  { * }

sub cairo_image_surface_create (
  uint32 $format,               # cairo_format_t $format,
  gint $width,
  gint $height
)
  returns cairo_surface_t
  is native(cairo)
  { * }

sub cairo_stroke (cairo_t $cr)
  is export
  is native(cairo)
  { * }

sub cairo_paint (cairo_t $cr)
  is export
  is native(cairo)
  { * }

sub cairo_set_source_rgb (
  cairo_t $cr,
  gdouble $red,
  gdouble $green,
  gdouble $blue
)
  is native(cairo)
  { * }

sub cairo_set_source_rgba (
  cairo_t $cr,
  gdouble $red,
  gdouble $green,
  gdouble $blue,
  gdouble $alpha
)
  is export
  is native(cairo)
  { * }

sub cairo_set_operator (
  cairo_t $cr,
  uint32 $op                    # cairo_operator_t $op
)
  is export
  is native(cairo)
  { * }

sub cairo_set_source_surface (
  cairo_t $cr,
  cairo_surface_t $surface,
  gdouble $x,
  gdouble $y
)
  is export
  is native(cairo)
  { * }

sub cairo_move_to (cairo_t $cr, gdouble $x, gdouble $y)
  is native(cairo)
  { * }

sub cairo_line_to (cairo_t $cr, gdouble $x, gdouble $y)
  is native(cairo)
  { * }
