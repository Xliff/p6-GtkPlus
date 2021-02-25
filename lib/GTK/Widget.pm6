use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Context;
use Pango::Layout;

use GLib::Value;

use GDK::Display;
use GDK::RGBA;
use GDK::Screen;

use GDK::Window;

use GTK::Raw::DnD;
use GTK::Raw::DragDest;
use GTK::Raw::DragSource;
use GTK::Raw::Subs;
use GTK::Raw::Types;
use GTK::Raw::Widget;

use GLib::Roles::Object;
use GLib::Roles::Pointers;
use ATK::Roles::Implementor;
use GTK::Roles::Buildable;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::Widget;

use GTK::StyleContext;

our subset GtkWidgetAncestry is export where
  GtkWidget | GtkBuildable | AtkImplementorIface | GObject;

class GTK::Widget {
  also does GLib::Roles::Object;
  also does ATK::Roles::Implementor;
  also does GTK::Roles::Buildable;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::Widget;

  has GtkWidget $!w is implementor;

  # For all widget-based *_get_type functions.
  has $!t;
  has $!n;

  submethod BUILD (:$widget) {
    self.setWidget($widget) if $widget
  }

  # Check all widgets to insure that %!signals is left for THIS object
  # and THIS object only!
  submethod DESTROY {
    warn "DESTROYING -- { self.getType }" if $DEBUG;
    self.unref;
    # All widget-dependents may need a variation of this.
    my $w_cheat = cast(GObject, $!w);
    self.cleanup unless $w_cheat.ref_count;
  }

  # Used by method destroy and submethod DESTROY
  method cleanup {
    self.disconnect-all($_) for %!signals, %!signals-widget
  }

  method setWidget (GtkWidgetAncestry $_) {
#    "setWidget".say;
    # cw: Consider at least a warning if $!w has already been set.
    $!w = do {
      when AtkImplementorIface {
        $!ai = $_;
        cast(GtkWidget, $_);
      }

      when GtkBuildable {
        $!b = $_;
        cast(GtkWidget, $_);
      }

      when GObject {
        $!o = $_;
        cast(GtkWidget, $_);
      }

      when GtkWidget {
        $_;
      }

      # This will go away once proper pass-down rules have been established.
      default {
#        say "Setting from { .^name }";
         die "GTK::Widget initialized from unexpected source: { .^name }!";
      }
    };

    self.roleInit-Object;
    self.roleInit-AtkImplementor;
    self.roleInit-GtkBuildable;
  }

  method GTK::Raw::Definitions::GtkWidget
    is also<
      GtkWidget
      Widget
      widget
    >
  { $!w }

  # proto new(|) { * }
  multi method new(|c) {
    die "No matching constructor for: ({ c.map( *.^name ).join(', ') })";
  }
  multi method new (GtkWidgetAncestry $widget, :$ref = True, *%others) {
    return unless $widget;

    my $o = self.bless(:$widget, |%others);
    $o.ref if $ref;
    $o;
  }

  # REALLY EXPERIMENTAL attempt to create a global object creation
  # factory.
  method CreateObject(GTK::Widget:U: GtkWidget $o) {
    my $type = GTK::Widget.getType( cast(GObject, $o) );

    # If no type, then we fall back to GTK::Widget.
    if ($type //= 'GTK::Widget') eq 'GTK::Widget' {
      warn 'Creating GTK::Widget as fallback...' if $DEBUG;
    }

    ::($type).new($o);
  }

  # Static methods
  method cairo_should_draw_window (
    GTK::Widget:U:
    cairo_t $cr,
    GdkWindow() $window
  )
    is also<cairo-should-draw-window>
  {
    gtk_cairo_should_draw_window($cr, $window);
  }

  method cairo_transform_to_window (
    GTK::Widget:U: cairo_t $cr,
    GtkWidget $!w,
    GdkWindow $window
  )
    is also<cairo-transform-to-window>
  {
    gtk_cairo_transform_to_window($cr, $!w, $window);
  }

  method default_direction is rw is also<default-direction> {
    Proxy.new:
      FETCH => -> $           { GTK::Widget.get_default_direction    },
      STORE => -> $, Int() \d { GTK::Widget.set_default_direction(d) }
  }

  method get_default_direction (GTK::Widget:U: )
    is also<get-default-direction>
  {
    GtkTextDirectionEnum( gtk_widget_get_default_direction() );
  }

  # method pop_composite_child (GTK::Widget:U: )
  #   is also<pop-composite-child>
  # {
  #   gtk_widget_pop_composite_child();
  # }
  #
  # method push_composite_child (GTK::Widget:U: )
  #   is also<push-composite-child>
  # {
  #   gtk_widget_push_composite_child();
  # }

  method set_default_direction (GTK::Widget:U: Int() $dir)
    is also<set-default-direction>
  {
    my GtkTextDirection $d = $dir;

    gtk_widget_set_default_direction($d);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # Default
  method accel-closures-changed is also<accel_closures_changed> {
    self.connect($!w, 'accel-closures-changed');
  }

  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method button-press-event is also<button_press_event> {
    self.connect-widget-event($!w, 'button-press-event');
  }

  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method button-release-event is also<button_release_event> {
    self.connect-widget-event($!w, 'button-release-event');
  }

  # Is originally:
  # GtkWidget, guint, gpointer --> gboolean
  method can-activate-accel is also<can_activate_accel> {
    self.connect-uint-ruint($!w, 'can-activate-accel');
  }

  # Signal --> No Hooks
  # Is originally:
  # GtkWidget, GParamSpec, gpointer --> void
  method child-notify is also<child_notify> {
    self.connect-gparam($!w, 'child-notify');
  }

  # Default Signal
  method composited-changed is also<composited_changed> {
    self.connect($!w, 'composited-changed');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method configure-event is also<configure_event> {
    self.connect-widget-event($!w, 'configure-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method damage-event is also<damage_event> {
    self.connect-widget-event($!w, 'damage-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method delete-event is also<delete_event> {
    self.connect-widget-event($!w, 'delete-event');
  }

  # Signal - Default No Hooks
  # Method renamed to avoid conflict with the destroy method using the same signature.
  method destroy-signal is also<destroy_signal> {
    self.connect($!w, 'destroy');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method destroy-event is also<destroy_event> {
    self.connect-widget-event($!w, 'destroy-event');
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, GtkTextDirection, gpointer --> void
  method direction-changed is also<direction_changed> {
    self.connect-uint($!w, 'direction-changed');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, gpointer --> void
  method drag-begin is also<drag_begin> {
    self.connect-widget-drag($!w, 'drag-begin');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, gpointer --> void
  method drag-data-delete is also<drag_data_delete> {
    self.connect-widget-drag($!w, 'drag-data-delete');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, GtkSelectionData, guint, guint, gpointer --> void
  method drag-data-get is also<drag_data_get> {
    self.connect-drag-data-get($!w);
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, gint, gint, GtkSelectionData, guint, guint, gpointer
  # --> void
  method drag-data-received is also<drag_data_received> {
    self.connect-drag-data-received($!w);
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, gint, gint, guint, gpointer --> gboolean
  method drag-drop is also<drag_drop> {
    self.connect-drag-action($!w, 'drag-drop');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, gpointer --> void
  method drag-end is also<drag_end> {
    self.connect-widget-drag($!w, 'drag-end');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, GtkDragResult, gpointer --> gboolean
  method drag-failed is also<drag_failed> {
    self.connect-drag-failed($!w);
  }

  # Signal void Run Last
  # GtkWidget, GdkDragContext, guint, gpointer --> void
  method drag-leave is also<drag_leave> {
    self.connect-drag-leave($!w);
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkDragContext, gint, gint, guint, gpointer --> gboolean
  method drag-motion is also<drag_motion> {
    self.connect-drag-action($!w, 'drag-motion');
  }

  # Signal gboolean Run Last
  # Multi to allow for method draw(cairo_t)
  # Is originally:
  # GtkWidget, cairo_t, gpointer --> gboolean
  multi method draw {
    self.connect-draw($!w);
  }

  # Signal gboolean Run Last
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method enter-notify-event is also<enter_notify_event> {
    self.connect-widget-event($!w, 'enter-notify-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  # Made multi to avoid conflict with another method event, below
  multi method event {
    self.connect-widget-event($!w, 'event');
  }

  # Signal Run
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> void
  method event-after is also<event_after> {
    self.connect-widget-event($!w, 'event-after');
  }

  # Is originally:
  # GtkWidget, GtkDirectionType, gpointer --> gboolean
  method focus {
    self.connect-uint-ruint($!w, 'focus');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method focus-in-event is also<focus_in_event> {
    self.connect-widget-event($!w, 'focus-in-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method focus-out-event is also<focus_out_event> {
    self.connect-widget-event($!w, 'focus-out-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method grab-broken-event is also<grab_broken_event> {
    self.connect-widget-event($!w, 'grab-broken-event');
  }

  # Signal Default Action
  method grab-focus is also<grab_focus> {
    self.connect($!w, 'grab-focus');
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, gboolean, gpointer --> void
  method grab-notify is also<grab_notify> {
    self.connect-uint($!w, 'grab-notify');
  }


  # Signal Default Run First
  # Renamed from "hide" so as to not conflict with the method below with same signature.
  # In cases where the method is more common than the signal, common practice will be to
  # append "-signal" to the signal handler.
  method hide-signal is also<hide_signal> {
    self.connect($!w, 'hide');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GtkWidget, gpointer --> void
  method hierarchy-changed is also<hierarchy_changed> {
    self.connect-widget($!w, 'hierarchy-changed');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method key-press-event is also<key_press_event> {
    self.connect-widget-event($!w, 'key-press-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method key-release-event is also<key_release_event> {
    self.connect-widget-event($!w, 'key-release-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GtkDirectionType, gpointer --> gboolean
  method keynav-failed is also<keynav_failed> {
    self.connect-uint-ruint($!w, 'keynav-failed');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method leave-notify-event is also<leave_notify_event> {
    self.connect-widget-event($!w, 'leave-notify-event');
  }

  # Signal Default Run First
  # Renamed to avoid conflict with the method map using the same signature.
  method map-signal is also<map_signal> {
    self.connect($!w, 'map');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method map-event is also<map_event> {
    self.connect-widget-event($!w, 'map-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, gboolean, gpointer --> gboolean
  method mnemonic-activate is also<mnemonic_activate> {
    self.connect-uint-ruint($!w, 'mnemonic-activate');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method motion-notify-event is also<motion_notify_event> {
    self.connect-widget-event($!w, 'motion-notify-event');
  }

  # Signal Action
  # Is originally:
  # GtkWidget, GtkDirectionType, gpointer --> void
  method move-focus is also<move_focus> {
    self.connect-uint($!w, 'move-focus');
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, GtkWidget, gpointer --> void
  method parent-set is also<parent_set> {
    self.connect-widget($!w, 'parent-set');
  }

  # Signal Default
  # Returns gboolean
  method popup-menu is also<popup_menu> {
    self.connect-ruint($!w, 'popup-menu');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method property-notify-event is also<property_notify_event> {
    self.connect-widget-event($!w, 'property-notify-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method proximity-in-event is also<proximity_in_event> {
    self.connect-widget-event($!w, 'proximity-in-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method proximity-out-event is also<proximity_out_event> {
    self.connect-widget-event($!w, 'proximity-out-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, gint, gint, gboolean, GtkTooltip, gpointer --> gboolean
  method query-tooltip is also<query_tooltip> {
    self.connect-query-tooltip($!w);
  }

  # Signal void Run First
  # Renamed to avoid conflict with the realize method using the same signature.
  method realize-signal is also<realize_signal> {
    self.connect($!w, 'realize');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GdkScreen, gpointer --> void
  method screen-changed is also<screen_changed> {
    self.connect-screen-changed($!w);
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method scroll-event is also<scroll_event> {
    self.connect-widget-event($!w, 'scroll-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method selection-clear-event is also<selection_clear_event> {
    self.connect-widget-event($!w, 'selection-clear-event');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GtkSelectionData, guint, guint, gpointer --> void
  method selection-get is also<selection_get> {
    self.connect-selection-get($!w);
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method selection-notify-event is also<selection_notify_event> {
    self.connect-widget-event($!w, 'selection-notify-event');
  }

  # Signal void Run Last
  # Is originally:
  # GtkWidget, GtkSelectionData, guint, gpointer --> void
  method selection-received is also<selection_received> {
    self.connect-selection-received($!w);
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method selection-request-event is also<selection_request_event> {
    self.connect-widget-event($!w, 'selection-request-event');
  }

  # Signal Default Run First
  # Renamed from "show" so as to not conflict with the method below with same signature.
  method show-signal is also<show_signal> {
    self.connect($!w, 'show');
  }

  # Is originally:
  # GtkWidget, GtkWidgetHelpType, gpointer --> gboolean
  method show-help is also<show_help> {
    self.connect-uint-ruint($!w, 'show-help');
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, GdkRectangle, gpointer --> void
  # Made multi so as to not conflict with the method of the same name.
  # Aliases made manually.
  multi method size-allocate {
    self.connect-size-allocate($!w);
  }
  multi method size_allocate {
    self.connect-size-allocate($!w);
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, GtkStateType, gpointer --> void
  method state-changed is also<state_changed> {
    self.connect-uint($!w, 'state-changed');
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, GtkStateFlags, gpointer --> void
  method state-flags-changed is also<state_flags_changed> {
    self.connect-uint($!w, 'state-flags-changed');
  }

  # Signal void Run First
  # Is originally:
  # GtkWidget, GtkStyle, gpointer --> void
  method style-set is also<style_set> {
    self.connect-style-set($!w);
  }

  # Signal Default Run First
  method style-updated is also<style_updated> {
    self.connect($!w, 'style-updated');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method touch-event is also<touch_event> {
    self.connect-widget-event($!w, 'touch-event');
  }

  # Signal Default Run First
  # Renamed to avoid conflict with the unmap method using the same signature.
  method unmap-signal is also<unmap_signal> {
    self.connect($!w, 'unmap');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method unmap-event is also<unmap_event> {
    self.connect-widget-event($!w, 'unmap-event');
  }

  # Signal Default Run Last
  # Renamed to avoid conflict with the unrealize method using the same signature.
  method unrealize-signal is also<unrealize_signal> {
    self.connect($!w, 'unrealize');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method visibility-notify-event is also<visibility_notify_event> {
    self.connect-widget-event($!w, 'visibility-notify-event');
  }

  # Signal gboolean Run Last
  # Is originally:
  # GtkWidget, GdkEvent, gpointer --> gboolean
  method window-state-event is also<window_state_event> {
    self.connect-widget-event($!w, 'window-state-event');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  method receives_default is rw is also<receives-default> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_receives_default($!w);
      },
      STORE => sub ($, Int() $receives_default is copy) {
        my gboolean $r = $receives_default.so.Int;

        gtk_widget_set_receives_default($!w, $r);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_name($!w);
      },
      STORE => sub ($, Str() $name is copy) {
        gtk_widget_set_name($!w, $name);
      }
    );
  }

  method app_paintable is rw is also<app-paintable> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_app_paintable($!w);
      },
      STORE => sub ($, Int() $app_paintable is copy) {
        my gboolean $a = $app_paintable.so.Int;

        gtk_widget_set_app_paintable($!w, $a);
      }
    );
  }

  method font_map (:$raw = False) is rw is also<font-map> {
    Proxy.new(
      FETCH => sub ($) {
        my $pfm = gtk_widget_get_font_map($!w);

        $pfm ??
          ( $raw ?? $pfm !! Pango::FontMap.new($pfm) )
          !!
          Nil;
      },
      STORE => sub ($, PangoFontMap() $font_map is copy) {
        gtk_widget_set_font_map($!w, $font_map);
      }
    );
  }

  method tooltip_markup is rw is also<tooltip-markup> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_markup($!w);
      },
      STORE => sub ($, Str() $markup is copy) {
        gtk_widget_set_tooltip_markup($!w, $markup);
      }
    );
  }

  method tooltip_text is rw is also<tooltip-text> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_text($!w);
      },
      STORE => sub ($, Str() $text is copy) {
        gtk_widget_set_tooltip_text($!w, $text);
      }
    );
  }

  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkTextDirectionEnum( gtk_widget_get_direction($!w) );
      },
      STORE => sub ($, Int() $dir is copy) {
        my GtkTextDirection $d = $dir;

        gtk_widget_set_direction($!w, $d);
      }
    );
  }

  method margin_top is rw is also<margin-top> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_top($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_top($!w, $margin);
      }
    );
  }

  method focus_on_click is rw is also<focus-on-click> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_focus_on_click($!w);
      },
      STORE => sub ($, Int() $focus_on_click is copy) {
        my gboolean $f = $focus_on_click.so.Int;

        gtk_widget_set_focus_on_click($!w, $f);
      }
    );
  }

  method child_visible is rw is also<child-visible> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_child_visible($!w);
      },
      STORE => sub ($, Int() $is_visible is copy) {
        my gboolean $i = $is_visible.so.Int;

        gtk_widget_set_child_visible($!w, $i);
      }
    );
  }

  method hexpand is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_hexpand($!w);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = $expand.so.Int;

        gtk_widget_set_hexpand($!w, $e);
      }
    );
  }

  method margin_right is rw is also<margin-right> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_right($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_right($!w, $margin);
      }
    );
  }

  method margin_left is rw is also<margin-left> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_left($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_left($!w, $margin);
      }
    );
  }

  method parent_window (:$raw = False) is rw is also<parent-window> {
    Proxy.new(
      FETCH => sub ($) {
        my $gw = gtk_widget_get_parent_window($!w);

        $gw ??
          ( $raw ?? $gw !! GDK::Window.new($gw) )
          !!
          Nil;
      },
      STORE => sub ($, GdkWindow() $parent_window is copy) {
        gtk_widget_set_parent_window($!w, $parent_window);
      }
    );
  }

  method state_flags is rw is also<state-flags> {
    Proxy.new(
      FETCH => sub ($) {
        # YYY - Write a method to enumerate flags for a given enum!
        gtk_widget_get_state_flags($!w);
      },
      STORE => sub ($, Int() $flags is copy) {
        my GtkStateFlags $f = $flags;

        gtk_widget_unset_state_flags($!w, $f);
      }
    );
  }

  method sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_sensitive($!w);
      },
      STORE => sub ($, Int() $sensitive is copy) {
        my gboolean $s = $sensitive.so.Int;

        gtk_widget_set_sensitive($!w, $s);
      }
    );
  }

  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_visible($!w);
      },
      STORE => sub ($, $visible is copy) {
        my gboolean $v = $visible.so.Int;

        gtk_widget_set_visible($!w, $v);
      }
    );
  }

  method window (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $gw = gtk_widget_get_window($!w);

        $gw ??
          ( $raw ?? $gw !! GDK::Window.new($gw) )
          !!
          Nil;
      },
      STORE => sub ($, GdkWindow() $window is copy) {
        gtk_widget_set_window($!w, $window);
      }
    );
  }

  method events is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_events($!w);
      },
      STORE => sub ($, Int() $events is copy) {
        my guint $e = $events;

        gtk_widget_set_events($!w, $e);
      }
    );
  }

  method opacity is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_opacity($!w);
      },
      STORE => sub ($, Num() $opacity is copy) {
        my gdouble $o = $opacity;

        gtk_widget_set_opacity($!w, $o);
      }
    );
  }

  method tooltip_window (:$raw = False) is rw is also<tooltip-window> {
    Proxy.new(
      FETCH => sub ($) {
        my $w = gtk_widget_get_tooltip_window($!w);

        $w ??
          ( $raw ?? $w !! GTK::Window.new($w) )
          !!
          Nil;
      },
      STORE => sub ($, GtkWindow() $custom_window is copy) {
        gtk_widget_set_tooltip_window($!w, $custom_window);
      }
    );
  }

  method font_options is rw is also<font-options> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_font_options($!w);
      },
      STORE => sub ($, cairo_font_options_t $options is copy) {
        gtk_widget_set_font_options($!w, $options);
      }
    );
  }

#  method class_css_name is rw {
#    Proxy.new(
#      FETCH => sub ($) {
#        gtk_widget_class_get_css_name($widget_class);
#      },
#      STORE => sub ($, $name is copy) {
#        gtk_widget_class_set_css_name($widget_class, $name);
#      }
#    );
#  }

  method margin_start is rw is also<margin-start> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_start($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_start($!w, $margin);
      }
    );
  }

  method realized is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_realized($!w);
      },
      STORE => sub ($, Int() $realized is copy) {
        my gboolean $r = $realized.so.Int;

        gtk_widget_set_realized($!w, $r);
      }
    );
  }

  method visual (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $v = gtk_widget_get_visual($!w);

        $v ??
          ( $raw ?? $v !! GDK::Visual.new($v) )
          !!
          Nil;
      },
      STORE => sub ($, GdkVisual() $visual is copy) {
        gtk_widget_set_visual($!w, $visual);
      }
    );
  }

  method vexpand is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_vexpand($!w);
      },
      STORE => sub ($, Int() $expand is copy) {
        my gboolean $e = $expand.so.Int;

        gtk_widget_set_vexpand($!w, $e);
      }
    );
  }

  method margin_bottom is rw is also<margin-bottom> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_bottom($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_bottom($!w, $margin);
      }
    );
  }

  method margin_end is rw is also<margin-end> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_end($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_end($!w, $margin);
      }
    );
  }

  method valign is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkAlignEnum( gtk_widget_get_valign($!w) );
      },
      STORE => sub ($, Int() $align is copy) {
        my GtkAlign $a = $align;

        gtk_widget_set_valign($!w, $a);
      }
    );
  }

  method has_window is rw is also<has-window> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_has_window($!w);
      },
      STORE => sub ($, Int() $has_window is copy) {
        my gboolean $h = $has_window.so.Int;

        gtk_widget_set_has_window($!w, $has_window);
      }
    );
  }

  method double_buffered is rw is also<double-buffered> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_double_buffered($!w);
      },
      STORE => sub ($, Int() $double_buffered is copy) {
        my gboolean $d = $double_buffered.so.Int;

        gtk_widget_set_double_buffered($!w, $double_buffered);
      }
    );
  }

  method parent (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $c = gtk_widget_get_parent($!w);

        $c ??
          ( $raw ?? $c !! GTK::Container.new($c) )
          !!
          Nil;
      },
      STORE => sub ($, GtkContainer() $parent is copy) {
        gtk_widget_set_parent($!w, $parent);
      }
    );
  }

  method has_tooltip is rw is also<has-tooltip> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_has_tooltip($!w);
      },
      STORE => sub ($, Int() $has_tooltip is copy) {
        my gboolean $h = $has_tooltip.so.Int;

        gtk_widget_set_has_tooltip($!w, $h);
      }
    );
  }

  method halign is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_halign($!w);
      },
      STORE => sub ($, Int() $align is copy) {
        my GtkAlign $a = $align;

        gtk_widget_set_halign($!w, $a);
      }
    );
  }

  method no_show_all is rw is also<no-show-all> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_no_show_all($!w);
      },
      STORE => sub ($, $no_show_all is copy) {
        gtk_widget_set_no_show_all($!w, $no_show_all);
      }
    );
  }

  method state is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_state($!w);
      },
      STORE => sub ($, Int() $state is copy) {
        my gboolean $s = $state.so.Int;

        gtk_widget_set_state($!w, $s);
      }
    );
  }

  method can_default is rw is also<can-default> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_can_default($!w);
      },
      STORE => sub ($, Int() $can_default is copy) {
        my gboolean $c = $can_default.so.Int;

        gtk_widget_set_can_default($!w, $c);
      }
    );
  }

  method vexpand_set is rw is also<vexpand-set> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_vexpand_set($!w);
      },
      STORE => sub ($, Int() $set is copy) {
        my gboolean $s = $set.so.Int;

        gtk_widget_set_vexpand_set($!w, $s);
      }
    );
  }

  method hexpand_set is rw is also<hexpand-set> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_hexpand_set($!w);
      },
      STORE => sub ($, Int() $set is copy) {
        my gboolean $s = $set.so.Int;

        gtk_widget_set_hexpand_set($!w, $set);
      }
    );
  }

  method mapped is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_mapped($!w);
      },
      STORE => sub ($, Int() $mapped is copy) {
        my gboolean $m = $mapped.so.Int;

        gtk_widget_set_mapped($!w, $m);
      }
    );
  }

  method composite_name is rw is also<composite-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_composite_name($!w);
      },
      STORE => sub ($, $name is copy) {
        gtk_widget_set_composite_name($!w, $name);
      }
    );
  }

  method can_focus is rw is also<can-focus> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_can_focus($!w);
      },
      STORE => sub ($, Int() $can_focus is copy) {
        my gboolean $c = $can_focus.so.Int;

        gtk_widget_set_can_focus($!w, $c);
      }
    );
  }

  method support_multidevice is rw is also<support-multidevice> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_widget_get_support_multidevice($!w);
      },
      STORE => sub ($, Int() $support_multidevice is copy) {
        my gboolean $s = $support_multidevice.so.Int;

        gtk_widget_set_support_multidevice($!w, $s);
      }
    );
  }

  # Convenience attribute.
  method margins is rw {
    Proxy.new(
      FETCH => sub ($) {
        (
          self.margin_left,
          self.margin_right,
          self.margin_top,
          self.margin_bottom
        );
      },
      STORE => -> $, *@margins {
        die 'GTK::Widget.margins will only accept numeric values'
          unless @margins.grep( *.^can('Int').elems ) == @margins.elems;
        if +@margins == 1 {
          my $m = @margins[0];
          self.margins = $m xx 4;
        } elsif +@margins <= 4 {
          my $i = 0;
          for <margin_left margin_right margin_top margin_bottom>  -> $m {
            self."$m"() = $_ with @margins[$i++];
          }
        } else {
          die 'GTK::Widget.margins will only accept up to 4 values';
        }
      }
    );
  }

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method composite-child is rw is also<composite_child> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('composite-child', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        warn "composite-child does not allow writing"
      }
    );
  }

  # Type: gboolean
  method expand is rw {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('expand', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('expand', $gv);
      }
    );
  }

  # Type: gboolean
  proto method has_focus (|)
    is also<has-focus>
  { * }

  # cw: Made multi so as to work with gtk_widget_has_focus, below
  multi method has_focus (GTK::Widget:D: ) is rw {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('has-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-focus', $gv);
      }
    );
  }

  # Type: gint
  method height-request is rw is also<height_request> {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('height-request', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height-request', $gv);
      }
    );
  }

  # Type: gboolean
  method is-focus is rw is also<is_focus> {
    my GLib::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('is-focus', $gv) );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('is-focus', $gv);
      }
    );
  }

  # Type: gint
  method margin is rw {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get('margin', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('margin', $gv);
      }
    );
  }

  # Type: gint
  method scale-factor is rw is also<scale_factor> {
    my GLib::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get(
          $!w, 'scale-factor', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn "scale-factor does not allow writing"
      }
    );
  }

  # DEPRECATED
  # # Type: GtkStyle
  # method style is rw {
  #   my GValue $gv .= new;
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new( self.prop_get('style', $gv) );
  # #        $gv.get_TYPE;
  #     },
  #     STORE => -> $, GValue() $val is copy {
  # #        $gv.set_TYPE($val);
  #       self.prop_set('style', $gv);
  #     }
  #   );
  # }

  # Type: gint
  method width-request is rw is also<width_request> {
    my GValue $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new( self.prop_get(
          $!w, 'width-request', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width-request', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  method add_events (Int() $events) is also<add-events> {
    my gint $e = $events;

    gtk_widget_add_events($!w, $e);
  }

  #method class_set_accessible_role (GtkWidgetClass $widget_class, AtkRole $role) {
  #  gtk_widget_class_set_accessible_role($widget_class, $role);
  #}

  method region_intersect (cairo_region_t $region)
    is also<region-intersect>
  {
    gtk_widget_region_intersect($!w, $region);
  }

  # Multi to allow for handler to signal draw.
  multi method draw (cairo_t $cr) {
    gtk_widget_draw($!w, $cr);
  }

  method remove_mnemonic_label (GtkWidget() $label)
    is also<remove-mnemonic-label>
  {
    gtk_widget_remove_mnemonic_label($!w, $label);
  }

  method input_shape_combine_region (cairo_region_t $region)
    is also<input-shape-combine-region>
  {
    gtk_widget_input_shape_combine_region($!w, $region);
  }

  method in_destruction is also<in-destruction> {
    so gtk_widget_in_destruction($!w);
  }

  method get_valign_with_baseline is also<get-valign-with-baseline> {
    gtk_widget_get_valign_with_baseline($!w);
  }

  method has_visible_focus is also<has-visible-focus> {
    so gtk_widget_has_visible_focus($!w);
  }

  method has_screen is also<has-screen> {
    so gtk_widget_has_screen($!w);
  }

  method override_background_color (
    Int() $state,
    GDK::RGBA $color
  )
    is also<override-background-color>
  {
    my GtkStateFlags $s = $state;

    gtk_widget_override_background_color($!w, $s, $color);
  }

  method override_font (PangoFontDescription() $font)
    is also<override-font>
  {
    gtk_widget_override_font($!w, $font);
  }

  method trigger_tooltip_query is also<trigger-tooltip-query> {
    gtk_widget_trigger_tooltip_query($!w);
  }

  method has_default is also<has-default> {
    so gtk_widget_has_default($!w);
  }

  method get_frame_clock (:$raw = False)
    is also<
      get-frame-clock
      frame-clock
      frame_clock
    >
  {
    my $fc = gtk_widget_get_frame_clock($!w);

    $fc ??
      ( $raw ?? $fc !! GDK::FrameClock.new($fc) )
      !!
      Nil;
  }

  proto method get_preferred_size(|)
    is also<get-preferred-size>
  { * }

  # Only use the shortened name for the no parameter variant.
  multi method get_preferred_size
    is also<
      preferred_size
      preferred-size
    >
  {
    my ($ms, $ns) = (GtkRequisition.new xx 2);
    samewith($ms, $ns);
  }
  multi method get_preferred_size (
    GtkRequisition $minimum_size,
    GtkRequisition $natural_size
  ) {
    gtk_widget_get_preferred_size($!w, $minimum_size, $natural_size);
    ($minimum_size, $natural_size);
  }

  method device_is_shadowed (GdkDevice $device)
    is also<device-is-shadowed>
  {
    so gtk_widget_device_is_shadowed($!w, $device);
  }

  method send_focus_change (GdkEvent $event)
    is also<send-focus-change>
  {
    gtk_widget_send_focus_change($!w, $event);
  }

  method list_action_prefixes is also<list-action-prefixes> {
    CStringArrayToArray( gtk_widget_list_action_prefixes($!w) )
  }

  method set_device_enabled (GdkDevice() $device, Int() $enabled)
    is also<set-device-enabled>
  {
    my gboolean $e = $enabled.so.Int;

    gtk_widget_set_device_enabled($!w, $device, $e);
  }

  method grab_default is also<grab-default> {
    gtk_widget_grab_default($!w);
  }

  method emit_can_activate_accel (Int() $signal_id)
    is also<emit-can-activate-accel>
  {
    my guint $s = $signal_id;

    gtk_widget_can_activate_accel($!w, $s);
  }

  method hide {
    gtk_widget_hide($!w);
  }

  method shape_combine_region (cairo_region_t $region)
    is also<shape-combine-region>
  {
    gtk_widget_shape_combine_region($!w, $region);
  }

  method unregister_window (GdkWindow() $window)
    is also<unregister-window>
  {
    gtk_widget_unregister_window($!w, $window);
  }

  method send_expose (GdkEvent() $event) is also<send-expose> {
    gtk_widget_send_expose($!w, $event);
  }

  method create_pango_context (:$raw = False) is also<create-pango-context> {
    my $pc = gtk_widget_create_pango_context($!w);

    $pc ??
      ( $raw ?? $pc !! Pango::Context.new($pc) )
      !!
      Nil;
  }

  method create_pango_layout(Str() $text, :$raw = False)
    is also<create-pango-layout>
  {
    my $pl = gtk_widget_create_pango_layout($!w, $text);

    $pl ??
      ( $raw ?? $pl !! Pango::Layout.new($pl) )
      !!
      Nil;
  }

  method get_device_events (GdkDevice() $device) is also<get-device-events> {
    gtk_widget_get_device_events($!w, $device);
  }

  # method style_get_valist (Str() $first_property_name, va_list $var_args)
  #   is also<style-get-valist>
  # {
  #   gtk_widget_style_get_valist($!w, $first_property_name, $var_args);
  # }

  # Conflict with signal<is-focus>!
  method toplevel_is_focus is also<toplevel-is-focus> {
    so gtk_widget_is_focus($!w);
  }

  method freeze_child_notify is also<freeze-child-notify> {
    gtk_widget_freeze_child_notify($!w);
  }

  method remove_accelerator (
    GtkAccelGroup() $accel_group,
    Int() $accel_key,
    Int() $accel_mods
  )
    is also<remove-accelerator>
  {
    my guint $ak = $accel_key;
    my GdkModifierType $am  = $accel_mods;

    gtk_widget_remove_accelerator($!w, $accel_group, $ak, $am);
  }

  method queue_draw_region (cairo_region_t $region)
    is also<queue-draw-region>
  {
    gtk_widget_queue_draw_region($!w, $region);
  }

  method is_visible (GtkWidget $!w) is also<is-visible> {
    so gtk_widget_is_visible($!w);
  }

  method emit-mnemonic_activate (gboolean $group_cycling)
    is also<emit_mnemonic-activate>
  {
    gtk_widget_mnemonic_activate($!w, $group_cycling);
  }

  method show_all is also<show-all> {
    gtk_widget_show_all($!w);
  }

  method show {
    gtk_widget_show($!w);
  }

  method queue_compute_expand is also<queue-compute-expand> {
    gtk_widget_queue_compute_expand($!w);
  }

  method is_ancestor (GtkWidget() $ancestor) is also<is-ancestor> {
    so gtk_widget_is_ancestor($!w, $ancestor);
  }

  method get_allocated_height is also<get-allocated-height> {
    gtk_widget_get_allocated_height($!w);
  }

  proto method get_allocation (|)
    is also<get-allocation>
  { * }

  multi method get_allocation {
    my GtkAllocation $a .= new;
    samewith($a);
  }
  multi method get_allocation (GtkAllocation $allocation) {
    gtk_widget_get_allocation($!w, $allocation);
    $allocation;
  }

  method get_style_context (:$raw = False)
    is also<
      get-style-context
      style-context
      style_context
    >
  {
    my $sc = gtk_widget_get_style_context($!w);

    $sc ??
      ( $raw ?? $sc !! GTK::StyleContext.new($sc) )
      !!
      Nil;
  }

  proto method get_clip (|)
    is also<get-clip>
  { * }

  multi method get_clip {
    my $a = GtkAllocation.new;

    die 'Could not create GtkAllocation!' unless $a;

    samewith($a);
  }
  multi method get_clip (GtkAllocation $clip) {
    gtk_widget_get_clip($!w, $clip);
  }

#  method class_find_style_property (GtkWidgetClass $klass, Str() $property_name) {
#    gtk_widget_class_find_style_property($klass, $property_name);
#  }

  method get_device_enabled (GdkDevice() $device) is also<get-device-enabled> {
    gtk_widget_get_device_enabled($!w, $device);
  }

  method get_ancestor (GType $widget_type, :$raw = False, :$widget = False)
    is also<get-ancestor>
  {
    my $w = gtk_widget_get_ancestor($!w, $widget_type);

    ReturnWidget($w, $raw, $widget);
  }

  method get_request_mode is also<get-request-mode> {
    GtkSizeRequestModeEnum( gtk_widget_get_request_mode($!w) );
  }

  method intersect (GdkRectangle() $area, GdkRectangle() $intersection) {
    gtk_widget_intersect($!w, $area, $intersection);
  }

  method unparent {
    gtk_widget_unparent($!w);
  }

  method set_clip (GtkAllocation $clip) is also<set-clip> {
    gtk_widget_set_clip($!w, $clip);
  }

  # conflicts with signal<grab-focus>!
  method focus_grab is also<focus-grab> {
    gtk_widget_grab_focus($!w);
  }

  proto method get_preferred_height_and_baseline_for_width (|)
    is also<get-preferred-height-and-baseline-for-width>
  { * }

  multi method get_preferred_height_and_baseline_for_width (Int() $width) {
    samewith($width, $, $, $, $);
  }
  multi method get_preferred_height_and_baseline_for_width (
    Int() $width,
    $minimum_height   is rw,
    $natural_height   is rw,
    $minimum_baseline is rw,
    $natural_baseline is rw
  ) {
    my @i = (
      $width, $minimum_height, $natural_height,
      $minimum_baseline, $natural_baseline
    );
    my gint ($ww, $mh, $nh, $mb, $nb) = ($width, 0, 0, 0, 0);
    gtk_widget_get_preferred_height_and_baseline_for_width(
      $!w, $ww, $mh, $nh, $mb, $nb
    );
    ($minimum_height, $natural_height, $minimum_baseline, $natural_baseline) =
      ($mh, $nh, $mb, $nb);
  }

  method activate {
    so gtk_widget_activate($!w);
  }

  method add_device_events (GdkDevice() $device, Int() $events)
    is also<add-device-events>
  {
    my GdkEventMask $e = $events;

    gtk_widget_add_device_events($!w, $device, $e);
  }

  method remove_tick_callback (Int() $id)
    is also<remove-tick-callback>
  {
    my guint $i = $id;

    gtk_widget_remove_tick_callback($!w, $i);
  }

  method queue_draw_area (Int() $x, Int() $y, Int() $width, Int() $height)
    is also<queue-draw-area>
  {
    my gint ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gtk_widget_queue_draw_area($!w, $xx, $yy, $w, $h);
  }

  method compute_expand (Int() $orientation)
    is also<compute-expand>
  {
    my GtkOrientation $o = $orientation;

    gtk_widget_compute_expand($!w, $orientation);
  }

  method set_redraw_on_allocate (Int() $redraw_on_allocate)
    is also<set-redraw-on-allocate>
  {
    my gboolean $r = $redraw_on_allocate.so.Int;

    gtk_widget_set_redraw_on_allocate($!w, $r);
  }

  proto method get_preferred_height (|)
    is also<get-preferred-height>
  { * }

  multi method get_preferred_height {
    samewith($, $);
  }
  multi method get_preferred_height (
    $minimum_height is rw,
    $natural_height is rw
  ) {
    my gint ($mh, $nh) = 0 xx 2;
    gtk_widget_get_preferred_height($!w, $mh, $nh);

    ($minimum_height, $natural_height) = ($mh, $nh);
  }

  method unmap (GtkWidget() $!w) {
    gtk_widget_unmap($!w);
  }

  method error_bell (GtkWidget() $!w) is also<error-bell> {
    gtk_widget_error_bell($!w);
  }

  proto method translate_coordinates(|)
    is also<translate-coordinates>
  { * }

  # Must not use samewith in a situations where the work is done by a
  # class method!
  multi method translate_coordinates (
    GTK::Widget:D:
    GtkWidget() $dest_widget,
    Int() $src_x,
    Int() $src_y
  ) {
    GTK::Widget.translate_coordinates($!w, $dest_widget, $src_x, $src_y);
  }
  multi method translate_coordinates (
    GTK::Widget:U:
    GtkWidget() $src_widget,
    GtkWidget() $dest_widget,
    Int() $src_x,
    Int() $src_y,
  ) {
    my ($dx, $dy) = (0, 0);
    my @r = GTK::Widget.translate_coordinates(
      $src_widget,
      $dest_widget,
      $src_x,
      $src_y,
      $,
      $,
      :all
    );

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method translate_coordinates (
    GTK::Widget:D:
    GtkWidget() $dest_widget,
    Int() $src_x,
    Int() $src_y,
    $dest_x is rw,
    $dest_y is rw,
    :$all = False
  ) {
    GTK::Widget.translate_coordinates(
      $!w,
      $dest_widget,
      $src_x,
      $src_y,
      $dest_x,
      $dest_y,
      :$all
    );
  }
  multi method translate_coordinates (
    GTK::Widget:U:
    GtkWidget() $src_widget,
    GtkWidget() $dest_widget,
    Int() $src_x,
    Int() $src_y,
    $dest_x is rw,
    $dest_y is rw,
    :$all = False
  ) {
    my ($sx, $sy, $dx, $dy) = ($src_x, $src_y, 0, 0);
    my $rv = gtk_widget_translate_coordinates(
      $src_widget, $dest_widget, $sx, $sy, $dx, $dy
    );
    ($dest_x, $dest_y) = ($dx, $dy);
    $all.not ?? $rv !! ($rv, $dest_x, $dest_y);
  }

  method style_get_property (Str() $property_name, GValue() $value)
    is also<style-get-property>
  {
    gtk_widget_style_get_property($!w, $property_name, $value);
  }

  method get_scale_factor is also<get-scale-factor> {
    gtk_widget_get_scale_factor($!w);
  }

  method is_composited is also<is-composited> {
    so gtk_widget_is_composited($!w);
  }

  method get_pango_context (:$raw = False) is also<get-pango-context> {
    my $pc = gtk_widget_get_pango_context($!w);

    $pc ??
      ( $raw ?? $pc !! Pango::Context.new($pc) )
      !!
      Nil;
  }

  #method class_set_template (GtkWidgetClass $widget_class, GBytes $template_bytes) {
  #  gtk_widget_class_set_template($widget_class, $template_bytes);
  #}

  #method class_set_accessible_type (GtkWidgetClass $widget_class, GType $type) {
  #  gtk_widget_class_set_accessible_type($widget_class, $type);
  #}

  method is_sensitive is also<is-sensitive> {
    so gtk_widget_is_sensitive($!w);
  }

  # Made multi to avoid conflict with the signal "event" handler.
  multi method event (GdkEvent() $event) {
    so gtk_widget_event($!w, $event);
  }

  method queue_resize_no_redraw is also<queue-resize-no-redraw> {
    gtk_widget_queue_resize_no_redraw($!w);
  }

  # To be used RARELY!
  method destroyed (CArray[GtkWidget] $widget_pointer) {
    gtk_widget_destroyed($!w, $widget_pointer);
  }

  method get_action_group (Str() $prefix) is also<get-action-group> {
    gtk_widget_get_action_group($!w, $prefix);
  }

  method init_template is also<init-template> {
    gtk_widget_init_template($!w);
  }

  proto method get_preferred_width_for_height (|)
    is also<get-preferred-width-for-height>
  { * }

  multi method get_preferred_width_for_height (Int() $height) {
    samewith($height, $, $);
  }
  multi method get_preferred_width_for_height (
    Int() $height,
    $minimum_width is rw,
    $natural_width is rw
  ) {
    my gint ($h, $mw, $nw) = ($height, 0, 0);
    gtk_widget_get_preferred_width_for_height($!w, $h, $mw, $nw);
    ($minimum_width, $natural_width) = ($mw, $nw);
  }

  method get_template_child (Int() $widget_type, Str() $name)
    is also<get-template-child>
  {
    my GType $wt = $widget_type;

    gtk_widget_get_template_child($!w, $wt, $name);
  }

  method reset_style is also<reset-style> {
    gtk_widget_reset_style($!w);
  }

  method realize {
    gtk_widget_realize($!w);
  }

  method get_allocated_baseline is also<get-allocated-baseline> {
    gtk_widget_get_allocated_baseline($!w);
  }

  method get_display (:$raw = False)
    is also<
      get-display
      display
    >
  {
    my $d = gtk_widget_get_display($!w);

    $d ??
      ( $raw ?? $d !! GDK::Display.new($d) )
      !!
      Nil;
  }

  method list_accel_closures (:$glist = False, :$raw = False)
    is also<list-accel-closures>
  {
    my $acl = gtk_widget_list_accel_closures($!w);

    return Nil unless $acl;
    return $acl if $glist;

    $acl = GLib::GList.new($acl) but GLib::Roles::ListData[GClosure];
    $raw ?? $acl.Array !! $acl.Array.map({ GLib::Closure.new($_) });
  }

  method size_allocate_with_baseline (
    GtkAllocation() $allocation,
    Int() $baseline
  )
    is also<size-allocate-with-baseline>
  {
    my gint $b = $baseline;

    gtk_widget_size_allocate_with_baseline($!w, $allocation, $b);
  }

  #method class_install_style_property_parser (GtkWidgetClass $klass, GParamSpec $pspec, GtkRcPropertyParser $parser) {
  #  gtk_widget_class_install_style_property_parser($klass, $pspec, $parser);
  #}

  method insert_action_group (Str() $name, GActionGroup $group)
    is also<insert-action-group>
  {
    gtk_widget_insert_action_group($!w, $name, $group);
  }

  method get_toplevel (:$raw = False, :$widget = False)
    is also<
      get-toplevel
      toplevel
    >
  {
    my $w = gtk_widget_get_toplevel($!w);

    ReturnWidget($w, $raw, $widget);
  }

  method set_device_events (GdkDevice() $device, Int() $events)
    is also<set-device-events>
  {
    my GdkEventMask $e = $events;

    gtk_widget_set_device_events($!w, $device, $e);
  }

  method get_clipboard (GdkAtom $selection, :$raw = False)
    is also<get-clipboard>
  {
    my $c = gtk_widget_get_clipboard($!w, $selection);

    $c ??
      ( $raw ?? $c !! GTK::Clipboard.new($c) )
      !!
      Nil;
  }

  method queue_draw is also<queue-draw> {
    gtk_widget_queue_draw($!w);
  }

  method map {
    gtk_widget_map($!w);
  }

  method register_window (GdkWindow() $window) is also<register-window> {
    gtk_widget_register_window($!w, $window);
  }

  #method class_bind_template_child_full (GtkWidgetClass $widget_class, Str() $name, gboolean $internal_child, gssize $struct_offset) {
  #  gtk_widget_class_bind_template_child_full($widget_class, $name, $internal_child, $struct_offset);
  #}

  method set_allocation (GtkAllocation() $allocation) is also<set-allocation> {
    gtk_widget_set_allocation($!w, $allocation);
  }

  method child_focus (Int() $direction) is also<child-focus> {
    my GtkDirectionType $d = $direction;

    gtk_widget_child_focus($!w, $d);
  }

  method queue_allocate is also<queue-allocate> {
    gtk_widget_queue_allocate($!w);
  }

  method show_now is also<show-now> {
    gtk_widget_show_now($!w);
  }

  method destroy {
    self.cleanup;
    gtk_widget_destroy($!w);
  }

  method get_allocated_size (GtkAllocation $allocation, Int() $baseline)
    is also<get-allocated-size>
  {
    my gint $b = $baseline;

    gtk_widget_get_allocated_size($!w, $allocation, $);
  }

  #method class_set_template_from_resource (GtkWidgetClass $widget_class, Str() $resource_name) {
  #  gtk_widget_class_set_template_from_resource($widget_class, $resource_name);
  #}

  method get_path (:$raw = False) is also<get-path> {
    my $wp = gtk_widget_get_path($!w);

    $wp ??
      ( $raw ?? $wp !! GTK::WidgetPath.new($wp) )
      !!
      Nil;
  }

  method is_toplevel is also<is-toplevel> {
    so gtk_widget_is_toplevel($!w);
  }

  method emit_child_notify (Str() $child_property)
    is also<emit-child-notify>
  {
    gtk_widget_child_notify($!w, $child_property);
  }

  #method class_install_style_property (GtkWidgetClass $klass, GParamSpec $pspec) {
  #  gtk_widget_class_install_style_property($klass, $pspec);
  #}

  method set_size_request (Int() $width, Int() $height)
    is also<set-size-request>
  {
    my gint ($ww, $hh) = ($width, $height);

    gtk_widget_set_size_request($!w, $ww, $hh);
  }

  method thaw_child_notify is also<thaw-child-notify> {
    gtk_widget_thaw_child_notify($!w);
  }

  method add_accelerator (
    Str() $accel_signal,
    GtkAccelGroup() $accel_group,
    Int() $accel_key,
    Int() $accel_mods,
    Int() $accel_flags
  )
    is also<add-accelerator>
  {
    my guint $ak = $accel_key;
    my GdkModifierType $am = $accel_mods;
    my guint32 $af = $accel_flags; # GtkAccelFlags;

    gtk_widget_add_accelerator(
      $!w,
      $accel_signal,
      $accel_group,
      $ak,
      $am,
      $af
    );
  }

  # Multi methods so as to not conflict with the signal handler of the same
  # name. Aliases implemented manually.
  multi method size_allocate (GtkAllocation() $allocation) {
    gtk_widget_size_allocate($!w, $allocation);
  }
  multi method size-allocate (GtkAllocation() $allocation) {
    self.size_allocate($allocation);
  }

  method emit_keynav_failed (GtkDirectionType $direction)
    is also<emit-keynav-failed>
  {
    gtk_widget_keynav_failed($!w, $direction);
  }

  method hide_on_delete is also<hide-on-delete> {
    gtk_widget_hide_on_delete($!w);
  }

  proto method get_preferred_width (|)
    is also<get-preferred-width>
  { * }

  multi method get_preferred_width {
    samewith($, $);
  }
  multi method get_preferred_width (
    $minimum_width is rw,
    $natural_width is rw
  ) {
    my gint ($mw, $nw) = 0 xx 2;
    gtk_widget_get_preferred_width($!w, $mw, $nw);
    ($minimum_width, $natural_width) = ($mw, $nw);
  }

  method get_screen (:$raw = False) is also<get-screen screen> {
    my $s = gtk_widget_get_screen($!w);

    $s ??
      ( $raw ?? $s !! GDK::Screen.new($s) )
      !!
      Nil;
  }

  method queue_resize is also<queue-resize> {
    gtk_widget_queue_resize($!w);
  }

  method get_accessible is also<get-accessible> {
    gtk_widget_get_accessible($!w);
  }

  proto method get_preferred_height_for_width (|)
    is also<get-preferred-height-for-width>
  { * }

  multi method get_preferred_height_for_width (Int() $w) {
    samewith($w, $, $);
  }
  multi method get_preferred_height_for_width (
    Int() $width,
    $minimum_height is rw,
    $natural_height is rw
  ) {
    my gint $ww = $width;
    my gint ($mh, $nh) = (0, 0);
    gtk_widget_get_preferred_height_for_width($!w, $ww, $mh, $nh);
    ($minimum_height, $natural_height) = ($mh, $nh);
  }

  method list_mnemonic_labels (
    :$glist = False,
    :$raw = False,
    :$widget = False
  )
    is also<list-mnemonic-labels>
  {
    my $ll = gtk_widget_list_mnemonic_labels($!w);

    return Nil unless $ll;
    return $ll if $glist;

    $ll = GLib::GList.new($ll) but GLib::Roles::ListData[GtkWidget];
    $ll.Array.map({ ReturnWidget($_, $raw, $widget) });
  }

  method add_mnemonic_label (GtkWidget() $label) is also<add-mnemonic-label> {
    gtk_widget_add_mnemonic_label($!w, $label);
  }

  #method class_set_connect_func

  method set_accel_path (Str() $accel_path, GtkAccelGroup() $accel_group)
    is also<set-accel-path>
  {
    gtk_widget_set_accel_path($!w, $accel_path, $accel_group);
  }

  method get_settings (:$raw = False) is also<get-settings> {
    my $s = gtk_widget_get_settings($!w);

    $s ??
      ( $raw ?? $s !! GTK::Settings.new($s) )
      !!
      Nil;
  }

  method get_modifier_mask (Int() $intent)
    is also<get-modifier-mask>
  {
    my guint $i = $intent;

    gtk_widget_get_modifier_mask($!w, $i);
  }

  method has_grab is also<has-grab> {
    so gtk_widget_has_grab($!w);
  }

  #method class_list_style_properties (GtkWidgetClass $klass, guint $n_properties) {
  #  gtk_widget_class_list_style_properties($klass, $n_properties);
  #}

  method get_allocated_width is also<get-allocated-width> {
    gtk_widget_get_allocated_width($!w);
  }

  method is_drawable is also<is-drawable> {
    so gtk_widget_is_drawable($!w);
  }

  multi method has_focus (GTK::Widget:U: ) {
    so gtk_widget_has_focus($!w);
  }

  method unrealize {
    gtk_widget_unrealize($!w);
  }

  method add_tick_callback (
             &callback,
    gpointer $user_data = gpointer,
             &notify    = Callable
  )
    is also<add-tick-callback>
  {
    gtk_widget_add_tick_callback($!w, &callback, $user_data, &notify);
  }


  # GTK Drag and Drop destination routines.

  method dest_add_image_targets is also<dest-add-image-targets> {
    gtk_drag_dest_add_image_targets($!w);
  }

  method dest_add_text_targets is also<dest-add-text-targets> {
    gtk_drag_dest_add_text_targets($!w);
  }

  method dest_add_uri_targets is also<dest-add-uri-targets> {
    gtk_drag_dest_add_uri_targets($!w);
  }

  method dest_find_target (
    GdkDragContext() $context,
    GtkTargetList() $target_list = GtkTargetList
  )
    is also<dest-find-target>
  {
    gtk_drag_dest_find_target($!w, $context, $target_list);
  }

  proto method dest_set (|)
    is also<dest-set>
  { * }

  multi method dest_set (
    Int() $flags,
    Int() $actions,
    @targets
  ) {
    samewith(
      $flags,
      GLib::Roles::TypedBuffer[GtkTargetEntry].new(@targets).p,
      @targets.elems,
      $actions
    );
  }
  multi method dest_set (
    Int() $flags,
    Pointer $targets,
    Int() $n_targets,
    Int() $actions
  ) {
    my GtkDestDefaults $f = $flags;
    my gint $nt = $n_targets;
    my guint $a = $actions;

    gtk_drag_dest_set($!w, $f, $targets, $nt, $a);
  }

  method dest_set_proxy (
    GdkWindow() $proxy_window,
    Int() $protocol,
    Int() $use_coordinates
  )
    is also<dest-set-proxy>
  {
    my guint $p = $protocol;
    my gboolean $uc = $use_coordinates;

    gtk_drag_dest_set_proxy($!w, $proxy_window, $p, $uc);
  }

  method dest_unset is also<dest-unset> {
    gtk_drag_dest_unset($!w);
  }

  # GTK Drag and Drop Source routines.
  method source_add_image_targets is also<source-add-image-targets>{
    gtk_drag_source_add_image_targets($!w);
  }

  method source_add_text_targets is also<source-add-text-targets> {
    gtk_drag_source_add_text_targets($!w);
  }

  method source_add_uri_targets is also<source-add-uri-targets> {
    gtk_drag_source_add_uri_targets($!w);
  }

  proto method source_set (|)
    is also<source-set>
  { * }

  multi method source_set (
    Int() $start_button_mask,
    Int() $actions,
    @targets,
  ) {
    samewith(
      $start_button_mask,
      GLib::Roles::TypedBuffer[GtkTargetEntry].new(@targets).p,
      @targets.elems,
      $actions
    );
  }
  multi method source_set (
    Int() $start_button_mask,
    $targets is copy,
    Int() $n_targets,
    Int() $actions
  ) {
    die unless $targets ~~ Pointer || $targets ~~ GLib::Roles::Pointers;

    $targets .= p if $targets ~~ GLib::Roles::Pointers;

    my guint ($sbm, $a) = ($start_button_mask, $actions);
    my gint $nt = $n_targets;

    gtk_drag_source_set($!w, $sbm, $targets, $nt, $a);
  }

  method source_set_icon_gicon (GIcon() $icon)
    is also<source-set-icon-gicon>
  {
    gtk_drag_source_set_icon_gicon($!w, $icon);
  }

  method source_set_icon_name (Str() $icon_name)
    is also<source-set-icon-name source-set-icon>
  {
    gtk_drag_source_set_icon_name($!w, $icon_name);
  }

  method source_set_icon_pixbuf (GdkPixbuf() $pixbuf)
    is also<source-set-icon-pixbuf source-set-pixbuf>
  {
    gtk_drag_source_set_icon_pixbuf($!w, $pixbuf);
  }

  method source_set_icon_stock (Str() $stock_id)
    is also<source-set-icon-stock source-set-stock>
  {
    gtk_drag_source_set_icon_stock($!w, $stock_id);
  }

  method source_unset is also<source-unset> {
    gtk_drag_source_unset($!w);
  }

  method drag_get_data(
    GdkDragContext() $context,
    GdkAtom $target,
    Int() $time
  )
    is also<drag-get-data>
  {
    my guint $t = $time;

    gtk_drag_get_data($!w, $context, $target, $t);
  }

  method drag_highlight is also<drag-highlight> {
    gtk_drag_highlight($!w);
  }

  method gtk_drag_unhighlight is also<drag-unhighlight> {
    gtk_drag_unhighlight($!w);
  }

  # Convenience function.
  method get_allocated_wh
    is also<
      get-allocated-wh
      allocated-wh
      allocated_wh
    >
  {
    (self.get_allocated_width, self.get_allocated_height);
  }

  method ReturnWidget ($w, $raw, $widget) {
    ReturnWidget($w, $raw, $widget);
  }

  # Remove all $n, $t from instances!
  method unstable_get_type(&sub, *@a)
    is also<unstable-get-type>
  {
    unstable_get_type(::?CLASS.^name, &sub, $!n, $!t);
  }

}

sub ReturnWidget ($w, $raw, $widget) is export {
  $w ?? ( $raw ?? $w
               !! ( $widget ?? GTK::Widget.new($w)
                            !! GTK::Widget.CreateObject($w) ) )
     !! Nil;
}
