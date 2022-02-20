use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::TreeViewColumn:ver<3.0.1146>;

sub gtk_tree_view_column_add_attribute (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell_renderer,
  gchar $attribute,
  gint $column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_cell_get_position (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell_renderer,
  gint $x_offset,
  gint $width
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_cell_get_size (
  GtkTreeViewColumn $tree_column,
  GdkRectangle $cell_area,
  gint $x_offset,
  gint $y_offset,
  gint $width,
  gint $height
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_cell_is_visible (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_cell_set_cell_data (
  GtkTreeViewColumn $tree_column,
  GtkTreeModel $tree_model,
  GtkTreeIter $iter,
  gboolean $is_expander,
  gboolean $is_expanded
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_clear (GtkTreeViewColumn $tree_column)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_clear_attributes (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell_renderer
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_clicked (GtkTreeViewColumn $tree_column)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_focus_cell (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_button (GtkTreeViewColumn $tree_column)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_tree_view (GtkTreeViewColumn $tree_column)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_width (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_x_offset (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_new ()
  returns GtkTreeViewColumn
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_new_with_area (GtkCellArea $area)
  returns GtkTreeViewColumn
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_pack_end (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_pack_start (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_queue_resize (GtkTreeViewColumn $tree_column)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_cell_data_func (
  GtkTreeViewColumn $tree_column,
  GtkCellRenderer $cell_renderer,
  &func (GtkTreeViewColumn, GtkCellRenderer, GtkTreeModel, GtkTreeIter, Pointer),
  gpointer $func_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_clickable (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_max_width (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_sort_column_id (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_min_width (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_reorderable (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_title (GtkTreeViewColumn $tree_column)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_fixed_width (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_sizing (GtkTreeViewColumn $tree_column)
  returns uint32 # GtkTreeViewColumnSizing
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_spacing (GtkTreeViewColumn $tree_column)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_resizable (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_sort_indicator (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_alignment (GtkTreeViewColumn $tree_column)
  returns gfloat
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_widget (GtkTreeViewColumn $tree_column)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_expand (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_visible (GtkTreeViewColumn $tree_column)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_get_sort_order (GtkTreeViewColumn $tree_column)
  returns uint32 # GtkSortType
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_clickable (
  GtkTreeViewColumn $tree_column,
  gboolean $clickable
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_max_width (
  GtkTreeViewColumn $tree_column,
  gint $max_width
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_sort_column_id (
  GtkTreeViewColumn $tree_column,
  gint $sort_column_id
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_min_width (
  GtkTreeViewColumn $tree_column,
  gint $min_width
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_reorderable (
  GtkTreeViewColumn $tree_column,
  gboolean $reorderable
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_title (
  GtkTreeViewColumn $tree_column,
  gchar $title
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_fixed_width (
  GtkTreeViewColumn $tree_column,
  gint $fixed_width
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_sizing (
  GtkTreeViewColumn $tree_column,
  uint32 $type                  # GtkTreeViewColumnSizing $type
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_spacing (
  GtkTreeViewColumn $tree_column,
  gint $spacing
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_resizable (
  GtkTreeViewColumn $tree_column,
  gboolean $resizable
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_sort_indicator (
  GtkTreeViewColumn $tree_column,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_alignment (
  GtkTreeViewColumn $tree_column,
  gfloat $xalign
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_widget (
  GtkTreeViewColumn $tree_column,
  GtkWidget $widget
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_expand (
  GtkTreeViewColumn $tree_column,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_visible (
  GtkTreeViewColumn $tree_column,
  gboolean $visible
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_column_set_sort_order (
  GtkTreeViewColumn $tree_column,
  uint32 $type                  # GtkSortType $order
)
  is native(gtk)
  is export
  { * }
