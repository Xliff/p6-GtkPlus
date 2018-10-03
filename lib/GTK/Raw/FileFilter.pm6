use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::FileFilter;

sub gtk_file_filter_add_custom (
  GtkFileFilter $filter,
  uint32 $needed,               # GtkFileFilterFlags $needed,
  GtkFileFilterFunc $func,
  gpointer $data,
  GDestroyNotify $notify
)
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_add_mime_type (GtkFileFilter $filter, gchar $mime_type)
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_add_pattern (GtkFileFilter $filter, gchar $pattern)
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_add_pixbuf_formats (GtkFileFilter $filter)
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_filter (
  GtkFileFilter $filter,
  GtkFileFilterInfo $filter_info
)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_get_needed (GtkFileFilter $filter)
  returns uint32 # GtkFileFilterFlags
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_new ()
  returns GtkFileFilter
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_new_from_gvariant (
  Pointer $variant              # GVariant $variant
)
  returns GtkFileFilter
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_to_gvariant (GtkFileFilter $filter)
  returns Pointer # GVariant
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_get_name (GtkFileFilter $filter)
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_file_filter_set_name (GtkFileFilter $filter, gchar $name)
  is native('gtk-3')
  is export
  { * }
