use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::Places:ver<3.0.1146>;

sub gtk_places_sidebar_add_shortcut (
  GtkPlacesSidebar $sidebar,
  GFile $location
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_nth_bookmark (
  GtkPlacesSidebar $sidebar,
  gint $n
)
  returns GFile
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_list_shortcuts (GtkPlacesSidebar $sidebar)
  returns GSList
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_remove_shortcut (
  GtkPlacesSidebar $sidebar,
  GFile $location
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_drop_targets_visible (
  GtkPlacesSidebar $sidebar,
  gboolean $visible,
  GdkDragContext $context
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_open_flags (GtkPlacesSidebar $sidebar)
  returns uint32 # GtkPlacesOpenFlags
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_desktop (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_other_locations (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_local_only (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_recent (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_location (GtkPlacesSidebar $sidebar)
  returns GFile
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_enter_location (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_starred_location (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_connect_to_server (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_get_show_trash (GtkPlacesSidebar $sidebar)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_open_flags (
  GtkPlacesSidebar $sidebar,
  uint32 $flags                   # GtkPlacesOpenFlags $flags
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_desktop (
  GtkPlacesSidebar $sidebar,
  gboolean $show_desktop
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_other_locations (
  GtkPlacesSidebar $sidebar,
  gboolean $show_other_locations
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_local_only (
  GtkPlacesSidebar $sidebar,
  gboolean $local_only
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_recent (
  GtkPlacesSidebar $sidebar,
  gboolean $show_recent
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_location (
  GtkPlacesSidebar $sidebar,
  GFile $location
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_enter_location (
  GtkPlacesSidebar $sidebar,
  gboolean $show_enter_location
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_starred_location (
  GtkPlacesSidebar $sidebar,
  gboolean $show_starred_location
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_connect_to_server (
  GtkPlacesSidebar $sidebar,
  gboolean $show_connect_to_server
)
  is native(gtk)
  is export
  { * }

sub gtk_places_sidebar_set_show_trash (
  GtkPlacesSidebar $sidebar,
  gboolean $show_trash
)
  is native(gtk)
  is export
  { * }