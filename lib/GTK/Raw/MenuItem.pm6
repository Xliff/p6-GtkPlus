use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::MenuItem;

sub gtk_menu_item_activate (GtkMenuItem $menu_item)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_deselect (GtkMenuItem $menu_item)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_new_with_label (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_select (GtkMenuItem $menu_item)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_toggle_size_allocate (
  GtkMenuItem $menu_item,
  gint $allocation
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_toggle_size_request (
  GtkMenuItem $menu_item,
  gint $requisition
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_label (GtkMenuItem $menu_item)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_accel_path (GtkMenuItem $menu_item)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_right_justified (GtkMenuItem $menu_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_reserve_indicator (GtkMenuItem $menu_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_submenu (GtkMenuItem $menu_item)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_get_use_underline (GtkMenuItem $menu_item)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_set_label (GtkMenuItem $menu_item, gchar $label)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_set_accel_path (GtkMenuItem $menu_item, gchar $accel_path)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_set_right_justified (
  GtkMenuItem $menu_item,
  gboolean $right_justified
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_set_reserve_indicator (
  GtkMenuItem $menu_item,
  gboolean $reserve
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_set_submenu (
  GtkMenuItem $menu_item,
  GtkWidget $submenu
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_item_set_use_underline (
  GtkMenuItem $menu_item,
  gboolean $setting
)
  is native(gtk)
  is export
  { * }