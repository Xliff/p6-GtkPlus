use v6.c;

use NativeCall;

use GTK::Compat::Raw::Event;

use GTK::Compat::Device;
use GTK::Compat::Screen;
use GTK::Compat::Types;

use GTK::Roles::Types;

class GTK::Compat::Event  {
  also does GTK::Roles::Types;

  has GdkEvents $!e handles<type window send_event>;

  submethod BUILD(:$event) {
    $!e = $event;
  }

  method GTK::Compat::Types::GtkEvents {
    $!e;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # Static/Class method
  method show_events is rw {
    Proxy.new(
      FETCH => -> $ {
        gdk_get_show_events()
      },
      STORE => -> $, Int() $val {
        my gboolean $v = self.RESOLVE-BOOL($val);
        gdk_set_show_events($v);
      }
    );
  }

  method device is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Device.new( gdk_event_get_device($!e) );
      },
      STORE => sub ($, GdkDevice() $device is copy) {
        gdk_event_set_device($!e, $device);
      }
    );
  }

  # GdkDeviceTool
  method device_tool is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_event_get_device_tool($!e);
      },
      STORE => sub ($, $tool is copy) {
        gdk_event_set_device_tool($!e, $tool);
      }
    );
  }

  method screen is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Screen.new( gdk_event_get_screen($!e) );
      },
      STORE => sub ($, GdkScreen() $screen is copy) {
        gdk_event_set_screen($!e, $screen);
      }
    );
  }

  method source_device is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Device.new( gdk_event_get_source_device($!e) );
      },
      STORE => sub ($, GdkDevice() $device is copy) {
        gdk_event_set_source_device($!e, $device);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # Class method.
  method setting_get (Str() $name, GValue() $value) {
    gdk_setting_get($name, $value);
  }

  # ↓↓↓↓ METHODS ↓↓↓↓
  method copy {
    gdk_event_copy($!e);
  }

  method free {
    gdk_event_free($!e);
  }

  method get_angle (GdkEvent() $event2, Num() $angle is rw) {
    my gdouble $a = $angle;
    gdk_events_get_angle($!e, $event2, $a);
  }

  method get_center (GdkEvent() $event2, Num() $x is rw, Num() $y is rw) {
    my gdouble ($xx, $yy) = ($x, $y);
    gdk_events_get_center($!e, $event2, $xx, $yy);
  }

  method get_distance (GdkEvent() $event2, Num() $distance is rw) {
    my gdouble $d = $distance;
    gdk_events_get_distance($!e, $event2, $d);
  }

  method pending {
    gdk_events_pending($!e);
  }

  method get {
    gdk_event_get($!e);
  }

  method get_axis (
    Int() $axis_use,              # GdkAxisUse $axis_use,
    Num() $value
  ) {
    my guint $au = self.RESOLVE-UINT($axis_use);
    my gdouble $v = $value;
    gdk_event_get_axis($!e, $au, $v);
  }

  method get_button (Int() $button) {
    my guint $b = self.RESOLVE-UINT($button);
    gdk_event_get_button($!e, $b);
  }

  method get_click_count (Int() $click_count) {
    my guint $cc = self.RESOLVE-UINT($click_count);
    gdk_event_get_click_count($!e, $cc);
  }

  method get_coords (Num() $x_win, Num() $y_win) {
    my gdouble ($xw, $yw) = ($x_win, $y_win);
    gdk_event_get_coords($!e, $xw, $yw);
  }

  method get_event_sequence {
    gdk_event_get_event_sequence($!e);
  }

  method get_event_type {
    gdk_event_get_event_type($!e);
  }

  method get_keycode (Int() $keycode) {
    my guint16 $kc = self.RESOLVE-UINT16($keycode);
    gdk_event_get_keycode($!e, $kc);
  }

  method get_keyval (guint $keyval) {
    my guint $kv = self.RESOLVE-UINT($keyval);
    gdk_event_get_keyval($!e, $kv);
  }

  method get_pointer_emulated {
    gdk_event_get_pointer_emulated($!e);
  }

  method get_root_coords (Num() $x_root, Num() $y_root) {
    my gdouble ($xr, $yr) = ($x_root, $y_root);
    gdk_event_get_root_coords($!e, $x_root, $y_root);
  }

  method get_scancode {
    gdk_event_get_scancode($!e);
  }

  method get_scroll_deltas (Num() $delta_x, Num() $delta_y) {
    my gdouble ($dx, $dy) = ($delta_x, $delta_y);
    gdk_event_get_scroll_deltas($!e, $dx, $dy);
  }

  method get_scroll_direction (
    Int() $direction              # GdkScrollDirection $direction
  ) {
    my guint $d = self.RESOLVE-UINT($direction);
    gdk_event_get_scroll_direction($!e, $d);
  }

  method get_seat {
    gdk_event_get_seat($!e);
  }

  method get_state (
    Int() $state                  # GdkModifierType $state
  ) {
    my guint $s = self.RESOLVE-UINT($state);
    gdk_event_get_state($!e, $s);
  }

  method get_time {
    gdk_event_get_time($!e);
  }

  method get_window {
    gdk_event_get_window($!e);
  }

  method handler_set (
    &handler,
    gpointer $data = Pointer,
    GDestroyNotify $notify = Pointer
  ) {
    gdk_event_handler_set(&handler, $data, $notify);
  }

  method is_scroll_stop_event {
    gdk_event_is_scroll_stop_event($!e);
  }

  method new (Int() $type) {
    my uint32 $t = self.RESOLVE-UINT($type);
    gdk_event_new($t);
  }

  method peek {
    gdk_event_peek($!e);
  }

  method put {
    gdk_event_put($!e);
  }

  method request_motions {
    gdk_event_request_motions($!e);
  }

  method sequence_get_type {
    gdk_event_sequence_get_type();
  }

  method triggers_context_menu {
    gdk_event_triggers_context_menu($!e);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
