use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::GtkToolItemGroup;

sub gtk_tool_item_group_get_drop_item (
  GtkToolItemGroup $group,
  gint $x,
  gint $y
)
  returns GtkToolItem
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_item_position (
  GtkToolItemGroup $group,
  GtkToolItem $item
)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_n_items (GtkToolItemGroup $group)
  returns guint
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_nth_item (
  GtkToolItemGroup $group,
  guint $index
)
  returns GtkToolItem
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_insert (
  GtkToolItemGroup $group,
  GtkToolItem $item,
  gint $position
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_new (gchar $label)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_set_item_position (
  GtkToolItemGroup $group,
  GtkToolItem $item,
  gint $position
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_ellipsize (GtkToolItemGroup $group)
  returns uint32 # PangoEllipsizeMode
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_label (GtkToolItemGroup $group)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_header_relief (GtkToolItemGroup $group)
  returns uint32 # GtkReliefStyle
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_collapsed (GtkToolItemGroup $group)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_get_label_widget (GtkToolItemGroup $group)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_set_ellipsize (
  GtkToolItemGroup $group,
  uint32 $ellipsize               # PangoEllipsizeMode $ellipsize
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_set_label (
  GtkToolItemGroup $group,
  gchar $label
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_set_header_relief (
  GtkToolItemGroup $group,
  uint32 $style                   # GtkReliefStyle $style
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_set_collapsed (
  GtkToolItemGroup $group,
  gboolean $collapsed
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_tool_item_group_set_label_widget (
  GtkToolItemGroup $group,
  GtkWidget $label_widget
)
  is native($LIBGTK)
  is export
  { * }