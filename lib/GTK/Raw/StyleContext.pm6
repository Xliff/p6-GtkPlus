use v6.c;

use NativeCall;

use GDK::RGBA;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;
use Pango::Raw::Types;

unit package GTK::Raw::StyleContext:ver<3.0.1146>;

sub gtk_style_context_add_class (GtkStyleContext $context, Str $class_name)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_add_provider (
  GtkStyleContext $context,
  GtkStyleProvider $provider,
  guint $priority
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_add_provider_for_screen (
  GdkScreen $screen,
  GtkStyleProvider $provider,
  guint $priority
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_add_region (
  GtkStyleContext $context,
  Str $region_name,
  uint32 $flags                 # GtkRegionFlags $flags
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_cancel_animations (
  GtkStyleContext $context,
  gpointer $region_id
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_background_color (
  GtkStyleContext $context,
  uint32 $flags,                # GtkStateFlags $state,
  GdkRGBA $color
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_border (
  GtkStyleContext $context,
  uint32 $flags,                # GtkStateFlags $state,
  GtkBorder $border
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_border_color (
  GtkStyleContext $context,
  uint32 $flags,                # GtkStateFlags $state,
  GdkRGBA $color
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_color (
  GtkStyleContext $context,
  uint32 $flags,                # GtkStateFlags $state,
  GdkRGBA $color
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_font (
  GtkStyleContext $context,
  uint32 $flags                 # GtkStateFlags $state,
)
  returns PangoFontDescription
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_margin (
  GtkStyleContext $context,
  uint32 $flags,                # GtkStateFlags $state,
  GtkBorder $margin
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_padding (
  GtkStyleContext $context,
  uint32 $flags,                # GtkStateFlags $state,
  GtkBorder $padding
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_property (
  GtkStyleContext $context,
  Str $property,
  uint32 $flags,                # GtkStateFlags $state,
  GValue $value
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_section (GtkStyleContext $context, Str $property)
  returns GtkCssSection
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_style_property (
  GtkStyleContext $context,
  Str $property_name,
  GValue $value
)
  is native(gtk)
  is export
  { * }

# sub gtk_style_context_get_style_valist (
#   GtkStyleContext $context,
#   va_list $args
# )
#   is native(gtk)
#   is export
#   { * }

sub gtk_style_context_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

# sub gtk_style_context_get_valist (
#   GtkStyleContext $context,
#   GtkStateFlags $state,
#   va_list $args
# )
#   is native(gtk)
#   is export
#   { * }

sub gtk_draw_insertion_cursor (
  GtkWidget $widget,
  cairo_t $cr,
  GdkRectangle $location,
  gboolean $is_primary,
  uint32 $direction,            # GtkTextDirection $direction,
  gboolean $draw_arrow
)
  is native(gtk)
  is export
  { * }

sub gtk_icon_set_render_icon_pixbuf (
  GtkIconSet $icon_set,
  GtkStyleContext $context,
  uint32 $size                  # GtkIconSize $size
)
  returns GdkPixbuf
  is native(gtk)
  is export
  { * }

sub gtk_icon_set_render_icon_surface (
  GtkIconSet $icon_set,
  GtkStyleContext $context,
  uint32 $size,                 # GtkIconSize $size
  gint $scale,
  GdkWindow $for_window
)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gtk_render_insertion_cursor (
  GtkStyleContext $context,
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  PangoLayout $layout,
  gint $index,
  uint32 $direction             # PangoDirection $direction
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_has_class (
  GtkStyleContext $context,
  Str $class_name
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_style_context_has_region (
  GtkStyleContext $context,
  Str $region_name,
  uint32 $flags                 # GtkRegionFlags $flags_return
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_style_context_invalidate (GtkStyleContext $context)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_list_classes (GtkStyleContext $context)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_style_context_list_regions (GtkStyleContext $context)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_style_context_lookup_color (
  GtkStyleContext $context,
  Str $color_name,
  GdkRGBA $color
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_style_context_lookup_icon_set (
  GtkStyleContext $context,
  Str $stock_id
)
  returns GtkIconSet
  is native(gtk)
  is export
  { * }

sub gtk_style_context_new ()
  returns GtkStyleContext
  is native(gtk)
  is export
  { * }

sub gtk_style_context_notify_state_change (
  GtkStyleContext $context,
  GdkWindow $window,
  gpointer $region_id,
  uint32 $state,                # GtkStateType $state,
  gboolean $state_value
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_pop_animatable_region (GtkStyleContext $context)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_push_animatable_region (
  GtkStyleContext $context,
  gpointer $region_id
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_remove_class (
  GtkStyleContext $context,
  Str $class_name
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_remove_provider (
  GtkStyleContext $context,
  GtkStyleProvider $provider
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_remove_provider_for_screen (
  GdkScreen $screen,
  GtkStyleProvider $provider
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_remove_region (
  GtkStyleContext $context,
  Str $region_name
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_reset_widgets (GdkScreen $screen)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_restore (GtkStyleContext $context)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_save (GtkStyleContext $context)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_scroll_animations (
  GtkStyleContext $context,
  GdkWindow $window,
  gint $dx,
  gint $dy
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_background (
  GtkStyleContext $context,
  GdkWindow $window
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_state_is_running (
  GtkStyleContext $context,
  uint32 $state,                # GtkStateType $state,
  gdouble $progress
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_style_context_to_string (
  GtkStyleContext $context,
  uint32 $flags                 # GtkStyleContextPrintFlags $flags
)
  returns gchar
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_direction (GtkStyleContext $context)
  returns uint32 # GtkTextDirection
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_junction_sides (GtkStyleContext $context)
  returns uint32 # GtkJunctionSides
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_path (GtkStyleContext $context)
  returns GtkWidgetPath
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_state (GtkStyleContext $context)
  returns uint32 # GtkStateFlags
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_scale (GtkStyleContext $context)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_frame_clock (GtkStyleContext $context)
  returns GdkFrameClock
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_parent (GtkStyleContext $context)
  returns GtkStyleContext
  is native(gtk)
  is export
  { * }

sub gtk_style_context_get_screen (GtkStyleContext $context)
  returns GdkScreen
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_direction (
  GtkStyleContext $context,
  uint32 $direction             # GtkTextDirection $direction
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_junction_sides (
  GtkStyleContext $context,
  uint32 $sides                 # GtkJunctionSides $sides
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_path (
  GtkStyleContext $context,
  GtkWidgetPath $path
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_state (
  GtkStyleContext $context,
  uint32 $flags                 # GtkStateFlags $state,
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_scale (GtkStyleContext $context, gint $scale)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_frame_clock (
  GtkStyleContext $context,
  GdkFrameClock $frame_clock
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_parent (
  GtkStyleContext $context,
  GtkStyleContext $parent
)
  is native(gtk)
  is export
  { * }

sub gtk_style_context_set_screen (
  GtkStyleContext $context,
  GdkScreen $screen
)
  is native(gtk)
  is export
  { * }
