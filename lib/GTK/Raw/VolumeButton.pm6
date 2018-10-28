use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::VolumeButton;

sub gtk_volume_button_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_volume_button_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }