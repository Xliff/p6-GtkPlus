use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Spinner;

sub gtk_spinner_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_spinner_new ()
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_spinner_start (GtkSpinner $spinner)
  is native('gtk-3')
  is export
  { * }

sub gtk_spinner_stop (GtkSpinner $spinner)
  is native('gtk-3')
  is export
  { * }
