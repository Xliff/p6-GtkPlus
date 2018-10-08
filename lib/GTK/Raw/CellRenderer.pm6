use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CellRenderer;

sub gtk_cell_renderer_activate (
  GtkCellRenderer $cell,
  GdkEvent $event,
  GtkWidget $widget,
  gchar $path,
  GdkRectangle $background_area,
  GdkRectangle $cell_area,
  uint32 $flags                 # GtkCellRendererState $flags
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_class_set_accessible_type (
  GtkCellRendererClass $renderer_class,
  GType $type
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_aligned_area (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  uint32 $flags,                # GtkCellRendererState $flags,
  GdkRectangle $cell_area,
  GdkRectangle $aligned_area
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_alignment (
  GtkCellRenderer $cell,
  gfloat $xalign,
  gfloat $yalign
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_fixed_size (
  GtkCellRenderer $cell,
  gint $width,
  gint $height
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_padding (
  GtkCellRenderer $cell,
  gint $xpad,
  gint $ypad
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_preferred_height (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  gint $minimum_size,
  gint $natural_size
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_preferred_height_for_width (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  gint $width,
  gint $minimum_height,
  gint $natural_height
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_preferred_size (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  GtkRequisition $minimum_size,
  GtkRequisition $natural_size
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_preferred_width (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  gint $minimum_size,
  gint $natural_size
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_preferred_width_for_height (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  gint $height,
  gint $minimum_width,
  gint $natural_width
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_request_mode (GtkCellRenderer $cell)
  returns uint32 # GtkSizeRequestMode
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_size (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  GdkRectangle $cell_area,
  gint $x_offset,
  gint $y_offset,
  gint $width,
  gint $height
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_state (
  GtkCellRenderer $cell,
  GtkWidget $widget,
  guint $cell_state             # GtkCellRendererState $cell_state
)
  returns uint32 # GtkStateFlags
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_is_activatable (GtkCellRenderer $cell)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_render (
  GtkCellRenderer $cell,
  cairo_t $cr,
  GtkWidget $widget,
  GdkRectangle $background_area,
  GdkRectangle $cell_area,
  uint32 $flags                 # GtkCellRendererState $flags
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_set_alignment (
  GtkCellRenderer $cell,
  gfloat $xalign,
  gfloat $yalign
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_set_fixed_size (
  GtkCellRenderer $cell,
  gint $width,
  gint $height
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_set_padding (
  GtkCellRenderer $cell,
  gint $xpad,
  gint $ypad
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_start_editing (
  GtkCellRenderer $cell,
  GdkEvent $event,
  GtkWidget $widget,
  gchar $path,
  GdkRectangle $background_area,
  GdkRectangle $cell_area,
  uint32 $flags                 # GtkCellRendererState $flags
)
  returns GtkCellEditable
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_stop_editing (
  GtkCellRenderer $cell,
  gboolean $canceled
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_visible (GtkCellRenderer $cell)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_get_sensitive (GtkCellRenderer $cell)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_set_visible (GtkCellRenderer $cell, gboolean $visible)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_renderer_set_sensitive (GtkCellRenderer $cell, gboolean $sensitive)
  is native('gtk-3')
  is export
  { * }
