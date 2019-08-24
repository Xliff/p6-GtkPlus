use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Pixbuf::Transforms;

class GTK::Compat::Pixbuf::Transforms {

  method new(|) {
    my $dieMsg = qq:to/DIE/.subst("\n", ' ');
      GTK::Compat::Pixbuf::Transforms is a static class and does not need
      instantiation.
      DIE

    warn $dieMsg if $DEBUG;

    GTK::Compat::Pixbuf::Transforms;
  }

  method composite (
    GTK::Compat::Pixbuf::Transforms:U:
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
    my gint ($dx, $dy, $dw, $dh, $oa) = resolve-int(
      $dest_x, $dest_y, $dest_width, $dest_height, $overall_alpha
    );
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
    GTK::Compat::Pixbuf::Transforms:U:
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
    my gint ($dx, $dy, $dw, $dh, $oa, $cx, $cy, $cs) = resolve-int(
      $dest_x, $dest_y, $dest_width, $dest_height,
      $overall_alpha,
      $check_x, $check_y, $check_size
    );
    my gdouble ($ox, $oy, $sx, $sy) =
      ($offset_x, $offset_y, $scale_x, $scale_y);
    my guint ($it, $c1, $c2) = resolve-uint($interp_type, $color1, $color2);

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
    GTK::Compat::Pixbuf::Transforms:U:
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
    my gint ($dw, $dh, $oa, $cs) = resolve-int(
      $dest_width, $dest_height, $overall_alpha, $check_size
    );
    my guint ($it, $c1, $c2) = resolve-uint($interp_type, $color1, $color2);

    gdk_pixbuf_composite_color_simple(
      $src, $dw, $dh, $it, $oa, $cs, $c1, $c2
    );
  }

  method flip (
    GTK::Compat::Pixbuf::Transforms:U:
    GdkPixbuf() $src,
    Int() $horizontal
  ) {
    my gboolean $h = resolve-bool($horizontal);

    gdk_pixbuf_flip($src, $h);
  }

  method rotate_simple (
    GTK::Compat::Pixbuf::Transforms:U:
    GdkPixbuf() $src,
    Int() $angle
  )
    is also<rotate-simple>
  {
    my guint $a = self.RESOLVE-UINT($angle);

    gdk_pixbuf_rotate_simple($src, $angle);
  }

  method scale (
    GTK::Compat::Pixbuf::Transforms:U:
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
    my gint ($dx, $dy, $dw, $dh) = resolve-int(
      $dest_x, $dest_y, $dest_width, $dest_height
    );
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
    GTK::Compat::Pixbuf::Transforms:U:
    GdkPixbuf() $src,
    Int() $dest_width,
    Int() $dest_height,
    Int() $interp_type
  )
    is also<scale-simple>
  {
    my gint ($dw, $dh) = resolve-int($dest_width, $dest_height);
    my guint $it = resolve-uint($interp_type);

    gdk_pixbuf_scale_simple($src, $dw, $dh, $it);
  }

}
