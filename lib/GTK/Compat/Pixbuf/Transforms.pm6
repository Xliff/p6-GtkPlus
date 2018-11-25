use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Pixbuf::Transforms;

class GTK::Compat::Pixbuf::Transforms {
  method composite (
    GdkPixbuf() $src,
    GdkPixbuf() $dest,
    Int() $dest_x,
    Int() $dest_y,
    Int() $dest_width,
    Int() $dest_height,
    Num() $offset_x,
    Num() $offset_y,
    Num() $scale_x,
    Num() $scale_y,
    Int() $interp_type,
    Int() $overall_alpha
  ) {
    my @i = ($dest_x, $dest_y, $dest_width, $dest_height, $overall_alpha);
    my gint ($dx, $dy, $dw, $dh, $oa) = resolve-int(@i);
    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);
    my guint $it = resolve-uint($interp_type);
    gdk_pixbuf_composite(
      $src, $dest,
      $dx, $dy, $dw, $dh,
      $ox, $oy,
      $sx, $sy,
      $it, $oa
    );
  }

  method composite_color (
    GdkPixbuf() $src,
    GdkPixbuf() $dest,
    Int() $dest_x,
    Int() $dest_y,
    Int() $dest_width,
    Int() $dest_height,
    Num() $offset_x,
    Num() $offset_y,
    Num() $scale_x,
    Num() $scale_y,
    Int() $interp_type,
    Int() $overall_alpha,
    Int() $check_x,
    Int() $check_y,
    Int() $check_size,
    Int() $color1,
    Int() $color2
  )
    is also<composite-color>
  {
    my @i = (
      $dest_x, $dest_y, $dest_width, $dest_height,
      $overall_alpha,
      $check_x, $check_y, $check_size
    );
    my gint ($dx, $dy, $dw, $dh, $oa, $cx, $cy, $cs) = resolve-int(@i);
    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);
    my @u = ($interp_type, $color1, $color2);
    my guint ($it, $c1, $c2) = resolve-uint(@u);
    gdk_pixbuf_composite_color(
      $src, $dest,
      $dx, $dy, $dw, $dh,
      $ox, $oy,
      $sx, $sy,
      $it,
      $oa,
      $cx, $cy, $cs,
      $c1, $c2
    );
  }

  method composite_color_simple (
    GdkPixbuf() $src,
    Int() $dest_width,
    Int() $dest_height,
    Int() $interp_type,
    Int() $overall_alpha,
    Int() $check_size,
    Int() $color1,
    Int() $color2
  )
    is also<composite-color-simple>
  {
    my @i = ($dest_width, $dest_height, $overall_alpha, $check_size);
    my gint ($dw, $dh, $oa, $cs) = resolve-int(@i);
    my @u = ($interp_type, $color1, $color2);
    my guint ($it, $c1, $c2) = resolve-uint(@u);
    gdk_pixbuf_composite_color_simple(
      $src, $dw, $dh, $it, $oa, $cs, $c1, $c2
    );
  }

  method flip (GdkPixbuf() $src, Int() $horizontal) {
    my gboolean $h = resolve-bool($horizontal);
    gdk_pixbuf_flip($src, $h);
  }

  method rotate_simple (GdkPixbuf() $src, Int() $angle)
    is also<rotate-simple>
  {
    my guint $a = self.RESOLVE-UINT($angle);
    gdk_pixbuf_rotate_simple($src, $angle);
  }

  method scale (
    GdkPixbuf() $src,
    GdkPixbuf() $dest,
    Int() $dest_x,
    Int() $dest_y,
    Int() $dest_width,
    Int() $dest_height,
    Num() $offset_x,
    Num() $offset_y,
    Num() $scale_x,
    Num() $scale_y,
    Int() $interp_type
  ) {
    my @i = ($dest_x, $dest_y, $dest_width, $dest_height);
    my gint ($dx, $dy, $dw, $dh) = resolve-int(@i);
    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);
    my guint $it = resolve-uint($interp_type);
    gdk_pixbuf_scale(
      $src, $dest,
      $dx, $dy, $dw, $dh,
      $ox, $oy,
      $sx, $sy,
      $it
    );
  }

  method scale_simple (
    GdkPixbuf() $src,
    Int() $dest_width,
    Int() $dest_height,
    Int() $interp_type
  )
    is also<scale-simple>
  {
    my @i = ($dest_width, $dest_height);
    my gint ($dw, $dh) = resolve-int(@i);
    my guint $it = resolve-uint($interp_type);
    gdk_pixbuf_scale_simple($src, $dw, $dh, $it);
  }
}
