use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::RecentFilter;

sub gtk_recent_filter_add_age (GtkRecentFilter $filter, gint $days)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_add_application (
  GtkRecentFilter $filter,
  gchar $application
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_add_custom (
  GtkRecentFilter $filter,
  uint32 $needed,               # GtkRecentFilterFlags $needed,
  GtkRecentFilterFunc $func,
  gpointer $data,
  GDestroyNotify $data_destroy
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_add_group (GtkRecentFilter $filter, gchar $group)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_add_mime_type (
  GtkRecentFilter $filter,
  gchar $mime_type
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_add_pattern (GtkRecentFilter $filter, gchar $pattern)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_add_pixbuf_formats (GtkRecentFilter $filter)
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_filter (
  GtkRecentFilter $filter, 
  GtkRecentFilterInfo $filter_info
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_get_needed (GtkRecentFilter $filter)
  returns uint32 # GtkRecentFilterFlags
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_new ()
  returns GtkRecentFilter
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_get_name (GtkRecentFilter $filter)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_recent_filter_set_name (GtkRecentFilter $filter, gchar $name)
  is native($LIBGTK)
  is export
  { * }