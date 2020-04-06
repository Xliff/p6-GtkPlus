use v6.c;

use NativeCall;


use GTK::Raw::Types;

unit package GTK::Raw::SearchEntry;

sub gtk_search_entry_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_search_entry_handle_event (GtkSearchEntry $entry, GdkEvent $event)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_search_entry_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }