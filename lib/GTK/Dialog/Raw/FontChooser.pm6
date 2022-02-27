use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Dialog::Raw::FontChooser:ver<3.0.1146>;

sub gtk_font_chooser_dialog_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_font_chooser_dialog_new (gchar $title, GtkWindow $parent)
  returns GtkWidget
  is native(gtk)
  is export
  { * }