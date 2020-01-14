use v6.c;

use NativeCall;

use GTK::Raw::Types;

unit package GTK::Raw::FileChooserWidget;

### /usr/include/gtk-3.0/gtk/gtkfilechooserwidget.h

sub gtk_file_chooser_widget_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub gtk_file_chooser_widget_new (GtkFileChooserAction $action)
  returns GtkFileChooserWidget
  is native(gtk)
  is export
{ * }
