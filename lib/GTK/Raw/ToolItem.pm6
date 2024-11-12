use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::ToolItem:ver<3.0.1146>;

sub gtk_tool_item_get_ellipsize_mode (GtkToolItem $tool_item)
  returns uint32 # PangoEllipsizeMode
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_icon_size (GtkToolItem $tool_item)
  returns uint32 # GtkIconSize
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_orientation (GtkToolItem $tool_item)
  returns uint32 # GtkOrientation
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_proxy_menu_item (
  GtkToolItem $tool_item,
  Str $menu_item_id
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_relief_style (GtkToolItem $tool_item)
  returns uint32 # GtkReliefStyle
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_text_alignment (GtkToolItem $tool_item)
  returns gfloat
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_text_orientation (GtkToolItem $tool_item)
  returns uint32 # GtkOrientation
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_text_size_group (GtkToolItem $tool_item)
  returns GtkSizeGroup
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_toolbar_style (GtkToolItem $tool_item)
  returns uint32 # GtkToolbarStyle
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_new ()
  returns GtkToolItem
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_rebuild_menu (GtkToolItem $tool_item)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_retrieve_proxy_menu_item (GtkToolItem $tool_item)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_proxy_menu_item (
  GtkToolItem $tool_item,
  Str $menu_item_id,
  GtkWidget $menu_item
)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_tooltip_markup (GtkToolItem $tool_item, Str $markup)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_tooltip_text (GtkToolItem $tool_item, Str $text)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_toolbar_reconfigured (GtkToolItem $tool_item)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_homogeneous (GtkToolItem $tool_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_is_important (GtkToolItem $tool_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_visible_vertical (GtkToolItem $tool_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_expand (GtkToolItem $tool_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_visible_horizontal (GtkToolItem $tool_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_get_use_drag_window (GtkToolItem $tool_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_homogeneous (
  GtkToolItem $tool_item,
  gboolean $homogeneous
)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_is_important (
  GtkToolItem $tool_item,
  gboolean $is_important
)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_visible_vertical (
  GtkToolItem $tool_item,
  gboolean $visible_vertical
)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_expand (
  GtkToolItem $tool_item,
  gboolean $expand
)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_visible_horizontal (
  GtkToolItem $tool_item,
  gboolean $visible_horizontal
)
  is native(gtk)
  is export
  { * }

sub gtk_tool_item_set_use_drag_window (
  GtkToolItem $tool_item,
  gboolean $use_drag_window
)
  is native(gtk)
  is export
  { * }