use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::LinkButton:ver<3.0.1146>;

sub gtk_link_button_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_link_button_new (gchar $uri)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_link_button_new_with_label (gchar $uri, gchar $label)
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

sub gtk_link_button_set_uri (GtkLinkButton $link_button, gchar $uri)
  is native(gtk)
  is export
  { * }