use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::RecentChooser:ver<3.0.1146>;

sub gtk_recent_chooser_add_filter (
  GtkRecentChooser $chooser,
  GtkRecentFilter $filter
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_error_quark ()
  returns GQuark
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_current_item (GtkRecentChooser $chooser)
  returns GtkRecentInfo
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_current_uri (GtkRecentChooser $chooser)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_items (GtkRecentChooser $chooser)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_uris (
  GtkRecentChooser $chooser,
  gsize $length is rw
)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_list_filters (GtkRecentChooser $chooser)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_remove_filter (
  GtkRecentChooser $chooser,
  GtkRecentFilter $filter
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_select_all (GtkRecentChooser $chooser)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_select_uri (
  GtkRecentChooser $chooser,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_current_uri (
  GtkRecentChooser $chooser,
  Str $uri,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_sort_func (
  GtkRecentChooser $chooser,
  GtkRecentSortFunc $sort_func,
  gpointer $sort_data,
  GDestroyNotify $data_destroy
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_unselect_all (GtkRecentChooser $chooser)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_unselect_uri (GtkRecentChooser $chooser, Str $uri)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_filter (GtkRecentChooser $chooser)
  returns GtkRecentFilter
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_limit (GtkRecentChooser $chooser)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_local_only (GtkRecentChooser $chooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_select_multiple (GtkRecentChooser $chooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_show_icons (GtkRecentChooser $chooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_show_not_found (GtkRecentChooser $chooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_show_private (GtkRecentChooser $chooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_show_tips (GtkRecentChooser $chooser)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_get_sort_type (GtkRecentChooser $chooser)
  returns uint32 # GtkRecentSortType
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_filter (
  GtkRecentChooser $chooser,
  GtkRecentFilter $filter
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_limit (GtkRecentChooser $chooser, gint $limit)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_local_only (
  GtkRecentChooser $chooser,
  gboolean $local_only
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_select_multiple (
  GtkRecentChooser $chooser,
  gboolean $select_multiple
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_show_icons (
  GtkRecentChooser $chooser,
  gboolean $show_icons
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_show_not_found (
  GtkRecentChooser $chooser,
  gboolean $show_not_found
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_show_private (
  GtkRecentChooser $chooser,
  gboolean $show_private
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_show_tips (
  GtkRecentChooser $chooser,
  gboolean $show_tips
)
  is native(gtk)
  is export
  { * }

sub gtk_recent_chooser_set_sort_type (
  GtkRecentChooser $chooser,
  uint32 $sort_type                         # GtkRecentSortType $sort_type
)
  is native(gtk)
  is export
  { * }
