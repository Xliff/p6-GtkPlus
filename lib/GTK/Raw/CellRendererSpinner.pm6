use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::CellRendererSpinner;

sub gtk_cell_renderer_spinner_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_spinner_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }