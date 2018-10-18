use v6.c;

use NativeCall;

use GTK::Bin;
use GTK::Widget;

use GTK::Compat::GList;
use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::Window;

# ALL METHODS NEED PERL6 REFINEMENTS!!

class GTK::Window is GTK::Bin {
  has GtkWindow $!win;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Window');
    $o;
  }

  submethod BUILD(:$window) {
    given $window {
      when GtkWindow | GtkWidget {
        self.setWindow($window);
      }
      when GTK::Window {
      }
      default {
      }
    }
  }

  multi method new (
    GtkWindowType $type,
    Str :$title = 'Window',
    Int :$width  = 200,
    Int :$height = 200
  ) {
    my $window = gtk_window_new($type);
    gtk_window_set_title($window, $title);
    gtk_window_set_default_size($window, $width, $height);
    samewith(:$window);
  }
  multi method new (GtkWidget $widget) {
    self.bless(:window($widget));
  }
  multi method new (GtkWindow $window) {
    self.bless(:$window);
  }

  method setWindow($window) {
    my $to-parent;
    $!win = do given $window {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkWindow, $_);
      }
      when GtkWindow {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
    }
    self.setBin($to-parent);
  }

  method GTK::Raw::Types::GtkWindow {
    $!win;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkWindow, gpointer --> void
  method activate-default {
    self.connect($!win, 'activate-default');
  }

  # Is originally:
  # GtkWindow, gpointer --> void
  method activate-focus {
    self.connect($!win, 'activate-focus');
  }

  # Is originally:
  # GtkWindow, gboolean, gpointer --> gboolean
  method enable-debugging {
    self.connect-uint-ruint($!win, 'enable-debugging');
  }

  # Is originally:
  # GtkWindow, gpointer --> void
  method keys-changed {
    self.connect($!win, 'keys-changed');
  }

  # Is originally:
  # GtkWindow, GtkWidget, gpointer --> void
  method set-focus {
    self.connect-widget($!win, 'set-focus');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑


  # *
  # * STATIC METHODS
  # *
  method set_auto_startup_notification (GTK::Window:U: Int() $setting) {
    # Static, so cannot use RESOLVE-BOOL
    my $s = $setting == 0 ?? 0 !! 1;
    gtk_window_set_auto_startup_notification($s);
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

  method set_interactive_debugging (GTK::Window:U: Int() $enable) {
    # Static, so cannot use RESOLVE-BOOL
    my gboolean $e = $enable == 0 ?? 0 !! 1;
    gtk_window_set_interactive_debugging($enable);
  }

  # ****************************************************************

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accept_focus is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_accept_focus($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_accept_focus($!win, $s);
      }
    );
  }

  method application is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_application($!win);
      },
      STORE => sub ($, GtkApplication() $application is copy) {
        gtk_window_set_application($!win, $application);
      }
    );
  }

  method attached_to is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_attached_to($!win);
      },
      STORE => sub ($, GtkWidget() $attach_widget is copy) {
        gtk_window_set_attached_to($!win, $attach_widget);
      }
    );
  }

  method decorated is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_decorated($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_decorated($!win, $s);
      }
    );
  }

  method deletable is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_deletable($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_deletable($!win, $s);
      }
    );
  }

  method destroy_with_parent is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_destroy_with_parent($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_destroy_with_parent($!win, $s);
      }
    );
  }

  method focus is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_focus($!win);
      },
      STORE => sub ($, GtkWidget() $focus is copy) {
        gtk_window_set_focus($!win, $focus);
      }
    );
  }

  method focus_on_map is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_focus_on_map($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_focus_on_map($!win, $s);
      }
    );
  }

  method focus_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_focus_visible($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_focus_visible($!win, $s);
      }
    );
  }

  method gravity is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_gravity($!win);
      },
      STORE => sub ($, Int() $gravity is copy) {
        my uint32 $g = self.RESOLVE-UINT($gravity);
        gtk_window_set_gravity($!win, $g);
      }
    );
  }

  method has_resize_grip is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_has_resize_grip($!win) );
      },
      STORE => sub ($, Int() $value is copy) {
        my gboolean $v = self.RESOLVE-UINT($value);
        gtk_window_set_has_resize_grip($!win, $v);
      }
    );
  }

  method hide_titlebar_when_maximized is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_hide_titlebar_when_maximized($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_hide_titlebar_when_maximized($!win, $s);
      }
    );
  }

  method icon is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_icon($!win);
      },
      STORE => sub ($, GdkPixbuf $icon is copy) {
        gtk_window_set_icon($!win, $icon);
      }
    );
  }

  method icon_list is rw {
    Proxy.new(
      FETCH => sub ($) {
        GList.new( gtk_window_get_icon_list($!win) );
      },
      STORE => sub ($, GList() $list is copy) {
        gtk_window_set_icon_list($!win, $list);
      }
    );
  }

  method icon_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_icon_name($!win);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_window_set_icon_name($!win, $name);
      }
    );
  }

  method mnemonic_modifier is rw {
    Proxy.new(
      FETCH => sub ($) {
        GdkModifierType( gtk_window_get_mnemonic_modifier($!win) );
      },
      STORE => sub ($, Int() $modifier is copy) {
        my uint32 $m = self.RESOLVE-UINT($modifier);
        gtk_window_set_mnemonic_modifier($!win, $m);
      }
    );
  }

  method mnemonics_visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_mnemonics_visible($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_mnemonics_visible($!win, $s);
      }
    );
  }

  method modal is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_modal($!win) );
      },
      STORE => sub ($, Int() $modal is copy) {
        my gboolean $m = self.RESOLVE-BOOL($modal);
        gtk_window_set_modal($!win, $m);
      }
    );
  }

  # DO NOT USE -- Is deprecated and conflicts with the recommended
  # function implemented in GTK::Widget
  #
  # method opacity is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       Bool( gtk_window_get_opacity($!win) );
  #     },
  #     STORE => sub ($, Num() $opacity is copy) {
  #       my gdouble $o = $opacity;
  #       gtk_window_set_opacity($!win, $o);
  #     }
  #   );
  # }

  method resizable is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_resizable($!win) );
      },
      STORE => sub ($, Int() $resizable is copy) {
        my gboolean $r = self.RESOLVE-BOOL($resizable);
        gtk_window_set_resizable($!win, $r);
      }
    );
  }

  method role is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_role($!win);
      },
      STORE => sub ($, Str() $role is copy) {
        gtk_window_set_role($!win, $role);
      }
    );
  }

  method screen is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_screen($!win);
      },
      STORE => sub ($, GdkScreen $screen is copy) {
        gtk_window_set_screen($!win, $screen);
      }
    );
  }

  method skip_pager_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_skip_pager_hint($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_skip_pager_hint($!win, $s);
      }
    );
  }

  method skip_taskbar_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_skip_taskbar_hint($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_skip_taskbar_hint($!win, $s);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_title($!win);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_window_set_title($!win, $title);
      }
    );
  }

  method titlebar is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_titlebar($!win);
      },
      STORE => sub ($, GtkWidget() $titlebar is copy) {
        gtk_window_set_titlebar($!win, $titlebar);
      }
    );
  }

  method transient_for is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Window.new( gtk_window_get_transient_for($!win) );
      },
      STORE => sub ($, GtkWindow() $parent is copy) {
        gtk_window_set_transient_for($!win, $parent);
      }
    );
  }

  method type_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        GdkWindowTypeHint( gtk_window_get_type_hint($!win) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my uint32 $h = self.RESOLVE-UINT($hint);
        gtk_window_set_type_hint($!win, $h);
      }
    );
  }

  method urgency_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_window_get_urgency_hint($!win) );
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_window_set_urgency_hint($!win, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

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
    # Need class GTK::AccelGroup
    gtk_window_add_accel_group($!win, $accel_group);
  }

  method add_mnemonic (Int() $keyval, GtkWidget() $target) {
    my guint $k = self.RESOLVE-UINT($keyval);
    gtk_window_add_mnemonic($!win, $keyval, $target);
  }

  method begin_move_drag (
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  ) {
    my @ui = ($button, $root_x, $root_y);
    my gint ($b, $rx, $ry) = self.RESOLVE-INT(@ui);
    my guint $t = self.RESOLVE-UINT($timestamp);
    gtk_window_begin_move_drag($!win, $b, $rx, $ry, $t);
  }

  method begin_resize_drag (
    Int() $edge,                  # GdkWindowEdge $edge,
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  ) {
    my uint32 $e = self.RESOLVE-UINT($edge);
    my @ui = ($button, $root_x, $root_y);
    my gint ($b, $rx, $ry) = self.RESOLVE-INT(@ui);
    my guint $t = self.RESOLVE-UINT($timestamp);
    gtk_window_begin_resize_drag($!win, $e, $b, $rx, $ry, $t);
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

  method fullscreen_on_monitor (GdkScreen $screen, Int() $monitor) {
    my gint $m = self.RESOLVE-INT($monitor);
    gtk_window_fullscreen_on_monitor($!win, $screen, $m);
  }

  method get_default_icon_list {
    gtk_window_get_default_icon_list();
  }

  method get_default_icon_name {
    gtk_window_get_default_icon_name();
  }

  method get_default_size (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_window_get_default_size($!win, $w, $h);
  }

  method get_default_widget {
    gtk_window_get_default_widget($!win);
  }

  method get_group {
    gtk_window_get_group($!win);
  }

  method get_position (Int() $root_x, Int() $root_y) {
    my @i = ($root_x, $root_y);
    my gint ($rx, $ry) = self.RESOLVE-INT(@i);
    gtk_window_get_position($!win, $rx, $ry);
  }

  method get_resize_grip_area (GdkRectangle() $rect) {
    gtk_window_get_resize_grip_area($!win, $rect);
  }

  multi method get_size {
    my ($width, $height) = (0, 0);
    samewith($width, $height);
    ($width, $height);
  }
  multi method get_size (Int() $width is rw, Int() $height is rw) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    my $rc = gtk_window_get_size($!win, $w, $h);
    ($width, $height) = ($w, $h);
    $rc;
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
    GList.new( gtk_window_list_toplevels() );
  }

  method maximize {
    gtk_window_maximize($!win);
  }

  method mnemonic_activate (
    Int() $keyval,                # guint $keyval,
    Int() $modifier               # GdkModifierType $modifier
  ) {
    my @u = ($keyval, $modifier);
    my guint ($kv, $m) = self.RESOLVE-UINT(@u);
    gtk_window_mnemonic_activate($!win, $kv, $m);
  }

  method move (Int() $x, Int() $y) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    gtk_window_move($!win, $xx, $yy);
  }

  method parse_geometry (gchar $geometry) {
    gtk_window_parse_geometry($!win, $geometry);
  }

  method present {
    gtk_window_present($!win);
  }

  method present_with_time (Int() $timestamp) {
    my guint $t = self.RESOLVE-UINT($timestamp);
    gtk_window_present_with_time($!win, $t);
  }

  method propagate_key_event (GdkEventKey $event) {
    Bool( gtk_window_propagate_key_event($!win, $event) );
  }

  method remove_accel_group (GtkAccelGroup $accel_group) {
    gtk_window_remove_accel_group($!win, $accel_group);
  }

  method remove_mnemonic (
    Int() $keyval,                # guint $keyval,
    GtkWidget() $target
  ) {
    my guint $kv = self.RESOLVE-UINT($keyval);
    gtk_window_remove_mnemonic($!win, $kv, $target);
  }

  method reshow_with_initial_size {
    gtk_window_reshow_with_initial_size($!win);
  }

  method resize (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_window_resize($!win, $w, $h);
  }

  method resize_grip_is_visible {
    gtk_window_resize_grip_is_visible($!win);
  }

  method resize_to_geometry (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_window_resize_to_geometry($!win, $w, $h);
  }

  method set_default (GtkWidget() $default_widget) {
    gtk_window_set_default($!win, $default_widget);
  }

  method set_default_geometry (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_window_set_default_geometry($!win, $w, $h);
  }

  method set_default_size (Int() $width, Int() $height) {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_window_set_default_size($!win, $w, $h);
  }

  method set_geometry_hints (
    GtkWidget() $geometry_widget,
    GdkGeometry $geometry,
    Int() $geom_mask                # GdkWindowHints
  ) {
    my uint32 $gm = self.RESOLVE-UINT($geom_mask);
    gtk_window_set_geometry_hints($!win, $geometry_widget, $geometry, $gm);
  }

  method set_has_user_ref_count (Int() $setting) {
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gtk_window_set_has_user_ref_count($!win, $setting);
  }

  method set_icon_from_file (gchar $filename, GError $err) {
    gtk_window_set_icon_from_file($!win, $filename, $err);
  }

  method set_keep_above (Int() $setting) {
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gtk_window_set_keep_above($!win, $s);
  }

  method set_keep_below (Int() $setting) {
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gtk_window_set_keep_below($!win, $s);
  }

  method set_position (Int() $position) {
    my uint32 $p = self.RESOLVE-UINT($position);
    gtk_window_set_position($!win, $p);
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
