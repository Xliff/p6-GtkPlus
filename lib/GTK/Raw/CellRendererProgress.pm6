use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::CellRendererProgress:ver<3.0.1146>;

sub gtk_cell_renderer_progress_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_progress_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }