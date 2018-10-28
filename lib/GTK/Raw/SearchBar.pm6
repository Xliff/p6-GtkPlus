use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::SearchBar;

sub gtk_search_bar_connect_entry (GtkSearchBar $bar, GtkEntry $entry)
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_handle_event (GtkSearchBar $bar, GdkEvent $event)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_new ()
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_get_show_close_button (GtkSearchBar $bar)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_get_search_mode (GtkSearchBar $bar)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_set_show_close_button (GtkSearchBar $bar, gboolean $visible)
  is native($LIBGTK)
  is export
  { * }

sub gtk_search_bar_set_search_mode (GtkSearchBar $bar, gboolean $search_mode)
  is native($LIBGTK)
  is export
  { * }