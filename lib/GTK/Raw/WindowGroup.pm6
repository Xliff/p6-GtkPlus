use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;
use GTK::Raw::Structs:ver<3.0.1146>;

unit package GTK::Raw::WindowGroup:ver<3.0.1146>;

sub gtk_window_group_add_window (
  GtkWindowGroup $window_group,
  GtkWindow $window
)
  is native(gtk)
  is export
  { * }

sub gtk_window_group_get_current_device_grab (
  GtkWindowGroup $window_group,
  GdkDevice $device
)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_window_group_get_current_grab (GtkWindowGroup $window_group)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_window_group_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_window_group_list_windows (GtkWindowGroup $window_group)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_window_group_new ()
  returns GtkWindowGroup
  is native(gtk)
  is export
  { * }

sub gtk_window_group_remove_window (
  GtkWindowGroup $window_group,
  GtkWindow $window
)
  is native(gtk)
  is export
  { * }
