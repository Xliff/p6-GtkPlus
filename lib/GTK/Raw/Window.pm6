use v6.c;

use GTK::Raw::Types;

unit package GTK::Raw::Window;

sub gtk_window_activate_default (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_activate_focus (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_activate_key (GtkWindow $window, GdkEventKey $event)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_add_accel_group (GtkWindow $window, GtkAccelGroup $accel_group)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_add_mnemonic (GtkWindow $window, guint $keyval, GtkWidget $target)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_begin_move_drag (GtkWindow $window, gint $button, gint $root_x, gint $root_y, guint32 $timestamp)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_begin_resize_drag (GtkWindow $window, GdkWindowEdge $edge, gint $button, gint $root_x, gint $root_y, guint32 $timestamp)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_close (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_deiconify (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_fullscreen (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_fullscreen_on_monitor (GtkWindow $window, GdkScreen $screen, gint $monitor)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_default_icon_list ()
  returns GList
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_default_icon_name ()
  returns Str
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_default_size (GtkWindow $window, gint $width, gint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_default_widget (GtkWindow $window)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_group (GtkWindow $window)
  returns GtkWindowGroup
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_position (GtkWindow $window, gint $root_x, gint $root_y)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_resize_grip_area (GtkWindow $window, GdkRectangle $rect)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_size (GtkWindow $window, gint $width, gint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_window_get_window_type (GtkWindow $window)
  returns GtkWindowType
  is native('gtk-3')
  is export
  { * }

sub gtk_window_has_group (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_has_toplevel_focus (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_iconify (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_is_active (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_is_maximized (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_list_toplevels ()
  returns GList
  is native('gtk-3')
  is export
  { * }

sub gtk_window_maximize (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_mnemonic_activate (GtkWindow $window, guint $keyval, GdkModifierType $modifier)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_move (GtkWindow $window, gint $x, gint $y)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_new (GtkWindowType $type)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_window_parse_geometry (GtkWindow $window, gchar $geometry)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_present (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_present_with_time (GtkWindow $window, guint32 $timestamp)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_propagate_key_event (GtkWindow $window, GdkEventKey $event)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_remove_accel_group (GtkWindow $window, GtkAccelGroup $accel_group)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_remove_mnemonic (GtkWindow $window, guint $keyval, GtkWidget $target)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_reshow_with_initial_size (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_resize (GtkWindow $window, gint $width, gint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_resize_grip_is_visible (GtkWindow $window)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_resize_to_geometry (GtkWindow $window, gint $width, gint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_auto_startup_notification (gboolean $setting)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default (GtkWindow $window, GtkWidget $default_widget)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default_geometry (GtkWindow $window, gint $width, gint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default_icon (GdkPixbuf $icon)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default_icon_from_file (gchar $filename, GError $err)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default_icon_list (GList $list)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default_icon_name (gchar $name)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_default_size (GtkWindow $window, gint $width, gint $height)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_geometry_hints (GtkWindow $window, GtkWidget $geometry_widget, GdkGeometry $geometry, GdkWindowHints $geom_mask)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_has_user_ref_count (GtkWindow $window, gboolean $setting)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_icon_from_file (GtkWindow $window, gchar $filename, GError $err)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_interactive_debugging (gboolean $enable)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_keep_above (GtkWindow $window, gboolean $setting)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_keep_below (GtkWindow $window, gboolean $setting)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_position (GtkWindow $window, GtkWindowPosition $position)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_startup_id (GtkWindow $window, gchar $startup_id)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_set_wmclass (GtkWindow $window, gchar $wmclass_name, gchar $wmclass_class)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_stick (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_unfullscreen (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_unmaximize (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }

sub gtk_window_unstick (GtkWindow $window)
  is native('gtk-3')
  is export
  { * }
