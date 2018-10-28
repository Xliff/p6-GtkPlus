use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::HeaderBar;

sub gtk_header_bar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_pack_end (GtkHeaderBar $bar, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_pack_start (GtkHeaderBar $bar, GtkWidget $child)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_get_has_subtitle (GtkHeaderBar $bar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_get_show_close_button (GtkHeaderBar $bar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_get_title (GtkHeaderBar $bar)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_get_decoration_layout (GtkHeaderBar $bar)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_get_subtitle (GtkHeaderBar $bar)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_get_custom_title (GtkHeaderBar $bar)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_set_has_subtitle (GtkHeaderBar $bar, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_set_show_close_button (GtkHeaderBar $bar, gboolean $setting)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_set_title (GtkHeaderBar $bar, gchar $title)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_set_decoration_layout (GtkHeaderBar $bar, gchar $layout)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_set_subtitle (GtkHeaderBar $bar, gchar $subtitle)
  is native(gtk)
  is export
  { * }

sub gtk_header_bar_set_custom_title (GtkHeaderBar $bar, GtkWidget $title_widget)
  is native(gtk)
  is export
  { * }