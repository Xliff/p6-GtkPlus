use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CellRendererCombo:ver<3.0.1146>;

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

sub raw_set_cellrenderercombo_model(
  GtkCellRendererCombo,
  Str,
  GtkTreeModel,
  Str
)
  is native(gobject)
  is symbol('g_object_set')
  is export
  { * }
