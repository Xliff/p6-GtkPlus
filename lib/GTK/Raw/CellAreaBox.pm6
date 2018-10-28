use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CellAreaBox;

sub gtk_cell_area_box_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_cell_area_box_new ()
  returns GtkCellArea
  is native($LIBGTK)
  is export
  { * }

sub gtk_cell_area_box_pack_end (
  GtkCellAreaBox $box,
  GtkCellRenderer $renderer,
  gboolean $expand,
  gboolean $align,
  gboolean $fixed
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_cell_area_box_pack_start (
  GtkCellAreaBox $box,
  GtkCellRenderer $renderer,
  gboolean $expand,
  gboolean $align,
  gboolean $fixed
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_cell_area_box_get_spacing (GtkCellAreaBox $box)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_cell_area_box_set_spacing (GtkCellAreaBox $box, gint $spacing)
  is native($LIBGTK)
  is export
  { * }