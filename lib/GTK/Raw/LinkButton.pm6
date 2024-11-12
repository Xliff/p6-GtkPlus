use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::LinkButton:ver<3.0.1146>;

sub gtk_link_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_link_button_new (Str $uri)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_link_button_new_with_label (Str $uri, Str $label)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_link_button_get_visited (GtkLinkButton $link_button)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_link_button_get_uri (GtkLinkButton $link_button)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_link_button_set_visited (GtkLinkButton $link_button, gboolean $visited)
  is native(gtk)
  is export
  { * }

sub gtk_link_button_set_uri (GtkLinkButton $link_button, Str $uri)
  is native(gtk)
  is export
  { * }