use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::Fixed:ver<3.0.1146>;

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