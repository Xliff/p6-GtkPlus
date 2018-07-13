use v6.c;

use NativeCall;

unit package GTK::Raw::Box;

sub gtk_box_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_box_new (GtkOrientation $orientation, gint $spacing)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_box_pack_end (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding)
  is native('gtk-3')
  is export
  { * }

sub gtk_box_pack_start (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding)
  is native('gtk-3')
  is export
  { * }

sub gtk_box_query_child_packing (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding, GtkPackType $pack_type)
  is native('gtk-3')
  is export
  { * }

sub gtk_box_reorder_child (GtkBox $box, GtkWidget $child, gint $position)
  is native('gtk-3')
  is export
  { * }

sub gtk_box_set_child_packing (GtkBox $box, GtkWidget $child, gboolean $expand, gboolean $fill, guint $padding, GtkPackType $pack_type)
  is native('gtk-3')
  is export
  { * }
