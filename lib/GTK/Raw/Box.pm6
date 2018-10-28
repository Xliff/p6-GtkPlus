use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Box;

sub gtk_box_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

# GtkOrientation $orientation
sub gtk_box_new (uint32 $orientation, gint $spacing)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_pack_end (
  GtkBox $box,
  GtkWidget $child,
  gboolean $expand,
  gboolean $fill,
  guint $padding
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_pack_start (
  GtkBox $box,
  GtkWidget $child,
  gboolean $expand,
  gboolean $fill,
  guint $padding
)
  is native($LIBGTK)
  is export
  { * }

# GtkPackType $pack_type
sub gtk_box_query_child_packing (
  GtkBox $box,
  GtkWidget $child,
  gboolean $expand is rw,
  gboolean $fill is rw,
  guint $padding is rw,
  uint32 $pack_type is rw
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_reorder_child (GtkBox $box, GtkWidget $child, gint $position)
  is native($LIBGTK)
  is export
  { * }

# GtkPackType $pack_type
sub gtk_box_set_child_packing (
  GtkBox $box,
  GtkWidget $child,
  gboolean $expand,
  gboolean $fill,
  guint $padding,
  uint32 $pack_type
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_get_center_widget (GtkBox $box)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

# -->GtkBaselinePosition
sub gtk_box_get_baseline_position (GtkBox $box)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_get_spacing (GtkBox $box)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_get_homogeneous (GtkBox $box)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_set_center_widget (GtkBox $box, GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

# GtkBaselinePosition $position
sub gtk_box_set_baseline_position (GtkBox $box, uint32 $position)
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_set_spacing (GtkBox $box, gint $spacing)
  is native($LIBGTK)
  is export
  { * }

sub gtk_box_set_homogeneous (GtkBox $box, gboolean $homogeneous)
  is native($LIBGTK)
  is export
  { * }