use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::Visual;

sub gdk_list_visuals ()
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_query_depths (gint $depths, gint $count)
  is native(gdk)
  is export
  { * }

sub gdk_query_visual_types (
  uint32 $visual_type,            # GdkVisualType $visual_types,
  gint $count
)
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_best ()
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_best_depth ()
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_best_type ()
  returns uint32 # GdkVisualType
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_best_with_both (
  gint $depth,
  uint32 $visual_type             # GdkVisualType $visual_types,
)
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_best_with_depth (gint $depth)
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_best_with_type (
  uint32 $visual_type             # GdkVisualType $visual_types,
)
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_bits_per_rgb (GdkVisual $visual)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_blue_pixel_details (
  GdkVisual $visual,
  guint32 $mask,
  gint $shift,
  gint $precision
)
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_byte_order (GdkVisual $visual)
  returns uint32 # GdkByteOrder
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_colormap_size (GdkVisual $visual)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_depth (GdkVisual $visual)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_green_pixel_details (
  GdkVisual $visual,
  guint32 $mask,
  gint $shift,
  gint $precision
)
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_red_pixel_details (
  GdkVisual $visual,
  guint32 $mask,
  gint $shift,
  gint $precision
)
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_screen (GdkVisual $visual)
  returns GdkScreen
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_system ()
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_visual_get_visual_type (GdkVisual $visual)
  returns uint32 # GdkVisualType
  is native(gdk)
  is export
  { * }
