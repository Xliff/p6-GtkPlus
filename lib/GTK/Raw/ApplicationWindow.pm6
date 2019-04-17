use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::ApplicationWindow;

sub gtk_application_window_get_id (GtkApplicationWindow $window)
  returns guint
  is native(gtk)
  is export
  { * }

sub gtk_application_window_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_application_window_new (GtkApplication $application)
  returns GtkApplicationWindow
  is native(gtk)
  is export
  { * }

sub gtk_application_window_get_help_overlay (GtkApplicationWindow $window)
  returns GtkShortcutsWindow
  is native(gtk)
  is export
  { * }

sub gtk_application_window_get_show_menubar (GtkApplicationWindow $window)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_application_window_set_help_overlay (
  GtkApplicationWindow $window, 
  GtkShortcutsWindow $help_overlay
)
  is native(gtk)
  is export
  { * }

sub gtk_application_window_set_show_menubar (
  GtkApplicationWindow $window, 
  gboolean $show_menubar
)
  is native(gtk)
  is export
  { * }
