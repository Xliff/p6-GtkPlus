use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::CellLayout:ver<3.0.1146>;

sub gtk_cell_layout_add_attribute (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gchar $attribute,
  gint $column
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_clear (GtkCellLayout $cell_layout)
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_clear_attributes (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_get_area (GtkCellLayout $cell_layout)
  returns GtkCellArea
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_get_cells (GtkCellLayout $cell_layout)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_pack_end (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_pack_start (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_reorder (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_layout_set_cell_data_func (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  GtkCellLayoutDataFunc $func,
  gpointer $func_data,
  &destroy (Pointer)
)
  is native(gtk)
  is export
  { * }

#void gtk_cell_layout_set_attributes  (
  # GtkCellLayout         *cell_layout,
  # GtkCellRenderer       *cell,
  #  ...)
sub gtk_cell_layout_set_attributes (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  Str $attribute,
  gint $column,
  Str
)
  is native(gtk)
  is export
  { * }
