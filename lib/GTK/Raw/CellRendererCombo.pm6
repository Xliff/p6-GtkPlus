use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CellRendererCombo;

sub gtk_cell_renderer_combo_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_combo_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }