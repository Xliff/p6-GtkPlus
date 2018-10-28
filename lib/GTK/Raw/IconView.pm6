use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::IconView;

sub gtk_icon_view_convert_widget_to_bin_window_coords (
  GtkIconView $icon_view,
  gint $wx,
  gint $wy,
  gint $bx,
  gint $by
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_create_drag_icon (GtkIconView $icon_view, GtkTreePath $path)
  returns cairo_surface_t
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_enable_model_drag_dest (
  GtkIconView $icon_view,
  GtkTargetEntry $targets,
  gint $n_targets,
  guint $actions                # GdkDragAction $actions
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_enable_model_drag_source (
  GtkIconView $icon_view,
  guint $sbm,                   # GdkModifierType $start_button_mask,
  GtkTargetEntry $targets,
  gint $n_targets,
  guint $actions                # GdkDragAction $actions
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_cell_rect (
  GtkIconView $icon_view,
  GtkTreePath $path,
  GtkCellRenderer $cell,
  GdkRectangle $rect
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_cursor (
  GtkIconView $icon_view,
  GtkTreePath $path,
  GtkCellRenderer $cell
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_dest_item_at_pos (
  GtkIconView $icon_view,
  gint $drag_x,
  gint $drag_y,
  GtkTreePath $path,
  guint $pos                    # GtkIconViewDropPosition $pos
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_drag_dest_item (
  GtkIconView $icon_view,
  GtkTreePath $path,
  guint $pos                    # GtkIconViewDropPosition $pos
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_item_at_pos (
  GtkIconView $icon_view,
  gint $x,
  gint $y,
  GtkTreePath $path,
  GtkCellRenderer $cell
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_item_column (GtkIconView $icon_view, GtkTreePath $path)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_item_row (GtkIconView $icon_view, GtkTreePath $path)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_path_at_pos (GtkIconView $icon_view, gint $x, gint $y)
  returns GtkTreePath
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_selected_items (GtkIconView $icon_view)
  returns GList
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_tooltip_context (
  GtkIconView $icon_view,
  gint $x,
  gint $y,
  gboolean $keyboard_tip,
  GtkTreeModel $model,
  GtkTreePath $path,
  GtkTreeIter $iter
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_visible_range (
  GtkIconView $icon_view,
  GtkTreePath $start_path,
  GtkTreePath $end_path
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_item_activated (GtkIconView $icon_view, GtkTreePath $path)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_new_with_area (GtkCellArea $area)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_new_with_model (GtkTreeModel $model)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_path_is_selected (
  GtkIconView $icon_view,
  GtkTreePath $path
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_scroll_to_path (
  GtkIconView $icon_view,
  GtkTreePath $path,
  gboolean $use_align,
  gfloat $row_align,
  gfloat $col_align
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_select_all (GtkIconView $icon_view)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_select_path (GtkIconView $icon_view, GtkTreePath $path)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_selected_foreach (
  GtkIconView $icon_view,
  GtkIconViewForeachFunc $func,
  gpointer $data
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_cursor (
  GtkIconView $icon_view,
  GtkTreePath $path,
  GtkCellRenderer $cell,
  gboolean $start_editing
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_drag_dest_item (
  GtkIconView $icon_view,
  GtkTreePath $path,
  guint $pos                    # GtkIconViewDropPosition $pos
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_tooltip_cell (
  GtkIconView $icon_view,
  GtkTooltip $tooltip,
  GtkTreePath $path,
  GtkCellRenderer $cell
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_tooltip_item (
  GtkIconView $icon_view,
  GtkTooltip $tooltip,
  GtkTreePath $path
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_unselect_all (GtkIconView $icon_view)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_unselect_path (GtkIconView $icon_view, GtkTreePath $path)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_unset_model_drag_dest (GtkIconView $icon_view)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_unset_model_drag_source (GtkIconView $icon_view)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_row_spacing (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_selection_mode (GtkIconView $icon_view)
  returns uint32 # GtkSelectionMode
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_item_orientation (GtkIconView $icon_view)
  returns uint32 # GtkOrientation
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_activate_on_single_click (GtkIconView $icon_view)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_item_width (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_pixbuf_column (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_columns (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_column_spacing (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_text_column (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_spacing (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_model (GtkIconView $icon_view)
  returns GtkTreeModel
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_tooltip_column (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_reorderable (GtkIconView $icon_view)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_markup_column (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_item_padding (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_get_margin (GtkIconView $icon_view)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_row_spacing (GtkIconView $icon_view, gint $row_spacing)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_selection_mode (
  GtkIconView $icon_view,
  uint32 $m                     # GtkSelectionMode $mode
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_item_orientation (
  GtkIconView $icon_view,
  uint32 $o                     # GtkOrientation $orientation
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_activate_on_single_click (
  GtkIconView $icon_view,
  gboolean $single
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_item_width (GtkIconView $icon_view, gint $item_width)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_pixbuf_column (GtkIconView $icon_view, gint $column)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_columns (GtkIconView $icon_view, gint $columns)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_column_spacing (
  GtkIconView $icon_view,
  gint $column_spacing
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_text_column (GtkIconView $icon_view, gint $column)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_spacing (GtkIconView $icon_view, gint $spacing)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_model (GtkIconView $icon_view, GtkTreeModel $model)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_tooltip_column (GtkIconView $icon_view, gint $column)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_reorderable (
  GtkIconView $icon_view,
  gboolean $reorderable
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_markup_column (GtkIconView $icon_view, gint $column)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_item_padding (
  GtkIconView $icon_view,
  gint $item_padding
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_icon_view_set_margin (GtkIconView $icon_view, gint $margin)
  is native($LIBGTK)
  is export
  { * }