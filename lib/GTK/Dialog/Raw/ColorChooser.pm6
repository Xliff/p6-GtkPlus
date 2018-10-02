use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Dialog::Raw::ColorChooser;

sub gtk_color_chooser_dialog_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_color_chooser_dialog_new (gchar $title, GtkWindow $parent)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }
