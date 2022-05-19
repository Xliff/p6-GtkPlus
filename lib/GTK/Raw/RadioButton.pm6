use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::RadioButton:ver<3.0.1146>;

sub gtk_radio_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_join_group (
  GtkRadioButton $radio_button,
  GtkRadioButton $group_source
)
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new (GSList $group)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_from_widget (GtkRadioButton $radio_group_member)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_label (GSList $group, Str $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_label_from_widget (
  GtkRadioButton $radio_group_member,
  Str            $label
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_mnemonic (GSList $group, Str $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_mnemonic_from_widget (
  GtkRadioButton $radio_group_member,
  Str            $label
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_get_group (GtkRadioButton $radio_button)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_set_group (GtkRadioButton $radio_button, GSList $group)
  is native(gtk)
  is export
  { * }
