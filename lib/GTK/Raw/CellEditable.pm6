use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::CellEditable;

sub gtk_cell_editable_editing_done (GtkCellEditable $cell_editable)
  is native(gtk)
  is export
  { * }

sub gtk_cell_editable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_editable_remove_widget (GtkCellEditable $cell_editable)
  is native(gtk)
  is export
  { * }

sub gtk_cell_editable_start_editing (
  GtkCellEditable $cell_editable,
  GdkEvent $event
)
  is native(gtk)
  is export
  { * }