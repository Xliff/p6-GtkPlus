use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Toolbar;

sub gtk_toolbar_get_drop_index (GtkToolbar $toolbar, gint $x, gint $y)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_icon_size (GtkToolbar $toolbar)
  returns GtkIconSize
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_item_index (GtkToolbar $toolbar, GtkToolItem $item)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_n_items (GtkToolbar $toolbar)
  returns gint
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_nth_item (GtkToolbar $toolbar, gint $n)
  returns GtkToolItem
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_relief_style (GtkToolbar $toolbar)
  returns GtkReliefStyle
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_style (GtkToolbar $toolbar)
  returns GtkToolbarStyle
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_insert (GtkToolbar $toolbar, GtkToolItem $item, gint $pos)
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_set_drop_highlight_item (
  GtkToolbar $toolbar,
  GtkToolItem $tool_item,
  gint $index
)
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_unset_icon_size (GtkToolbar $toolbar)
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_unset_style (GtkToolbar $toolbar)
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_get_show_arrow (GtkToolbar $toolbar)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_toolbar_set_show_arrow (GtkToolbar $toolbar, gboolean $show_arrow)
  is native('gtk-3')
  is export
  { * }
