use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Frame;

sub gtk_frame_get_label_align (GtkFrame $frame, gfloat $xalign, gfloat $yalign)
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_new (gchar $label)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_set_label_align (GtkFrame $frame, gfloat $xalign, gfloat $yalign)
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_get_label_widget (GtkFrame $frame)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_get_shadow_type (GtkFrame $frame)
  returns uint32 # GtkShadowType
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_get_label (GtkFrame $frame)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_set_label_widget (GtkFrame $frame, GtkWidget $label_widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_set_shadow_type (
  GtkFrame $frame,
  uint32 $type                  # GtkShadowType $type
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_frame_set_label (GtkFrame $frame, gchar $label)
  is native($LIBGTK)
  is export
  { * }