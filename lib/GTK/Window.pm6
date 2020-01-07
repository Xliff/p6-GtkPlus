use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Bin;
use GTK::Widget;

use GLib::GList;
use GDK::Pixbuf;

use GDK::Screen;
use GTK::Raw::Types;
use GTK::Raw::Window;

our subset WindowAncestry is export where GtkWindow | BinAncestry;

# ALL METHODS NEED PERL6 REFINEMENTS!!

class GTK::Window is GTK::Bin {
  has GtkWindow $!win is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$window, :$title, :$width, :$height) {
    given $window {
      when WindowAncestry {
        self.setWindow($window);
        # This still isn't working!
        self.title = $title if $title;
        self.set-default-size($width, $height) if $width && $height;
      }
      when GTK::Window {
      }
      default {
      }
    }
  }

  method setWindow(WindowAncestry $window) {
    my $to-parent;
    $!win = do given $window {
      when GtkWindow {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
      when BinAncestry {
        $to-parent = $_;
        nativecast(GtkWindow, $_);
      }
    }
    self.setBin($to-parent);
  }

  multi method new (WindowAncestry $window) {
    my $o = self.bless(:$window);
    $o.upref;
    $o;
  }
  multi method new (
    Str $title   = 'Window',
    Int :$type   = GTK_WINDOW_TOPLEVEL,           # GtkWindowType $type,
    Int :$width  = 200,
    Int :$height = 200
  ) {
    my guint $t = $type;
    my $window = gtk_window_new($t);
    samewith($window, :$title, :$width, :$height);
  }
  # This multi could be deprecated.
  multi method new (
    Int $type    = GTK_WINDOW_TOPLEVEL,           # GtkWindowType $type,
    Str :$title  = 'Window',
    Int :$width  = 200,
    Int :$height = 200
  ) {
    my guint $t = $type;
    my $window = gtk_window_new($t);
    samewith($window, :$title, :$width, :$height);
  }
  multi method new (
    GtkWindow $window,
    Str :$title = 'Window',
    Int :$width  = 200,
    Int :$height = 200
  ) {
    $window ?? self.bless(:$window, :$title, :$width, :$height) !! Nil;
  }

  method GTK::Raw::Types::GtkWindow
    is also<
      window
      GtkWindow
    >
  { $!win }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkWindow, gpointer --> void
  method activate-default is also<activate_default> {
    self.connect($!win, 'activate-default');
  }

  # Is originally:
  # GtkWindow, gpointer --> void
  method activate-focus is also<activate_focus> {
    self.connect($!win, 'activate-focus');
  }

  # Is originally:
  # GtkWindow, gboolean, gpointer --> gboolean
  method enable-debugging is also<enable_debugging> {
    self.connect-uint-ruint($!win, 'enable-debugging');
  }

  # Is originally:
  # GtkWindow, gpointer --> void
  method keys-changed is also<keys_changed> {
    self.connect($!win, 'keys-changed');
  }

  # Is originally:
  # GtkWindow, GtkWidget, gpointer --> void
  method set-focus is also<set_focus> {
    self.connect-widget($!win, 'set-focus');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑


  # *
  # * STATIC METHODS
  # *
  method set_auto_startup_notification (GTK::Window:U: Int() $setting)
    is also<set-auto-startup-notification>
  {
    # Static, so cannot use resolve-bool
    my gboolean $s = $setting.so.Int;

    gtk_window_set_auto_startup_notification($s);
  }

  method set_default_icon (GTK::Window:U: GdkPixbuf() $icon)
    is also<set-default-icon>
  {
    gtk_window_set_default_icon($icon);
  }

  method set_default_icon_from_file (
    GTK::Window:U: Str() $filename,
    CArray[Pointer[GError]] $err = gerror
  )
    is also<set-default-icon-from-file>
  {
    gtk_window_set_default_icon_from_file($filename, $err);
  }

  method set_default_icon_list (GTK::Window:U: GList() $list)
    is also<set-default-icon-list>
  {
    gtk_window_set_default_icon_list($list);
  }

  method set_default_icon_name (GTK::Window:U: Str() $name)
    is also<set-default-icon-name>
  {
    gtk_window_set_default_icon_name($name);
  }

  method set_interactive_debugging (GTK::Window:U: Int() $enable)
    is also<set-interactive-debugging>
  {
    # Static, so cannot use resolve-bool
    my gboolean $e = $enable.so.Int;

    gtk_window_set_interactive_debugging($enable);
  }

  # ****************************************************************

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accept_focus is rw is also<accept-focus> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_accept_focus($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

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

  method attached_to is rw is also<attached-to> {
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
        my gboolean $s = $setting.so.Int;

        gtk_window_set_decorated($!win, $s);
      }
    );
  }

  method deletable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_deletable($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_deletable($!win, $s);
      }
    );
  }

  method destroy_with_parent is rw is also<destroy-with-parent> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_destroy_with_parent($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

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

  method focus_on_map is rw is also<focus-on-map> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_focus_on_map($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_focus_on_map($!win, $s);
      }
    );
  }

  method focus_visible is rw is also<focus-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_focus_visible($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_focus_visible($!win, $s);
      }
    );
  }

  method gravity is rw {
    Proxy.new(
      FETCH => sub ($) {
        GdkGravity( gtk_window_get_gravity($!win) );
      },
      STORE => sub ($, Int() $gravity is copy) {
        my uint32 $g = $gravity;

        gtk_window_set_gravity($!win, $g);
      }
    );
  }

  method has_resize_grip is rw is also<has-resize-grip> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_has_resize_grip($!win);
      },
      STORE => sub ($, Int() $value is copy) {
        my gboolean $v = $value.so.Int;

        gtk_window_set_has_resize_grip($!win, $v);
      }
    );
  }

  method hide_titlebar_when_maximized
    is rw
    is also<hide-titlebar-when-maximized>
  {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_hide_titlebar_when_maximized($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_hide_titlebar_when_maximized($!win, $s);
      }
    );
  }

  method icon is rw {
    Proxy.new(
      FETCH => sub ($) {
        GDK::Pixbuf( gtk_window_get_icon($!win) );
      },
      STORE => sub ($, GdkPixbuf() $icon is copy) {
        gtk_window_set_icon($!win, $icon);
      }
    );
  }

  method icon_list is rw is also<icon-list> {
    Proxy.new(
      FETCH => sub ($) {
        GLib::GList.new( GdkPixbuf, gtk_window_get_icon_list($!win) );
      },
      STORE => sub ($, GList() $list is copy) {
        gtk_window_set_icon_list($!win, $list);
      }
    );
  }

  method icon_name is rw is also<icon-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_window_get_icon_name($!win);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_window_set_icon_name($!win, $name);
      }
    );
  }

  method mnemonic_modifier is rw is also<mnemonic-modifier> {
    Proxy.new(
      FETCH => sub ($) {
        GdkModifierTypeEnum( gtk_window_get_mnemonic_modifier($!win) );
      },
      STORE => sub ($, Int() $modifier is copy) {
        my GdkModifierType $m = $modifier;

        gtk_window_set_mnemonic_modifier($!win, $m);
      }
    );
  }

  method mnemonics_visible is rw is also<mnemonics-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_mnemonics_visible($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_mnemonics_visible($!win, $s);
      }
    );
  }

  method modal is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_modal($!win);
      },
      STORE => sub ($, Int() $modal is copy) {
        my gboolean $m = $modal.so.Int;

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
        so gtk_window_get_resizable($!win);
      },
      STORE => sub ($, Int() $resizable is copy) {
        my gboolean $r = $resizable.so.Int;

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
        GDK::Screen.new( gtk_window_get_screen($!win) );
      },
      STORE => sub ($, GdkScreen() $screen is copy) {
        gtk_window_set_screen($!win, $screen);
      }
    );
  }

  method skip_pager_hint is rw is also<skip-pager-hint> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_skip_pager_hint($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_skip_pager_hint($!win, $s);
      }
    );
  }

  method skip_taskbar_hint is rw is also<skip-taskbar-hint> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_skip_taskbar_hint($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

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
        # Would use CreateObject, but there are questions regarding the
        # lexical nature of 'use'. If an attempt is made to dynamically
        # require the right object here, a circular dependency may be
        # induced. It's safer to create the Widget, and let the caller
        # make the call to CreateObject via:
        #     GTK::Widget.CreateObject($returned.Widget)
        GTK::Widget.new( gtk_window_get_titlebar($!win) );
      },
      STORE => sub ($, GtkWidget() $titlebar is copy) {
        gtk_window_set_titlebar($!win, $titlebar);
      }
    );
  }

  method transient_for is rw is also<transient-for> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Window.new( gtk_window_get_transient_for($!win) );
      },
      STORE => sub ($, GtkWindow() $parent is copy) {
        gtk_window_set_transient_for($!win, $parent);
      }
    );
  }

  method type_hint is rw is also<type-hint> {
    Proxy.new(
      FETCH => sub ($) {
        GdkWindowTypeHint( gtk_window_get_type_hint($!win) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my uint32 $h = $hint;

        gtk_window_set_type_hint($!win, $h);
      }
    );
  }

  method urgency_hint is rw is also<urgency-hint> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_urgency_hint($!win);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting.so.Int;

        gtk_window_set_urgency_hint($!win, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  method activate_default_widget is also<activate-default-widget> {
    gtk_window_activate_default($!win);
  }

  method activate_focused_widget is also<activate-focused-widget> {
    gtk_window_activate_focus($!win);
  }

  method activate_key (GdkEventKey $event) is also<activate-key> {
    gtk_window_activate_key($!win, $event);
  }

  method add_accel_group (GtkAccelGroup $accel_group)
    is also<add-accel-group>
  {
    # Need class GTK::AccelGroup
    gtk_window_add_accel_group($!win, $accel_group);
  }

  method add_mnemonic (Int() $keyval, GtkWidget() $target)
    is also<add-mnemonic>
  {
    my guint $k = $keyval;

    gtk_window_add_mnemonic($!win, $keyval, $target);
  }

  method begin_move_drag (
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  )
    is also<begin-move-drag>
  {
    my gint ($b, $rx, $ry) = ($button, $root_x, $root_y);
    my guint $t = $timestamp;

    gtk_window_begin_move_drag($!win, $b, $rx, $ry, $t);
  }

  method begin_resize_drag (
    Int() $edge,                  # GdkWindowEdge $edge,
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  )
    is also<begin-resize-drag>
  {
    my uint32 $e = $edge;
    my gint ($b, $rx, $ry) = ($button, $root_x, $root_y);
    my guint $t = $timestamp;

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

  method fullscreen_on_monitor (GdkScreen() $screen, Int() $monitor)
    is also<fullscreen-on-monitor>
  {
    my gint $m = $monitor;

    gtk_window_fullscreen_on_monitor($!win, $screen, $m);
  }

  method get_default_icon_list
    is also<get-default-icon-list>
  {
    gtk_window_get_default_icon_list();
  }

  method get_default_icon_name
    is also<get-default-icon-name>
  {
    gtk_window_get_default_icon_name();
  }

  method get_default_size (Int() $width, Int() $height)
    is also<get-default-size>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_window_get_default_size($!win, $w, $h);
  }

  method get_default_widget is also<get-default-widget> {
    gtk_window_get_default_widget($!win);
  }

  method get_group is also<get-group> {
    gtk_window_get_group($!win);
  }

  method get_position (Int() $root_x, Int() $root_y) is also<get-position> {
    my gint ($rx, $ry) = ($root_x, $root_y);

    gtk_window_get_position($!win, $rx, $ry);
  }

  method get_resize_grip_area (GdkRectangle() $rect)
    is also<get-resize-grip-area>
  {
    gtk_window_get_resize_grip_area($!win, $rect);
  }

  multi method get-size {
    self.get_size;
  }
  multi method get_size {
    my ($width, $height) = (0, 0);
    samewith($width, $height);
    ($width, $height);
  }
  multi method get-size (Int() $width is rw, Int() $height is rw) {
    self.get_size($width, $height);
  }
  multi method get_size (Int() $width is rw, Int() $height is rw) {
    my gint ($w, $h) = ($width, $height);
    my $rc = gtk_window_get_size($!win, $w, $h);

    ($width, $height) = ($w, $h);
    $rc;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_window_get_type, $n, $t );
  }

  method get_window_type is also<get-window-type> {
    gtk_window_get_window_type($!win);
  }

  method has_group is also<has-group> {
    gtk_window_has_group($!win);
  }

  method has_toplevel_focus is also<has-toplevel-focus> {
    gtk_window_has_toplevel_focus($!win);
  }

  method iconify {
    gtk_window_iconify($!win);
  }

  method is_active is also<is-active> {
    gtk_window_is_active($!win);
  }

  method is_maximized is also<is-maximized> {
    gtk_window_is_maximized($!win);
  }

  method list_toplevels is also<list-toplevels> {
    GList.new( GtkWidget, gtk_window_list_toplevels() );
  }

  method maximize {
    gtk_window_maximize($!win);
  }

  method mnemonic_activate (
    Int() $keyval,                # guint $keyval,
    Int() $modifier               # GdkModifierType $modifier
  )
    is also<mnemonic-activate>
  {
    my guint ($kv, $m) = ($keyval, $modifier);

    gtk_window_mnemonic_activate($!win, $kv, $m);
  }

  method move (Int() $x, Int() $y) {
    my gint ($xx, $yy) = ($x, $y);

    gtk_window_move($!win, $xx, $yy);
  }

  method parse_geometry (Str() $geometry) is also<parse-geometry> {
    gtk_window_parse_geometry($!win, $geometry);
  }

  method present {
    gtk_window_present($!win);
  }

  method present_with_time (Int() $timestamp) is also<present-with-time> {
    my guint $t = $timestamp;

    gtk_window_present_with_time($!win, $t);
  }

  method propagate_key_event (GdkEventKey $event)
    is also<propagate-key-event>
  {
    Bool( gtk_window_propagate_key_event($!win, $event) );
  }

  method remove_accel_group (GtkAccelGroup $accel_group)
    is also<remove-accel-group>
  {
    gtk_window_remove_accel_group($!win, $accel_group);
  }

  method remove_mnemonic (
    Int() $keyval,                # guint $keyval,
    GtkWidget() $target
  )
    is also<remove-mnemonic>
  {
    my guint $kv = $keyval;

    gtk_window_remove_mnemonic($!win, $kv, $target);
  }

  method reshow_with_initial_size
    is also<reshow-with-initial-size>
  {
    gtk_window_reshow_with_initial_size($!win);
  }

  method resize (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gtk_window_resize($!win, $w, $h);
  }

  method resize_grip_is_visible
    is also<resize-grip-is-visible>
  {
    gtk_window_resize_grip_is_visible($!win);
  }

  method resize_to_geometry (Int() $width, Int() $height)
    is also<resize-to-geometry>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_window_resize_to_geometry($!win, $w, $h);
  }

  method set_default (GtkWidget() $default_widget)
    is also<set-default>
  {
    gtk_window_set_default($!win, $default_widget);
  }

  method set_default_geometry (Int() $width, Int() $height)
    is also<set-default-geometry>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_window_set_default_geometry($!win, $w, $h);
  }

  method set_default_size (Int() $width, Int() $height)
    is also<set-default-size>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_window_set_default_size($!win, $w, $h);
  }

  method set_geometry_hints (
    GtkWidget() $geometry_widget,
    GdkGeometry $geometry,
    Int() $geom_mask                # GdkWindowHints
  )
    is also<set-geometry-hints>
  {
    my uint32 $gm = $geom_mask;

    gtk_window_set_geometry_hints($!win, $geometry_widget, $geometry, $gm);
  }

  method set_has_user_ref_count (Int() $setting)
    is also<set-has-user-ref-count>
  {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_has_user_ref_count($!win, $setting);
  }

  method set_icon_from_file (
    Str() $filename,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-icon-from-file>
  {
    clear_error;
    my $rv = gtk_window_set_icon_from_file($!win, $filename, $error);
    set_error($error);
    $rv;
  }

  method set_keep_above (Int() $setting) is also<set-keep-above> {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_keep_above($!win, $s);
  }

  method set_keep_below (Int() $setting) is also<set-keep-below> {
    my gboolean $s = $setting.so.Int;

    gtk_window_set_keep_below($!win, $s);
  }

  method set_position (Int() $position) is also<set-position> {
    my uint32 $p = $position;

    gtk_window_set_position($!win, $p);
  }

  method set_startup_id (Str() $startup_id) is also<set-startup-id> {
    gtk_window_set_startup_id($!win, $startup_id);
  }

  method set_wmclass (Str() $wmclass_name, Str() $wmclass_class)
    is also<set-wmclass>
  {
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
