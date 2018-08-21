use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Pane;

sub gtk_paned_add1 (GtkPaned $paned, GtkWidget $child)
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_add2 (GtkPaned $paned, GtkWidget $child)
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_get_child1 (GtkPaned $paned)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_get_child2 (GtkPaned $paned)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_get_handle_window (GtkPaned $paned)
  returns GdkWindow
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_new (GtkOrientation $orientation)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_pack1 (GtkPaned $paned, GtkWidget $child, gboolean $resize, gboolean $shrink)
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_pack2 (GtkPaned $paned, GtkWidget $child, gboolean $resize, gboolean $shrink)
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_get_position (GtkPaned $paned)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_get_wide_handle (GtkPaned $paned)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_set_position (GtkPaned $paned, gint $position)
  is native('gtk-3')
  is export
  { * }

sub gtk_paned_set_wide_handle (GtkPaned $paned, gboolean $wide)
  is native('gtk-3')
  is export
  { * }
