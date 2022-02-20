use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::CellRendererPixbuf:ver<3.0.1146>;

sub gtk_cell_renderer_pixbuf_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_pixbuf_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }