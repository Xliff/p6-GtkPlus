use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions;
use GDK::Raw::Structs;
use GTK::Raw::Definitions:ver<3.0.1146>;

unit package GTK::Raw::Window:ver<3.0.1146>;

sub gtk_window_activate_default (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_activate_focus (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_activate_key (GtkWindow $window, GdkEventKey $event)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_add_accel_group (GtkWindow $window, GtkAccelGroup $accel_group)
  is native(gtk)
  is export
{ * }

sub gtk_window_add_mnemonic (
  GtkWindow $window,
  guint     $keyval,
  GtkWidget $target
)
  is native(gtk)
  is export
{ * }

sub gtk_window_begin_move_drag (
  GtkWindow $window,
  gint      $button,
  gint      $root_x,
  gint      $root_y,
  guint     $timestamp
)
  is native(gtk)
  is export
{ * }

sub gtk_window_begin_resize_drag (
  GtkWindow $window,
  uint32    $edge,                   # GdkWindowEdge $edge,
  gint      $button,
  gint      $root_x,
  gint      $root_y,
  guint     $timestamp
)
  is native(gtk)
  is export
{ * }

sub gtk_window_close (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_deiconify (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_fullscreen (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_fullscreen_on_monitor (
  GtkWindow $window,
  GdkScreen $screen,
  gint      $monitor
)
  is native(gtk)
  is export
{ * }

sub gtk_window_get_default_icon_list ()
  returns GList
  is native(gtk)
  is export
{ * }

sub gtk_window_get_default_icon_name ()
  returns Str
  is native(gtk)
  is export
{ * }

sub gtk_window_get_default_size (
  GtkWindow $window,
  gint      $width   is rw,
  gint      $height  is rw
)
  is native(gtk)
  is export
{ * }

sub gtk_window_get_default_widget (GtkWindow $window)
  returns GtkWidget
  is native(gtk)
  is export
{ * }


sub gtk_window_get_group (GtkWindow $window)
  returns GtkWindowGroup
  is native(gtk)
  is export
{ * }

sub gtk_window_get_position (GtkWindow $window, gint $root_x, gint $root_y)
  is native(gtk)
  is export
{ * }

sub gtk_window_get_resize_grip_area (GtkWindow $window, GdkRectangle $rect)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_size (
  GtkWindow $window,
  gint      $width   is rw,
  gint      $height  is rw
)
  is native(gtk)
  is export
{ * }

sub gtk_window_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

# --> GtkWindowType
sub gtk_window_get_window_type (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_has_group (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_has_toplevel_focus (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_iconify (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_is_active (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_is_maximized (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_list_toplevels ()
  returns GList
  is native(gtk)
  is export
{ * }

sub gtk_window_maximize (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_mnemonic_activate (
  GtkWindow $window,
  guint $keyval,
  uint32 $modifier              # GdkModifierType $modifier
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_move (GtkWindow $window, gint $x, gint $y)
  is native(gtk)
  is export
{ * }

# GtkWindowType $type
sub gtk_window_new (uint32 $type)
  returns GtkWidget
  is native(gtk)
  is export
{ * }

sub gtk_window_parse_geometry (GtkWindow $window, Str $geometry)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_present (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_present_with_time (GtkWindow $window, guint $timestamp)
  is native(gtk)
  is export
{ * }

sub gtk_window_propagate_key_event (GtkWindow $window, GdkEventKey $event)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_remove_accel_group (
  GtkWindow     $window,
  GtkAccelGroup $accel_group
)
  is native(gtk)
  is export
{ * }

sub gtk_window_remove_mnemonic (
  GtkWindow $window,
  guint     $keyval,
  GtkWidget $target
)
  is native(gtk)
  is export
{ * }

sub gtk_window_reshow_with_initial_size (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_resize (GtkWindow $window, gint $width, gint $height)
  is native(gtk)
  is export
{ * }

sub gtk_window_resize_grip_is_visible (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_resize_to_geometry (
  GtkWindow $window,
  gint      $width,
  gint      $height
)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_auto_startup_notification (gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default (GtkWindow $window, GtkWidget $default_widget)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default_geometry (
  GtkWindow $window,
  gint      $width,
  gint      $height
)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default_icon (GdkPixbuf $icon)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default_icon_from_file (
  Str $filename,
  CArray[Pointer[GError]] $err
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default_icon_list (GList $list)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default_icon_name (Str $name)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_default_size (GtkWindow $window, gint $width, gint $height)
  is native(gtk)
  is export
{ * }

# GdkWindowHints $geom_mask
sub gtk_window_set_geometry_hints (
  GtkWindow $window,
  GtkWidget $geometry_widget,
  GdkGeometry $geometry,
  uint32 $geom_mask
)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_has_user_ref_count (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_icon_from_file (
  GtkWindow               $window,
  Str                     $filename,
  CArray[Pointer[GError]] $err
)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_set_interactive_debugging (gboolean $enable)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_keep_above (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_keep_below (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

# GtkWindowPosition $position
sub gtk_window_set_position (GtkWindow $window, uint32 $position)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_startup_id (GtkWindow $window, Str $startup_id)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_wmclass (
  GtkWindow $window,
  Str       $wmclass_name,
  Str       $wmclass_class
)
  is native(gtk)
  is export
{ * }

sub gtk_window_stick (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_unfullscreen (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_unmaximize (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_unstick (GtkWindow $window)
  is native(gtk)
  is export
{ * }

sub gtk_window_get_titlebar (GtkWindow $window)
  returns GtkWidget
  is native(gtk)
  is export
{ * }

sub gtk_window_get_urgency_hint (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_modal (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_icon_name (GtkWindow $window)
  returns Str
  is native(gtk)
  is export
{ * }

sub gtk_window_get_skip_taskbar_hint (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_has_resize_grip (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_focus_visible (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_title (GtkWindow $window)
  returns Str
  is native(gtk)
  is export
{ * }

sub gtk_window_get_skip_pager_hint (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_screen (GtkWindow $window)
  returns GdkScreen
  is native(gtk)
  is export
{ * }

sub gtk_window_get_mnemonic_modifier (GtkWindow $window)
  returns uint32 # GdkModifierType
  is native(gtk)
  is export
{ * }

sub gtk_window_get_decorated (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_gravity (GtkWindow $window)
  returns uint32 # GdkGravity
  is native(gtk)
  is export
{ * }

sub gtk_window_get_focus_on_map (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

# --> GdkWindowTypeHint
sub gtk_window_get_type_hint (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_icon (GtkWindow $window)
  returns GdkPixbuf
  is native(gtk)
  is export
{ * }

sub gtk_window_get_mnemonics_visible (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_deletable (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_transient_for (GtkWindow $window)
  returns GtkWindow
  is native(gtk)
  is export
{ * }

sub gtk_window_get_attached_to (GtkWindow $window)
  returns GtkWidget
  is native(gtk)
  is export
{ * }

sub gtk_window_get_accept_focus (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_destroy_with_parent (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_role (GtkWindow $window)
  returns Str
  is native(gtk)
  is export
{ * }

sub gtk_window_get_application (GtkWindow $window)
  returns GtkApplication
  is native(gtk)
  is export
{ * }

sub gtk_window_get_focus (GtkWindow $window)
  returns GtkWidget
  is native(gtk)
  is export
{ * }

sub gtk_window_get_opacity (GtkWindow $window)
  returns gdouble
  is native(gtk)
  is export
{ * }

sub gtk_window_get_hide_titlebar_when_maximized (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_get_icon_list (GtkWindow $window)
  returns GList
  is native(gtk)
  is export
{ * }

sub gtk_window_get_resizable (GtkWindow $window)
  returns uint32
  is native(gtk)
  is export
{ * }

sub gtk_window_set_titlebar (GtkWindow $window, GtkWidget $titlebar)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_urgency_hint (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_modal (GtkWindow $window, gboolean $modal)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_icon_name (GtkWindow $window, Str $name)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_skip_taskbar_hint (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_has_resize_grip (GtkWindow $window, gboolean $value)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_focus_visible (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_title (GtkWindow $window, Str $title)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_skip_pager_hint (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_screen (GtkWindow $window, GdkScreen $screen)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_mnemonic_modifier (
  GtkWindow $window,
  uint32 $modifier              # GdkModifierType $modifier
)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_decorated (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_gravity (
  GtkWindow $window,
  uint32 $gravity               # GdkGravity $gravity
)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_focus_on_map (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

# GdkWindowTypeHint $hint
sub gtk_window_set_type_hint (GtkWindow $window, uint32 $hint)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_icon (GtkWindow $window, GdkPixbuf $icon)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_mnemonics_visible (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_deletable (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_transient_for (GtkWindow $window, GtkWindow $parent)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_attached_to (GtkWindow $window, GtkWidget $attach_widget)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_accept_focus (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_destroy_with_parent (GtkWindow $window, gboolean $setting)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_role (GtkWindow $window, Str $role)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_application (GtkWindow $window, GtkApplication $application)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_focus (GtkWindow $window, GtkWidget $focus)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_opacity (GtkWindow $window, gdouble $opacity)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_hide_titlebar_when_maximized (
  GtkWindow $window,
  gboolean  $setting
)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_icon_list (GtkWindow $window, GList $list)
  is native(gtk)
  is export
{ * }

sub gtk_window_set_resizable (GtkWindow $window, gboolean $resizable)
  is native(gtk)
  is export
{ * }
