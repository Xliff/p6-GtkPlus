use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Fixed;

sub gtk_fixed_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_fixed_move (GtkFixed $fixed, GtkWidget $widget, gint $x, gint $y)
  is native(gtk)
  is export
  { * }

sub gtk_fixed_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_fixed_put (GtkFixed $fixed, GtkWidget $widget, gint $x, gint $y)
  is native(gtk)
  is export
  { * }