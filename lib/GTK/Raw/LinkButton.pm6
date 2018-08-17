use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::LinkButton;

sub gtk_link_button_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_link_button_new (gchar $uri)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_link_button_new_with_label (gchar $uri, gchar $label)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_link_button_get_visited (GtkLinkButton $link_button)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_link_button_get_uri (GtkLinkButton $link_button)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_link_button_set_visited (GtkLinkButton $link_button, gboolean $visited)
  is native('gtk-3')
  is export
  { * }

sub gtk_link_button_set_uri (GtkLinkButton $link_button, gchar $uri)
  is native('gtk-3')
  is export
  { * }
