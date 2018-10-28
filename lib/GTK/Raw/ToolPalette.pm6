use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ToolPalette;

sub gtk_tool_palette_add_drag_dest (
  GtkToolPalette $palette,
  GtkWidget $widget,
  uint32 $flags,                # GtkDestDefaults $flags,
  uint32 $targets,              # GtkToolPaletteDragTargets $targets,
  uint32 $actions               # GdkDragAction $actions
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_drag_item (
  GtkToolPalette $palette,
  GtkSelectionData $selection
)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_drag_target_group ()
  returns GtkTargetEntry
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_drag_target_item ()
  returns GtkTargetEntry
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_drop_group (
  GtkToolPalette $palette,
  gint $x,
  gint $y
)
  returns GtkToolItemGroup
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_drop_item (
  GtkToolPalette $palette,
  gint $x,
  gint $y
)
  returns GtkToolItem
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_exclusive (
  GtkToolPalette $palette,
  GtkToolItemGroup $group
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_expand (
  GtkToolPalette $palette,
  GtkToolItemGroup $group
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_group_position (
  GtkToolPalette $palette,
  GtkToolItemGroup $group
)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_hadjustment (GtkToolPalette $palette)
  returns uint32 # GtkAdjustment
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_icon_size (GtkToolPalette $palette)
  returns uint32 # GtkIconSize
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_style (GtkToolPalette $palette)
  returns uint32 # GtkToolbarStyle
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_get_vadjustment (GtkToolPalette $palette)
  returns uint32 # GtkAdjustment
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_set_drag_source (
  GtkToolPalette $palette,
  uint32 $targets               # GtkToolPaletteDragTargets $targets
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_set_exclusive (
  GtkToolPalette $palette,
  GtkToolItemGroup $group,
  gboolean $exclusive
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_set_expand (
  GtkToolPalette $palette,
  GtkToolItemGroup $group,
  gboolean $expand
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_set_group_position (
  GtkToolPalette $palette,
  GtkToolItemGroup $group,
  gint $position
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_unset_icon_size (GtkToolPalette $palette)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_palette_unset_style (GtkToolPalette $palette)
  is native('gtk-3')
  is export
  { * }
