use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Spinner;

sub gtk_spinner_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_spinner_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_spinner_start (GtkSpinner $spinner)
  is native($LIBGTK)
  is export
  { * }

sub gtk_spinner_stop (GtkSpinner $spinner)
  is native($LIBGTK)
  is export
  { * }