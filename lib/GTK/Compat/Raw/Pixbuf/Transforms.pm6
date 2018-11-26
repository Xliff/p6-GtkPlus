use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Pixbuf::Transforms;

sub gdk_pixbuf_composite (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  gint $dest_x,
  gint $dest_y,
  gint $dest_width,
  gint $dest_height,
  gdouble $offset_x,
  gdouble $offset_y,
  gdouble $scale_x,
  gdouble $scale_y,
  uint32 $interp_type,            # GdkInterpType $interp_type,
  gint $overall_alpha
)
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_composite_color (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  gint $dest_x,
  gint $dest_y,
  gint $dest_width,
  gint $dest_height,
  gdouble $offset_x,
  gdouble $offset_y,
  gdouble $scale_x,
  gdouble $scale_y,
  uint32 $interp_type,            # GdkInterpType $interp_type,
  gint $overall_alpha,
  gint $check_x,
  gint $check_y,
  gint $check_size,
  guint32 $color1,
  guint32 $color2
)
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_composite_color_simple (
  GdkPixbuf $src,
  gint $dest_width,
  gint $dest_height,
  uint32 $interp_type,            # GdkInterpType $interp_type,
  gint $overall_alpha,
  gint $check_size,
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

sub gdk_pixbuf_rotate_simple (GdkPixbuf $src, uint32 $angle)
  returns GdkPixbuf
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_scale (
  GdkPixbuf $src,
  GdkPixbuf $dest,
  gint $dest_x,
  gint $dest_y,
  gint $dest_width,
  gint $dest_height,
  gdouble $offset_x,
  gdouble $offset_y,
  gdouble $scale_x,
  gdouble $scale_y,
  uint32 $interp_type             # GdkInterpType $interp_type,
)
  is native(gdk)
  is export
  { * }

sub gdk_pixbuf_scale_simple (
  GdkPixbuf $src,
  gint $dest_width,
  gint $dest_height,
  uint32 $interp_type             # GdkInterpType $interp_type,
)
  returns GdkPixbuf
  is native(gdk)
  is export
  { * }
