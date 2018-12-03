use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Device;

use GTK::;

class GTK::Compat::Device {
  has GdkDevice $!d;

  submethod BUILD(:$device) {
    $!d = $device;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkDevice, gpointer --> void
  method changed {
    self.connect($!w, 'changed');
  }

  # Is originally:
  # GdkDevice, GdkDeviceTool, gpointer --> void
  method tool-changed is also<tool_changed> {
    self.connect($!w, 'tool-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_device_get_mode($!d);
      },
      STORE => sub ($, $mode is copy) {
        gdk_device_set_mode($!d, $mode);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GdkDevice
  method associated-device is rw is also<associated_device> {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('associated-device', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        warn "associated-device does not allow writing"
      }
    );
  }

  # Type: GdkAxisFlags
  method axes is rw {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('axes', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        warn "axes does not allow writing"
      }
    );
  }

  # Type: GdkDeviceManager
  method device-manager is rw is also<device_manager> {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('device-manager', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('device-manager', $gv);
      }
    );
  }

  # Type: GdkDisplay
  method display is rw {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('display', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: gboolean
  method has-cursor is rw is also<has_cursor> {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('has-cursor', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-cursor', $gv);
      }
    );
  }

  # Type: GdkInputMode
  method input-mode is rw is also<input_mode> {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('input-mode', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('input-mode', $gv);
      }
    );
  }

  # Type: GdkInputSource
  method input-source is rw is also<input_source> {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('input-source', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('input-source', $gv);
      }
    );
  }

  # Type: guint
  method n-axes is rw is also<n_axes> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('n-axes', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        warn "n-axes does not allow writing"
      }
    );
  }

  # Type: gchar
  method name is rw {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: guint
  method num-touches is rw is also<num_touches> {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('num-touches', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        $gv.uint = $val;
        self.prop_set('num-touches', $gv);
      }
    );
  }

  # Type: gchar
  method product-id is rw is also<product_id> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('product-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set('product-id', $gv);
      }
    );
  }

  # Type: GdkSeat
  method seat is rw {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('seat', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('seat', $gv);
      }
    );
  }

  # Type: GdkDeviceTool
  method tool is rw {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('tool', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        warn "tool does not allow writing"
      }
    );
  }

  # Type: GdkDeviceType
  method type is rw {
    my GTK::Compat::Value $gv .= new( -type- );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('type', $gv)
        );
        #$gv.TYPE
      },
      STORE => -> $, $val is copy {
        #$gv.TYPE = $val;
        self.prop_set('type', $gv);
      }
    );
  }

  # Type: gchar
  method vendor-id is rw is also<vendor_id> {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('vendor-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, $val is copy {
        $gv.string = $val;
        self.prop_set('vendor-id', $gv);
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method free_history (gint $n_events) is also<free-history> {
    gdk_device_free_history($!d, $n_events);
  }

  method get_associated_device is also<get-associated-device> {
    gdk_device_get_associated_device($!d);
  }

  method get_axes is also<get-axes> {
    gdk_device_get_axes($!d);
  }

  method get_axis (gdouble $axes, GdkAxisUse $use, gdouble $value)
    is also<get-axis>
  {
    gdk_device_get_axis($!d, $axes, $use, $value);
  }

  method get_axis_use (guint $index_) is also<get-axis-use> {
    gdk_device_get_axis_use($!d, $index_);
  }

  method get_axis_value (
    gdouble $axes,
    GdkAtom $axis_label,
    gdouble $value
  )
    is also<get-axis-value>
  {
    gdk_device_get_axis_value($!d, $axes, $axis_label, $value);
  }

  method get_device_type is also<get-device-type> {
    gdk_device_get_device_type($!d);
  }

  method get_display is also<get-display> {
    gdk_device_get_display($!d);
  }

  method get_has_cursor is also<get-has-cursor> {
    gdk_device_get_has_cursor($!d);
  }

  method get_history (
    GdkWindow $window,
    guint32 $start,
    guint32 $stop,
    GdkTimeCoord $events,
    gint $n_events
  )
    is also<get-history>
  {
    gdk_device_get_history($!d, $window, $start, $stop, $events, $n_events);
  }

  method get_key (
    guint $index_,
    guint $keyval,
    GdkModifierType $modifiers
  )
    is also<get-key>
  {
    gdk_device_get_key($!d, $index_, $keyval, $modifiers);
  }

  method get_last_event_window is also<get-last-event-window> {
    gdk_device_get_last_event_window($!d);
  }

  method get_n_axes is also<get-n-axes> {
    gdk_device_get_n_axes($!d);
  }

  method get_n_keys is also<get-n-keys> {
    gdk_device_get_n_keys($!d);
  }

  method get_name is also<get-name> {
    gdk_device_get_name($!d);
  }

  method get_position (GdkScreen $screen, gint $x, gint $y)
    is also<get-position>
  {
    gdk_device_get_position($!d, $screen, $x, $y);
  }

  method get_position_double (GdkScreen $screen, gdouble $x, gdouble $y)
    is also<get-position-double>
  {
    gdk_device_get_position_double($!d, $screen, $x, $y);
  }

  method get_product_id is also<get-product-id> {
    gdk_device_get_product_id($!d);
  }

  method get_seat is also<get-seat> {
    gdk_device_get_seat($!d);
  }

  method get_source is also<get-source> {
    gdk_device_get_source($!d);
  }

  method get_state (
    GdkWindow $window,
    gdouble $axes,
    GdkModifierType $mask
  )
    is also<get-state>
  {
    gdk_device_get_state($!d, $window, $axes, $mask);
  }

  method get_type is also<get-type> {
    gdk_device_get_type();
  }

  method get_vendor_id is also<get-vendor-id> {
    gdk_device_get_vendor_id($!d);
  }

  method get_window_at_position (gint $win_x, gint $win_y)
    is also<get-window-at-position>
  {
    gdk_device_get_window_at_position($!d, $win_x, $win_y);
  }

  method get_window_at_position_double (gdouble $win_x, gdouble $win_y)
    is also<get-window-at-position-double>
  {
    gdk_device_get_window_at_position_double($!d, $win_x, $win_y);
  }

  method grab (
    GdkWindow $window,
    GdkGrabOwnership $grab_ownership,
    gboolean $owner_events,
    GdkEventMask $event_mask,
    GdkCursor $cursor,
    guint32 $time
  ) {
    gdk_device_grab(
      $!d,
      $window,
      $grab_ownership,
      $owner_events,
      $event_mask,
      $cursor,
      $time
    );
  }

  method grab_info_libgtk_only (
    GdkDevice $device,
    GdkWindow $grab_window,
    gboolean $owner_events
  )
    is also<grab-info-libgtk-only>
  {
    gdk_device_grab_info_libgtk_only(
      $!d, $device, $grab_window, $owner_events
    );
  }

  method list_axes is also<list-axes> {
    gdk_device_list_axes($!d);
  }

  method list_slave_devices is also<list-slave-devices> {
    gdk_device_list_slave_devices($!d);
  }

  method set_axis_use (guint $index, GdkAxisUse $use)
    is also<set-axis-use>
  {
    gdk_device_set_axis_use($!d, $index, $use);
  }

  method set_key (
    guint $index,
    guint $keyval,
    GdkModifierType $modifiers
  )
    is also<set-key>
  {
    gdk_device_set_key($!d, $index, $keyval, $modifiers);
  }

  method ungrab (guint32 $time) {
    gdk_device_ungrab($!d, $time_);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
