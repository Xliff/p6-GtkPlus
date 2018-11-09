use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::WindowGroup;

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
