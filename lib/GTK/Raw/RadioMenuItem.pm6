use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::RadioMenuItem;

sub gtk_radio_menu_item_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_join_group (
  GtkRadioMenuItem $radio_menu_item,
  GtkRadioMenuItem $group_source
)
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_new (GSList $group)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_new_from_widget (GtkRadioMenuItem $group)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_new_with_label (GSList $group, gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_new_with_label_from_widget (
  GtkRadioMenuItem $group,
  gchar $label
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_new_with_mnemonic (
  GSList $group,
  gchar $label
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_new_with_mnemonic_from_widget (
  GtkRadioMenuItem $group,
  gchar $label
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_get_group (GtkRadioMenuItem $radio_menu_item)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_radio_menu_item_set_group (
  GtkRadioMenuItem $radio_menu_item,
  GSList $group
)
  is native(gtk)
  is export
  { * }