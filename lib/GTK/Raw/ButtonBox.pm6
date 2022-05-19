use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::ButtonBox:ver<3.0.1146>;

sub gtk_button_box_get_child_non_homogeneous (
  GtkButtonBox $widget,
  GtkWidget $child
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_button_box_get_child_secondary (
  GtkButtonBox $widget,
  GtkWidget $child
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_button_box_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_button_box_new (
  uint32 $orientation           # GtkOrientation $orientation
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_button_box_set_child_non_homogeneous (
  GtkButtonBox $widget,
  GtkWidget $child,
  gboolean $non_homogeneous
)
  is native(gtk)
  is export
  { * }

sub gtk_button_box_set_child_secondary (
  GtkButtonBox $widget,
  GtkWidget $child,
  gboolean $is_secondary
)
  is native(gtk)
  is export
  { * }

sub gtk_button_box_get_layout (GtkButtonBox $widget)
  returns uint32 # GtkButtonBoxStyle
  is native(gtk)
  is export
  { * }

sub gtk_button_box_set_layout (
  GtkButtonBox $widget,
  uint32 $layout_style           # GtkButtonBoxStyle $layout_style
)
  is native(gtk)
  is export
  { * }