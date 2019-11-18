use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Visual;

class GTK::Compat::Visual {
  has GdkVisual $!vis is implementor;

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
  method gdk_list_visuals
    is DEPRECATED('GDK::Screen.get_default')
    is also<gdk-list-visuals>
  {
    gdk_list_visuals();
  }

  method gdk_query_depths (gint $count) is also<gdk-query-depths> {
    gdk_query_depths($!vis, $count);
  }

  method gdk_query_visual_types (gint $count)
    is DEPRECATED(
      'GDK::Screen.get_system_visuals and GDK::Screen.get_rgba_visible'
    )
    is also<gdk-query-visual-types>
  {
    gdk_query_visual_types($!vis, $count);
  }

  method get_best is also<get-best> {
    gdk_visual_get_best();
  }

  method get_best_depth is also<get-best-depth> {
    gdk_visual_get_best_depth();
  }

  method get_best_type is also<get-best-type> {
    gdk_visual_get_best_type();
  }

  method get_best_with_both (GdkVisualType $visual_type)
    is also<get-best-with-both>
  {
    gdk_visual_get_best_with_both($!vis, $visual_type);
  }

  method get_best_with_depth is also<get-best-with-depth> {
    gdk_visual_get_best_with_depth($!vis);
  }

  method get_best_with_type is also<get-best-with-type> {
    gdk_visual_get_best_with_type($!vis);
  }

  method get_bits_per_rgb is DEPRECATED is also<get-bits-per-rgb> {
    gdk_visual_get_bits_per_rgb($!vis);
  }

  method get_blue_pixel_details (
    guint32 $mask,
    gint $shift,
    gint $precision
  )
    is also<get-blue-pixel-details>
  {
    gdk_visual_get_blue_pixel_details($!vis, $mask, $shift, $precision);
  }

  # method get_byte_order {
  #   gdk_visual_get_byte_order($!vis);
  # }

  # method get_colormap_size {
  #   gdk_visual_get_colormap_size($!vis);
  # }

  method get_depth is also<get-depth> {
    gdk_visual_get_depth($!vis);
  }

  method get_green_pixel_details (
    guint32 $mask,
    gint $shift,
    gint $precision
  )
    is also<get-green-pixel-details>
  {
    gdk_visual_get_green_pixel_details($!vis, $mask, $shift, $precision);
  }

  method get_red_pixel_details (
    guint32 $mask,
    gint $shift,
    gint $precision
  )
    is also<get-red-pixel-details>
  {
    gdk_visual_get_red_pixel_details($!vis, $mask, $shift, $precision);
  }

  method get_screen is also<get-screen> {
    gdk_visual_get_screen($!vis);
  }

  method get_system is also<get-system> {
    gdk_visual_get_system();
  }

  method get_type is also<get-type> {
    gdk_visual_get_type();
  }

  method get_visual_type is also<get-visual-type> {
    gdk_visual_get_visual_type($!vis);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
