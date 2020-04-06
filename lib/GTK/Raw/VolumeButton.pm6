use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::VolumeButton;

sub gtk_volume_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_volume_button_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }