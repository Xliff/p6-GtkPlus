use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Layout:ver<3.0.1146>;

sub gtk_layout_get_bin_window (GtkLayout $layout)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gtk_layout_get_size (
  GtkLayout $layout,
  guint $width  is rw,
  guint $height is rw
)
  is native(gtk)
  is export
  { * }

sub gtk_layout_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_layout_move (
  GtkLayout $layout,
  GtkWidget $child_widget,
  gint $x,
  gint $y
)
  is native(gtk)
  is export
  { * }

sub gtk_layout_new (
  GtkAdjustment $hadjustment,
  GtkAdjustment $vadjustment
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_layout_put (
  GtkLayout $layout,
  GtkWidget $child_widget,
  gint $x,
  gint $y
)
  is native(gtk)
  is export
  { * }

sub gtk_layout_set_size (GtkLayout $layout, guint $width, guint $height)
  is native(gtk)
  is export
  { * }

sub gtk_layout_get_hadjustment (GtkLayout $layout)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_layout_get_vadjustment (GtkLayout $layout)
  returns GtkAdjustment
  is native(gtk)
  is export
  { * }

sub gtk_layout_set_hadjustment (
  GtkLayout $layout,
  GtkAdjustment $adjustment
)
  is native(gtk)
  is export
  { * }

sub gtk_layout_set_vadjustment (
  GtkLayout $layout,
  GtkAdjustment $adjustment
)
  is native(gtk)
  is export
  { * }
