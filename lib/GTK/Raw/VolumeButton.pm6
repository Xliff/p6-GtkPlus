use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::VolumeButton:ver<3.0.1146>;

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