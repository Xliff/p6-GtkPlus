use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Scrollbar;

sub gtk_scrollbar_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

# (GtkOrientation $orientation, GtkAdjustment $adjustment)
sub gtk_scrollbar_new (uint32 $orientation, GtkAdjustment $adjustment)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }