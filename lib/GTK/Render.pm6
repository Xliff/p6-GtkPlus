use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Render;

class GTK::Render {

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activity (
    GtkStyleContext $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_activity($context, $cr, $x, $y, $width, $height);
  }

  method arrow  (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $angle,
    gdouble $x,
    gdouble $y,
    gdouble $size
  ) {
    gtk_render_arrow($context, $cr, $angle, $x, $y, $size);
  }

  method background (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_background($context, $cr, $x, $y, $width, $height);
  }

  method background_get_clip  (
    GtkStyleContext() $context,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GdkRectangle $out_clip
  )
    is also<background-get-clip>
  {
    gtk_render_background_get_clip(
      $context,
      $x, $y,
      $width, $height,
      $out_clip
    );
  }

  method check (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_check($context, $cr, $x, $y, $width, $height);
  }

  method expander (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_expander($context, $cr, $x, $y, $width, $height);
  }

  method extension (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GtkPositionType $gap_side
  ) {
    gtk_render_extension($context, $cr, $x, $y, $width, $height, $gap_side);
  }

  method focus (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_focus($context, $cr, $x, $y, $width, $height);
  }

  method frame (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_frame($context, $cr, $x, $y, $width, $height);
  }

  method frame_gap (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GtkPositionType $gap_side,
    gdouble $xy0_gap,
    gdouble $xy1_gap
  )
    is also<frame-gap>
  {
    gtk_render_frame_gap(
      $context,
      $cr,
      $x, $y,
      $width, $height,
      $gap_side,
      $xy0_gap, $xy1_gap
    );
  }

  method handle (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_handle($context, $cr, $x, $y, $width, $height);
  }

  method icon (
    GtkStyleContext() $context,
    cairo_t $cr,
    GdkPixbuf() $pixbuf,
    gdouble $x,
    gdouble $y
  ) {
    gtk_render_icon($context, $cr, $pixbuf, $x, $y);
  }

  method icon_pixbuf (
    GtkStyleContext() $context,
    GtkIconSource $source,
    GtkIconSize $size
  )
    is also<icon-pixbuf>
  {
    gtk_render_icon_pixbuf($context, $source, $size);
  }

  method icon_surface (
    GtkStyleContext() $context,
    cairo_t $cr,
    cairo_surface_t $surface,
    gdouble $x,
    gdouble $y
  )
    is also<icon-surface>
  {
    gtk_render_icon_surface($context, $cr, $surface, $x, $y);
  }

  method insertion_cursor (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    PangoLayout $l,
    gint $i,
    PangoDirection $d
  )
    is also<insertion-cursor>
  {
    gtk_render_insertion_cursor($context, $cr, $x, $y, $l, $i, $d);
  }

  method layout  (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    PangoLayout $layout
  ) {
    gtk_render_layout($context, $cr, $x, $y, $layout);
  }

  method line (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x0,
    gdouble $y0,
    gdouble $x1,
    gdouble $y1
  ) {
    gtk_render_line($context, $cr, $x0, $y0, $x1, $y1);
  }

  method option (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height
  ) {
    gtk_render_option($context, $cr, $x, $y, $width, $height);
  }

  method slider (
    GtkStyleContext() $context,
    cairo_t $cr,
    gdouble $x,
    gdouble $y,
    gdouble $width,
    gdouble $height,
    GtkOrientation $orientation
  ) {
    gtk_render_slider($context, $cr, $x, $y, $width, $height, $orientation);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
