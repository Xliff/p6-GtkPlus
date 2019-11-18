use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Raw::Screen;
use GTK::Compat::Raw::X11_Screen;
use GTK::Compat::Types;

use GTK::Roles::Types;
use GTK::Roles::Signals::Generic;

class GTK::Compat::Screen {
  also does GTK::Roles::Types;
  also does GTK::Roles::Signals::Generic;

  has GdkScreen $!screen is implementor;

  submethod BUILD(:$screen) {
    $!screen = $screen;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GTK::Compat::Types::GdkScreen is also<screen> {
    $!screen;
  }

  method new (GdkScreen() $screen) {
    self.bless(:$screen);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkScreen, gpointer --> void
  method composited-changed {
    self.connect($!screen, 'composited-changed');
  }

  # Is originally:
  # GdkScreen, gpointer --> void
  method monitors-changed {
    self.connect($!screen, 'monitors-changed');
  }

  # Is originally:
  # GdkScreen, gpointer --> void
  method size-changed {
    self.connect($!screen, 'size-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font_options is rw is also<font-options> {
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
      STORE => sub ($, Num() $dpi is copy) {
        gdk_screen_set_resolution($!screen, $dpi);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_active_window is also<get-active-window> {
    gdk_screen_get_active_window($!screen);
  }

  method get_default is also<get-default> {
    my $screen = gdk_screen_get_default();
    self.bless(:$screen);
  }

  method get_display is also<get-display> {
    ::('GTK::Compat::Display').new( gdk_screen_get_display($!screen) );
  }

  method get_height is also<get-height> {
    gdk_screen_get_height($!screen);
  }

  method get_height_mm is also<get-height-mm> {
    gdk_screen_get_height_mm($!screen);
  }

  method get_monitor_at_point (Int() $x, Int() $y)
    is also<get-monitor-at-point>
  {
    my ($xx, $yy) = self.RESOLVE-INT($x, $y);
    gdk_screen_get_monitor_at_point($!screen, $x, $y);
  }

  method get_monitor_at_window (GdkWindow() $window)
    is also<get-monitor-at-window>
  {
    gdk_screen_get_monitor_at_window($!screen, $window);
  }

  method get_monitor_geometry (gint $monitor_num, GdkRectangle() $dest)
    is also<get-monitor-geometry>
  {
    gdk_screen_get_monitor_geometry($!screen, $monitor_num, $dest);
  }

  method get_monitor_height_mm (gint $monitor_num)
    is also<get-monitor-height-mm>
  {
    gdk_screen_get_monitor_height_mm($!screen, $monitor_num);
  }

  method get_monitor_plug_name (gint $monitor_num)
    is also<get-monitor-plug-name>
  {
    gdk_screen_get_monitor_plug_name($!screen, $monitor_num);
  }

  method get_monitor_scale_factor (gint $monitor_num)
    is also<get-monitor-scale-factor>
  {
    gdk_screen_get_monitor_scale_factor($!screen, $monitor_num);
  }

  method get_monitor_width_mm (gint $monitor_num)
    is also<get-monitor-width-mm>
  {
    gdk_screen_get_monitor_width_mm($!screen, $monitor_num);
  }

  method get_monitor_workarea (Int() $monitor_num, GdkRectangle() $dest)
    is also<get-monitor-workarea>
  {
    my $mn = self.RESOLVE-INT($monitor_num);
    gdk_screen_get_monitor_workarea($!screen, $mn, $dest);
  }

  method get_n_monitors is also<get-n-monitors> {
    gdk_screen_get_n_monitors($!screen);
  }

  method get_number is also<get-number> {
    gdk_screen_get_number($!screen);
  }

  method get_rgba_visual is also<get-rgba-visual> {
    gdk_screen_get_rgba_visual($!screen);
  }

  method get_root_window
    is also<get-root-window root-window root_window>
  {
    gdk_screen_get_root_window($!screen);
  }

  method get_setting (Str $name, GValue() $value) is also<get-setting> {
    gdk_screen_get_setting($!screen, $name, $value);
  }

  method get_system_visual is also<get-system-visual> {
    gdk_screen_get_system_visual($!screen);
  }

  method get_toplevel_windows is also<get-toplevel-windows> {
    gdk_screen_get_toplevel_windows($!screen);
  }

  method get_type is also<get-type> {
    gdk_screen_get_type();
  }

  method get_width is also<get-width> {
    gdk_screen_get_width($!screen);
  }

  method get_width_mm is also<get-width-mm> {
    gdk_screen_get_width_mm($!screen);
  }

  method get_window_stack is also<get-window-stack> {
    gdk_screen_get_window_stack($!screen);
  }

  method is_composited is also<is-composited> {
    gdk_screen_is_composited($!screen);
  }

  method list_visuals is also<list-visuals> {
    gdk_screen_list_visuals($!screen);
  }

  method make_display_name is also<make-display-name> {
    gdk_screen_make_display_name($!screen);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑
  
  method x11_get_default_screen {
    gdk_x11_get_default_screen();
  }

  method x11_get_current_desktop {
    gdk_x11_screen_get_current_desktop($!screen);
  }

  method x11_get_monitor_output (Int() $monitor_num) {
    my gint $mn = self.RESOLVE-INT($monitor_num);
    gdk_x11_screen_get_monitor_output($!screen, $mn);
  }

  method x11_get_number_of_desktops {
    gdk_x11_screen_get_number_of_desktops($!screen);
  }

  method x11_get_screen_number {
    gdk_x11_screen_get_screen_number($!screen);
  }

  method x11_get_type {
    gdk_x11_screen_get_type();
  }

  method x11_get_window_manager_name {
    gdk_x11_screen_get_window_manager_name($!screen);
  }

  method x11_get_xscreen {
    gdk_x11_screen_get_xscreen($!screen);
  }

  method x11_supports_net_wm_hint (GdkAtom $property) {
    gdk_x11_screen_supports_net_wm_hint($!screen, $property);
  }

}
