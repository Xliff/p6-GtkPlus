use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Raw::Screen;
use GTK::Compat::Types;

use GTK::Roles::Types;

class GTK::Compat::Screen {
  also does GTK::Roles::Types;

  has GdkScreen $!screen;

  submethod BUILD(:$screen) {
    $!screen = $screen;
  }

  method GTK::Compat::Types::GdkScreen is also<screen> {
    $!screen;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font_options is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_screen_get_font_options($!screen);
      },
      STORE => sub ($, $options is copy) {
        gdk_screen_set_font_options($!screen, $options);
      }
    );
  }

  method resolution is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_screen_get_resolution($!screen);
      },
      STORE => sub ($, $dpi is copy) {
        gdk_screen_set_resolution($!screen, $dpi);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_active_window {
    gdk_screen_get_active_window($!screen);
  }

  method get_default {
    gdk_screen_get_default();
  }

  method get_display {
    gdk_screen_get_display($!screen);
  }

  method get_height {
    gdk_screen_get_height($!screen);
  }

  method get_height_mm {
    gdk_screen_get_height_mm($!screen);
  }

  method get_monitor_at_point (gint $x, gint $y) {
    gdk_screen_get_monitor_at_point($!screen, $x, $y);
  }

  method get_monitor_at_window (GdkWindow() $window) {
    gdk_screen_get_monitor_at_window($!screen, $window);
  }

  method get_monitor_geometry (gint $monitor_num, GdkRectangle() $dest) {
    gdk_screen_get_monitor_geometry($!screen, $monitor_num, $dest);
  }

  method get_monitor_height_mm (gint $monitor_num) {
    gdk_screen_get_monitor_height_mm($!screen, $monitor_num);
  }

  method get_monitor_plug_name (gint $monitor_num) {
    gdk_screen_get_monitor_plug_name($!screen, $monitor_num);
  }

  method get_monitor_scale_factor (gint $monitor_num) {
    gdk_screen_get_monitor_scale_factor($!screen, $monitor_num);
  }

  method get_monitor_width_mm (gint $monitor_num) {
    gdk_screen_get_monitor_width_mm($!screen, $monitor_num);
  }

  method get_monitor_workarea (gint $monitor_num, GdkRectangle() $dest) {
    gdk_screen_get_monitor_workarea($!screen, $monitor_num, $dest);
  }

  method get_n_monitors {
    gdk_screen_get_n_monitors($!screen);
  }

  method get_number {
    gdk_screen_get_number($!screen);
  }

  method get_rgba_visual {
    gdk_screen_get_rgba_visual($!screen);
  }

  method get_root_window {
    gdk_screen_get_root_window($!screen);
  }

  method get_setting (Str $name, GValue() $value) {
    gdk_screen_get_setting($!screen, $name, $value);
  }

  method get_system_visual {
    gdk_screen_get_system_visual($!screen);
  }

  method get_toplevel_windows {
    gdk_screen_get_toplevel_windows($!screen);
  }

  method get_type {
    gdk_screen_get_type();
  }

  method get_width {
    gdk_screen_get_width($!screen);
  }

  method get_width_mm {
    gdk_screen_get_width_mm($!screen);
  }

  method get_window_stack {
    gdk_screen_get_window_stack($!screen);
  }

  method is_composited {
    gdk_screen_is_composited($!screen);
  }

  method list_visuals {
    gdk_screen_list_visuals($!screen);
  }

  method make_display_name {
    gdk_screen_make_display_name($!screen);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
