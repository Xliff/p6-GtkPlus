use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Layout;

sub gtk_layout_get_bin_window (GtkLayout $layout)
  returns GdkWindow
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_get_size (
  GtkLayout $layout,
  guint $width  is rw,
  guint $height is rw
)
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_move (
  GtkLayout $layout,
  GtkWidget $child_widget,
  gint $x,
  gint $y
)
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_new (
  GtkAdjustment $hadjustment,
  GtkAdjustment $vadjustment
)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_put (
  GtkLayout $layout,
  GtkWidget $child_widget,
  gint $x,
  gint $y
)
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_set_size (GtkLayout $layout, guint $width, guint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_get_hadjustment (GtkLayout $layout)
  returns GtkAdjustment
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_get_vadjustment (GtkLayout $layout)
  returns GtkAdjustment
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_set_hadjustment (
  GtkLayout $layout,
  GtkAdjustment $adjustment
)
  is native('gtk-3')
  is export
  { * }

sub gtk_layout_set_vadjustment (
  GtkLayout $layout,
  GtkAdjustment $adjustment
)
  is native('gtk-3')
  is export
  { * }
