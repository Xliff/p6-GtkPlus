use v6.c;

use NativeCall;

use GTK::Raw::Pointers;
use GTK::Raw::Widget;

class GTK::Widget {
  also does GTK::Roles::Signal;

  has GtkWidget $!w;

  submethod BUILD (GtkWidget :$widget) {
    $!w = $widget;
  }

  #submethod DESTROY {
  #  self.disself.connect_all;
  #  g_object_unref($!w);
  #}

  #method setWidget($widget) {
  #  $!w = $widget;
  #}

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
  method destroy {
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
  method draw {
    self.connect($!w, 'draw');
  }

  # Signal gboolean Run Last
  method enter-notify-event {
    self.connect($!w, 'enter-notify-event');
  }

  # Signal gboolean Run Last
  method event {
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
  method hide {
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
  method map {
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
  method realize {
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
  method show {
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
  method unmap {
    self.connect($!w, 'unmap');
  }

  # Signal gboolean Run Last
  method unmap-event {
    self.connect($!w, 'unmap-event');
  }

  # Signal void Run Last
  method unrealize {
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
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_receives_default($!w);
      },
      STORE => -> sub ($, $receives_default is copy) {
        gtk_widget_set_receives_default($!w, $receives_default);
      }
    );
  }

  method name is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_name($!w);
      },
      STORE => -> sub ($, $name is copy) {
        gtk_widget_set_name($!w, $name);
      }
    );
  }

  method app_paintable is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_app_paintable($!w);
      },
      STORE => -> sub ($, $app_paintable is copy) {
        gtk_widget_set_app_paintable($!w, $app_paintable);
      }
    );
  }

  method font_map is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_font_map($!w);
      },
      STORE => -> sub ($, $font_map is copy) {
        gtk_widget_set_font_map($!w, $font_map);
      }
    );
  }

  method tooltip_markup is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_markup($!w);
      },
      STORE => -> sub ($, $markup is copy) {
        gtk_widget_set_tooltip_markup($!w, $markup);
      }
    );
  }

  method tooltip_text is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_text($!w);
      },
      STORE => -> sub ($, $text is copy) {
        gtk_widget_set_tooltip_text($!w, $text);
      }
    );
  }

  method direction is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_direction($!w);
      },
      STORE => -> sub ($, $dir is copy) {
        gtk_widget_set_direction($!w, $dir);
      }
    );
  }

  method margin_top is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_margin_top($!w);
      },
      STORE => -> sub ($, $margin is copy) {
        gtk_widget_set_margin_top($!w, $margin);
      }
    );
  }

  method focus_on_click is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_focus_on_click($!w);
      },
      STORE => -> sub ($, $focus_on_click is copy) {
        gtk_widget_set_focus_on_click($!w, $focus_on_click);
      }
    );
  }

  method child_visible is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_child_visible($!w);
      },
      STORE => -> sub ($, $is_visible is copy) {
        gtk_widget_set_child_visible($!w, $is_visible);
      }
    );
  }

  method hexpand is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_hexpand($!w);
      },
      STORE => -> sub ($, $expand is copy) {
        gtk_widget_set_hexpand($!w, $expand);
      }
    );
  }

  method margin_right is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_margin_right($!w);
      },
      STORE => -> sub ($, $margin is copy) {
        gtk_widget_set_margin_right($!w, $margin);
      }
    );
  }

  method margin_left is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_margin_left($!w);
      },
      STORE => -> sub ($, $margin is copy) {
        gtk_widget_set_margin_left($!w, $margin);
      }
    );
  }

  method parent_window is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_parent_window($!w);
      },
      STORE => -> sub ($, $parent_window is copy) {
        gtk_widget_set_parent_window($!w, $parent_window);
      }
    );
  }

  method state_flags is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_state_flags($!w);
      },
      STORE => -> sub ($, $flags is copy) {
        gtk_widget_unset_state_flags($!w, $flags);
      }
    );
  }

  method sensitive is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_sensitive($!w);
      },
      STORE => -> sub ($, $sensitive is copy) {
        gtk_widget_set_sensitive($!w, $sensitive);
      }
    );
  }

  method visible is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_visible($!w);
      },
      STORE => -> sub ($, $visible is copy) {
        gtk_widget_set_visible($!w, $visible);
      }
    );
  }

  method window is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_window($!w);
      },
      STORE => -> sub ($, $window is copy) {
        gtk_widget_set_window($!w, $window);
      }
    );
  }

  method events is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_events($!w);
      },
      STORE => -> sub ($, $events is copy) {
        gtk_widget_set_events($!w, $events);
      }
    );
  }

  method opacity is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_opacity($!w);
      },
      STORE => -> sub ($, $opacity is copy) {
        gtk_widget_set_opacity($!w, $opacity);
      }
    );
  }

  method tooltip_window is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_tooltip_window($!w);
      },
      STORE => -> sub ($, $custom_window is copy) {
        gtk_widget_set_tooltip_window($!w, $custom_window);
      }
    );
  }

  method font_options is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_font_options($!w);
      },
      STORE => -> sub ($, $options is copy) {
        gtk_widget_set_font_options($!w, $options);
      }
    );
  }

  method class_css_name is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_class_get_css_name($widget_class);
      },
      STORE => -> sub ($, $name is copy) {
        gtk_widget_class_set_css_name($widget_class, $name);
      }
    );
  }

  method margin_start is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_margin_start($!w);
      },
      STORE => -> sub ($, $margin is copy) {
        gtk_widget_set_margin_start($!w, $margin);
      }
    );
  }

  method realized is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_realized($!w);
      },
      STORE => -> sub ($, $realized is copy) {
        gtk_widget_set_realized($!w, $realized);
      }
    );
  }

  method visual is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_visual($!w);
      },
      STORE => -> sub ($, $visual is copy) {
        gtk_widget_set_visual($!w, $visual);
      }
    );
  }

  method vexpand is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_vexpand($!w);
      },
      STORE => -> sub ($, $expand is copy) {
        gtk_widget_set_vexpand($!w, $expand);
      }
    );
  }

  method margin_bottom is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_margin_bottom($!w);
      },
      STORE => -> sub ($, $margin is copy) {
        gtk_widget_set_margin_bottom($!w, $margin);
      }
    );
  }

  method margin_end is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_margin_end($!w);
      },
      STORE => -> sub ($, $margin is copy) {
        gtk_widget_set_margin_end($!w, $margin);
      }
    );
  }

  method valign is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_valign($!w);
      },
      STORE => -> sub ($, $align is copy) {
        gtk_widget_set_valign($!w, $align);
      }
    );
  }

  method has_window is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_has_window($!w);
      },
      STORE => -> sub ($, $has_window is copy) {
        gtk_widget_set_has_window($!w, $has_window);
      }
    );
  }

  method double_buffered is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_double_buffered($!w);
      },
      STORE => -> sub ($, $double_buffered is copy) {
        gtk_widget_set_double_buffered($!w, $double_buffered);
      }
    );
  }

  method parent is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_parent($!w);
      },
      STORE => -> sub ($, $parent is copy) {
        gtk_widget_set_parent($!w, $parent);
      }
    );
  }

  method has_tooltip is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_has_tooltip($!w);
      },
      STORE => -> sub ($, $has_tooltip is copy) {
        gtk_widget_set_has_tooltip($!w, $has_tooltip);
      }
    );
  }

  method halign is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_halign($!w);
      },
      STORE => -> sub ($, $align is copy) {
        gtk_widget_set_halign($!w, $align);
      }
    );
  }

  method no_show_all is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_no_show_all($!w);
      },
      STORE => -> sub ($, $no_show_all is copy) {
        gtk_widget_set_no_show_all($!w, $no_show_all);
      }
    );
  }

  method state is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_state($!w);
      },
      STORE => -> sub ($, $state is copy) {
        gtk_widget_set_state($!w, $state);
      }
    );
  }

  method can_default is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_can_default($!w);
      },
      STORE => -> sub ($, $can_default is copy) {
        gtk_widget_set_can_default($!w, $can_default);
      }
    );
  }

  method vexpand_set is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_vexpand_set($!w);
      },
      STORE => -> sub ($, $set is copy) {
        gtk_widget_set_vexpand_set($!w, $set);
      }
    );
  }

  method hexpand_set is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_hexpand_set($!w);
      },
      STORE => -> sub ($, $set is copy) {
        gtk_widget_set_hexpand_set($!w, $set);
      }
    );
  }

  method mapped is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_mapped($!w);
      },
      STORE => -> sub ($, $mapped is copy) {
        gtk_widget_set_mapped($!w, $mapped);
      }
    );
  }

  method composite_name is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_composite_name($!w);
      },
      STORE => -> sub ($, $name is copy) {
        gtk_widget_set_composite_name($!w, $name);
      }
    );
  }

  method can_focus is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_can_focus($!w);
      },
      STORE => -> sub ($, $can_focus is copy) {
        gtk_widget_set_can_focus($!w, $can_focus);
      }
    );
  }

  method support_multidevice is rw {
    Proxy,new(
      FETCH => sub ($) {
        gtk_widget_get_support_multidevice($!w);
      },
      STORE => -> sub ($, $support_multidevice is copy) {
        gtk_widget_set_support_multidevice($!w, $support_multidevice);
      }
    );
  }

  method add_events (GtkWidget $!w, gint $events) {
    gtk_widget_add_events($!w, $events);
  }

  method class_set_accessible_role (GtkWidgetClass $widget_class, AtkRole $role) {
    gtk_widget_class_set_accessible_role($widget_class, $role);
  }

  method region_intersect (GtkWidget $!w, cairo_region_t $region) {
    gtk_widget_region_intersect($!w, $region);
  }

  method draw (GtkWidget $!w, cairo_t $cr) {
    gtk_widget_draw($!w, $cr);
  }

  method remove_mnemonic_label (GtkWidget $!w, GtkWidget $label) {
    gtk_widget_remove_mnemonic_label($!w, $label);
  }

  method input_shape_combine_region (GtkWidget $!w, cairo_region_t $region) {
    gtk_widget_input_shape_combine_region($!w, $region);
  }

  method in_destruction (GtkWidget $!w) {
    gtk_widget_in_destruction($!w);
  }

  method get_valign_with_baseline (GtkWidget $!w) {
    gtk_widget_get_valign_with_baseline($!w);
  }

  method has_visible_focus (GtkWidget $!w) {
    gtk_widget_has_visible_focus($!w);
  }

  method has_screen (GtkWidget $!w) {
    gtk_widget_has_screen($!w);
  }

  method override_background_color (GtkWidget $!w, GtkStateFlags $state, GdkRGBA $color) {
    gtk_widget_override_background_color($!w, $state, $color);
  }

  method trigger_tooltip_query (GtkWidget $!w) {
    gtk_widget_trigger_tooltip_query($!w);
  }

  method get_size_request (GtkWidget $!w, gint $width, gint $height) {
    gtk_widget_get_size_request($!w, $width, $height);
  }

  method has_default (GtkWidget $!w) {
    gtk_widget_has_default($!w);
  }

  method get_root_window (GtkWidget $!w) {
    gtk_widget_get_root_window($!w);
  }

  method get_frame_clock (GtkWidget $!w) {
    gtk_widget_get_frame_clock($!w);
  }

  method get_preferred_size (GtkWidget $!w, GtkRequisition $minimum_size, GtkRequisition $natural_size) {
    gtk_widget_get_preferred_size($!w, $minimum_size, $natural_size);
  }

  method device_is_shadowed (GtkWidget $!w, GdkDevice $device) {
    gtk_widget_device_is_shadowed($!w, $device);
  }

  method send_focus_change (GtkWidget $!w, GdkEvent $event) {
    gtk_widget_send_focus_change($!w, $event);
  }

  method size_request (GtkWidget $!w, GtkRequisition $requisition) {
    gtk_widget_size_request($!w, $requisition);
  }

  method override_cursor (GtkWidget $!w, GdkRGBA $cursor, GdkRGBA $secondary_cursor) {
    gtk_widget_override_cursor($!w, $cursor, $secondary_cursor);
  }

  method list_action_prefixes (GtkWidget $!w) {
    gtk_widget_list_action_prefixes($!w);
  }

  method set_device_enabled (GtkWidget $!w, GdkDevice $device, gboolean $enabled) {
    gtk_widget_set_device_enabled($!w, $device, $enabled);
  }

  method get_pointer (GtkWidget $!w, gint $x, gint $y) {
    gtk_widget_get_pointer($!w, $x, $y);
  }

  method grab_default (GtkWidget $!w) {
    gtk_widget_grab_default($!w);
  }

  method can_activate_accel (GtkWidget $!w, guint $signal_id) {
    gtk_widget_can_activate_accel($!w, $signal_id);
  }

  method hide (GtkWidget $!w) {
    gtk_widget_hide($!w);
  }

  method shape_combine_region (GtkWidget $!w, cairo_region_t $region) {
    gtk_widget_shape_combine_region($!w, $region);
  }

  method unregister_window (GtkWidget $!w, GdkWindow $window) {
    gtk_widget_unregister_window($!w, $window);
  }

  method send_expose (GtkWidget $!w, GdkEvent $event) {
    gtk_widget_send_expose($!w, $event);
  }

  method override_symbolic_color (GtkWidget $!w, gchar $name, GdkRGBA $color) {
    gtk_widget_override_symbolic_color($!w, $name, $color);
  }

  method create_pango_context (GtkWidget $!w) {
    gtk_widget_create_pango_context($!w);
  }

  method get_device_events (GtkWidget $!w, GdkDevice $device) {
    gtk_widget_get_device_events($!w, $device);
  }

  method style_get_valist (GtkWidget $!w, gchar $first_property_name, va_list $var_args) {
    gtk_widget_style_get_valist($!w, $first_property_name, $var_args);
  }

  method is_focus (GtkWidget $!w) {
    gtk_widget_is_focus($!w);
  }

  method freeze_child_notify (GtkWidget $!w) {
    gtk_widget_freeze_child_notify($!w);
  }

  method remove_accelerator (GtkWidget $!w, GtkAccelGroup $accel_group, guint $accel_key, GdkModifierType $accel_mods) {
    gtk_widget_remove_accelerator($!w, $accel_group, $accel_key, $accel_mods);
  }

  method queue_draw_region (GtkWidget $!w, cairo_region_t $region) {
    gtk_widget_queue_draw_region($!w, $region);
  }

  method gtk_requisition_get_type () {
    gtk_requisition_get_type();
  }

  method is_visible (GtkWidget $!w) {
    gtk_widget_is_visible($!w);
  }

  method mnemonic_activate (GtkWidget $!w, gboolean $group_cycling) {
    gtk_widget_mnemonic_activate($!w, $group_cycling);
  }

  method show_all (GtkWidget $!w) {
    gtk_widget_show_all($!w);
  }

  method show (GtkWidget $!w) {
    gtk_widget_show($!w);
  }

  method queue_compute_expand (GtkWidget $!w) {
    gtk_widget_queue_compute_expand($!w);
  }

  method is_ancestor (GtkWidget $!w, GtkWidget $ancestor) {
    gtk_widget_is_ancestor($!w, $ancestor);
  }

  method override_color (GtkWidget $!w, GtkStateFlags $state, GdkRGBA $color) {
    gtk_widget_override_color($!w, $state, $color);
  }

  method get_allocated_height (GtkWidget $!w) {
    gtk_widget_get_allocated_height($!w);
  }

  method get_allocation (GtkWidget $!w, GtkAllocation $allocation) {
    gtk_widget_get_allocation($!w, $allocation);
  }

  method get_style_context (GtkWidget $!w) {
    gtk_widget_get_style_context($!w);
  }

  method get_clip (GtkWidget $!w, GtkAllocation $clip) {
    gtk_widget_get_clip($!w, $clip);
  }

  method class_find_style_property (GtkWidgetClass $klass, gchar $property_name) {
    gtk_widget_class_find_style_property($klass, $property_name);
  }

  method get_device_enabled (GtkWidget $!w, GdkDevice $device) {
    gtk_widget_get_device_enabled($!w, $device);
  }

  method get_ancestor (GtkWidget $!w, GType $widget_type) {
    gtk_widget_get_ancestor($!w, $widget_type);
  }

  method get_request_mode (GtkWidget $!w) {
    gtk_widget_get_request_mode($!w);
  }

  method intersect (GtkWidget $!w, GdkRectangle $area, GdkRectangle $intersection) {
    gtk_widget_intersect($!w, $area, $intersection);
  }

  method unparent (GtkWidget $!w) {
    gtk_widget_unparent($!w);
  }

  method set_clip (GtkWidget $!w, GtkAllocation $clip) {
    gtk_widget_set_clip($!w, $clip);
  }

  method grab_focus (GtkWidget $!w) {
    gtk_widget_grab_focus($!w);
  }

  method get_preferred_height_and_baseline_for_width (GtkWidget $!w, gint $width, gint $minimum_height, gint $natural_height, gint $minimum_baseline, gint $natural_baseline) {
    gtk_widget_get_preferred_height_and_baseline_for_width($!w, $width, $minimum_height, $natural_height, $minimum_baseline, $natural_baseline);
  }

  method activate (GtkWidget $!w) {
    gtk_widget_activate($!w);
  }

  method add_device_events (GtkWidget $!w, GdkDevice $device, GdkEventMask $events) {
    gtk_widget_add_device_events($!w, $device, $events);
  }

  method create_pango_layout (GtkWidget $!w, gchar $text) {
    gtk_widget_create_pango_layout($!w, $text);
  }

  method gtk_cairo_should_draw_window (cairo_t $cr, GdkWindow $window) {
    gtk_cairo_should_draw_window($cr, $window);
  }

  method remove_tick_callback (GtkWidget $!w, guint $id) {
    gtk_widget_remove_tick_callback($!w, $id);
  }

  method class_bind_template_callback_full (GtkWidgetClass $widget_class, gchar $callback_name, GCallback $callback_symbol) {
    gtk_widget_class_bind_template_callback_full($widget_class, $callback_name, $callback_symbol);
  }

  method get_requisition (GtkWidget $!w, GtkRequisition $requisition) {
    gtk_widget_get_requisition($!w, $requisition);
  }

  method queue_draw_area (GtkWidget $!w, gint $x, gint $y, gint $width, gint $height) {
    gtk_widget_queue_draw_area($!w, $x, $y, $width, $height);
  }

  method compute_expand (GtkWidget $!w, GtkOrientation $orientation) {
    gtk_widget_compute_expand($!w, $orientation);
  }

  method override_font (GtkWidget $!w, PangoFontDescription $font_desc) {
    gtk_widget_override_font($!w, $font_desc);
  }

  method set_redraw_on_allocate (GtkWidget $!w, gboolean $redraw_on_allocate) {
    gtk_widget_set_redraw_on_allocate($!w, $redraw_on_allocate);
  }

  method get_preferred_height (GtkWidget $!w, gint $minimum_height, gint $natural_height) {
    gtk_widget_get_preferred_height($!w, $minimum_height, $natural_height);
  }

  method unmap (GtkWidget $!w) {
    gtk_widget_unmap($!w);
  }

  method error_bell (GtkWidget $!w) {
    gtk_widget_error_bell($!w);
  }

  method translate_coordinates (GtkWidget $src_widget, GtkWidget $dest_widget, gint $src_x, gint $src_y, gint $dest_x, gint $dest_y) {
    gtk_widget_translate_coordinates($src_widget, $dest_widget, $src_x, $src_y, $dest_x, $dest_y);
  }

  method style_get_property (GtkWidget $!w, gchar $property_name, GValue $value) {
    gtk_widget_style_get_property($!w, $property_name, $value);
  }

  method get_scale_factor (GtkWidget $!w) {
    gtk_widget_get_scale_factor($!w);
  }

  method is_composited (GtkWidget $!w) {
    gtk_widget_is_composited($!w);
  }

  method get_pango_context (GtkWidget $!w) {
    gtk_widget_get_pango_context($!w);
  }

  method class_set_template (GtkWidgetClass $widget_class, GBytes $template_bytes) {
    gtk_widget_class_set_template($widget_class, $template_bytes);
  }

  method class_set_accessible_type (GtkWidgetClass $widget_class, GType $type) {
    gtk_widget_class_set_accessible_type($widget_class, $type);
  }

  method is_sensitive (GtkWidget $!w) {
    gtk_widget_is_sensitive($!w);
  }

  method event (GtkWidget $!w, GdkEvent $event) {
    gtk_widget_event($!w, $event);
  }

  method queue_resize_no_redraw (GtkWidget $!w) {
    gtk_widget_queue_resize_no_redraw($!w);
  }

  method destroyed (GtkWidget $!w, GtkWidget $widget_pointer) {
    gtk_widget_destroyed($!w, $widget_pointer);
  }

  method get_action_group (GtkWidget $!w, gchar $prefix) {
    gtk_widget_get_action_group($!w, $prefix);
  }

  method init_template (GtkWidget $!w) {
    gtk_widget_init_template($!w);
  }

  method get_preferred_width_for_height (GtkWidget $!w, gint $height, gint $minimum_width, gint $natural_width) {
    gtk_widget_get_preferred_width_for_height($!w, $height, $minimum_width, $natural_width);
  }

  method get_template_child (GtkWidget $!w, GType $widget_type, gchar $name) {
    gtk_widget_get_template_child($!w, $widget_type, $name);
  }

  method reset_style (GtkWidget $!w) {
    gtk_widget_reset_style($!w);
  }

  method realize (GtkWidget $!w) {
    gtk_widget_realize($!w);
  }

  method get_allocated_baseline (GtkWidget $!w) {
    gtk_widget_get_allocated_baseline($!w);
  }

  method get_display (GtkWidget $!w) {
    gtk_widget_get_display($!w);
  }

  method list_accel_closures (GtkWidget $!w) {
    gtk_widget_list_accel_closures($!w);
  }

  method size_allocate_with_baseline (GtkWidget $!w, GtkAllocation $allocation, gint $baseline) {
    gtk_widget_size_allocate_with_baseline($!w, $allocation, $baseline);
  }

  method class_install_style_property_parser (GtkWidgetClass $klass, GParamSpec $pspec, GtkRcPropertyParser $parser) {
    gtk_widget_class_install_style_property_parser($klass, $pspec, $parser);
  }

  method insert_action_group (GtkWidget $!w, gchar $name, GActionGroup $group) {
    gtk_widget_insert_action_group($!w, $name, $group);
  }

  method get_toplevel (GtkWidget $!w) {
    gtk_widget_get_toplevel($!w);
  }

  method set_device_events (GtkWidget $!w, GdkDevice $device, GdkEventMask $events) {
    gtk_widget_set_device_events($!w, $device, $events);
  }

  method set_default_direction (GtkTextDirection $dir) {
    gtk_widget_set_default_direction($dir);
  }

  method get_default_direction () {
    gtk_widget_get_default_direction();
  }

  method get_clipboard (GtkWidget $!w, GdkAtom $selection) {
    gtk_widget_get_clipboard($!w, $selection);
  }

  method queue_draw (GtkWidget $!w) {
    gtk_widget_queue_draw($!w);
  }

  method map (GtkWidget $!w) {
    gtk_widget_map($!w);
  }

  method render_icon_pixbuf (GtkWidget $!w, gchar $stock_id, GtkIconSize $size) {
    gtk_widget_render_icon_pixbuf($!w, $stock_id, $size);
  }

  method register_window (GtkWidget $!w, GdkWindow $window) {
    gtk_widget_register_window($!w, $window);
  }

  method class_bind_template_child_full (GtkWidgetClass $widget_class, gchar $name, gboolean $internal_child, gssize $struct_offset) {
    gtk_widget_class_bind_template_child_full($widget_class, $name, $internal_child, $struct_offset);
  }

  method set_allocation (GtkWidget $!w, GtkAllocation $allocation) {
    gtk_widget_set_allocation($!w, $allocation);
  }

  method child_focus (GtkWidget $!w, GtkDirectionType $direction) {
    gtk_widget_child_focus($!w, $direction);
  }

  method reparent (GtkWidget $!w, GtkWidget $new_parent) {
    gtk_widget_reparent($!w, $new_parent);
  }

  method queue_allocate (GtkWidget $!w) {
    gtk_widget_queue_allocate($!w);
  }

  method show_now (GtkWidget $!w) {
    gtk_widget_show_now($!w);
  }

  method destroy (GtkWidget $!w) {
    gtk_widget_destroy($!w);
  }

  method pop_composite_child () {
    gtk_widget_pop_composite_child();
  }

  method gtk_requisition_free (GtkRequisition $requisition) {
    gtk_requisition_free($requisition);
  }

  method get_child_requisition (GtkWidget $!w, GtkRequisition $requisition) {
    gtk_widget_get_child_requisition($!w, $requisition);
  }

  method get_allocated_size (GtkWidget $!w, GtkAllocation $allocation, int $baseline) {
    gtk_widget_get_allocated_size($!w, $allocation, $baseline);
  }

  method class_set_template_from_resource (GtkWidgetClass $widget_class, gchar $resource_name) {
    gtk_widget_class_set_template_from_resource($widget_class, $resource_name);
  }

  method get_path (GtkWidget $!w) {
    gtk_widget_get_path($!w);
  }

  method is_toplevel (GtkWidget $!w) {
    gtk_widget_is_toplevel($!w);
  }

  method child_notify (GtkWidget $!w, gchar $child_property) {
    gtk_widget_child_notify($!w, $child_property);
  }

  method class_install_style_property (GtkWidgetClass $klass, GParamSpec $pspec) {
    gtk_widget_class_install_style_property($klass, $pspec);
  }

  method gtk_requisition_new () {
    gtk_requisition_new();
  }

  method set_size_request (GtkWidget $!w, gint $width, gint $height) {
    gtk_widget_set_size_request($!w, $width, $height);
  }

  method thaw_child_notify (GtkWidget $!w) {
    gtk_widget_thaw_child_notify($!w);
  }

  method add_accelerator (GtkWidget $!w, gchar $accel_signal, GtkAccelGroup $accel_group, guint $accel_key, GdkModifierType $accel_mods, GtkAccelFlags $accel_flags) {
    gtk_widget_add_accelerator($!w, $accel_signal, $accel_group, $accel_key, $accel_mods, $accel_flags);
  }

  method size_allocate (GtkWidget $!w, GtkAllocation $allocation) {
    gtk_widget_size_allocate($!w, $allocation);
  }

  method keynav_failed (GtkWidget $!w, GtkDirectionType $direction) {
    gtk_widget_keynav_failed($!w, $direction);
  }

  method hide_on_delete (GtkWidget $!w) {
    gtk_widget_hide_on_delete($!w);
  }

  method gtk_requisition_copy (GtkRequisition $requisition) {
    gtk_requisition_copy($requisition);
  }

  method get_preferred_width (GtkWidget $!w, gint $minimum_width, gint $natural_width) {
    gtk_widget_get_preferred_width($!w, $minimum_width, $natural_width);
  }

  method get_screen (GtkWidget $!w) {
    gtk_widget_get_screen($!w);
  }

  method queue_resize (GtkWidget $!w) {
    gtk_widget_queue_resize($!w);
  }

  method gtk_cairo_transform_to_window (cairo_t $cr, GtkWidget $!w, GdkWindow $window) {
    gtk_cairo_transform_to_window($cr, $!w, $window);
  }

  method get_accessible (GtkWidget $!w) {
    gtk_widget_get_accessible($!w);
  }

  method get_preferred_height_for_width (GtkWidget $!w, gint $width, gint $minimum_height, gint $natural_height) {
    gtk_widget_get_preferred_height_for_width($!w, $width, $minimum_height, $natural_height);
  }

  method push_composite_child () {
    gtk_widget_push_composite_child();
  }

  method list_mnemonic_labels (GtkWidget $!w) {
    gtk_widget_list_mnemonic_labels($!w);
  }

  method add_mnemonic_label (GtkWidget $!w, GtkWidget $label) {
    gtk_widget_add_mnemonic_label($!w, $label);
  }

  method class_set_self.connect_func (GtkWidgetClass $widget_class, GtkBuilderself.connectFunc $self.connect_func, gpointer $self.connect_data, GDestroyNotify $self.connect_data_destroy) {
    gtk_widget_class_set_self.connect_func($widget_class, $self.connect_func, $self.connect_data, $self.connect_data_destroy);
  }

  method set_accel_path (GtkWidget $!w, gchar $accel_path, GtkAccelGroup $accel_group) {
    gtk_widget_set_accel_path($!w, $accel_path, $accel_group);
  }

  method get_settings (GtkWidget $!w) {
    gtk_widget_get_settings($!w);
  }

  method get_modifier_mask (GtkWidget $!w, GdkModifierIntent $intent) {
    gtk_widget_get_modifier_mask($!w, $intent);
  }

  method has_grab (GtkWidget $!w) {
    gtk_widget_has_grab($!w);
  }

  method class_list_style_properties (GtkWidgetClass $klass, guint $n_properties) {
    gtk_widget_class_list_style_properties($klass, $n_properties);
  }

  method get_allocated_width (GtkWidget $!w) {
    gtk_widget_get_allocated_width($!w);
  }

  method is_drawable (GtkWidget $!w) {
    gtk_widget_is_drawable($!w);
  }

  method has_focus (GtkWidget $!w) {
    gtk_widget_has_focus($!w);
  }

  method unrealize (GtkWidget $!w) {
    gtk_widget_unrealize($!w);
  }

  method add_tick_callback (GtkWidget $!w, GtkTickCallback $callback, gpointer $user_data, GDestroyNotify $notify) {
    gtk_widget_add_tick_callback($!w, $callback, $user_data, $notify);
  }

}
