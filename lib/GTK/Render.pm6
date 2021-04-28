use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;

use GTK::Raw::Types;
use GTK::Raw::Render;

use GLib::Roles::StaticClass;

class GTK::Render {
  also does GLib::Roles::StaticClass;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activity (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_activity($context, $cr, $xx, $yy, $ww, $hh);
  }

  method arrow  (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $angle,
    Num() $x,
    Num() $y,
    Num() $size
  ) {
    my gdouble ($a, $xx, $yy, $ss) = ($angle, $x, $y, $size);

    gtk_render_arrow($context, $cr, $a, $xx, $yy, $ss);
  }

  method background (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_background($context, $cr, $xx, $yy, $ww, $hh);
  }

  method background_get_clip  (
    GtkStyleContext() $context,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    GdkRectangle() $out_clip
  )
    is also<background-get-clip>
  {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_background_get_clip($context,$xx, $yy, $ww, $hh, $out_clip);
  }

  method check (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_check($context, $cr, $xx, $yy, $ww, $hh);
  }

  method expander (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_expander($context, $cr, $xx, $yy, $ww, $hh);
  }

  method extension (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $gap_side
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);
    my guint $gs = $gap_side;

    gtk_render_extension($context, $cr, $xx, $yy, $ww, $hh, $gs);
  }

  method focus (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_focus($context, $cr, $xx, $yy, $ww, $hh);
  }

  method frame (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_frame($context, $cr, $xx, $yy, $ww, $hh);
  }

  method frame_gap (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $gap_side,
    Num() $xy0_gap,
    Num() $xy1_gap
  )
    is also<frame-gap>
  {
    my gdouble ($xx, $yy, $ww, $hh, $g0, $g1) =
      ($x, $y, $width, $height, $xy0_gap, $xy1_gap);
    my guint $gs = self.$gap_side;

    gtk_render_frame_gap($context, $cr, $xx, $yy, $ww, $hh, $gs, $g0, $g1);
  }

  method handle (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_handle($context, $cr, $xx, $yy, $ww, $hh);
  }

  method icon (
    GtkStyleContext() $context,
    cairo_t $cr,
    GdkPixbuf() $pixbuf,
    Num() $x,
    Num() $y
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gtk_render_icon($context, $cr, $pixbuf, $xx, $yy);
  }

  method icon_pixbuf (
    GtkStyleContext() $context,
    GtkIconSource $source,
    Int() $size
  )
    is also<icon-pixbuf>
  {
    my guint $s = $size;

    gtk_render_icon_pixbuf($context, $source, $s);
  }

  method icon_surface (
    GtkStyleContext() $context,
    cairo_t $cr,
    cairo_surface_t $surface,
    Num() $x,
    Num() $y
  )
    is also<icon-surface>
  {
    my gdouble ($xx, $yy) = ($x, $y);

    gtk_render_icon_surface($context, $cr, $surface, $xx, $yy);
  }

  method insertion_cursor (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    PangoLayout() $l,
    Int() $i,
    Int() $d                  # PangoDirection
  )
    is also<insertion-cursor>
  {
    my gdouble ($xx, $yy) = ($x, $y);
    my guint $dd = $d;
    my gint $ii = $i;

    gtk_render_insertion_cursor($context, $cr, $xx, $yy, $l, $ii, $dd);
  }

  method layout  (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    PangoLayout() $l
  ) {
    my gdouble ($xx, $yy) = ($x, $y);

    gtk_render_layout($context, $cr, $xx, $yy, $l);
  }

  method line (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x0,
    Num() $y0,
    Num() $x1,
    Num() $y1
  ) {
    my gdouble ($xx0, $yy0, $xx1, $yy1) = ($x0, $y0, $x1, $y1);

    gtk_render_line($context, $cr, $xx0, $yy0, $xx1, $yy1);
  }

  method option (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);

    gtk_render_option($context, $cr, $xx, $yy, $ww, $hh);
  }

  method slider (
    GtkStyleContext() $context,
    cairo_t $cr,
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height,
    Int() $orientation
  ) {
    my gdouble ($xx, $yy, $ww, $hh) = ($x, $y, $width, $height);
    my guint $o = $orientation;

    gtk_render_slider($context, $cr, $xx, $yy, $ww, $hh, $o);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
