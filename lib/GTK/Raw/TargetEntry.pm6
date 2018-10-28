use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::TargetEntry;

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