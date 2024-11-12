use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::FileFilter:ver<3.0.1146>;

sub gtk_file_filter_add_custom (
  GtkFileFilter $filter,
  uint32 $needed,               # GtkFileFilterFlags $needed,
  GtkFileFilterFunc $func,
  gpointer $data,
  GDestroyNotify $notify
)
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_add_mime_type (GtkFileFilter $filter, Str $mime_type)
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_add_pattern (GtkFileFilter $filter, Str $pattern)
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_add_pixbuf_formats (GtkFileFilter $filter)
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_filter (
  GtkFileFilter $filter,
  GtkFileFilterInfo $filter_info
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_get_needed (GtkFileFilter $filter)
  returns uint32 # GtkFileFilterFlags
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_new ()
  returns GtkFileFilter
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_new_from_gvariant (
  Pointer $variant              # GVariant $variant
)
  returns GtkFileFilter
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_to_gvariant (GtkFileFilter $filter)
  returns Pointer # GVariant
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_get_name (GtkFileFilter $filter)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_file_filter_set_name (GtkFileFilter $filter, Str $name)
  is native(gtk)
  is export
  { * }