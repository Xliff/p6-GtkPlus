use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Render;

sub gtk_render_activity (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_arrow (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $angle,
  gdouble $x,
  gdouble $y,
  gdouble $size
)
  is native(gtk)
  is export
  { * }

sub gtk_render_background (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_background_get_clip (
  GtkStyleContext $context,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height,
  GdkRectangle $out_clip
)
  is native(gtk)
  is export
  { * }

sub gtk_render_check (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_expander (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_extension (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height,
  uint32 $gap_side                # GtkPositionType $gap_side
)
  is native(gtk)
  is export
  { * }

sub gtk_render_focus (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_frame (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_frame_gap (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height,
  uint32 $gap_side,               # GtkPositionType $gap_side,
  gdouble $xy0_gap,
  gdouble $xy1_gap
)
  is native(gtk)
  is export
  { * }

sub gtk_render_handle (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_icon (
  GtkStyleContext $context,
  cairo_t $cr,
  GdkPixbuf $pixbuf,
  gdouble $x,
  gdouble $y
)
  is native(gtk)
  is export
  { * }

sub gtk_render_icon_pixbuf (
  GtkStyleContext $context,
  GtkIconSource $source,
  uint32 $size                    # GtkIconSize $size
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_render_icon_surface (
  GtkStyleContext $context,
  cairo_t $cr,
  cairo_surface_t $surface,
  gdouble $x,
  gdouble $y
)
  is native(gtk)
  is export
  { * }

sub gtk_render_layout (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  PangoLayout $layout
)
  is native(gtk)
  is export
  { * }

sub gtk_render_line (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x0,
  gdouble $y0,
  gdouble $x1,
  gdouble $y1
)
  is native(gtk)
  is export
  { * }

sub gtk_render_option (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(gtk)
  is export
  { * }

sub gtk_render_slider (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height,
  uint32 $orientation             # GtkOrientation $orientation
)
  is native(gtk)
  is export
  { * }

sub gtk_render_insertion_cursor (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  uint32 $l,                      # PangoLayout $layout
  gint $i,
  uint32 $d                       # PangoDirection $direction
)
  is native(gtk)
  is export
  { * }
