use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CellLayout;

sub gtk_cell_layout_add_attribute (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gchar $attribute,
  gint $column
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_clear (GtkCellLayout $cell_layout)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_clear_attributes (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_get_area (GtkCellLayout $cell_layout)
  returns GtkCellArea
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_get_cells (GtkCellLayout $cell_layout)
  returns GList
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_pack_end (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gboolean $expand
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_pack_start (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gboolean $expand
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_reorder (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  gint $position
)
  is native('gtk-3')
  is export
  { * }

sub gtk_cell_layout_set_cell_data_func (
  GtkCellLayout $cell_layout,
  GtkCellRenderer $cell,
  GtkCellLayoutDataFunc $func,
  gpointer $func_data,
  GDestroyNotify $destroy
)
  is native('gtk-3')
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
  is native('gtk-3')
  is export
  { * }
