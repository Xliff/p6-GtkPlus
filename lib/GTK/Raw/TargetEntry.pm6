use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::TargetEntry:ver<3.0.1146>;

sub gtk_target_entry_copy (GtkTargetEntry $data)
  returns GtkTargetEntry
  is native(gtk)
  is export
{ * }

sub gtk_target_entry_free (GtkTargetEntry $data)
  is native(gtk)
  is export
{ * }

sub gtk_target_entry_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub gtk_target_entry_new (gchar $target, guint $flags, guint $info)
  returns GtkTargetEntry
  is native(gtk)
  is export
{ * }
