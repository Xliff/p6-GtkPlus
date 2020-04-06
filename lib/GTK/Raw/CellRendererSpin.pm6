use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::CellRendererSpin;

sub gtk_cell_renderer_spin_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_spin_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }