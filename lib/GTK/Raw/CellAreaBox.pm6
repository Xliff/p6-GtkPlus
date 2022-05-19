use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CellAreaBox:ver<3.0.1146>;

sub gtk_cell_area_box_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_box_new ()
  returns GtkCellArea
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_box_pack_end (
  GtkCellAreaBox $box,
  GtkCellRenderer $renderer,
  gboolean $expand,
  gboolean $align,
  gboolean $fixed
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_box_pack_start (
  GtkCellAreaBox $box,
  GtkCellRenderer $renderer,
  gboolean $expand,
  gboolean $align,
  gboolean $fixed
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_box_get_spacing (GtkCellAreaBox $box)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_cell_area_box_set_spacing (GtkCellAreaBox $box, gint $spacing)
  is native(gtk)
  is export
  { * }