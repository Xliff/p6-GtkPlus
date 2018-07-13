use v6.c;

use NativeCall;

use GTK::Raw::Types;

unit package GTK::Raw::Application;

sub gtk_application_add_accelerator (GtkApplication $application, gchar $accelerator, gchar $action_name, GVariant $parameter)
  is native('gtk-3')
  is export
  { * }

sub gtk_application_add_window (GtkApplication $application, GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_accels_for_action (GtkApplication $application, gchar $detailed_action_name)
  returns CArray[Str]
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_actions_for_accel (GtkApplication $application, gchar $accel)
  returns CArray[Str]
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_active_window (GtkApplication $application)
  returns GtkWindow
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_menu_by_id (GtkApplication $application, gchar $id)
  returns GMenu
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_window_by_id (GtkApplication $application, guint $id)
  returns GtkWindow
  is native('gtk-3')
  is export
  { * }

sub gtk_application_get_windows (GtkApplication $application)
  returns GList
  is native('gtk-3')
  is export
  { * }

sub gtk_application_inhibit (GtkApplication $application, GtkWindow $window, GtkApplicationInhibitFlags $flags, gchar $reason)
  returns guint
  is native('gtk-3')
  is export
  { * }

sub gtk_application_is_inhibited (GtkApplication $application, GtkApplicationInhibitFlags $flags)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_application_list_action_descriptions (GtkApplication $application)
  returns CArray[Str]
  is native('gtk-3')
  is export
  { * }

sub gtk_application_new (gchar $application_id, GApplicationFlags $flags)
  returns GtkApplication
  is native('gtk-3')
  is export
  { * }

sub gtk_application_prefers_app_menu (GtkApplication $application)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_application_remove_accelerator (GtkApplication $application, gchar $action_name, GVariant $parameter)
  is native('gtk-3')
  is export
  { * }

sub gtk_application_remove_window (GtkApplication $application, GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_application_uninhibit (GtkApplication $application, guint $cookie)
  is native('gtk-3')
  is export
  { * }
