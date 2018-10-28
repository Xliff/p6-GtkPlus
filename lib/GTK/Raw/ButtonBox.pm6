use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ButtonBox;

sub gtk_button_box_get_child_non_homogeneous (
  GtkButtonBox $widget,
  GtkWidget $child
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_get_child_secondary (
  GtkButtonBox $widget,
  GtkWidget $child
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_new (
  uint32 $orientation           # GtkOrientation $orientation
)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_set_child_non_homogeneous (
  GtkButtonBox $widget,
  GtkWidget $child,
  gboolean $non_homogeneous
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_set_child_secondary (
  GtkButtonBox $widget,
  GtkWidget $child,
  gboolean $is_secondary
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_get_layout (GtkButtonBox $widget)
  returns uint32 # GtkButtonBoxStyle
  is native($LIBGTK)
  is export
  { * }

sub gtk_button_box_set_layout (
  GtkButtonBox $widget,
  uint32 $layout_style           # GtkButtonBoxStyle $layout_style
)
  is native($LIBGTK)
  is export
  { * }