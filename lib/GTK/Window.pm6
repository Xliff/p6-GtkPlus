use v6.c;

use GTK::Bin;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Window;

use GTK::Roles::Signals;

class GTK::Window is GTK::Bin {
  also does GTK::Roles::Signals;

  has GtkWindow $!win;

  submethod BUILD(:$window) {
    $!win = $window;
  }

  multi method new (
    GtkWindowType $type,
                 :$title = 'Window',
                 :$width  = 200,
                 :$height = 200
  ) {
    my $window = gtk_window_new($type);
    gtk_window_set_title($window, $title);
    gtk_window_set_default_size($window, $width, $height);

    self.bless(:$window, :bin($window), :container($window), :widget($window));
  }

  multi method new (:$window) {
    self.bless(:$window, :bin($window), :container($window), :widget($window));
  }

  # Signal void Action
  method activate-default {
    self.connect($!win, 'activate-default');
  }

  # Signal void Action
  method activate-focus {
    self.connect($!win, 'activate-focus');
  }

  # Signal gboolean Action
  method enable-debugging {
    self.connect($!win, 'enable-debugging');
  }

  # Signal void Run First
  method keys-changed {
    self.connect($!win, 'keys-changed');
  }

  # Signal void Run Last
  method set-focus {
    self.connect($!win, 'set-focus');
  }

  # *
  # * STATIC METHODS
  # *
  method set_auto_startup_notification (GTK::Window:U: gboolean $setting) {
    gtk_window_set_auto_startup_notification($setting);
  }

  method set_default_icon (GTK::Window:U: GdkPixbuf $icon) {
    gtk_window_set_default_icon($icon);
  }

  method set_default_icon_from_file (GTK::Window:U: gchar $filename, GError $err) {
    gtk_window_set_default_icon_from_file($filename, $err);
  }

  method set_default_icon_list (GTK::Window:U: GList $list) {
    gtk_window_set_default_icon_list($list);
  }

  method set_default_icon_name (GTK::Window:U: gchar $name) {
    gtk_window_set_default_icon_name($name);
  }

  method set_interactive_debugging (GTK::Window:U: gboolean $enable) {
    gtk_window_set_interactive_debugging($enable);
  }

  # ****************************************************************I


