use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TreeView;

# gint  gtk_tree_view_insert_column_with_attributes (
#   GtkTreeView               *tree_view,
#   gint                       position,
#   const gchar               *title,
#   GtkCellRenderer           *cell,
#   ...
# ) G_GNUC_NULL_TERMINATED;

sub gtk_tree_view_append_column (
  GtkTreeView $tree_view,
  GtkTreeViewColumn $column
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_collapse_all (GtkTreeView $tree_view)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_collapse_row (GtkTreeView $tree_view, GtkTreePath $path)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_columns_autosize (GtkTreeView $tree_view)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_convert_bin_window_to_tree_coords (
  GtkTreeView $tree_view,
  gint $bx,
  gint $by,
  gint $tx is rw,
  gint $ty is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_convert_bin_window_to_widget_coords (
  GtkTreeView $tree_view,
  gint $bx,
  gint $by,
  gint $wx is rw,
  gint $wy is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_convert_tree_to_bin_window_coords (
  GtkTreeView $tree_view,
  gint $tx,
  gint $ty,
  gint $bx is rw,
  gint $by is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_convert_widget_to_bin_window_coords (
  GtkTreeView $tree_view,
  gint $wx,
  gint $wy,
  gint $bx is rw,
  gint $by is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_convert_widget_to_tree_coords (
  GtkTreeView $tree_view,
  gint $wx,
  gint $wy,
  gint $tx is rw,
  gint $ty is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_create_row_drag_icon (
  GtkTreeView $tree_view,
  GtkTreePath $path
)
  returns cairo_surface_t
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_enable_model_drag_dest (
  GtkTreeView $tree_view,
  GtkTargetEntry $targets,
  gint $n_targets,
  uint32 $actions               # GdkDragAction $actions
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_enable_model_drag_source (
  GtkTreeView $tree_view,
  uint64 $start_button_mask,    # GdkModifierType $start_button_mask,
  GtkTargetEntry $targets,
  gint $n_targets,
  uint32                        # GdkDragAction $actions
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_expand_all (GtkTreeView $tree_view)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_expand_row (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  gboolean $open_all
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_expand_to_path (
  GtkTreeView $tree_view,
  GtkTreePath $path
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_background_area (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $column,
  GdkRectangle $rect
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_bin_window (GtkTreeView $tree_view)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_cell_area (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $column,
  GdkRectangle $rect
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_column (GtkTreeView $tree_view, gint $n)
  returns GtkTreeViewColumn
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_columns (GtkTreeView $tree_view)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_cursor (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $focus_column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_dest_row_at_pos (
  GtkTreeView $tree_view,
  gint $drag_x,
  gint $drag_y,
  GtkTreePath $path,
  uint32 $pos                   # GtkTreeViewDropPosition $pos
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_drag_dest_row (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  uint32                        # GtkTreeViewDropPosition $pos
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_n_columns (GtkTreeView $tree_view)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_path_at_pos (
  GtkTreeView $tree_view,
  gint $x,
  gint $y,
  GtkTreePath $path,
  GtkTreeViewColumn $column,
  gint $cell_x,
  gint $cell_y
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_row_separator_func (GtkTreeView $tree_view)
  returns GtkTreeViewRowSeparatorFunc
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_search_equal_func (GtkTreeView $tree_view)
  returns GtkTreeViewSearchEqualFunc
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_search_position_func (GtkTreeView $tree_view)
  returns GtkTreeViewSearchPositionFunc
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_selection (GtkTreeView $tree_view)
  returns GtkTreeSelection
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_tooltip_context (
  GtkTreeView $tree_view,
  gint $x,
  gint $y,
  gboolean $keyboard_tip,
  GtkTreeModel $model,
  GtkTreePath $path,
  GtkTreeIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_visible_range (
  GtkTreeView $tree_view,
  GtkTreePath $start_path,
  GtkTreePath $end_path
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_visible_rect (
  GtkTreeView $tree_view,
  GdkRectangle $visible_rect
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_insert_column (
  GtkTreeView $tree_view,
  GtkTreeViewColumn $column,
  gint $position
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_insert_column_with_data_func (
  GtkTreeView $tree_view,
  gint $position,
  gchar $title,
  GtkCellRenderer $cell,
  GtkTreeCellDataFunc $func,
  gpointer $data,
  GDestroyNotify $dnotify
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_is_blank_at_pos (
  GtkTreeView $tree_view,
  gint $x,
  gint $y,
  GtkTreePath $path,
  GtkTreeViewColumn $column,
  gint $cell_x,
  gint $cell_y
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_is_rubber_banding_active (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_map_expanded_rows (
  GtkTreeView $tree_view,
  GtkTreeViewMappingFunc $func,
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_move_column_after (
  GtkTreeView $tree_view,
  GtkTreeViewColumn $column,
  GtkTreeViewColumn $base_column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_new_with_model (GtkTreeModel $model)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_remove_column (
  GtkTreeView $tree_view,
  GtkTreeViewColumn $column
)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_row_activated (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_row_expanded (GtkTreeView $tree_view, GtkTreePath $path)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_scroll_to_cell (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $column,
  gboolean $use_align,
  gfloat $row_align,
  gfloat $col_align
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_scroll_to_point (
  GtkTreeView $tree_view,
  gint $tree_x,
  gint $tree_y
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_column_drag_function (
  GtkTreeView $tree_view,
  GtkTreeViewColumnDropFunc $func,
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_cursor (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $focus_column,
  gboolean $start_editing
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_cursor_on_cell (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  GtkTreeViewColumn $focus_column,
  GtkCellRenderer $focus_cell,
  gboolean $start_editing
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_destroy_count_func (
  GtkTreeView $tree_view,
  GtkTreeDestroyCountFunc $func,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_drag_dest_row (
  GtkTreeView $tree_view,
  GtkTreePath $path,
  uint32 $pos                   # GtkTreeViewDropPosition $pos
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_row_separator_func (
  GtkTreeView $tree_view,
  GtkTreeViewRowSeparatorFunc $func,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_search_equal_func (
  GtkTreeView $tree_view,
  GtkTreeViewSearchEqualFunc $search_equal_func,
  gpointer $search_user_data,
  GDestroyNotify $search_destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_search_position_func (
  GtkTreeView $tree_view,
  GtkTreeViewSearchPositionFunc $func,
  gpointer $data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_tooltip_cell (
  GtkTreeView $tree_view,
  GtkTooltip $tooltip,
  GtkTreePath $path,
  GtkTreeViewColumn $column,
  GtkCellRenderer $cell
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_tooltip_row (
  GtkTreeView $tree_view,
  GtkTooltip $tooltip,
  GtkTreePath $path
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_unset_rows_drag_dest (GtkTreeView $tree_view)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_unset_rows_drag_source (GtkTreeView $tree_view)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_hadjustment (GtkTreeView $tree_view)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_enable_tree_lines (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_expander_column (GtkTreeView $tree_view)
  returns GtkTreeViewColumn
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_headers_clickable (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_reorderable (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_grid_lines (GtkTreeView $tree_view)
  returns uint32 # GtkTreeViewGridLines
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_tooltip_column (GtkTreeView $tree_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_show_expanders (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_model (GtkTreeView $tree_view)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_rules_hint (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_level_indentation (GtkTreeView $tree_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_enable_search (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_activate_on_single_click (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_search_entry (GtkTreeView $tree_view)
  returns GtkEntry
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_search_column (GtkTreeView $tree_view)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_headers_visible (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_vadjustment (GtkTreeView $tree_view)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_fixed_height_mode (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_hover_selection (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_rubber_banding (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_get_hover_expand (GtkTreeView $tree_view)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_hadjustment (
  GtkTreeView $tree_view,
  GtkAdjustment $adjustment
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_enable_tree_lines (
  GtkTreeView $tree_view,
  gboolean $enabled
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_expander_column (
  GtkTreeView $tree_view,
  GtkTreeViewColumn $column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_headers_clickable (
  GtkTreeView $tree_view,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_reorderable (
  GtkTreeView $tree_view,
  gboolean $reorderable
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_grid_lines (
  GtkTreeView $tree_view,
  uint32 $grid_lines            # GtkTreeViewGridLines $grid_lines
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_tooltip_column (GtkTreeView $tree_view, gint $column)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_show_expanders (
  GtkTreeView $tree_view,
  gboolean $enabled
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_model (GtkTreeView $tree_view, GtkTreeModel $model)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_rules_hint (GtkTreeView $tree_view, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_level_indentation (
  GtkTreeView $tree_view,
  gint $indentation
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_enable_search (
  GtkTreeView $tree_view,
  gboolean $enable_search
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_activate_on_single_click (
  GtkTreeView $tree_view,
  gboolean $single
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_search_entry (
  GtkTreeView $tree_view,
  GtkEntry $entry
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_search_column (
  GtkTreeView $tree_view,
  gint $column
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_headers_visible (
  GtkTreeView $tree_view,
  gboolean $headers_visible
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_vadjustment (
  GtkTreeView $tree_view,
  GtkAdjustment $adjustment
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_fixed_height_mode (
  GtkTreeView $tree_view,
  gboolean $enable
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_hover_selection (
  GtkTreeView $tree_view,
  gboolean $hover
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_rubber_banding (
  GtkTreeView $tree_view,
  gboolean $enable
)
  is native(gtk)
  is export
  { * }

sub gtk_tree_view_set_hover_expand (
  GtkTreeView $tree_view,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }