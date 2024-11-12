use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::CellArea:ver<3.0.1146>;

sub gtk_cell_area_activate (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  GdkRectangle $cell_area,
  uint32 $flags,                # GtkCellRendererState $flags,
  gboolean $edit_only
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_activate_cell (
  GtkCellArea $area,
  GtkWidget $widget,
  GtkCellRenderer $renderer,
  GdkEvent $event,
  GdkRectangle $cell_area,
  uint32 $flags                 # GtkCellRendererState $flags
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_add (GtkCellArea $area, GtkCellRenderer $renderer)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_add_focus_sibling (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  GtkCellRenderer $sibling
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_apply_attributes (
  GtkCellArea $area,
  GtkTreeModel $tree_model,
  GtkTreeIter $iter,
  gboolean $is_expander,
  gboolean $is_expanded
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_attribute_connect (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $attribute,
  gint $column
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_attribute_disconnect (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $attribute
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_attribute_get_column (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $attribute
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_cell_get_property (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $property_name,
  GValue $value
)
  is native(gtk)
  is export
  { * }

# sub gtk_cell_area_cell_get_valist (
#   GtkCellArea $area,
#   GtkCellRenderer $renderer,
#   Str $first_property_name,
#   va_list $var_args
# )
#   is native(gtk)
#   is export
#   { * }

sub gtk_cell_area_cell_set_property (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $property_name,
  GValue $value
)
  is native(gtk)
  is export
  { * }

# sub gtk_cell_area_cell_set_valist (
#   GtkCellArea $area,
#   GtkCellRenderer $renderer,
#   Str $first_property_name,
#   va_list $var_args
# )
#   is native(gtk)
#   is export
#   { * }

# sub gtk_cell_area_class_find_cell_property (
#   GtkCellAreaClass $aclass,
#    Str $property_name
# )
#   returns GParamSpec
#   is native(gtk)
#   is export
#   { * }

# sub gtk_cell_area_class_install_cell_property (
#   GtkCellAreaClass $aclass,
#   guint $property_id,
#   GParamSpec $pspec
# )
#   is native(gtk)
#   is export
#   { * }

# sub gtk_cell_area_class_list_cell_properties (
#   GtkCellAreaClass $aclass,
#   guint $n_properties
# )
#   returns CArray[GParamSpec]
#   is native(gtk)
#   is export
#   { * }

sub gtk_cell_area_copy_context (
  GtkCellArea $area,
  GtkCellAreaContext $context
)
  returns GtkCellAreaContext
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_create_context (GtkCellArea $area)
  returns GtkCellAreaContext
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_event (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  GdkEvent $event,
  GdkRectangle $cell_area,
  uint32 $flags                 # GtkCellRendererState $flags
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_focus (
  GtkCellArea $area,
  uint32 $direction             # GtkDirectionType $direction
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_foreach (
  GtkCellArea $area,
  GtkCellCallback $callback,
  gpointer $callback_data
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_foreach_alloc (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  GdkRectangle $cell_area,
  GdkRectangle $background_area,
  GtkCellAllocCallback $callback,
  gpointer $callback_data
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_cell_allocation (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  GtkCellRenderer $renderer,
  GdkRectangle $cell_area,
  GdkRectangle $allocation
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_cell_at_position (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  GdkRectangle $cell_area,
  gint $x,
  gint $y,
  GdkRectangle $alloc_area
)
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_current_path_string (GtkCellArea $area)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_edit_widget (GtkCellArea $area)
  returns GtkCellEditable
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_edited_cell (GtkCellArea $area)
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_focus_from_sibling (
  GtkCellArea $area,
  GtkCellRenderer $renderer
)
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_focus_siblings (
  GtkCellArea $area,
  GtkCellRenderer $renderer
)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_preferred_height (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  gint $minimum_height is rw,
  gint $natural_height is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_preferred_height_for_width (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  gint $width,
  gint $minimum_height is rw,
  gint $natural_height is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_preferred_width (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  gint $minimum  is rw,
  gint $natural_width is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_preferred_width_for_height (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  gint $height,
  gint $minimum_width is rw,
  gint $natural_width is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_request_mode (GtkCellArea $area)
  returns uint32 # GtkSizeRequestMode
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_has_renderer (
  GtkCellArea $area,
  GtkCellRenderer $renderer
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_inner_cell_area (
  GtkCellArea $area,
  GtkWidget $widget,
  GdkRectangle $cell_area,
  GdkRectangle $inner_area
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_is_activatable (GtkCellArea $area)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_is_focus_sibling (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  GtkCellRenderer $sibling
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_remove (GtkCellArea $area, GtkCellRenderer $renderer)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_remove_focus_sibling (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  GtkCellRenderer $sibling
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_render (
  GtkCellArea $area,
  GtkCellAreaContext $context,
  GtkWidget $widget,
  Cairo::cairo_t $cr,
  GdkRectangle $background_area,
  GdkRectangle $cell_area,
  uint32 $flags,                # GtkCellRendererState $flags,
  gboolean $paint_focus
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_request_renderer (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  uint32 $orientation,          # GtkOrientation $orientation,
  GtkWidget $widget,
  gint $for_size,
  gint $minimum_size is rw,
  gint $natural_size is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_stop_editing (GtkCellArea $area, gboolean $canceled)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_get_focus_cell (GtkCellArea $area)
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_set_focus_cell (
  GtkCellArea $area,
  GtkCellRenderer $renderer
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_add_with_properties (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $name,
  GValue $value,
  Str
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_cell_set (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $name,
  GValue $value,
  Str
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_cell_get (
  GtkCellArea $area,
  GtkCellRenderer $renderer,
  Str $name,
  GValue $value,
  Str
)
  is native(gtk)
  is export
  { * }
