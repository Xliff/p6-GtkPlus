use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::ComboBox:ver<3.0.1146>;

sub gtk_combo_box_get_active_iter (
  GtkComboBox $combo_box,
  GtkTreeIter $iter
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_has_entry (GtkComboBox $combo_box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_popup_accessible (GtkComboBox $combo_box)
  returns Pointer # AtkObject
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_row_separator_func (GtkComboBox $combo_box)
  returns GtkTreeViewRowSeparatorFunc
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_new_with_area (GtkCellArea $area)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_new_with_area_and_entry (GtkCellArea $area)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_new_with_entry ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_new_with_model (GtkTreeModel $model)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_new_with_model_and_entry (GtkTreeModel $model)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_popdown (GtkComboBox $combo_box)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_popup (GtkComboBox $combo_box)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_popup_for_device (
  GtkComboBox $combo_box,
  GdkDevice $device
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_active_iter (
  GtkComboBox $combo_box,
  GtkTreeIter $iter
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_row_separator_func (
  GtkComboBox $combo_box,
  &func (GtkTreeModel, GtkTreeIter, Pointer --> gboolean),
  gpointer $data,
  &destroy (Pointer)
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_model (GtkComboBox $combo_box)
  returns GtkTreeModel
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_entry_text_column (GtkComboBox $combo_box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_column_span_column (GtkComboBox $combo_box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_active (GtkComboBox $combo_box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_add_tearoffs (GtkComboBox $combo_box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_active_id (GtkComboBox $combo_box)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_popup_fixed_width (GtkComboBox $combo_box)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_title (GtkComboBox $combo_box)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_id_column (GtkComboBox $combo_box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_wrap_width (GtkComboBox $combo_box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_row_span_column (GtkComboBox $combo_box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_focus_on_click (GtkComboBox $combo)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_get_button_sensitivity (GtkComboBox $combo_box)
  returns uint32 # GtkSensitivityType
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_model (
  GtkComboBox $combo_box,
  GtkTreeModel $model
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_entry_text_column (
  GtkComboBox $combo_box,
  gint $text_column
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_column_span_column (
  GtkComboBox $combo_box,
  gint $column_span
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_active (GtkComboBox $combo_box, gint $index)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_add_tearoffs (
  GtkComboBox $combo_box,
  gboolean $add_tearoffs
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_active_id (
  GtkComboBox $combo_box,
  gchar $active_id
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_popup_fixed_width (
  GtkComboBox $combo_box,
  gboolean $fixed
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_title (GtkComboBox $combo_box, gchar $title)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_id_column (
  GtkComboBox $combo_box,
  gint $id_column
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_wrap_width (
  GtkComboBox $combo_box,
  gint $width
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_row_span_column (
  GtkComboBox $combo_box,
  gint $row_span
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_focus_on_click (
  GtkComboBox $combo,
  gboolean $focus_on_click
)
  is native(gtk)
  is export
  { * }

sub gtk_combo_box_set_button_sensitivity (
  GtkComboBox $combo_box,
  uint32 $sensitivity           # GtkSensitivityType $sensitivity
)
  is native(gtk)
  is export
  { * }
