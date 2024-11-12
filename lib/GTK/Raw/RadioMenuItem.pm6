use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::RadioMenuItem:ver<3.0.1146>;

sub gtk_radio_menu_item_get_type ()
  returns GType
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_join_group (
  GtkRadioMenuItem $radio_menu_item,
  GtkRadioMenuItem $group_source
)
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_new (GSList $group)
  returns GtkRadioMenuItem
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_new_from_widget (GtkRadioMenuItem $group)
  returns GtkRadioMenuItem
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_new_with_label (GSList $group, Str $label)
  returns GtkRadioMenuItem
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_new_with_label_from_widget (
  GtkRadioMenuItem $group,
  Str $label
)
  returns GtkRadioMenuItem
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_new_with_mnemonic (
  GSList $group,
  Str $label
)
  returns GtkWidget
  is      native(gtk)
  is      export
  { * }

sub gtk_radio_menu_item_new_with_mnemonic_from_widget (
  GtkRadioMenuItem $group,
  Str              $label
)
  returns GtkRadioMenuItem
  is      native(gtk)
  is      export
{ * }

sub gtk_radio_menu_item_get_group (GtkRadioMenuItem $radio_menu_item)
  returns GSList
  is      native(gtk)
  is      export
{ * }

sub gtk_radio_menu_item_set_group (
  GtkRadioMenuItem $radio_menu_item,
  GSList           $group
)
  is      native(gtk)
  is      export
  { * }
