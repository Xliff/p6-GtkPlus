use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::RecentFilter:ver<3.0.1146>;

sub gtk_recent_filter_add_age (GtkRecentFilter $filter, gint $days)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_add_application (
  GtkRecentFilter $filter,
  Str $application
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_add_custom (
  GtkRecentFilter $filter,
  uint32 $needed,               # GtkRecentFilterFlags $needed,
  &func (GtkRecentFilterInfo, Pointer --> gboolean),
  gpointer $data,
  GDestroyNotify $data_destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_add_group (GtkRecentFilter $filter, Str $group)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_add_mime_type (
  GtkRecentFilter $filter,
  Str $mime_type
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_add_pattern (GtkRecentFilter $filter, Str $pattern)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_add_pixbuf_formats (GtkRecentFilter $filter)
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_filter (
  GtkRecentFilter $filter,
  GtkRecentFilterInfo $filter_info
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_get_needed (GtkRecentFilter $filter)
  returns uint32 # GtkRecentFilterFlags
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_new ()
  returns GtkRecentFilter
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_get_name (GtkRecentFilter $filter)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_recent_filter_set_name (GtkRecentFilter $filter, Str $name)
  is native(gtk)
  is export
  { * }
