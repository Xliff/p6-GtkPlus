use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;

use GTK::Raw::Subs;
use GTK::Raw::Types;
use GTK::Raw::Widget;

use GTK::Roles::Signals;
use GTK::Roles::Types;

class GTK::Widget {
  also does GTK::Roles::Signals;
  also does GTK::Roles::Types;

  has GtkWidget $!w;

  submethod BUILD (:$widget) {
    given $widget {
      when GtkWidget {
        $!w = $widget;
      }
      default {
      }
    }
  }

  submethod DESTROY {
    g_object_unref($!w.p);
  }

  method widget {
    $!w;
  }

  proto new(|) { * }

  method new($widget) {
    self.bless(:$widget);
  }

  method GTK::Raw::Types::GtkWidget {
    $!w;
  }

  method setWidget($widget) {
#    "setWidget".say;
    # cw: Consider at least a warning if $!w has already been set.
    $!w = do given $widget {
      when GtkWidget   { $_; }
      # This will go away once proper pass-down rules have been established.
      default {
#        say "Setting from { .^name }";
         die "GTK::Widget initialized from unexpected source!";
      }
    };
  }

  method setType($typeName) {
    self.IS-PROTECTED;

    my $oldType = self.getType;
    with $oldType {
      warn "WARNING -- Resetting type from $oldType to $typeName"
        unless $oldType eq 'GTK::Widget' || $oldType eq $typeName;
    }

    g_object_set_string($!w, 'GTKPLUS-Type', $typeName)
      unless ($oldType // '') ne $typeName;
  }

  # Static methods
  method cairo_should_draw_window (GTK::Widget:U: cairo_t $cr, GdkWindow $window) {
    gtk_cairo_should_draw_window($cr, $window);
  }

  method cairo_transform_to_window (GTK::Widget:U: cairo_t $cr, GtkWidget $!w, GdkWindow $window) {
    gtk_cairo_transform_to_window($cr, $!w, $window);
  }

  method get_default_direction(GTK::Widget:U: ) {
    gtk_widget_get_default_direction();
  }

  method pop_composite_child(GTK::Widget:U: ) {
    gtk_widget_pop_composite_child();
  }

  method push_composite_child(GTK::Widget:U: ) {
    gtk_widget_push_composite_child();
  }

  method set_default_direction (GTK::Widget:U: GtkTextDirection $dir) {
    gtk_widget_set_default_direction($dir);
  }

  method requisition_get_type(GTK::Widget:U: ) {
    gtk_requisition_get_type();
  }

  method requisition_new(GTK::Widget:U: ) {
    gtk_requisition_new();
  }

  # Signal
  method accel-closures-changed {
    self.connect($!w, 'accel-closures-changed');
  }

  # Signal
  method button-press-event {
    self.connect($!w, 'button-press-event');
  }

  # Signal
  method button-release-event {
    self.connect($!w, 'button-release-event');
  }

  # Signal --> Boolean
  method can-activate-accel {
    self.connect($!w, 'can-activate-accel');
  }

  # Signal --> No Hooks
  method child-notify {
    self.connect($!w, 'child-notify');
  }

  # Signal
  method composited-changed {
    self.connect($!w, 'composited-changed');
  }

  # Signal gboolean Run Last
  method configure-event {
    self.connect($!w, 'configure-event');
  }

  # Signal gboolean Run Last
  method damage-event {
    self.connect($!w, 'damage-event');
  }

  # Signal gboolean Run Last
  method delete-event {
    self.connect($!w, 'delete-event');
  }

  # Signal void No Hooks
  # Method renamed to avoid conflict with the destroy method using the same signature.
  method destroy-signal {
    self.connect($!w, 'destroy');
  }

  # Signal gboolean Run Last
  method destroy-event {
    self.connect($!w, 'destroy-event');
  }

  # Signal void Run First
  method direction-changed {
    self.connect($!w, 'direction-changed');
  }

  # Signal void Run Last
  method drag-begin {
    self.connect($!w, 'drag-begin');
  }

  # Signal void Run Last
  method drag-data-delete {
    self.connect($!w, 'drag-data-delete');
  }

  # Signal void Run Last
  method drag-data-get {
    self.connect($!w, 'drag-data-get');
  }

  # Signal void Run Last
  method drag-data-received {
    self.connect($!w, 'drag-data-received');
  }

  # Signal gboolean Run Last
  method drag-drop {
    self.connect($!w, 'drag-drop');
  }

  # Signal void Run Last
  method drag-end {
    self.connect($!w, 'drag-end');
  }

  # Signal gboolean Run Last
  method drag-failed {
    self.connect($!w, 'drag-failed');
  }

  # Signal void Run Last
  method drag-leave {
    self.connect($!w, 'drag-leave');
  }

  # Signal gboolean Run Last
  method drag-motion {
    self.connect($!w, 'drag-motion');
  }

  # Signal gboolean Run Last
  # Multi to allow for method draw(GtkWidget, cairo_t)
  multi method draw {
    self.connect($!w, 'draw');
  }

  # Signal gboolean Run Last
  method enter-notify-event {
    self.connect($!w, 'enter-notify-event');
  }

  # Signal gboolean Run Last
  # Made multi to avoid conflict with another method event, below
  multi method event {
    self.connect($!w, 'event');
  }

  # Signal Run
  method event-after {
    self.connect($!w, 'event-after');
  }

  # Signal gboolean Run Last
  method focus {
    self.connect($!w, 'focus');
  }

  # Signal gboolean Run Last
  method focus-in-event {
    self.connect($!w, 'focus-in-event');
  }

  # Signal gboolean Run Last
  method focus-out-event {
    self.connect($!w, 'focus-out-event');
  }

  # Signal gboolean Run Last
  method grab-broken-event {
    self.connect($!w, 'grab-broken-event');
  }

  # Signal  Action
  method grab-focus {
    self.connect($!w, 'grab-focus');
  }

  # Signal void Run First
  method grab-notify {
    self.connect($!w, 'grab-notify');
  }


  # Signal void Run First
  # Renamed from "hide" so as to not conflict with the method below with same signature.
  # In cases where the method is more common than the signal, common practice will be to
  # append "-signal" to the signal handler.
  method hide-signal {
    self.connect($!w, 'hide');
  }

  # Signal void Run Last
  method hierarchy-changed {
    self.connect($!w, 'hierarchy-changed');
  }

  # Signal gboolean Run Last
  method key-press-event {
    self.connect($!w, 'key-press-event');
  }

  # Signal gboolean Run Last
  method key-release-event {
    self.connect($!w, 'key-release-event');
  }

  # Signal gboolean Run Last
  method keynav-failed {
    self.connect($!w, 'keynav-failed');
  }

  # Signal gboolean Run Last
  method leave-notify-event {
    self.connect($!w, 'leave-notify-event');
  }

  # Signal void Run First
  # Renamed to avoid conflict with the method map using the same signature.
  method map-signal {
    self.connect($!w, 'map');
  }

  # Signal gboolean Run Last
  method map-event {
    self.connect($!w, 'map-event');
  }

  # Signal gboolean Run Last
  method mnemonic-activate {
    self.connect($!w, 'mnemonic-activate');
  }

  # Signal gboolean Run Last
  method motion-notify-event {
    self.connect($!w, 'motion-notify-event');
  }

  # Signal Action
  method move-focus {
    self.connect($!w, 'move-focus');
  }

  # Signal void Run First
  method parent-set {
    self.connect($!w, 'parent-set');
  }

  # Signal gboolean
  method popup-menu {
    self.connect($!w, 'popup-menu');
  }

  # Signal gboolean Run Last
  method property-notify-event {
    self.connect($!w, 'property-notify-event');
  }

  # Signal gboolean Run Last
  method proximity-in-event {
    self.connect($!w, 'proximity-in-event');
  }

  # Signal gboolean Run Last
  method proximity-out-event {
    self.connect($!w, 'proximity-out-event');
  }

  # Signal gboolean Run Last
  method query-tooltip {
    self.connect($!w, 'query-tooltip');
  }

  # Signal void Run First
  # Renamed to avoid conflict with the realize method using the same signature.
  method realize-signal {
    self.connect($!w, 'realize');
  }

  # Signal void Run Last
  method screen-changed {
    self.connect($!w, 'screen-changed');
  }

  # Signal gboolean Run Last
  method scroll-event {
    self.connect($!w, 'scroll-event');
  }

  # Signal gboolean Run Last
  method selection-clear-event {
    self.connect($!w, 'selection-clear-event');
  }

  # Signal void Run Last
  method selection-get {
    self.connect($!w, 'selection-get');
  }

  # Signal gboolean Run Last
  method selection-notify-event {
    self.connect($!w, 'selection-notify-event');
  }

  # Signal void Run Last
  method selection-received {
    self.connect($!w, 'selection-received');
  }

  # Signal gboolean Run Last
  method selection-request-event {
    self.connect($!w, 'selection-request-event');
  }

  # Signal void Run First
  # Renamed from "show" so as to not conflict with the method below with same signature.
  method show-signal {
    self.connect($!w, 'show');
  }

  method show-help {
    self.connect($!w, 'show-help');
  }

  # Signal void Run First
  method size-allocate {
    self.connect($!w, 'size-allocate');
  }

  # Signal void Run First
  method state-changed {
    self.connect($!w, 'state-changed');
  }

  # Signal void Run First
  method state-flags-changed {
    self.connect($!w, 'state-flags-changed');
  }

  # Signal void Run First
  method style-set {
    self.connect($!w, 'style-set');
  }

  # Signal void Run First
  method style-updated {
    self.connect($!w, 'style-updated');
  }

  # Signal gboolean Run Last
  method touch-event {
    self.connect($!w, 'touch-event');
  }

  # Signal void Run First
  # Renamed to avoid conflict with the unmap method using the same signature.
  method unmap-signal {
    self.connect($!w, 'unmap');
  }

  # Signal gboolean Run Last
  method unmap-event {
    self.connect($!w, 'unmap-event');
  }

  # Signal void Run Last
  # Renamed to avoid conflict with the unrealize method using the same signature.
  method unrealize-signal {
    self.connect($!w, 'unrealize');
  }

  # Signal gboolean Run Last
  method visibility-notify-event {
    self.connect($!w, 'visibility-notify-event');
  }

  # Signal gboolean Run Last
  method window-state-event {
    self.connect($!w, 'window-state-event');
  }

  method receives_default is rw {
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

  method app_paintable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_app_paintable($!w);
      },
      STORE => sub ($, $app_paintable is copy) {
        gtk_widget_set_app_paintable($!w, $app_paintable);
      }
    );
  }

  method font_map is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_font_map($!w);
      },
      STORE => sub ($, $font_map is copy) {
        gtk_widget_set_font_map($!w, $font_map);
      }
    );
  }

  method tooltip_markup is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_markup($!w);
      },
      STORE => sub ($, $markup is copy) {
        gtk_widget_set_tooltip_markup($!w, $markup);
      }
    );
  }

  method tooltip_text is rw {
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

  method margin_top is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_top($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_top($!w, $margin);
      }
    );
  }

  method focus_on_click is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_focus_on_click($!w);
      },
      STORE => sub ($, $focus_on_click is copy) {
        gtk_widget_set_focus_on_click($!w, $focus_on_click);
      }
    );
  }

  method child_visible is rw {
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

  method margin_right is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_right($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_right($!w, $margin);
      }
    );
  }

  method margin_left is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_left($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_left($!w, $margin);
      }
    );
  }

  method parent_window is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_parent_window($!w);
      },
      STORE => sub ($, $parent_window is copy) {
        gtk_widget_set_parent_window($!w, $parent_window);
      }
    );
  }

  method state_flags is rw {
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
        gtk_widget_get_window($!w);
      },
      STORE => sub ($, $window is copy) {
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
      STORE => sub ($, $opacity is copy) {
        gtk_widget_set_opacity($!w, $opacity);
      }
    );
  }

  method tooltip_window is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_window($!w);
      },
      STORE => sub ($, $custom_window is copy) {
        gtk_widget_set_tooltip_window($!w, $custom_window);
      }
    );
  }

  method font_options is rw {
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

  method margin_start is rw {
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

  method margin_bottom is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_margin_bottom($!w);
      },
      STORE => sub ($, $margin is copy) {
        gtk_widget_set_margin_bottom($!w, $margin);
      }
    );
  }

  method margin_end is rw {
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

  method has_window is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_has_window($!w);
      },
      STORE => sub ($, $has_window is copy) {
        gtk_widget_set_has_window($!w, $has_window);
      }
    );
  }

  method double_buffered is rw {
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
      STORE => sub ($, $parent is copy) {
        gtk_widget_set_parent($!w, $parent);
      }
    );
  }

  method has_tooltip is rw {
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

  method no_show_all is rw {
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

  method can_default is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_can_default($!w);
      },
      STORE => sub ($, $can_default is copy) {
        gtk_widget_set_can_default($!w, $can_default);
      }
    );
  }

  method vexpand_set is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_vexpand_set($!w);
      },
      STORE => sub ($, $set is copy) {
        gtk_widget_set_vexpand_set($!w, $set);
      }
    );
  }

  method hexpand_set is rw {
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

  method composite_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_composite_name($!w);
      },
      STORE => sub ($, $name is copy) {
        gtk_widget_set_composite_name($!w, $name);
      }
    );
  }

  method can_focus is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_can_focus($!w);
      },
      STORE => sub ($, $can_focus is copy) {
        gtk_widget_set_can_focus($!w, $can_focus);
      }
    );
  }

  method support_multidevice is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_widget_get_support_multidevice($!w);
      },
      STORE => sub ($, $support_multidevice is copy) {
        gtk_widget_set_support_multidevice($!w, $support_multidevice);
      }
    );
  }

  method getType {
    g_object_get_string(
      nativecast(Pointer, $!w),
      'GTKPLUS-Type'
    );
  }

  method add_events (gint $events) {
    gtk_widget_add_events($!w, $events);
  }

  #method class_set_accessible_role (GtkWidgetClass $widget_class, AtkRole $role) {
  #  gtk_widget_class_set_accessible_role($widget_class, $role);
  #}

  method region_intersect (cairo_region_t $region) {
    gtk_widget_region_intersect($!w, $region);
  }

  # Multi to allow for handler to signal draw.
  multi method draw (GtkWidget $!w, cairo_t $cr) {
    gtk_widget_draw($!w, $cr);
  }

  method remove_mnemonic_label (GtkWidget $label) {
    gtk_widget_remove_mnemonic_label($!w, $label);
  }

  method input_shape_combine_region (cairo_region_t $region) {
    gtk_widget_input_shape_combine_region($!w, $region);
  }

  method in_destruction {
    gtk_widget_in_destruction($!w);
  }

  method get_valign_with_baseline {
    gtk_widget_get_valign_with_baseline($!w);
  }

  method has_visible_focus {
    gtk_widget_has_visible_focus($!w);
  }

  method has_screen {
    gtk_widget_has_screen($!w);
  }

  method override_background_color (
    GtkStateFlags $state,
    GTK::Compat::RGBA $color
  ) {
    gtk_widget_override_background_color($!w, $state, $color);
  }

  method trigger_tooltip_query {
    gtk_widget_trigger_tooltip_query($!w);
  }

  method get_size_request (gint $width, gint $height) {
    gtk_widget_get_size_request($!w, $width, $height);
  }

  method has_default {
    gtk_widget_has_default($!w);
  }

  method get_root_window {
    gtk_widget_get_root_window($!w);
  }

  method get_frame_clock {
    gtk_widget_get_frame_clock($!w);
  }

  method get_preferred_size (
    GtkRequisition $minimum_size,
    GtkRequisition $natural_size
  ) {
    gtk_widget_get_preferred_size($!w, $minimum_size, $natural_size);
  }

  method device_is_shadowed (GdkDevice $device) {
    gtk_widget_device_is_shadowed($!w, $device);
  }

  method send_focus_change (GdkEvent $event) {
    gtk_widget_send_focus_change($!w, $event);
  }

  method size_request (GtkRequisition $requisition) {
    gtk_widget_size_request($!w, $requisition);
  }

  method override_cursor (
    GTK::Compat::RGBA $cursor,
    GTK::Compat::RGBA $secondary_cursor
  ) {
    gtk_widget_override_cursor($!w, $cursor, $secondary_cursor);
  }

  method list_action_prefixes {
    gtk_widget_list_action_prefixes($!w);
  }

  method set_device_enabled (GdkDevice $device, gboolean $enabled) {
    gtk_widget_set_device_enabled($!w, $device, $enabled);
  }

  method get_pointer (gint $x, gint $y) {
    gtk_widget_get_pointer($!w, $x, $y);
  }

  method grab_default  {
    gtk_widget_grab_default($!w);
  }

  method can_activate_accel (guint $signal_id) {
    gtk_widget_can_activate_accel($!w, $signal_id);
  }

  method hide {
    gtk_widget_hide($!w);
  }

  method shape_combine_region (cairo_region_t $region) {
    gtk_widget_shape_combine_region($!w, $region);
  }

  method unregister_window (GdkWindow $window) {
    gtk_widget_unregister_window($!w, $window);
  }

  method send_expose (GdkEvent $event) {
    gtk_widget_send_expose($!w, $event);
  }

  method override_symbolic_color (gchar $name, GTK::Compat::RGBA $color) {
    gtk_widget_override_symbolic_color($!w, $name, $color);
  }

  method create_pango_context {
    gtk_widget_create_pango_context($!w);
  }

  method get_device_events (GdkDevice $device) {
    gtk_widget_get_device_events($!w, $device);
  }

  method style_get_valist (gchar $first_property_name, va_list $var_args) {
    gtk_widget_style_get_valist($!w, $first_property_name, $var_args);
  }

  method is_focus {
    gtk_widget_is_focus($!w);
  }

  method freeze_child_notify {
    gtk_widget_freeze_child_notify($!w);
  }

  method remove_accelerator (
    GtkAccelGroup $accel_group,
    guint $accel_key,
    GdkModifierType $accel_mods
  ) {
    gtk_widget_remove_accelerator($!w, $accel_group, $accel_key, $accel_mods);
  }

  method queue_draw_region (cairo_region_t $region) {
    gtk_widget_queue_draw_region($!w, $region);
  }

  method is_visible (GtkWidget $!w) {
    gtk_widget_is_visible($!w);
  }

  method mnemonic_activate (gboolean $group_cycling) {
    gtk_widget_mnemonic_activate($!w, $group_cycling);
  }

  method show_all {
    gtk_widget_show_all($!w);
  }

  method show {
    gtk_widget_show($!w);
  }

  method queue_compute_expand {
    gtk_widget_queue_compute_expand($!w);
  }

  method is_ancestor (GtkWidget() $ancestor) {
    gtk_widget_is_ancestor($!w, $ancestor);
  }

  method override_color (GtkStateFlags $state, GTK::Compat::RGBA $color) {
    gtk_widget_override_color($!w, $state, $color);
  }

  method get_allocated_height {
    gtk_widget_get_allocated_height($!w);
  }

  method get_allocation (GtkAllocation $allocation) {
    gtk_widget_get_allocation($!w, $allocation);
  }

  method get_style_context {
    gtk_widget_get_style_context($!w);
  }

  method get_clip (GtkAllocation $clip) {
    gtk_widget_get_clip($!w, $clip);
  }

