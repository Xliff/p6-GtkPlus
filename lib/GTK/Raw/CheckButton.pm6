use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::CheckButton;

sub gtk_check_button_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_check_button_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_check_button_new_with_label (gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_check_button_new_with_mnemonic (gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }
