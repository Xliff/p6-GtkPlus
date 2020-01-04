use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Visual;

use GDK::Screen;

class GDK::Visual {
  has GdkVisual $!vis is implementor;

  submethod BUILD(:$visual) {
    $!vis = $visual;
  }

  multi method new (GdkVisual $visual) {
    $visual ?? self.bless(:$visual) !! Nil;
  }
  
  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method gdk_query_depths (Int() $count) is also<gdk-query-depths> {
    my gint $c = $count;

    gdk_query_depths($!vis, $c);
  }

  method get_best_depth is also<get-best-depth> {
    gdk_visual_get_best_depth();
  }

  method get_best_type is also<get-best-type> {
    gdk_visual_get_best_type();
  }

  proto method get_blue_pixel_details (|)
    is also<get-blue-pixel-details>
  { * }

  multi method get_blue_pixel_details {
    samewith($, $, $);
  }
  method get_blue_pixel_details (
    $mask      is rw,
    $shift     is rw,
    $precision is rw
  ) {
    my guint32 $m = 0;
    my gint ($s, $p) = 0 xx 2;

    gdk_visual_get_blue_pixel_details($!vis, $m, $s, $p);
    ($mask, $shift, $precision) = ($m, $s, $p);
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

  proto method get_green_pixel_details (|)
    is also<get-green-pixel-details>
  { * }

  multi method get_green_pixel_details {
    samewith($, $, $);
  }
  multi method get_green_pixel_details (
    $mask      is rw,
    $shift     is rw,
    $precision is rw
  ) {
    my guint32 $m = 0;
    my gint ($s, $p) = (0, 0);

    gdk_visual_get_green_pixel_details($!vis, $m, $s, $p);
    ($mask, $shift, $precision) = ($m, $s, $p);
  }

  proto method get_red_pixel_details (|)
    is also<get-red-pixel-details>
  { * }

  multi method get_red_pixel_details {
    samewith($, $, $);
  }
  multi method get_red_pixel_details (
    $mask      is rw,
    $shift     is rw,
    $precision is rw
  )
    is also<get-red-pixel-details>
  {
    my guint32 $m = 0;
    my gint ($s, $p) = (0, 0);

    gdk_visual_get_red_pixel_details($!vis, $m, $s, $p);
    ($mask, $shift, $precision) = ($m, $s, $p);
  }

  method get_screen (:$raw = False) is also<get-screen> {
    my $s = gdk_visual_get_screen($!vis);

    $s ??
      ( $raw ?? $s !! GDK::Screen.new($s) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_visual_get_type, $n, $t );
  }

  method get_visual_type is also<get-visual-type> {
    GdkVisualTypeEnum( gdk_visual_get_visual_type($!vis) );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
