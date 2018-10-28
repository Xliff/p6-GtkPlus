use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CellRendererSpinner;

sub gtk_cell_renderer_spinner_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_cell_renderer_spinner_new ()
  returns GtkCellRenderer
  is native($LIBGTK)
  is export
  { * }