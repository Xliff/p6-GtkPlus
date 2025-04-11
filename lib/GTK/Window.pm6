use v6.c;

use Method::Also;
use NativeCall;

use GTK::Bin:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GLib::GList;
use GDK::Pixbuf;
use GTK::WindowGroup:ver<3.0.1146>;

use GDK::Screen;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::Window:ver<3.0.1146>;

our subset GtkWindowAncestry is export
  where GtkWindow | GtkBinAncestry;

constant WindowAncestry is export := GtkWindowAncestry;

# ALL METHODS NEED PERL6 REFINEMENTS!!

class GTK::Window:ver<3.0.1146> is GTK::Bin {
  has GtkWindow $!win is implementor;

  submethod BUILD (:$window, :$title, :$width, :$height) {
    if $window {
      self.setWindow($window);
      # This still isn't working!
      self.title = $title if $title;
      self.set-default-size($width, $height) if $width && $height;
    }
  }

  method setGtkWindow (WindowAncestry $_)
    is also<setWindow>
  {
    my $to-parent;

    $!win = do {
      when GtkWindow {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }

      default {
        $to-parent = $_;
        nativecast(GtkWindow, $_);
      }
    }
    self.setGtkBin($to-parent);
  }

  method GTK::Raw::Definitions::GtkWindow
    is also<
      Window
      GtkWindow
    >
  { $!win }

  multi method new (WindowAncestry $window, :$ref = True) {
    return Nil unless $window;

    my $o = self.bless(:$window);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Str $title,
    Int :$type   = GTK_WINDOW_TOPLEVEL,           # GtkWindowType $type,
    Int :$width  = 200,
    Int :$height = 200
  ) {
    my guint $t       = $type;
    my        $window = gtk_window_new($t);
    
    samewith($window, :$title, :$width, :$height);
  }
  # This multi could be deprecated.
  multi method new (
    Int $type,                # GtkWindowType $type,
    Str :$title  = 'Window',
    Int :$width  = 200,
    Int :$height = 200
  ) {
    my guint $t      = $type;
    my       $window = gtk_window_new($t);

    samewith($window, :$title, :$width, :$height);
  }
  multi method new (
    GtkWindow  $window,
    Str       :$title = 'Window',
    Int       :$width  = 200,
    Int       :$height = 200
  ) {
    $window ?? self.bless(:$window, :$title, :$width, :$height) !! Nil;
  }
  multi method new {
    GTK::Window.new(GTK_WINDOW_TOPLEVEL);
  }

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
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-default-icon-from-file>
  {
    clear_error;
    my $rv = so gtk_window_set_default_icon_from_file($filename, $error);
    set_error($error);
    $rv;
  }

  proto method set_default_icon_list (|)
    is also<set-default-icon-list>
  { * }

  multi method set_default_icon_list (GTK::Window:U: @list) {
    samewith( GLib::GList.new(@list) );
  }
  multi method set_default_icon_list (GTK::Window:U: GList() $list) {
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

  method application (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $app = gtk_window_get_application($!win);

        $app ??
          ( $raw ?? $app !! ::('GTK::Application').new($app) )
          !!
          Nil;
      },
      STORE => sub ($, GtkApplication() $application is copy) {
        gtk_window_set_application($!win, $application);
      }
    );
  }

  method attached_to (:$raw = False, :$widget = False)
    is rw is also<attached-to>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_window_get_attached_to($!win);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $attach_widget is copy) {
        gtk_window_set_attached_to($!win, $attach_widget);
      }
    );
  }

  method decorated is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_window_get_decorated($!win);
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

  method focus (:$raw = False, :$widget = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_window_get_focus($!win);

        self.ReturnWidget($w, $raw, $widget);
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
        GdkGravityEnum( gtk_window_get_gravity($!win) );
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

  method icon (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $p = gtk_window_get_icon($!win);

        $p ??
          ( $raw ?? $p !! GDK::Pixbuf.new($p) )
          !!
          Nil;
      },
      STORE => sub ($, GdkPixbuf() $icon is copy) {
        gtk_window_set_icon($!win, $icon);
      }
    );
  }

  method icon_list (:$glist = False, :$raw = False) is rw is also<icon-list> {
    Proxy.new(
      FETCH => sub ($) {
        my $il = gtk_window_get_icon_list($!win);

        return Nil unless $il;
        return $il if $glist;

        $il = GLib::GList.new($il) but GLib::Roles::ListData[GdkPixbuf];
        $raw ?? $il.Array !! $il.Array.map({ GDK::Pixbuf.new($_) });
      },
      STORE => sub ($, $list is copy) {
        die "icon_list can only take a GList or a Positional of{''
            }GDK::Pixbuf-compatible values"
        unless $list ~~ (Positional, GLib::GList, GList).any;

        # Warning!! -- Passing a GList-compatible will currently BYPASS
        #              any further checking.
        $list = do given $list {
          when GLib::GList { .GList }
          when GList       { $_ }

          when Positional  {
            # YYY - Is this too much magic to abstract?
            .map({
              # do if $_ ~~ T {
              do if $_ ~~ GdkPixbuf {
                $_;
              # } elseif .^can(T.name).elems {
              } elsif .^can('GdkPixbuf').elems {
                # ."{ T.^name }"()
                .GdkPixbuf;
              } else {
                # die "Value passed to {&?ROUTINE.name} must be {T.^name} compatible"
                die 'Value passed to icon_list must be GDK::Pixbuf compatible';
              }
            });
          }
        }

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

  method screen (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $s = gtk_window_get_screen($!win);

        $s ??
          ( $raw ?? $s !! GDK::Screen.new($s) )
          !!
          Nil;
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

  method titlebar (:$raw = False, :$widget = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Would use CreateObject, but there are questions regarding the
        # lexical nature of 'use'. If an attempt is made to dynamically
        # require the right object here, a circular dependency may be
        # induced. It's safer to create the Widget, and let the caller
        # make the call to CreateObject via:
        #     GTK::Widget.CreateObject($returned.Widget)

        # Yes, and with ReturnWidget, we can now find out in testing.
        my $w = gtk_window_get_titlebar($!win);

        self.ReturnWidget($w, $raw, $widget);
      },
      STORE => sub ($, GtkWidget() $titlebar is copy) {
        gtk_window_set_titlebar($!win, $titlebar);
      }
    );
  }

  method transient_for (:$raw = False) is rw is also<transient-for> {
    Proxy.new(
      FETCH => sub ($) {
        my $win = gtk_window_get_transient_for($!win);

        $win ??
          ( $raw ?? $win !! GTK::Window.new($win) )
          !!
          Nil;
      },
      STORE => sub ($, GtkWindow() $parent is copy) {
        gtk_window_set_transient_for($!win, $parent);
      }
    );
  }

  method type_hint is rw is also<type-hint> {
    Proxy.new(
      FETCH => sub ($) {
        GdkWindowTypeHintEnum( gtk_window_get_type_hint($!win) );
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

  method default_icon_list is rw is also<default-icon-list> is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_default_icon_list    },
      STORE => -> $, \v { self.set_default_icon_list(v) }
  }

  method default_icon_name is rw is also<default-icon-name> is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_default_icon_name    },
      STORE => -> $, \v { self.set_default_icon_name(v) }
  }

  method default_size is rw is also<default-size> is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_default_size    },
      STORE => -> $, \v { self.set_default_size(v) }
  }

  method position is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_position    },
      STORE => -> $, \v { self.set_position(v) }
  }

  method default_widget is rw is also<default-widget> is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_default_widget },
      STORE => -> $, \v { self.set_default(v)     }
  }

  method activate_default_widget is also<activate-default-widget> {
    gtk_window_activate_default($!win);
  }

  method activate_focused_widget is also<activate-focused-widget> {
    gtk_window_activate_focus($!win);
  }

  method activate_key (GdkEventKey $event) is also<activate-key> {
    gtk_window_activate_key($!win, $event);
  }

  method add_accel_group (GtkAccelGroup() $accel_group)
    is also<add-accel-group>
  {
    # Need class GTK::AccelGroup:ver<3.0.1146>
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

  proto method get_default_size (|)
    is also<get-default-size>
  { * }

  multi method get_default_size {
    samewith($, $);
  }
  multi method get_default_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_window_get_default_size($!win, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_default_widget ( :$raw = False )
    is also<
      get_default
      get-default
      get-default-widget
    >
  {
    propReturnObject(
      gtk_window_get_default_widget($!win),
      $raw,
      |GTK::Widget.getTypePair
    );
  }

  method get_group (:$raw = False) is also<get-group> {
    my $wg = gtk_window_get_group($!win);

    $wg ??
      ( $raw ?? $wg !! GTK::WindowGroup.new($wg) )
      !!
      Nil;
  }

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position {
    samewith($, $);
  }
  multi method get_position ($root_x is rw, $root_y is rw) {
    my gint ($rx, $ry) = 0 xx 2;

    gtk_window_get_position($!win, $rx, $ry);
    ($root_x, $root_y) = ($rx, $ry);
  }

  method get_resize_grip_area (GdkRectangle() $rect)
    is also<get-resize-grip-area>
  {
    gtk_window_get_resize_grip_area($!win, $rect);
  }

  proto method get_size (|)
    is also<get-size>
  { * }

  multi method get_size is also<size> {
    samewith($, $);
  }
  multi method get_size ($width is rw, $height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gtk_window_get_size($!win, $w, $h);
    ($width, $height) = ($w, $h);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_window_get_type, $n, $t );
  }

  method get_window_type is also<get-window-type> {
    GtkWindowTypeEnum( gtk_window_get_window_type($!win) );
  }

  method has_group is also<has-group> {
    so gtk_window_has_group($!win);
  }

  method has_toplevel_focus is also<has-toplevel-focus> {
    so gtk_window_has_toplevel_focus($!win);
  }

  method iconify {
    gtk_window_iconify($!win);
  }

  method is_active is also<is-active> {
    so gtk_window_is_active($!win);
  }

  method is_maximized is also<is-maximized> {
    so gtk_window_is_maximized($!win);
  }

  method list_toplevels (:$glist = False, :$raw = False, :$widget = False)
    is also<list-toplevels>
  {
    my $tlw = gtk_window_list_toplevels();

    return Nil unless $tlw;
    return $tlw if $glist;

    $tlw = GLib::GList.new($tlw) but GLib::Roles::ListData[GtkWidget];
    $tlw.Array.map({ self.ReturnWidget($_, $raw, $widget) });
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

    so gtk_window_mnemonic_activate($!win, $kv, $m);
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
    so gtk_window_propagate_key_event($!win, $event);
  }

  method remove_accel_group (GtkAccelGroup() $accel_group)
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

  # method reshow_with_initial_size
  #   is also<reshow-with-initial-size>
  # {
  #   gtk_window_reshow_with_initial_size($!win);
  # }

  method resize (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gtk_window_resize($!win, $w, $h);
  }

  method resize_grip_is_visible
    is also<resize-grip-is-visible>
  {
    gtk_window_resize_grip_is_visible($!win);
  }

  # method resize_to_geometry (Int() $width, Int() $height)
  #   is also<resize-to-geometry>
  # {
  #   my gint ($w, $h) = ($width, $height);
  #
  #   gtk_window_resize_to_geometry($!win, $w, $h);
  # }

  method set_default (GtkWidget() $default_widget)
    is also<
      set-default
      set_default_widget
      set-default-widget
    >
  {
    gtk_window_set_default($!win, $default_widget);
  }

  # method set_default_geometry (Int() $width, Int() $height)
  #   is also<set-default-geometry>
  # {
  #   my gint ($w, $h) = ($width, $height);
  #
  #   gtk_window_set_default_geometry($!win, $w, $h);
  # }

  method set_default_size (Int() $width, Int() $height)
    is also<set-default-size>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_window_set_default_size($!win, $w, $h);
  }


  proto method set_geometry_hints (|)
    is also<set-geometry-hints>
  { * }

  multi method set_geometry_hints (
    GtkWidget() $geometry_widget,
    Int() $geom_mask
  ) {
    samewith($geometry_widget, GdkGeometry, $geom_mask);
  }
  multi method set_geometry_hints (
    GtkWidget() $geometry_widget,
    GdkGeometry $geometry,
    Int() $geom_mask                # GdkWindowHints
  ) {
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
    my $rv = so gtk_window_set_icon_from_file($!win, $filename, $error);
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

  use GDK::Raw::Cairo;
  use GDK::Raw::Screen;
  use GLib::Raw::Signal;
  use GTK::Raw::Widget;

  use GTK::Roles::Signals::Widget;

  method makeTransparent ( :$button-press = True, :$paint = True ) {
    my $win-obj := self.GObject;

    # cw: Convert to method!
    g-connect-draw(
      cast(Pointer, $win-obj),
      'draw',
      -> *@a {
        CATCH { default { .message.say; .backtrace.concise.say } }

        my $c = gdk_cairo_create( gtk_widget_get_window( @a[0] ) );
        $c.set_source_rgba(1.0.Num, 1.0.Num, 1.0.Num, 0.0.Num);
        $c.set_operator(OPERATOR_SOURCE.Int);
        $c.paint;
        $c.destroy;

        0;
      },
      gpointer,
      0
    ) if $paint;

    my $screen-changed = -> *@a {
      CATCH { default { .message.say; .backtrace.concise.say } }

      my $s = gtk_widget_get_screen( @a[0] );
      my $v = gdk_screen_get_rgba_visual($s);
      $v ?? gtk_widget_set_visual( @a[0], $v)
         !! say 'No visual!';
    }

    # cw: Convert to method!
    g-connect-screen-changed(
      cast(Pointer, $win-obj),
      'screen-changed',
      -> *@a {
        $screen-changed( |@a );
      },
      gpointer,
      0
    );

    self.decorated = 0;
    self.add_events(GDK_BUTTON_PRESS_MASK);

    # cw: Convert to method!
    g-connect-widget-event(
      cast(Pointer, $win-obj),
      'button-press-event',
      -> *@a --> gboolean {
        CATCH { default { .message.say; .backtrace.concise.say } }

        if $button-press ~~ Callable {
          $button-press( |@a ) if $button-press;
        } else {
          self.decorated = self.decorated.not;
        }

        my guint $r = 0;
        $r;
      },
      gpointer,
      0
    ) if $button-press;

    $screen-changed(self.GtkWindow);
  }

}
