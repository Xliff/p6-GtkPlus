use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::CheckButton:ver<3.0.1146>;

sub gtk_check_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_check_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_check_button_new_with_label (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_check_button_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }