use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::RadioButton;

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

sub gtk_radio_button_new_with_label (GSList $group, gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_label_from_widget (
  GtkRadioButton $radio_group_member,
  gchar $label
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_mnemonic (GSList $group, gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_radio_button_new_with_mnemonic_from_widget (
  GtkRadioButton $radio_group_member,
  gchar $label
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