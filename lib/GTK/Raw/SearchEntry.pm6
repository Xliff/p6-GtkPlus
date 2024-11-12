use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::SearchEntry:ver<3.0.1146>;

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
  returns GtkSearchEntry
  is native(gtk)
  is export
  { * }
