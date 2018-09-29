use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ToolItem;

sub gtk_tool_item_get_ellipsize_mode (GtkToolItem $tool_item)
  returns uint32 # PangoEllipsizeMode
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_icon_size (GtkToolItem $tool_item)
  returns uint32 # GtkIconSize
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_orientation (GtkToolItem $tool_item)
  returns uint32 # GtkOrientation
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_proxy_menu_item (
  GtkToolItem $tool_item,
  gchar $menu_item_id
)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_relief_style (GtkToolItem $tool_item)
  returns uint32 # GtkReliefStyle
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_text_alignment (GtkToolItem $tool_item)
  returns gfloat
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_text_orientation (GtkToolItem $tool_item)
  returns uint32 # GtkOrientation
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_text_size_group (GtkToolItem $tool_item)
  returns GtkSizeGroup
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_toolbar_style (GtkToolItem $tool_item)
  returns uint32 # GtkToolbarStyle
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_new ()
  returns GtkToolItem
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_rebuild_menu (GtkToolItem $tool_item)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_retrieve_proxy_menu_item (GtkToolItem $tool_item)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_proxy_menu_item (
  GtkToolItem $tool_item,
  gchar $menu_item_id,
  GtkWidget $menu_item
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_tooltip_markup (GtkToolItem $tool_item, gchar $markup)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_tooltip_text (GtkToolItem $tool_item, gchar $text)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_toolbar_reconfigured (GtkToolItem $tool_item)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_homogeneous (GtkToolItem $tool_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_is_important (GtkToolItem $tool_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_visible_vertical (GtkToolItem $tool_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_expand (GtkToolItem $tool_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_visible_horizontal (GtkToolItem $tool_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_get_use_drag_window (GtkToolItem $tool_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_homogeneous (
  GtkToolItem $tool_item,
  gboolean $homogeneous
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_is_important (
  GtkToolItem $tool_item,
  gboolean $is_important
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_visible_vertical (
  GtkToolItem $tool_item,
  gboolean $visible_vertical
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_expand (
  GtkToolItem $tool_item,
  gboolean $expand
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_visible_horizontal (
  GtkToolItem $tool_item,
  gboolean $visible_horizontal
)
  is native('gtk-3')
  is export
  { * }

sub gtk_tool_item_set_use_drag_window (
  GtkToolItem $tool_item,
  gboolean $use_drag_window
)
  is native('gtk-3')
  is export
  { * }
