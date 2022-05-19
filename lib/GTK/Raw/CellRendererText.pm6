use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CellRendererText:ver<3.0.1146>;

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