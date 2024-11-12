use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Scrollbar:ver<3.0.1146>;

sub gtk_scrollbar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

# (GtkOrientation $orientation, GtkAdjustment $adjustment)
sub gtk_scrollbar_new (uint32 $orientation, GtkAdjustment $adjustment)
  returns GtkWidget
  is native(gtk)
  is export
  { * }