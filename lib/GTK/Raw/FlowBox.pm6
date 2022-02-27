use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::FlowBox:ver<3.0.1146>;

sub gtk_flow_box_bind_model (
  GtkFlowBox $box,
  GListModel $model,
  GtkFlowBoxCreateWidgetFunc $create_widget_func,
  gpointer $user_data,
  GDestroyNotify $user_data_free_func
)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_child_changed (GtkFlowBoxChild $child)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_child_get_index (GtkFlowBoxChild $child)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_child_is_selected (GtkFlowBoxChild $child)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_child_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_child_at_index (GtkFlowBox $box, gint $idx)
  returns GtkFlowBoxChild
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_child_at_pos (GtkFlowBox $box, gint $x, gint $y)
  returns GtkFlowBoxChild
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_selected_children (GtkFlowBox $box)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_insert (GtkFlowBox $box, GtkWidget $widget, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_invalidate_filter (GtkFlowBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_invalidate_sort (GtkFlowBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_select_all (GtkFlowBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_select_child (GtkFlowBox $box, GtkFlowBoxChild $child)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_selected_foreach (
  GtkFlowBox $box,
  GtkFlowBoxForeachFunc $func,
  gpointer $data
)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_filter_func (
  GtkFlowBox $box,
  &filter_func (GtkFlowBoxChild, Pointer --> gboolean),
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

# (GtkFlowBox $box, GtkAdjustment $adjustment)
sub gtk_flow_box_set_hadjustment (GtkFlowBox $box, uint32 $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_sort_func (
  GtkFlowBox $box,
  &sort_func (GtkFlowBox, GtkFlowBox, Pointer --> gint),
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gtk)
  is export
  { * }

# (GtkFlowBox $box, GtkAdjustment $adjustment)
sub gtk_flow_box_set_vadjustment (GtkFlowBox $box, uint32 $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_unselect_all (GtkFlowBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_unselect_child (GtkFlowBox $box, GtkFlowBoxChild $child)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_homogeneous (GtkFlowBox $box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_max_children_per_line (GtkFlowBox $box)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_selection_mode (GtkFlowBox $box)
  returns uint32 # GtkSelectionMode
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_column_spacing (GtkFlowBox $box)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_min_children_per_line (GtkFlowBox $box)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_activate_on_single_click (GtkFlowBox $box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_get_row_spacing (GtkFlowBox $box)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_homogeneous (GtkFlowBox $box, gboolean $homogeneous)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_max_children_per_line (
  GtkFlowBox $box,
  guint $n_children
)
  is native(gtk)
  is export
  { * }

# (GtkFlowBox $box, GtkSelectionMode $mode)
sub gtk_flow_box_set_selection_mode (GtkFlowBox $box, uint32 $mode)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_column_spacing (GtkFlowBox $box, guint $spacing)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_min_children_per_line (
  GtkFlowBox $box,
  guint $n_children
)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_activate_on_single_click (
  GtkFlowBox $box,
  gboolean $single
)
  is native(gtk)
  is export
  { * }

sub gtk_flow_box_set_row_spacing (GtkFlowBox $box, guint $spacing)
  is native(gtk)
  is export
  { * }
