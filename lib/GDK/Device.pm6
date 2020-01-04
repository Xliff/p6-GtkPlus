use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Device;

use GLib::Value;

use GTK::Roles::Properties;
use GTK::Roles::Types;

use GDK::Roles::Signals::Device;

my subset Ancestry where GdkDevice | GObject;

class GDK::Device {
  also does GDK::Roles::Signals::Device;
  also does GTK::Roles::Properties;
  also does GTK::Roles::Types;

  has GdkDevice $!d is implementor;

  submethod BUILD(:$device) {
    $!prop = nativecast(GObject, $!d = $device);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals, %!signals-device;
  }

  method new(Ancestry $device) {
    my $o = self.bless(:$device);
    $o.upref;
    $o;
  }

  # Cannot rename or alias to new due to GdkDevice in both this signature
  # and Ancestry
  method get_associated_device(GdkDevice() $dev)
    is also<get-associated-device>
  {
    my $device = gdk_device_get_associated_device($dev);
    self.bless(:$device);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkDevice, gpointer --> void
  method changed {
    self.connect($!d, 'changed');
  }

  # Is originally:
  # GdkDevice, GdkDeviceTool, gpointer --> void
  method tool-changed is also<tool_changed> {
    self.connect-device-tool($!d);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GdkInputMode( gdk_device_get_mode($!d) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = self.RESOLVE-UINT($mode);
        gdk_device_set_mode($!d, $m);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: GdkDevice
  method associated-device is rw is also<associated_device> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('associated-device', $gv)
        );
        GDK::Device.new( $gv.object );
      },
      STORE => -> $, $val is copy {
        warn 'associated-device does not allow writing';
      }
    );
  }

  # Type: GdkAxisFlags
  method axes is rw {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('axes', $gv)
        );
        GdkAxisFlags( $gv.uint );
      },
      STORE => -> $, $val is copy {
        warn 'axes does not allow writing';
      }
    );
  }

  # Type: GdkDeviceManager
  method device-manager is rw is also<device_manager> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('device-manager', $gv)
        );
        $gv.object;
      },
      STORE => -> $, GdkDeviceManager() $val is copy {
        $gv.object = $val;
        self.prop_set('device-manager', $gv);
      }
    );
  }

  # Type: GdkDisplay
  method display is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('display', $gv)
        );
        $gv.object;
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: gboolean
  method has-cursor is rw is also<has_cursor> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('input-mode', $gv)
        );
        GdkInputMode( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set('input-mode', $gv);
      }
    );
  }

  # Type: GdkInputSource
  method input-source is rw is also<input_source> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('input-source', $gv)
        );
        GdkInputSource( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set('input-source', $gv);
      }
    );
  }

  # Type: guint
  method n-axes is rw is also<n_axes> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('n-axes', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, $val is copy {
        warn 'n-axes does not allow writing'
      }
    );
  }

  # Type: gchar
  method name is rw {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('seat', $gv)
        );
        $gv.object;
      },
      STORE => -> $, GdkSeat() $val is copy {
        $gv.object = $val;
        self.prop_set('seat', $gv);
      }
    );
  }

  # Type: GdkDeviceTool
  method tool is rw {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('tool', $gv)
        );
        $gv.object
      },
      STORE => -> $, $val is copy {
        warn 'tool does not allow writing'
      }
    );
  }

  # Type: GdkDeviceType
  method type is rw {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('type', $gv)
        );
        GdkDeviceType( $gv.uint );
      },
      STORE => -> $, $val is copy {
        $gv.uint = self.RESOLVE-UINT($val);
        self.prop_set('type', $gv);
      }
    );
  }

  # Type: gchar
  method vendor-id is rw is also<vendor_id> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my gint $ne = self.RESOLVE-INT($n_events);
    gdk_device_free_history($!d, $ne);
  }

  method get_axes is also<get-axes> {
    gdk_device_get_axes($!d);
  }

  method get_axis (Num() $axes, Int() $use, Num() $value)
    is also<get-axis>
  {
    my gdouble ($a, $v) = ($axes, $value);
    my guint $u = self.RESOLVE-UINT($use);
    gdk_device_get_axis($!d, $a, $u, $v);
  }

  method get_axis_use (Int() $index) is also<get-axis-use> {
    my guint $i = self.RESOLVE-UINT($index);
    gdk_device_get_axis_use($!d, $i);
  }

  method get_axis_value (
    Num() $axes,
    GdkAtom $axis_label,
    Num() $value
  )
    is also<get-axis-value>
  {
    my gdouble ($a, $v) = ($axes, $value);
    gdk_device_get_axis_value($!d, $a, $axis_label, $v);
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
    GdkWindow() $window,
    Int() $start,
    Int() $stop,
    Int() $events,
    Int() $n_events
  )
    is also<get-history>
  {
    my @u = ($start, $stop, $events);
    my guint ($st, $sp, $e) = self.RESOLVE-UINT(@u);
    my $ne = self.RESOLVE-INT($n_events);
    gdk_device_get_history($!d, $window, $st, $sp, $e, $ne);
  }

  method get_key (
    Int() $index,
    Int() $keyval,
    Int() $modifiers
  )
    is also<get-key>
  {
    my @u = ($index, $keyval, $modifiers);
    my guint ($i, $k, $m) = self.RESOLVE-UINT(@u);
    gdk_device_get_key($!d, $i, $k, $m);
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

  method get_position (GdkScreen() $screen, Int() $x, Int() $y)
    is also<get-position>
  {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    gdk_device_get_position($!d, $screen, $xx, $yy);
  }

  method get_position_double (GdkScreen() $screen, Num() $x, Num() $y)
    is also<get-position-double>
  {
    my gdouble ($xx, $yy) = ($x, $y);
    gdk_device_get_position_double($!d, $screen, $xx, $yy);
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
    GdkWindow() $window,
    Num() $axes,
    Int() $mask
  )
    is also<get-state>
  {
    my gdouble $a = $axes;
    my guint $m = self.RESOLVE-UINT($mask);
    gdk_device_get_state($!d, $window, $a, $m);
  }

  method get_type is also<get-type> {
    gdk_device_get_type();
  }

  method get_vendor_id is also<get-vendor-id> {
    gdk_device_get_vendor_id($!d);
  }

  method get_window_at_position (Int() $win_x, Int() $win_y)
    is also<get-window-at-position>
  {
    my @i = ($win_x, $win_y);
    my gint ($wx, $wy) = self.RESOLVE.INT(@i);
    gdk_device_get_window_at_position($!d, $wx, $wy);
  }

  method get_window_at_position_double (Num() $win_x, Num() $win_y)
    is also<get-window-at-position-double>
  {
    my gdouble ($wx, $wy) = ($win_x, $win_y);
    gdk_device_get_window_at_position_double($!d, $wx, $wy);
  }

  method grab (
    GdkWindow() $window,
    Int() $grab_ownership,
    Int() $owner_events,
    Int() $event_mask,
    GdkCursor() $cursor,
    Int() $time
  ) {
    my gboolean $oe = self.RESOLVE-BOOL($owner_events);
    my @u = ($grab_ownership, $event_mask, $time);
    my guint ($go, $em, $t) = self.RESOLVE-UINT(@u);

    gdk_device_grab($!d, $window, $go, $oe, $em, $cursor, $t);
  }

  method grab_info_libgtk_only (
    GdkDisplay() $display,
    GdkDevice() $device,
    GdkWindow() $grab_window,
    gboolean $owner_events
  )
    is also<grab-info-libgtk-only>
  {
    my gboolean $oe = self.RESOLVE-BOOL($owner_events);
    gdk_device_grab_info_libgdk_only($display, $device, $grab_window, $oe);
  }

  method list_axes is also<list-axes> {
    gdk_device_list_axes($!d);
  }

  method list_slave_devices is also<list-slave-devices> {
    gdk_device_list_slave_devices($!d);
  }

  method set_axis_use (Int() $index, Int() $use)
    is also<set-axis-use>
  {
    my @u = ($index, $use);
    my guint ($i, $u) = self.RESOLVE-UINT(@u);
    gdk_device_set_axis_use($!d, $i, $u);
  }

  method set_key (
    Int() $index,
    Int() $keyval,
    Int() $modifiers
  )
    is also<set-key>
  {
    my @u = ($index, $keyval, $modifiers);
    my guint ($i, $k, $m) = self.RESOLVE-UINT(@u);
    gdk_device_set_key($!d, $i, $k, $m);
  }

  method ungrab (Int() $time) {
    my guint $t = self.RESOLVE-UINT($time);
    gdk_device_ungrab($!d, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
