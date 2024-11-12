use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::ListBox:ver<3.0.1146>;

sub gtk_list_box_bind_model (
  GtkListBox $box,
  GListModel $model,
             &create_widget_func (Pointer, Pointer --> GtkWidget),
  gpointer   $user_data,
             &user_data_free_func (gpointer)
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_drag_highlight_row (GtkListBox $box, GtkListBoxRow $row)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_drag_unhighlight_row (GtkListBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_row_at_index (GtkListBox $box, gint $index)
  returns GtkListBoxRow
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_row_at_y (GtkListBox $box, gint $y)
  returns GtkListBoxRow
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_selected_row (GtkListBox $box)
  returns GtkListBoxRow
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_selected_rows (GtkListBox $box)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_list_box_insert (GtkListBox $box, GtkWidget $child, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_invalidate_filter (GtkListBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_invalidate_headers (GtkListBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_invalidate_sort (GtkListBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_list_box_prepend (GtkListBox $box, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_changed (GtkListBoxRow $row)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_get_index (GtkListBoxRow $row)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_is_selected (GtkListBoxRow $row)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_list_box_select_all (GtkListBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_select_row (GtkListBox $box, GtkListBoxRow $row)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_selected_foreach (
  GtkListBox $box,
             &func (GtkListBox, GtkListBoxRow, gpointer),
  gpointer   $data
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_filter_func (
  GtkListBox $box,
             &filter_func (GtkListBoxRow, gpointer --> gboolean),
  gpointer   $user_data,
             &destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_header_func (
  GtkListBox $box,
             &update_header (GtkListBoxRow, GtkListBoxRow, Pointer),
  gpointer   $user_data,
             &destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_placeholder (GtkListBox $box, GtkWidget $placeholder)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_sort_func (
  GtkListBox $box,
             &sort_func (GtkListBoxRow, GtkListBoxRow, Pointer --> gint),
  gpointer   $user_data,
             &destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_unselect_all (GtkListBox $box)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_unselect_row (GtkListBox $box, GtkListBoxRow $row)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_adjustment (GtkListBox $box)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_get_header (GtkListBoxRow $row)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_get_activatable (GtkListBoxRow $row)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_get_selectable (GtkListBoxRow $row)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_selection_mode (GtkListBox $box)
  returns uint32 # GtkSelectionMode
  is native(gtk)
  is export
  { * }

sub gtk_list_box_get_activate_on_single_click (GtkListBox $box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_adjustment (GtkListBox $box, GtkAdjustment $adjustment)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_set_header (GtkListBoxRow $row, GtkWidget $header)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_set_activatable (
  GtkListBoxRow $row,
  gboolean      $activatable
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_row_set_selectable (
  GtkListBoxRow $row,
  gboolean      $selectable
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_selection_mode (
  GtkListBox $box,
  uint32     $mode                  # GtkSelectionMode $mode
)
  is native(gtk)
  is export
  { * }

sub gtk_list_box_set_activate_on_single_click (
  GtkListBox $box,
  gboolean   $single
)
  is native(gtk)
  is export
  { * }
