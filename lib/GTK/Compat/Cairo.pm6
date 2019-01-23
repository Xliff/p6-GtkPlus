use v6.c;

use Cairo;
use Method::Also;
use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Compat::Raw::Cairo;

use GTK::Raw::Utils;

class GTK::Compat::Cairo {

  method create (GdkWindow() $window) {
    gdk_cairo_create($window);
  }

  method draw_from_gl (
    Cairo::cairo_t $cr,
    GdkWindow() $window,
    Int() $source,
    Int() $source_type,
    Int() $buffer_scale,
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  )
    is also<draw-from-gl>
  {
    my @i = ($source, $source_type, $buffer_scale, $x, $y, $width, $height);
    my gint ($s, $st, $bs, $xx, $yy, $w, $h) = resolve-int(@i);
    gdk_cairo_draw_from_gl($cr, $window, $s, $st, $bs, $xx, $yy, $w, $h);
  }

  method get_clip_rectangle (Cairo::cairo_t $cr, GdkRectangle() $rect)
    is also<get-clip-rectangle>
  {
    gdk_cairo_get_clip_rectangle($cr, $rect);
  }

  method get_drawing_context (Cairo::cairo_t $cr)
    is also<get-drawing-context>
  {
    gdk_cairo_get_drawing_context($cr);
  }

  method rectangle (Cairo::cairo_t $cr, GdkRectangle() $rectangle) {
    gdk_cairo_rectangle($cr, $rectangle);
  }

  method region (Cairo::cairo_t $cr, cairo_region_t $region) {
    gdk_cairo_region($cr, $region);
  }

  method region_create_from_surface (Cairo::cairo_surface_t $surface)
    is also<region-create-from-surface>
  {
    gdk_cairo_region_create_from_surface($surface);
  }

  # method set_source_color (Cairo::cairo_t $cr, GdkColor $color) {
  #   gdk_cairo_set_source_color($cr, $color);
  # }

  method set_source_pixbuf (
    Cairo::cairo_t $cr,
    GdkPixbuf() $pixbuf,
    Num() $pixbuf_x,
    Num() $pixbuf_y
  )
    is also<set-source-pixbuf>
  {
    my gdouble ($px, $py) = ($pixbuf_x, $pixbuf_y);
    gdk_cairo_set_source_pixbuf($cr, $pixbuf, $px, $py);
  }

  method set_source_rgba (Cairo::cairo_t $cr, GdkRGBA $rgba)
    is also<set-source-rgba>
  {
    gdk_cairo_set_source_rgba($cr, $rgba);
  }

  method set_source_window (
    Cairo::cairo_t $cr,
    GdkWindow() $window,
    Num() $x,
    Num() $y
  )
    is also<set-source-window>
  {
    my gdouble ($xx, $yy) = ($x, $y);
    gdk_cairo_set_source_window($cr, $window, $xx, $yy);
  }

  method surface_create_from_pixbuf (
    GdkPixbuf() $pixbuf,
    Int() $scale,
    GdkWindow() $for_window
  )
    is also<surface-create-from-pixbuf>
  {
    my gint $s = resolve-int($scale);
    gdk_cairo_surface_create_from_pixbuf($pixbuf, $s, $for_window);
  }

}
