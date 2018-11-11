use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Visual;

class GTK::Compat::Visual {
  has GdkVisual $!vis;

  submethod BUILD(:$visual) {
    $!vis = $visual;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method gdk_list_visuals {
    gdk_list_visuals();
  }

  method gdk_query_depths (gint $count) {
    gdk_query_depths($!vis, $count);
  }

  method gdk_query_visual_types (gint $count) {
    gdk_query_visual_types($!vis, $count);
  }

  method get_best {
    gdk_visual_get_best();
  }

  method get_best_depth {
    gdk_visual_get_best_depth();
  }

  method get_best_type {
    gdk_visual_get_best_type();
  }

  method get_best_with_both (GdkVisualType $visual_type) {
    gdk_visual_get_best_with_both($!vis, $visual_type);
  }

  method get_best_with_depth {
    gdk_visual_get_best_with_depth($!vis);
  }

  method get_best_with_type {
    gdk_visual_get_best_with_type($!vis);
  }

  method get_bits_per_rgb {
    gdk_visual_get_bits_per_rgb($!vis);
  }

  method get_blue_pixel_details (
    guint32 $mask,
    gint $shift,
    gint $precision
  ) {
    gdk_visual_get_blue_pixel_details($!vis, $mask, $shift, $precision);
  }

  method get_byte_order {
    gdk_visual_get_byte_order($!vis);
  }

  method get_colormap_size {
    gdk_visual_get_colormap_size($!vis);
  }

  method get_depth {
    gdk_visual_get_depth($!vis);
  }

  method get_green_pixel_details (
    guint32 $mask,
    gint $shift,
    gint $precision
  ) {
    gdk_visual_get_green_pixel_details($!vis, $mask, $shift, $precision);
  }

  method get_red_pixel_details (
    guint32 $mask,
    gint $shift,
    gint $precision
  ) {
    gdk_visual_get_red_pixel_details($!vis, $mask, $shift, $precision);
  }

  method get_screen {
    gdk_visual_get_screen($!vis);
  }

  method get_system {
    gdk_visual_get_system();
  }

  method get_type {
    gdk_visual_get_type();
  }

  method get_visual_type {
    gdk_visual_get_visual_type($!vis);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
