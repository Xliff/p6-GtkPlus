use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::LinkButton;

sub gtk_link_button_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_link_button_new (gchar $uri)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_link_button_new_with_label (gchar $uri, gchar $label)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_link_button_get_visited (GtkLinkButton $link_button)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_link_button_get_uri (GtkLinkButton $link_button)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_link_button_set_visited (GtkLinkButton $link_button, gboolean $visited)
  is native($LIBGTK)
  is export
  { * }

sub gtk_link_button_set_uri (GtkLinkButton $link_button, gchar $uri)
  is native($LIBGTK)
  is export
  { * }