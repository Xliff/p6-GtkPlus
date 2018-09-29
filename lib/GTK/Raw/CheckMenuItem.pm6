use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CheckMenuItem;

sub gtk_check_menu_item_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_new_with_label (gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_toggled (GtkCheckMenuItem $check_menu_item)
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_get_inconsistent (GtkCheckMenuItem $check_menu_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_get_active (GtkCheckMenuItem $check_menu_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_get_draw_as_radio (GtkCheckMenuItem $check_menu_item)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_set_inconsistent (
  GtkCheckMenuItem $check_menu_item,
  gboolean $setting
)
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_set_active (
  GtkCheckMenuItem $check_menu_item,
  gboolean $is_active
)
  is native('gtk-3')
  is export
  { * }

sub gtk_check_menu_item_set_draw_as_radio (
  GtkCheckMenuItem $check_menu_item,
  gboolean $draw_as_radio
)
  is native('gtk-3')
  is export
  { * }