#  method class_find_style_property (GtkWidgetClass $klass, gchar $property_name) {
#    gtk_widget_class_find_style_property($klass, $property_name);
#  }

  method get_device_enabled (GdkDevice $device) {
    gtk_widget_get_device_enabled($!w, $device);
  }

  method get_ancestor (GType $widget_type) {
    gtk_widget_get_ancestor($!w, $widget_type);
  }

  method get_request_mode {
    gtk_widget_get_request_mode($!w);
  }

  method intersect (GdkRectangle $area, GdkRectangle $intersection) {
    gtk_widget_intersect($!w, $area, $intersection);
  }

  method unparent {
    gtk_widget_unparent($!w);
  }

  method set_clip (GtkAllocation $clip) {
    gtk_widget_set_clip($!w, $clip);
  }

  method grab_focus {
    gtk_widget_grab_focus($!w);
  }

  method get_preferred_height_and_baseline_for_width (
    gint $width,
    gint $minimum_height,
    gint $natural_height,
    gint $minimum_baseline,
    gint $natural_baseline
  ) {
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

  method add_device_events (GdkDevice $device, GdkEventMask $events) {
    gtk_widget_add_device_events($!w, $device, $events);
  }

  method create_pango_layout (gchar $text) {
    gtk_widget_create_pango_layout($!w, $text);
  }

  method remove_tick_callback (guint $id) {
    gtk_widget_remove_tick_callback($!w, $id);
  }

  #method class_bind_template_callback_full (GtkWidgetClass $widget_class, gchar $callback_name, GCallback $callback_symbol) {
  #  gtk_widget_class_bind_template_callback_full($widget_class, $callback_name, $callback_symbol);
  #}

  method get_requisition (GtkRequisition $requisition) {
    gtk_widget_get_requisition($!w, $requisition);
  }

  method queue_draw_area (gint $x, gint $y, gint $width, gint $height) {
    gtk_widget_queue_draw_area($!w, $x, $y, $width, $height);
  }

  method compute_expand (GtkOrientation $orientation) {
    gtk_widget_compute_expand($!w, $orientation);
  }

  method override_font (PangoFontDescription $font_desc) {
    gtk_widget_override_font($!w, $font_desc);
  }

  method set_redraw_on_allocate (gboolean $redraw_on_allocate) {
    gtk_widget_set_redraw_on_allocate($!w, $redraw_on_allocate);
  }

  method get_preferred_height (gint $minimum_height, gint $natural_height) {
    gtk_widget_get_preferred_height($!w, $minimum_height, $natural_height);
  }

  method unmap (GtkWidget() $!w) {
    gtk_widget_unmap($!w);
  }

  method error_bell (GtkWidget() $!w) {
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
  ) {
    gtk_widget_translate_coordinates(
      $src_widget,
      $dest_widget,
      $src_x,
      $src_y,
      $dest_x,
      $dest_y
    );
  }

  method style_get_property (gchar $property_name, GValue $value) {
    gtk_widget_style_get_property($!w, $property_name, $value);
  }

  method get_scale_factor {
    gtk_widget_get_scale_factor($!w);
  }

  method is_composited {
    gtk_widget_is_composited($!w);
  }

  method get_pango_context {
    gtk_widget_get_pango_context($!w);
  }

  #method class_set_template (GtkWidgetClass $widget_class, GBytes $template_bytes) {
  #  gtk_widget_class_set_template($widget_class, $template_bytes);
  #}

  #method class_set_accessible_type (GtkWidgetClass $widget_class, GType $type) {
  #  gtk_widget_class_set_accessible_type($widget_class, $type);
  #}

  method is_sensitive {
    gtk_widget_is_sensitive($!w);
  }

  # Made multi to avoid conflict with the signal "event" handler.
  multi method event (GdkEvent $event) {
    gtk_widget_event($!w, $event);
  }

  method queue_resize_no_redraw {
    gtk_widget_queue_resize_no_redraw($!w);
  }

  method destroyed (GtkWidget() $widget_pointer) {
    gtk_widget_destroyed($!w, $widget_pointer);
  }

  method get_action_group (gchar $prefix) {
    gtk_widget_get_action_group($!w, $prefix);
  }

  method init_template {
    gtk_widget_init_template($!w);
  }

  method get_preferred_width_for_height (
    gint $height,
    gint $minimum_width,
    gint $natural_width
  ) {
    gtk_widget_get_preferred_width_for_height(
      $!w,
      $height,
      $minimum_width,
      $natural_width
    );
  }

  method get_template_child (GType $widget_type, gchar $name) {
    gtk_widget_get_template_child($!w, $widget_type, $name);
  }

  method reset_style {
    gtk_widget_reset_style($!w);
  }

  method realize {
    gtk_widget_realize($!w);
  }

  method get_allocated_baseline {
    gtk_widget_get_allocated_baseline($!w);
  }

  method get_display {
    gtk_widget_get_display($!w);
  }

  method list_accel_closures {
    gtk_widget_list_accel_closures($!w);
  }

  method size_allocate_with_baseline (
    GtkAllocation $allocation,
    gint $baseline
  ) {
    gtk_widget_size_allocate_with_baseline($!w, $allocation, $baseline);
  }

  #method class_install_style_property_parser (GtkWidgetClass $klass, GParamSpec $pspec, GtkRcPropertyParser $parser) {
  #  gtk_widget_class_install_style_property_parser($klass, $pspec, $parser);
  #}

  method insert_action_group (gchar $name, GActionGroup $group) {
    gtk_widget_insert_action_group($!w, $name, $group);
  }

  method get_toplevel {
    gtk_widget_get_toplevel($!w);
  }

  method set_device_events (GdkDevice $device, GdkEventMask $events) {
    gtk_widget_set_device_events($!w, $device, $events);
  }

  method get_clipboard (GdkAtom $selection) {
    gtk_widget_get_clipboard($!w, $selection);
  }

  method queue_draw {
    gtk_widget_queue_draw($!w);
  }

  method map {
    gtk_widget_map($!w);
  }

  method render_icon_pixbuf (gchar $stock_id, GtkIconSize $size) {
    gtk_widget_render_icon_pixbuf($!w, $stock_id, $size);
  }

  method register_window (GdkWindow $window) {
    gtk_widget_register_window($!w, $window);
  }

  #method class_bind_template_child_full (GtkWidgetClass $widget_class, gchar $name, gboolean $internal_child, gssize $struct_offset) {
  #  gtk_widget_class_bind_template_child_full($widget_class, $name, $internal_child, $struct_offset);
  #}

  method set_allocation (GtkAllocation $allocation) {
    gtk_widget_set_allocation($!w, $allocation);
  }

  method child_focus (GtkDirectionType $direction) {
    gtk_widget_child_focus($!w, $direction);
  }

  method reparent (GtkWidget() $new_parent) {
    gtk_widget_reparent($!w, $new_parent);
  }

  method queue_allocate {
    gtk_widget_queue_allocate($!w);
  }

  method show_now {
    gtk_widget_show_now($!w);
  }

  method destroy {
    gtk_widget_destroy($!w);
  }

  method requisition_free (GtkRequisition $requisition) {
    gtk_requisition_free($requisition);
  }

  method get_child_requisition (GtkRequisition $requisition) {
    gtk_widget_get_child_requisition($!w, $requisition);
  }

  method get_allocated_size (GtkAllocation $allocation, int $baseline) {
    gtk_widget_get_allocated_size($!w, $allocation, $baseline);
  }

  #method class_set_template_from_resource (GtkWidgetClass $widget_class, gchar $resource_name) {
  #  gtk_widget_class_set_template_from_resource($widget_class, $resource_name);
  #}

  method get_path {
    gtk_widget_get_path($!w);
  }

  method is_toplevel {
    gtk_widget_is_toplevel($!w);
  }

  method child_notify (gchar $child_property) {
    gtk_widget_child_notify($!w, $child_property);
  }

  #method class_install_style_property (GtkWidgetClass $klass, GParamSpec $pspec) {
  #  gtk_widget_class_install_style_property($klass, $pspec);
  #}

  method set_size_request (gint $width, gint $height) {
    gtk_widget_set_size_request($!w, $width, $height);
  }

  method thaw_child_notify {
    gtk_widget_thaw_child_notify($!w);
  }

  method add_accelerator (
    gchar $accel_signal,
    GtkAccelGroup $accel_group,
    guint $accel_key,
    GdkModifierType $accel_mods,
    GtkAccelFlags $accel_flags
  ) {
    gtk_widget_add_accelerator(
      $!w,
      $accel_signal,
      $accel_group,
      $accel_key,
      $accel_mods,
      $accel_flags
    );
  }

  method size_allocate (GtkAllocation $allocation) {
    gtk_widget_size_allocate($!w, $allocation);
  }

  method keynav_failed (GtkDirectionType $direction) {
    gtk_widget_keynav_failed($!w, $direction);
  }

  method hide_on_delete {
    gtk_widget_hide_on_delete($!w);
  }

  method requisition_copy (GtkRequisition $requisition) {
    gtk_requisition_copy($requisition);
  }

  method get_preferred_width (gint $minimum_width, gint $natural_width) {
    gtk_widget_get_preferred_width($!w, $minimum_width, $natural_width);
  }

  method get_screen {
    gtk_widget_get_screen($!w);
  }

  method queue_resize {
    gtk_widget_queue_resize($!w);
  }

  method get_accessible {
    gtk_widget_get_accessible($!w);
  }

  method get_preferred_height_for_width (
    gint $width,
    gint $minimum_height,
    gint $natural_height
  ) {
    gtk_widget_get_preferred_height_for_width(
      $!w,
      $width,
      $minimum_height,
      $natural_height
    );
  }

  method list_mnemonic_labels {
    gtk_widget_list_mnemonic_labels($!w);
  }

  method add_mnemonic_label (GtkWidget $label) {
    gtk_widget_add_mnemonic_label($!w, $label);
  }

  #method class_set_connect_func (GtkWidgetClass $widget_class, GtkBuilderself.connectFunc $self.connect_func, gpointer $self.connect_data, GDestroyNotify $self.connect_data_destroy) {
  #  gtk_widget_class_set_connect_func($widget_class, $self.connect_func, $self.connect_data, $self.connect_data_destroy);
  #}

  method set_accel_path (gchar $accel_path, GtkAccelGroup $accel_group) {
    gtk_widget_set_accel_path($!w, $accel_path, $accel_group);
  }

  method get_settings {
    gtk_widget_get_settings($!w);
  }

  method get_modifier_mask (GdkModifierIntent $intent) {
    gtk_widget_get_modifier_mask($!w, $intent);
  }

  method has_grab {
    gtk_widget_has_grab($!w);
  }

  #method class_list_style_properties (GtkWidgetClass $klass, guint $n_properties) {
  #  gtk_widget_class_list_style_properties($klass, $n_properties);
  #}

  method get_allocated_width {
    gtk_widget_get_allocated_width($!w);
  }

  method is_drawable {
    gtk_widget_is_drawable($!w);
  }

  method has_focus {
    gtk_widget_has_focus($!w);
  }

  method unrealize {
    gtk_widget_unrealize($!w);
  }

  method add_tick_callback (
    GtkTickCallback $callback,
    gpointer $user_data,
    GDestroyNotify $notify
  ) {
    gtk_widget_add_tick_callback($!w, $callback, $user_data, $notify);
  }

}
