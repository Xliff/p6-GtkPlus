use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CellRendererAccel:ver<3.0.1146>;

sub gtk_cell_renderer_accel_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_accel_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }