use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Display;
use GTK::Compat::RGBA;
use GTK::Compat::Screen;
use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Compat::Window;

use GTK::Raw::DragDest;
use GTK::Raw::DragSource;
use GTK::Raw::Subs;
use GTK::Raw::Types;
use GTK::Raw::Widget;

use GTK::Roles::Buildable;
use GTK::Roles::Data;
use GTK::Roles::Properties;
use GTK::Roles::Signals::Generic;
use GTK::Roles::Signals::Widget;
use GTK::Roles::Types;

use GTK::StyleContext;

class GTK::Widget {
  also does GTK::Roles::Buildable;
  also does GTK::Roles::Data;
  also does GTK::Roles::Properties;
  also does GTK::Roles::Signals::Generic;
  also does GTK::Roles::Signals::Widget;
  also does GTK::Roles::Types;

  has GtkWidget $!w;

  submethod BUILD (:$widget) {
    given $widget {
      when GtkWidget {
        self.setWidget($widget);
      }
      default {
      }
    }
  }

  submethod DESTROY {
    g_object_unref($!w.p);
    self.disconnect-all($_) for %!signals, %!signals-widget;
  }

  proto new(|) { * }

  method new($widget) {
    self.bless(:$widget);
  }

  method GTK::Raw::Types::GtkWidget is also<widget> {
    $!w;
  }

  # We use these for inc/dec ops
  method upref   {   g_object_ref($!w.p) }
  method downref { g_object_unref($!w.p) }

  method setWidget($widget) {
#    "setWidget".say;
    # cw: Consider at least a warning if $!w has already been set.
    $!w = do given $widget {
      when GtkWidget {
        $_;
      }
      # This will go away once proper pass-down rules have been established.
      default {
#        say "Setting from { .^name }";
         die "GTK::Widget initialized from unexpected source!";
      }
    };
    $!prop = nativecast(GObject, $!w);    # GTK::Roles::Properties
    $!b = nativecast(GtkBuildable, $!w);  # GTK::Roles::Buildable
    $!data = $!w.p;                       # GTK::Roles::Data
  }

  # REALLY EXPERIMENTAL attempt to create a global object creation
  # factory.
  method CreateObject(GtkWidget $o) {
    self.IS-PROTECTED;

    my $type = g_object_get_string($o.p, 'GTKPLUS-Type');
    # In this situation, GTK::Widget CANNOT validate what will happen
    # if there is no type. The caller has to INSURE that if this call is
    # made, they are aware of this possibility.
    #
    # Therefore this should be made into a PROPER exception with
    # the die() message as the payload.
    die "Invalid type name { $type } passed to GTK::Widget.CreateObject():"
      unless $type ~~ /^ 'GTK::' /;
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

  method get_default_direction(GTK::Widget:U: )
    is also<get-default-direction>
  {
    gtk_widget_get_default_direction();
  }

  method pop_composite_child(GTK::Widget:U: )
    is also<pop-composite-child>
  {
    gtk_widget_pop_composite_child();
  }

  method push_composite_child(GTK::Widget:U: )
    is also<push-composite-child>
  {
    gtk_widget_push_composite_child();
  }

  method set_default_direction (GTK::Widget:U: GtkTextDirection $dir)
    is also<set-default-direction>
  {
    gtk_widget_set_default_direction($dir);
  }

  method requisition_get_type(GTK::Widget:U: )
    is also<requisition-get-type>
  {
    gtk_requisition_get_type();
  }

  method requisition_new(GTK::Widget:U: ) is also<requisition-new> {
    gtk_requisition_new();
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
        gtk_widget_get_receives_default($!w);
      },
      STORE => sub ($, $receives_default is copy) {
        gtk_widget_set_receives_default($!w, $receives_default);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_name($!w);
      },
      STORE => sub ($, $name is copy) {
        gtk_widget_set_name($!w, $name);
      }
    );
  }

  method app_paintable is rw is also<app-paintable> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_app_paintable($!w);
      },
      STORE => sub ($, $app_paintable is copy) {
        gtk_widget_set_app_paintable($!w, $app_paintable);
      }
    );
  }

  method font_map is rw is also<font-map> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_font_map($!w);
      },
      STORE => sub ($, $font_map is copy) {
        gtk_widget_set_font_map($!w, $font_map);
      }
    );
  }

  method tooltip_markup is rw is also<tooltip-markup> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_markup($!w);
      },
      STORE => sub ($, $markup is copy) {
        gtk_widget_set_tooltip_markup($!w, $markup);
      }
    );
  }

  method tooltip_text is rw is also<tooltip-text> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_text($!w);
      },
      STORE => sub ($, $text is copy) {
        gtk_widget_set_tooltip_text($!w, $text);
      }
    );
  }

  method direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_direction($!w);
      },
      STORE => sub ($, $dir is copy) {
        gtk_widget_set_direction($!w, $dir);
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
        gtk_widget_get_focus_on_click($!w);
      },
      STORE => sub ($, $focus_on_click is copy) {
        gtk_widget_set_focus_on_click($!w, $focus_on_click);
      }
    );
  }

  method child_visible is rw is also<child-visible> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_child_visible($!w);
      },
      STORE => sub ($, $is_visible is copy) {
        gtk_widget_set_child_visible($!w, $is_visible);
      }
    );
  }

  method hexpand is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_hexpand($!w);
      },
      STORE => sub ($, $expand is copy) {
        gtk_widget_set_hexpand($!w, $expand);
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

  method parent_window is rw is also<parent-window> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_parent_window($!w);
      },
      STORE => sub ($, $parent_window is copy) {
        gtk_widget_set_parent_window($!w, $parent_window);
      }
    );
  }

  method state_flags is rw is also<state-flags> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_state_flags($!w);
      },
      STORE => sub ($, $flags is copy) {
        gtk_widget_unset_state_flags($!w, $flags);
      }
    );
  }

  method sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_sensitive($!w);
      },
      STORE => sub ($, $sensitive is copy) {
        gtk_widget_set_sensitive($!w, $sensitive);
      }
    );
  }

  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_visible($!w);
      },
      STORE => sub ($, $visible is copy) {
        gtk_widget_set_visible($!w, $visible);
      }
    );
  }

  method window is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Window.new( gtk_widget_get_window($!w) );
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
      STORE => sub ($, $events is copy) {
        gtk_widget_set_events($!w, $events);
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

  method tooltip_window is rw is also<tooltip-window> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_window($!w);
      },
      STORE => sub ($, $custom_window is copy) {
        gtk_widget_set_tooltip_window($!w, $custom_window);
      }
    );
  }

  method font_options is rw is also<font-options> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_font_options($!w);
      },
      STORE => sub ($, $options is copy) {
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
        gtk_widget_get_realized($!w);
      },
      STORE => sub ($, $realized is copy) {
        gtk_widget_set_realized($!w, $realized);
      }
    );
  }

  method visual is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_visual($!w);
      },
      STORE => sub ($, $visual is copy) {
        gtk_widget_set_visual($!w, $visual);
      }
    );
  }

  method vexpand is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_vexpand($!w);
      },
      STORE => sub ($, $expand is copy) {
        gtk_widget_set_vexpand($!w, $expand);
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
        gtk_widget_get_valign($!w);
      },
      STORE => sub ($, $align is copy) {
        gtk_widget_set_valign($!w, $align);
      }
    );
  }

  method has_window is rw is also<has-window> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_has_window($!w);
      },
      STORE => sub ($, $has_window is copy) {
        gtk_widget_set_has_window($!w, $has_window);
      }
    );
  }

  method double_buffered is rw is also<double-buffered> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_double_buffered($!w);
      },
      STORE => sub ($, $double_buffered is copy) {
        gtk_widget_set_double_buffered($!w, $double_buffered);
      }
    );
  }

  method parent is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_parent($!w);
      },
      STORE => sub ($, GtkWidget() $parent is copy) {
        gtk_widget_set_parent($!w, $parent);
      }
    );
  }

  method has_tooltip is rw is also<has-tooltip> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_has_tooltip($!w);
      },
      STORE => sub ($, $has_tooltip is copy) {
        gtk_widget_set_has_tooltip($!w, $has_tooltip);
      }
    );
  }

  method halign is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_halign($!w);
      },
      STORE => sub ($, $align is copy) {
        gtk_widget_set_halign($!w, $align);
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
        gtk_widget_get_state($!w);
      },
      STORE => sub ($, $state is copy) {
        gtk_widget_set_state($!w, $state);
      }
    );
  }

  method can_default is rw is also<can-default> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_can_default($!w);
      },
      STORE => sub ($, $can_default is copy) {
        gtk_widget_set_can_default($!w, $can_default);
      }
    );
  }

  method vexpand_set is rw is also<vexpand-set> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_vexpand_set($!w);
      },
      STORE => sub ($, $set is copy) {
        gtk_widget_set_vexpand_set($!w, $set);
      }
    );
  }

  method hexpand_set is rw is also<hexpand-set> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_hexpand_set($!w);
      },
      STORE => sub ($, $set is copy) {
        gtk_widget_set_hexpand_set($!w, $set);
      }
    );
  }

  method mapped is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_mapped($!w);
      },
      STORE => sub ($, $mapped is copy) {
        gtk_widget_set_mapped($!w, $mapped);
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
        gtk_widget_get_can_focus($!w);
      },
      STORE => sub ($, $can_focus is copy) {
        gtk_widget_set_can_focus($!w, $can_focus);
      }
    );
  }

  method support_multidevice is rw is also<support-multidevice> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_support_multidevice($!w);
      },
      STORE => sub ($, $support_multidevice is copy) {
        gtk_widget_set_support_multidevice($!w, $support_multidevice);
      }
    );
  }

  # Convenience attribute.
  method margins is rw {
    Proxy.new(
      FETCH => -> $ {
        (
          self.margin_left,
          self.margin_right,
          self.margin_top,
          self.margin_bottom
        );
      },
      STORE => -> $, Int() $margin {
        my $m = self.RESOLVE-UINT($margin);
        self.margin_left =
        self.margin_right =
        self.margin_top =
        self.margin_bottom = $m;
      }
    );
  }

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method composite-child is rw is also<composite_child> {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('composite-child', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        warn "composite-child does not allow writing"
      }
    );
  }

  # Type: gboolean
  method expand is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('expand', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('expand', $gv);
      }
    );
  }

  # Type: gboolean
  method has-focus is rw is also<has_focus> {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('has-focus', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('has-focus', $gv);
      }
    );
  }

  # Type: gint
  method height-request is rw is also<height_request> {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('height-request', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set('height-request', $gv);
      }
    );
  }

  # Type: gboolean
  method is-focus is rw is also<is_focus> {
    my GTK::Compat::Value $gv .= new(G_TYPE_BOOLEAN);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('is-focus', $gv) );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('is-focus', $gv);
      }
    );
  }

  # Type: gint
  method margin is rw {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get('margin', $gv) );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set('margin', $gv);
      }
    );
  }

  # Type: gint
  method scale-factor is rw is also<scale_factor> {
    my GTK::Compat::Value $gv .= new(G_TYPE_INT);
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get(
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
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new( self.prop_get('style', $gv) );
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
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new( self.prop_get(
          $!w, 'width-request', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = self.RESOLVE-INT($val);
        self.prop_set('width-request', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  method add_events (gint $events) is also<add-events> {
    gtk_widget_add_events($!w, $events);
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

  method remove_mnemonic_label (GtkWidget $label)
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
    gtk_widget_in_destruction($!w);
  }

  method get_valign_with_baseline is also<get-valign-with-baseline> {
    gtk_widget_get_valign_with_baseline($!w);
  }

  method has_visible_focus is also<has-visible-focus> {
    gtk_widget_has_visible_focus($!w);
  }

  method has_screen is also<has-screen> {
    gtk_widget_has_screen($!w);
  }

  method override_background_color (
    GtkStateFlags $state,
    GTK::Compat::RGBA $color
  )
    is also<override-background-color>
  {
    gtk_widget_override_background_color($!w, $state, $color);
  }

  method trigger_tooltip_query is also<trigger-tooltip-query> {
    gtk_widget_trigger_tooltip_query($!w);
  }

  method get_size_request (Int() $width, Int() $height)
    is also<get-size-request>
  {
    my @i = ($width, $height);
    my gint ($w, $h) = self.RESOLVE-INT(@i);
    gtk_widget_get_size_request($!w, $width, $height);
  }

  method has_default is also<has-default> {
    gtk_widget_has_default($!w);
  }

  method get_root_window is also<
    get-root-window
    root-window
    root_window
  > {
    gtk_widget_get_root_window($!w);
  }

  method get_frame_clock is also<
    get-frame-clock
    frame-clock
    frame_clock
  > {
    gtk_widget_get_frame_clock($!w);
  }

  proto method get_preferred_size(|) is also<get-preferred-size> { * }

  # Only use the shortened name for the no parameter variant.
  multi method get_preferred_size is also<preferred_size preferred-size> {
    my ($ms, $ns) = (GtkRequisition.new xx 2);
    samewith($ms, $ns);
    ($ms, $ns)
  }
  multi method get_preferred_size (
    GtkRequisition $minimum_size,
    GtkRequisition $natural_size
  ) {
    gtk_widget_get_preferred_size($!w, $minimum_size, $natural_size);
  }

  method device_is_shadowed (GdkDevice $device)
    is also<device-is-shadowed>
  {
    gtk_widget_device_is_shadowed($!w, $device);
  }

  method send_focus_change (GdkEvent $event)
    is also<send-focus-change>
  {
    gtk_widget_send_focus_change($!w, $event);
  }

  method size_request (GtkRequisition $requisition) is also<size-request> {
    gtk_widget_size_request($!w, $requisition);
  }

  method override_cursor (
    GTK::Compat::RGBA $cursor,
    GTK::Compat::RGBA $secondary_cursor
  ) is also<override-cursor> {
    gtk_widget_override_cursor($!w, $cursor, $secondary_cursor);
  }

  method list_action_prefixes is also<list-action-prefixes> {
    gtk_widget_list_action_prefixes($!w);
  }

  method set_device_enabled (GdkDevice $device, gboolean $enabled)
    is also<set-device-enabled>
  {
    gtk_widget_set_device_enabled($!w, $device, $enabled);
  }

  method get_pointer (gint $x, gint $y) is also<get-pointer> {
    gtk_widget_get_pointer($!w, $x, $y);
  }

  method grab_default  is also<grab-default> {
    gtk_widget_grab_default($!w);
  }

  method emit_can_activate_accel (guint $signal_id)
    is also<emit-can-activate-accel>
  {
    gtk_widget_can_activate_accel($!w, $signal_id);
  }

  method hide {
    gtk_widget_hide($!w);
  }

  method shape_combine_region (cairo_region_t $region)
    is also<shape-combine-region>
  {
    gtk_widget_shape_combine_region($!w, $region);
  }

  method unregister_window (GdkWindow $window)
    is also<unregister-window>
  {
    gtk_widget_unregister_window($!w, $window);
  }

  method send_expose (GdkEvent $event) is also<send-expose> {
    gtk_widget_send_expose($!w, $event);
  }

  method override_symbolic_color (Str() $name, GTK::Compat::RGBA $color)
    is also<override-symbolic-color>
  {
    gtk_widget_override_symbolic_color($!w, $name, $color);
  }

  method create_pango_context is also<create-pango-context> {
    gtk_widget_create_pango_context($!w);
  }

  method create_pango_layout(Str() $text) is also<create-pango-layout> {
    gtk_widget_create_pango_layout($!w, $text);
  }

  method get_device_events (GdkDevice $device) is also<get-device-events> {
    gtk_widget_get_device_events($!w, $device);
  }

  # method style_get_valist (Str() $first_property_name, va_list $var_args)
  #   is also<style-get-valist>
  # {
  #   gtk_widget_style_get_valist($!w, $first_property_name, $var_args);
  # }

  method toplevel_is_focus is also<toplevel-is-focus> {
    gtk_widget_is_focus($!w);
  }

  method freeze_child_notify is also<freeze-child-notify> {
    gtk_widget_freeze_child_notify($!w);
  }

  method remove_accelerator (
    GtkAccelGroup $accel_group,
    guint $accel_key,
    GdkModifierType $accel_mods
  )
    is also<remove-accelerator>
  {
    gtk_widget_remove_accelerator($!w, $accel_group, $accel_key, $accel_mods);
  }

  method queue_draw_region (cairo_region_t $region)
    is also<queue-draw-region>
  {
    gtk_widget_queue_draw_region($!w, $region);
  }

  method is_visible (GtkWidget $!w) is also<is-visible> {
    gtk_widget_is_visible($!w);
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
    gtk_widget_is_ancestor($!w, $ancestor);
  }

  method override_color (GtkStateFlags $state, GTK::Compat::RGBA $color)
    is also<override-color>
  {
    gtk_widget_override_color($!w, $state, $color);
  }

  method get_allocated_height is also<get-allocated-height> {
    gtk_widget_get_allocated_height($!w);
  }

  method get_allocation (GtkAllocation $allocation) is also<get-allocation> {
    gtk_widget_get_allocation($!w, $allocation);
  }

  method get_style_context is also<
    get-style-context
    style-context
    style_context
  > {
    GTK::StyleContext.new( gtk_widget_get_style_context($!w) );
  }

  method get_clip (GtkAllocation $clip) is also<get-clip> {
    gtk_widget_get_clip($!w, $clip);
  }

#  method class_find_style_property (GtkWidgetClass $klass, Str() $property_name) {
#    gtk_widget_class_find_style_property($klass, $property_name);
#  }

  method get_device_enabled (GdkDevice $device) is also<get-device-enabled> {
    gtk_widget_get_device_enabled($!w, $device);
  }

  method get_ancestor (GType $widget_type) is also<get-ancestor> {
    gtk_widget_get_ancestor($!w, $widget_type);
  }

  method get_request_mode is also<get-request-mode> {
    gtk_widget_get_request_mode($!w);
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

  method focus_grab is also<focus-grab> {
    gtk_widget_grab_focus($!w);
  }

  method get_preferred_height_and_baseline_for_width (
    gint $width,
    gint $minimum_height,
    gint $natural_height,
    gint $minimum_baseline,
    gint $natural_baseline
  )
    is also<get-preferred-height-and-baseline-for-width>
  {
    gtk_widget_get_preferred_height_and_baseline_for_width(
      $!w,
      $width,
      $minimum_height,
      $natural_height,
      $minimum_baseline,
      $natural_baseline
    );
  }

  method activate {
    gtk_widget_activate($!w);
  }

  method add_device_events (GdkDevice $device, GdkEventMask $events)
    is also<add-device-events>
  {
    gtk_widget_add_device_events($!w, $device, $events);
  }

  method remove_tick_callback (guint $id)
    is also<remove-tick-callback>
  {
    gtk_widget_remove_tick_callback($!w, $id);
  }

  #method class_bind_template_callback_full (GtkWidgetClass $widget_class, Str() $callback_name, GCallback $callback_symbol) {
  #  gtk_widget_class_bind_template_callback_full($widget_class, $callback_name, $callback_symbol);
  #}

  method get_requisition (GtkRequisition $requisition)
    is also<get-requisition>
  {
    gtk_widget_get_requisition($!w, $requisition);
  }

  method queue_draw_area (gint $x, gint $y, gint $width, gint $height)
    is also<queue-draw-area>
  {
    gtk_widget_queue_draw_area($!w, $x, $y, $width, $height);
  }

  method compute_expand (GtkOrientation $orientation)
    is also<compute-expand>
  {
    gtk_widget_compute_expand($!w, $orientation);
  }

  method override_font (PangoFontDescription $font_desc)
    is also<override-font>
  {
    gtk_widget_override_font($!w, $font_desc);
  }

  method set_redraw_on_allocate (gboolean $redraw_on_allocate)
    is also<set-redraw-on-allocate>
  {
    gtk_widget_set_redraw_on_allocate($!w, $redraw_on_allocate);
  }

  method get_preferred_height (gint $minimum_height, gint $natural_height)
    is also<get-preferred-height>
  {
    gtk_widget_get_preferred_height($!w, $minimum_height, $natural_height);
  }

  method unmap (GtkWidget() $!w) {
    gtk_widget_unmap($!w);
  }

  method error_bell (GtkWidget() $!w) is also<error-bell> {
    gtk_widget_error_bell($!w);
  }

  method translate_coordinates (
    GTK::Widget:U:
    GtkWidget $src_widget,
    GtkWidget $dest_widget,
    gint $src_x,
    gint $src_y,
    gint $dest_x,
    gint $dest_y
  )
    is also<translate-coordinates>
  {
    gtk_widget_translate_coordinates(
      $src_widget,
      $dest_widget,
      $src_x,
      $src_y,
      $dest_x,
      $dest_y
    );
  }

  method style_get_property (Str() $property_name, GValue $value)
    is also<style-get-property>
  {
    gtk_widget_style_get_property($!w, $property_name, $value);
  }

  method get_scale_factor is also<get-scale-factor> {
    gtk_widget_get_scale_factor($!w);
  }

  method is_composited is also<is-composited> {
    gtk_widget_is_composited($!w);
  }

  method get_pango_context is also<get-pango-context> {
    gtk_widget_get_pango_context($!w);
  }

  #method class_set_template (GtkWidgetClass $widget_class, GBytes $template_bytes) {
  #  gtk_widget_class_set_template($widget_class, $template_bytes);
  #}

  #method class_set_accessible_type (GtkWidgetClass $widget_class, GType $type) {
  #  gtk_widget_class_set_accessible_type($widget_class, $type);
  #}

  method is_sensitive is also<is-sensitive> {
    gtk_widget_is_sensitive($!w);
  }

  # Made multi to avoid conflict with the signal "event" handler.
  multi method event (GdkEvent $event) {
    gtk_widget_event($!w, $event);
  }

  method queue_resize_no_redraw is also<queue-resize-no-redraw> {
    gtk_widget_queue_resize_no_redraw($!w);
  }

  method destroyed (GtkWidget() $widget_pointer) {
    gtk_widget_destroyed($!w, $widget_pointer);
  }

  method get_action_group (Str() $prefix) is also<get-action-group> {
    gtk_widget_get_action_group($!w, $prefix);
  }

  method init_template is also<init-template> {
    gtk_widget_init_template($!w);
  }

  method get_preferred_width_for_height (
    gint $height,
    gint $minimum_width,
    gint $natural_width
  )
    is also<get-preferred-width-for-height>
  {
    gtk_widget_get_preferred_width_for_height(
      $!w,
      $height,
      $minimum_width,
      $natural_width
    );
  }

  method get_template_child (GType $widget_type, Str() $name)
    is also<get-template-child>
  {
    gtk_widget_get_template_child($!w, $widget_type, $name);
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

  method get_display is also<get-display display> {
    GTK::Compat::Display.new( gtk_widget_get_display($!w) );
  }

  method list_accel_closures is also<list-accel-closures> {
    gtk_widget_list_accel_closures($!w);
  }

  method size_allocate_with_baseline (
    GtkAllocation $allocation,
    gint $baseline
  )
    is also<size-allocate-with-baseline>
  {
    gtk_widget_size_allocate_with_baseline($!w, $allocation, $baseline);
  }

  #method class_install_style_property_parser (GtkWidgetClass $klass, GParamSpec $pspec, GtkRcPropertyParser $parser) {
  #  gtk_widget_class_install_style_property_parser($klass, $pspec, $parser);
  #}

  method insert_action_group (Str() $name, GActionGroup $group)
    is also<insert-action-group>
  {
    gtk_widget_insert_action_group($!w, $name, $group);
  }

  method get_toplevel is also<
    get-toplevel
    toplevel
  > {
    GTK::Widget.new( gtk_widget_get_toplevel($!w) );
  }

  method set_device_events (GdkDevice $device, GdkEventMask $events)
    is also<set-device-events>
  {
    gtk_widget_set_device_events($!w, $device, $events);
  }

  method get_clipboard (GdkAtom $selection) is also<get-clipboard> {
    gtk_widget_get_clipboard($!w, $selection);
  }

  method queue_draw is also<queue-draw> {
    gtk_widget_queue_draw($!w);
  }

  method map {
    gtk_widget_map($!w);
  }

  method render_icon_pixbuf (Str() $stock_id, GtkIconSize $size)
    is also<render-icon-pixbuf>
  {
    gtk_widget_render_icon_pixbuf($!w, $stock_id, $size);
  }

  method register_window (GdkWindow $window) is also<register-window> {
    gtk_widget_register_window($!w, $window);
  }

  #method class_bind_template_child_full (GtkWidgetClass $widget_class, Str() $name, gboolean $internal_child, gssize $struct_offset) {
  #  gtk_widget_class_bind_template_child_full($widget_class, $name, $internal_child, $struct_offset);
  #}

  method set_allocation (GtkAllocation $allocation) is also<set-allocation> {
    gtk_widget_set_allocation($!w, $allocation);
  }

  method child_focus (GtkDirectionType $direction) is also<child-focus> {
    gtk_widget_child_focus($!w, $direction);
  }

  method reparent (GtkWidget() $new_parent) {
    gtk_widget_reparent($!w, $new_parent);
  }

  method queue_allocate is also<queue-allocate> {
    gtk_widget_queue_allocate($!w);
  }

  method show_now is also<show-now> {
    gtk_widget_show_now($!w);
  }

  method destroy {
    gtk_widget_destroy($!w);
  }

  method requisition_free (GtkRequisition $requisition)
    is also<requisition-free>
  {
    gtk_requisition_free($requisition);
  }

  method get_child_requisition (GtkRequisition $requisition)
    is also<get-child-requisition>
  {
    gtk_widget_get_child_requisition($!w, $requisition);
  }

  method get_allocated_size (GtkAllocation $allocation, Int() $baseline)
    is also<get-allocated-size>
  {
    my gint $b = self.RESOLVE-INT($baseline);
    gtk_widget_get_allocated_size($!w, $allocation, $);
  }

  #method class_set_template_from_resource (GtkWidgetClass $widget_class, Str() $resource_name) {
  #  gtk_widget_class_set_template_from_resource($widget_class, $resource_name);
  #}

  method get_path is also<get-path> {
    gtk_widget_get_path($!w);
  }

  method is_toplevel is also<is-toplevel> {
    gtk_widget_is_toplevel($!w);
  }

  method emit_child_notify (Str() $child_property)
    is also<emit-child-notify>
  {
    gtk_widget_child_notify($!w, $child_property);
  }

  #method class_install_style_property (GtkWidgetClass $klass, GParamSpec $pspec) {
  #  gtk_widget_class_install_style_property($klass, $pspec);
  #}

  method set_size_request (gint $width, gint $height)
    is also<set-size-request>
  {
    gtk_widget_set_size_request($!w, $width, $height);
  }

  method thaw_child_notify is also<thaw-child-notify> {
    gtk_widget_thaw_child_notify($!w);
  }

  method add_accelerator (
    Str() $accel_signal,
    GtkAccelGroup $accel_group,
    guint $accel_key,
    GdkModifierType $accel_mods,
    GtkAccelFlags $accel_flags
  )
    is also<add-accelerator>
  {
    gtk_widget_add_accelerator(
      $!w,
      $accel_signal,
      $accel_group,
      $accel_key,
      $accel_mods,
      $accel_flags
    );
  }

  # Multi methods so as to not conflict with the signal handler of the same
  # name. Aliases implemented manually.
  multi method size_allocate (GtkAllocation $allocation) {
    gtk_widget_size_allocate($!w, $allocation);
  }
  multi method size-allocate (GtkAllocation $allocation) {
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

  method requisition_copy (GtkRequisition $requisition)
    is also<requisition-copy>
  {
    gtk_requisition_copy($requisition);
  }

  method get_preferred_width (gint $minimum_width, gint $natural_width)
    is also<get-preferred-width>
  {
    gtk_widget_get_preferred_width($!w, $minimum_width, $natural_width);
  }

  method get_screen is also<get-screen screen> {
    GTK::Compat::Screen.new( gtk_widget_get_screen($!w) );
  }

  method queue_resize is also<queue-resize> {
    gtk_widget_queue_resize($!w);
  }

  method get_accessible is also<get-accessible> {
    gtk_widget_get_accessible($!w);
  }

  method get_preferred_height_for_width (
    gint $width,
    gint $minimum_height,
    gint $natural_height
  )
    is also<get-preferred-height-for-width>
  {
    gtk_widget_get_preferred_height_for_width(
      $!w,
      $width,
      $minimum_height,
      $natural_height
    );
  }

  method list_mnemonic_labels is also<list-mnemonic-labels> {
    gtk_widget_list_mnemonic_labels($!w);
  }

  method add_mnemonic_label (GtkWidget $label) is also<add-mnemonic-label> {
    gtk_widget_add_mnemonic_label($!w, $label);
  }

  #method class_set_connect_func (GtkWidgetClass $widget_class, GtkBuilderself.connectFunc $self.connect_func, gpointer $self.connect_data, GDestroyNotify $self.connect_data_destroy) {
  #  gtk_widget_class_set_connect_func($widget_class, $self.connect_func, $self.connect_data, $self.connect_data_destroy);
  #}

  method set_accel_path (Str() $accel_path, GtkAccelGroup $accel_group)
    is also<set-accel-path>
  {
    gtk_widget_set_accel_path($!w, $accel_path, $accel_group);
  }

  method get_settings is also<get-settings> {
    gtk_widget_get_settings($!w);
  }

  method get_modifier_mask (GdkModifierIntent $intent)
    is also<get-modifier-mask>
  {
    gtk_widget_get_modifier_mask($!w, $intent);
  }

  method has_grab is also<has-grab> {
    gtk_widget_has_grab($!w);
  }

  #method class_list_style_properties (GtkWidgetClass $klass, guint $n_properties) {
  #  gtk_widget_class_list_style_properties($klass, $n_properties);
  #}

  method get_allocated_width is also<get-allocated-width> {
    gtk_widget_get_allocated_width($!w);
  }

  method is_drawable is also<is-drawable> {
    gtk_widget_is_drawable($!w);
  }

  method global_has_focus is also<global-has-focus> {
    gtk_widget_has_focus($!w);
  }

  method unrealize {
    gtk_widget_unrealize($!w);
  }

  method add_tick_callback (
    &callback,
    gpointer $user_data = gpointer,
    GDestroyNotify $notify = GDestroyNotify
  )
    is also<add-tick-callback>
  {
    gtk_widget_add_tick_callback($!w, &callback, $user_data, $notify);
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
    GdkDragContext $context,
    GtkTargetList() $target_list
  )
    is also<dest-find-target>
  {
    gtk_drag_dest_find_target($!w, $context, $target_list);
  }

  method dest_set (
    GtkDestDefaults $flags,
    GtkTargetEntry $targets,
    Int() $n_targets,
    Int() $actions
  )
    is also<dest-set>
  {
    my gint $nt = self.RESOLVE-INT($n_targets);
    my guint $a = self.RESOLVE-UINT($actions);
    gtk_drag_dest_set($!w, $flags, $targets, $nt, $a);
  }

  method dest_set_proxy (
    GdkWindow $proxy_window,
    Int() $protocol,
    Int() $use_coordinates
  )
    is also<dest-set-proxy>
  {
    my guint $p = self.RESOLVE-UINT($protocol);
    my gboolean $uc = self.RESOLVE-BOOL($use_coordinates);
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

  method source_set (
    Int() $start_button_mask,
    GtkTargetEntry $targets,
    Int() $n_targets,
    Int() $actions
  )
    is also<source-set>
  {
    my @u = ($start_button_mask, $actions);
    my guint ($sbm, $a) = self.RESOLVE-UINT(@u);
    my gint $nt = self.RESOLVE-INT($n_targets);
    gtk_drag_source_set($!w, $sbm, $targets, $nt, $a);
  }

  method source_set_icon_gicon (GIcon $icon)
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

}
