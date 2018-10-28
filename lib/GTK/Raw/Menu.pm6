use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Menu;

sub gtk_menu_attach (
  GtkMenu $menu,
  GtkWidget $child,
  guint $left_attach,
  guint $right_attach,
  guint $top_attach,
  guint $bottom_attach
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_attach_to_widget (
  GtkMenu $menu,
  GtkWidget $attach_widget,
  GtkMenuDetachFunc $detacher
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_detach (GtkMenu $menu)
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_attach_widget (GtkMenu $menu)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_for_attach_widget (GtkWidget $widget)
  returns GList
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_menu_new ()
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_new_from_model (GMenuModel $model)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_place_on_monitor (GtkMenu $menu, GdkMonitor $monitor)
  is native(gtk)
  is export
  { * }

sub gtk_menu_popdown (GtkMenu $menu)
  is native(gtk)
  is export
  { * }

sub gtk_menu_popup (
  GtkMenu $menu,
  GtkWidget $parent_menu_shell,
  GtkWidget $parent_menu_item,
  GtkMenuPositionFunc $func,
  gpointer $data,
  guint $button,
  guint32 $activate_time
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_popup_at_pointer (GtkMenu $menu, GdkEvent $trigger_event)
  is native(gtk)
  is export
  { * }

sub gtk_menu_popup_at_rect (
  GtkMenu $menu,
  GdkWindow $rect_window,
  GdkRectangle $rect,
  uint32 $rect_anchor,            # GdkGravity $rect_anchor,
  uint32 $menu_anchor,            # GdkGravity $menu_anchor,
  GdkEvent $trigger_event
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_popup_at_widget (
  GtkMenu $menu,
  GtkWidget $widget,
  uint32 $wisdget_anchor,         # GdkGravity $widget_anchor,
  uint32 $menu_anchor,            # GdkGravity $menu_anchor,
  GdkEvent $trigger_event
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_popup_for_device (
  GtkMenu $menu,
  GdkDevice $device,
  GtkWidget $parent_menu_shell,
  GtkWidget $parent_menu_item,
  GtkMenuPositionFunc $func,
  gpointer $data,
  GDestroyNotify $destroy,
  guint $button,
  guint32 $activate_time
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_reorder_child (
  GtkMenu $menu,
  GtkWidget $child,
  gint $position
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_reposition (GtkMenu $menu)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_screen (GtkMenu $menu, GdkScreen $screen)
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_tearoff_state (GtkMenu $menu)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_accel_group (GtkMenu $menu)
  returns GtkAccelGroup
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_title (GtkMenu $menu)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_accel_path (GtkMenu $menu)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_active (GtkMenu $menu)
  returns GtkWidget
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_reserve_toggle_size (GtkMenu $menu)
  returns uint32
  is native(gtk)
  is export
  { * }

sub gtk_menu_get_monitor (GtkMenu $menu)
  returns gint
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_tearoff_state (GtkMenu $menu, gboolean $torn_off)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_accel_group (GtkMenu $menu, GtkAccelGroup $accel_group)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_title (GtkMenu $menu, gchar $title)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_accel_path (GtkMenu $menu, gchar $accel_path)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_active (GtkMenu $menu, guint $index)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_reserve_toggle_size (
  GtkMenu $menu,
  gboolean $reserve_toggle_size
)
  is native(gtk)
  is export
  { * }

sub gtk_menu_set_monitor (GtkMenu $menu, gint $monitor_num)
  is native(gtk)
  is export
  { * }