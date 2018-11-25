use v6.c;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Pixbuf::Transforms;

sub gdk_pixbuf_composite (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  int $dest_x,
  int $dest_y,
  int $dest_width,
  int $dest_height,
  double $offset_x,
  double $offset_y,
  double $scale_x,
  double $scale_y,
  GdkInterpType $interp_type,
  int $overall_alpha
)
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_composite_color (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  int $dest_x,
  int $dest_y,
  int $dest_width,
  int $dest_height,
  double $offset_x,
  double $offset_y,
  double $scale_x,
  double $scale_y,
  GdkInterpType $interp_type,
  int $overall_alpha,
  int $check_x,
  int $check_y,
  int $check_size,
  guint32 $color1,
  guint32 $color2
)
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_composite_color_simple (
  GdkPixbuf $src,
  int $dest_width,
  int $dest_height,
  GdkInterpType $interp_type,
  int $overall_alpha,
  int $check_size,
  guint32 $color1,
  guint32 $color2
)
  returns GdkPixbuf
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_flip (GdkPixbuf $src, gboolean $horizontal)
  returns GdkPixbuf
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_rotate_simple (GdkPixbuf $src, GdkPixbufRotation $angle)
  returns GdkPixbuf
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_scale (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  int $dest_x,
  int $dest_y,
  int $dest_width,
  int $dest_height,
  double $offset_x,
  double $offset_y,
  double $scale_x,
  double $scale_y,
  GdkInterpType $interp_type\
)
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_scale_simple (
  GdkPixbuf $src,
  int $dest_width,
  int $dest_height,
  GdkInterpType $interp_type
)
  returns GdkPixbuf
  is native(gdk)
  is export
  { * }
