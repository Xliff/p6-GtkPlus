use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::CellRendererToggle:ver<3.0.1146>;

sub gtk_cell_renderer_toggle_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_new ()
  returns GtkCellRenderer
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_get_active (GtkCellRendererToggle $toggle)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_get_activatable (GtkCellRendererToggle $toggle)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_get_radio (GtkCellRendererToggle $toggle)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_set_active (
  GtkCellRendererToggle $toggle,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_set_activatable (
  GtkCellRendererToggle $toggle,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }

sub gtk_cell_renderer_toggle_set_radio (
  GtkCellRendererToggle $toggle,
  gboolean $radio
)
  is native(gtk)
  is export
  { * }