use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Pane:ver<3.0.1146>;

sub gtk_paned_add1 (GtkPaned $paned, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_paned_add2 (GtkPaned $paned, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_paned_get_child1 (GtkPaned $paned)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_paned_get_child2 (GtkPaned $paned)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_paned_get_handle_window (GtkPaned $paned)
  returns GdkWindow
  is native(gtk)
  is export
  { * }

sub gtk_paned_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_paned_new (
  uint32 $orientation               # GtkOrientation $orientation
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_paned_pack1 (
  GtkPaned $paned,
  GtkWidget $child,
  gboolean $resize,
  gboolean $shrink
)
  is native(gtk)
  is export
  { * }

sub gtk_paned_pack2 (
  GtkPaned $paned,
  GtkWidget $child,
  gboolean $resize,
  gboolean $shrink
)
  is native(gtk)
  is export
  { * }

sub gtk_paned_get_position (GtkPaned $paned)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_paned_get_wide_handle (GtkPaned $paned)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_paned_set_position (GtkPaned $paned, gint $position)
  is native(gtk)
  is export
  { * }

sub gtk_paned_set_wide_handle (GtkPaned $paned, gboolean $wide)
  is native(gtk)
  is export
  { * }