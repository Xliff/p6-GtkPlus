use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::CellRendererText;

sub gtk_cell_renderer_text_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_text_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_text_set_fixed_height_from_font (
  GtkCellRendererText $renderer,
  gint $number_of_rows
)
  is native(gtk)
  is export
  { * }