  method accept_focus is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_accept_focus($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_accept_focus($!win, $setting);
      }
    );
  }

  method application is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_application($!win);
      },
      STORE => sub ($, $application is copy) {
        gtk_window_set_application($!win, $application);
      }
    );
  }

  method attached_to is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_attached_to($!win);
      },
      STORE => sub ($, $attach_widget is copy) {
        gtk_window_set_attached_to($!win, $attach_widget);
      }
    );
  }

  method decorated is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_decorated($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_decorated($!win, $setting);
      }
    );
  }

  method deletable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_deletable($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_deletable($!win, $setting);
      }
    );
  }

  method destroy_with_parent is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_destroy_with_parent($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_destroy_with_parent($!win, $setting);
      }
    );
  }

  method focus is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_focus($!win);
      },
      STORE => sub ($, $focus is copy) {
        gtk_window_set_focus($!win, $focus);
      }
    );
  }

  method focus_on_map is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_focus_on_map($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_focus_on_map($!win, $setting);
      }
    );
  }

  method focus_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_focus_visible($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_focus_visible($!win, $setting);
      }
    );
  }

  method gravity is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_gravity($!win);
      },
      STORE => sub ($, $gravity is copy) {
        gtk_window_set_gravity($!win, $gravity);
      }
    );
  }

  method has_resize_grip is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_has_resize_grip($!win);
      },
      STORE => sub ($, $value is copy) {
        gtk_window_set_has_resize_grip($!win, $value);
      }
    );
  }

  method hide_titlebar_when_maximized is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_hide_titlebar_when_maximized($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_hide_titlebar_when_maximized($!win, $setting);
      }
    );
  }

  method icon is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_icon($!win);
      },
      STORE => sub ($, $icon is copy) {
        gtk_window_set_icon($!win, $icon);
      }
    );
  }

  method icon_list is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_icon_list($!win);
      },
      STORE => sub ($, $list is copy) {
        gtk_window_set_icon_list($!win, $list);
      }
    );
  }

  method icon_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_icon_name($!win);
      },
      STORE => sub ($, $name is copy) {
        gtk_window_set_icon_name($!win, $name);
      }
    );
  }

  method mnemonic_modifier is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_mnemonic_modifier($!win);
      },
      STORE => sub ($, $modifier is copy) {
        gtk_window_set_mnemonic_modifier($!win, $modifier);
      }
    );
  }

  method mnemonics_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_mnemonics_visible($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_mnemonics_visible($!win, $setting);
      }
    );
  }

  method modal is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_modal($!win);
      },
      STORE => sub ($, $modal is copy) {
        gtk_window_set_modal($!win, $modal);
      }
    );
  }

  method opacity is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_opacity($!win);
      },
      STORE => sub ($, $opacity is copy) {
        gtk_window_set_opacity($!win, $opacity);
      }
    );
  }

  method resizable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_resizable($!win);
      },
      STORE => sub ($, $resizable is copy) {
        gtk_window_set_resizable($!win, $resizable);
      }
    );
  }

  method role is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_role($!win);
      },
      STORE => sub ($, $role is copy) {
        gtk_window_set_role($!win, $role);
      }
    );
  }

  method screen is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_screen($!win);
      },
      STORE => sub ($, $screen is copy) {
        gtk_window_set_screen($!win, $screen);
      }
    );
  }

  method skip_pager_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_skip_pager_hint($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_skip_pager_hint($!win, $setting);
      }
    );
  }

  method skip_taskbar_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_skip_taskbar_hint($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_skip_taskbar_hint($!win, $setting);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_title($!win);
      },
      STORE => sub ($, $title is copy) {
        gtk_window_set_title($!win, $title);
      }
    );
  }

  method titlebar is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_titlebar($!win);
      },
      STORE => sub ($, $titlebar is copy) {
        gtk_window_set_titlebar($!win, $titlebar);
      }
    );
  }

  method transient_for is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_transient_for($!win);
      },
      STORE => sub ($, $parent is copy) {
        gtk_window_set_transient_for($!win, $parent);
      }
    );
  }

  method type_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_type_hint($!win);
      },
      STORE => sub ($, $hint is copy) {
        gtk_window_set_type_hint($!win, $hint);
      }
    );
  }

  method urgency_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_urgency_hint($!win);
      },
      STORE => sub ($, $setting is copy) {
        gtk_window_set_urgency_hint($!win, $setting);
      }
    );
  }

  method activate_default {
    gtk_window_activate_default($!win);
  }

  method activate_focus {
    gtk_window_activate_focus($!win);
  }

  method activate_key (GdkEventKey $event) {
    gtk_window_activate_key($!win, $event);
  }

  method add_accel_group (GtkAccelGroup $accel_group) {
    gtk_window_add_accel_group($!win, $accel_group);
  }

  method add_mnemonic (guint $keyval, GtkWidget $target) {
    gtk_window_add_mnemonic($!win, $keyval, $target);
  }

  method begin_move_drag (gint $button, gint $root_x, gint $root_y, guint $timestamp) {
    gtk_window_begin_move_drag($!win, $button, $root_x, $root_y, $timestamp);
  }

  method begin_resize_drag (GdkWindowEdge $edge, gint $button, gint $root_x, gint $root_y, guint $timestamp) {
    gtk_window_begin_resize_drag($!win, $edge, $button, $root_x, $root_y, $timestamp);
  }

  method close {
    gtk_window_close($!win);
  }

  method deiconify {
    gtk_window_deiconify($!win);
  }

  method fullscreen {
    gtk_window_fullscreen($!win);
  }

  method fullscreen_on_monitor (GdkScreen $screen, gint $monitor) {
    gtk_window_fullscreen_on_monitor($!win, $screen, $monitor);
  }

  method get_default_icon_list {
    gtk_window_get_default_icon_list();
  }

  method get_default_icon_name {
    gtk_window_get_default_icon_name();
  }

  method get_default_size (gint $width, gint $height) {
    gtk_window_get_default_size($!win, $width, $height);
  }

  method get_default_widget {
    gtk_window_get_default_widget($!win);
  }

  method get_group {
    gtk_window_get_group($!win);
  }

  method get_position (gint $root_x, gint $root_y) {
    gtk_window_get_position($!win, $root_x, $root_y);
  }

  method get_resize_grip_area (GdkRectangle $rect) {
    gtk_window_get_resize_grip_area($!win, $rect);
  }

  method get_size (gint $width, gint $height) {
    gtk_window_get_size($!win, $width, $height);
  }

  method get_type {
    gtk_window_get_type();
  }

  method get_window_type {
    gtk_window_get_window_type($!win);
  }

  method has_group {
    gtk_window_has_group($!win);
  }

  method has_toplevel_focus {
    gtk_window_has_toplevel_focus($!win);
  }

  method iconify {
    gtk_window_iconify($!win);
  }

  method is_active {
    gtk_window_is_active($!win);
  }

  method is_maximized {
    gtk_window_is_maximized($!win);
  }

  method list_toplevels {
    gtk_window_list_toplevels();
  }

  method maximize {
    gtk_window_maximize($!win);
  }

  method mnemonic_activate (guint $keyval, GdkModifierType $modifier) {
    gtk_window_mnemonic_activate($!win, $keyval, $modifier);
  }

  method move (gint $x, gint $y) {
    gtk_window_move($!win, $x, $y);
  }

  method parse_geometry (gchar $geometry) {
    gtk_window_parse_geometry($!win, $geometry);
  }

  method present {
    gtk_window_present($!win);
  }

  method present_with_time (guint $timestamp) {
    gtk_window_present_with_time($!win, $timestamp);
  }

  method propagate_key_event (GdkEventKey $event) {
    gtk_window_propagate_key_event($!win, $event);
  }

  method remove_accel_group (GtkAccelGroup $accel_group) {
    gtk_window_remove_accel_group($!win, $accel_group);
  }

  method remove_mnemonic (guint $keyval, GtkWidget $target) {
    gtk_window_remove_mnemonic($!win, $keyval, $target);
  }

  method reshow_with_initial_size {
    gtk_window_reshow_with_initial_size($!win);
  }

  method resize (gint $width, gint $height) {
    gtk_window_resize($!win, $width, $height);
  }

  method resize_grip_is_visible {
    gtk_window_resize_grip_is_visible($!win);
  }

  method resize_to_geometry (gint $width, gint $height) {
    gtk_window_resize_to_geometry($!win, $width, $height);
  }

  method set_default (GtkWidget $default_widget) {
    gtk_window_set_default($!win, $default_widget);
  }

  method set_default_geometry (gint $width, gint $height) {
    gtk_window_set_default_geometry($!win, $width, $height);
  }

  method set_default_size (gint $width, gint $height) {
    gtk_window_set_default_size($!win, $width, $height);
  }

  method set_geometry_hints (GtkWidget $geometry_widget, GdkGeometry $geometry, GdkWindowHints $geom_mask) {
    gtk_window_set_geometry_hints($!win, $geometry_widget, $geometry, $geom_mask);
  }

  method set_has_user_ref_count (gboolean $setting) {
    gtk_window_set_has_user_ref_count($!win, $setting);
  }

  method set_icon_from_file (gchar $filename, GError $err) {
    gtk_window_set_icon_from_file($!win, $filename, $err);
  }

  method set_keep_above (gboolean $setting) {
    gtk_window_set_keep_above($!win, $setting);
  }

  method set_keep_below (gboolean $setting) {
    gtk_window_set_keep_below($!win, $setting);
  }

  method set_position (GtkWindowPosition $position) {
    gtk_window_set_position($!win, $position);
  }

  method set_startup_id (gchar $startup_id) {
    gtk_window_set_startup_id($!win, $startup_id);
  }

  method set_wmclass (gchar $wmclass_name, gchar $wmclass_class) {
    gtk_window_set_wmclass($!win, $wmclass_name, $wmclass_class);
  }

  method stick {
    gtk_window_stick($!win);
  }

  method unfullscreen {
    gtk_window_unfullscreen($!win);
  }

  method unmaximize {
    gtk_window_unmaximize($!win);
  }

  method unstick {
    gtk_window_unstick($!win);
  }

}
