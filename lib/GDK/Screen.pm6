use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Screen;
use GDK::Raw::X11_Screen;

use GDK::Visual;
use GDK::Window;

use GLib::Roles::ListData;
use GLib::Roles::Signals::Generic;

class GDK::Screen {
  also does GLib::Roles::Signals::Generic;

  has GdkScreen $!screen is implementor;

  submethod BUILD(:$screen) {
    $!screen = $screen;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals;
  }

  method GDK::Raw::Definitions::GdkScreen
    is also<screen>
  { $!screen }

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
  method get_active_window (:$raw = False)
    is DEPRECATED
    is also<get-active-window>
  {
    my $w = gdk_screen_get_active_window($!screen);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  method get_default is also<get-default> {
    my $screen = gdk_screen_get_default();

    $screen ?? self.bless(:$screen) !! Nil;
  }

  method get_display is also<get-display> {
    ::('GDK::Display').new( gdk_screen_get_display($!screen) );
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
    my ($xx, $yy) = ($x, $y);

    gdk_screen_get_monitor_at_point($!screen, $x, $y);
  }

  method get_monitor_at_window (GdkWindow() $window)
    is also<get-monitor-at-window>
  {
    gdk_screen_get_monitor_at_window($!screen, $window);
  }

  method get_monitor_geometry (Int() $monitor_num, GdkRectangle() $dest)
    is also<get-monitor-geometry>
  {
    my gint $m = $monitor_num;

    gdk_screen_get_monitor_geometry($!screen, $m, $dest);
  }

  method get_monitor_height_mm (Int() $monitor_num)
    is also<get-monitor-height-mm>
  {
    my gint $m = $monitor_num;

    gdk_screen_get_monitor_height_mm($!screen, $m);
  }

  method get_monitor_plug_name (Int() $monitor_num)
    is also<get-monitor-plug-name>
  {
    my gint $m = $monitor_num;

    gdk_screen_get_monitor_plug_name($!screen, $m);
  }

  method get_monitor_scale_factor (Int() $monitor_num)
    is also<get-monitor-scale-factor>
  {
    my gint $m = $monitor_num;

    gdk_screen_get_monitor_scale_factor($!screen, $m);
  }

  method get_monitor_width_mm (Int() $monitor_num)
    is also<get-monitor-width-mm>
  {
    my gint $m = $monitor_num;

    gdk_screen_get_monitor_width_mm($!screen, $m);
  }

  method get_monitor_workarea (Int() $monitor_num, GdkRectangle() $dest)
    is also<get-monitor-workarea>
  {
    my $mn = $monitor_num;

    gdk_screen_get_monitor_workarea($!screen, $mn, $dest);
  }

  method get_n_monitors is also<get-n-monitors> {
    gdk_screen_get_n_monitors($!screen);
  }

  method get_number is also<get-number> {
    gdk_screen_get_number($!screen);
  }

  method get_rgba_visual (:$raw = False) is also<get-rgba-visual> {
    my $v = gdk_screen_get_rgba_visual($!screen);

    $v ??
      ( $raw ?? $v !! GDK::Visual.new($v) )
      !!
      Nil;
  }

  method get_root_window (:$raw = False)
    is also<
      get-root-window
      root-window
      root_window
    >
  {
    my $w = gdk_screen_get_root_window($!screen);

    $w ??
      ( $raw ?? $w !! GDK::Window($w) )
      !!
      Nil;
  }

  method get_setting (Str() $name, GValue() $value) is also<get-setting> {
    so gdk_screen_get_setting($!screen, $name, $value);
  }

  method get_system_visual (:$raw = False) is also<get-system-visual> {
    my $v = gdk_screen_get_system_visual($!screen);

    $v ??
      ( $raw ?? $v !! GDK::Visual.new($v) )
      !!
      Nil;
  }

  method get_toplevel_windows (:$glist = False, :$raw = False)
    is also<get-toplevel-windows>
  {
    my $wl = gdk_screen_get_toplevel_windows($!screen);

    return Nil unless $wl;
    return $wl if $glist;

    $wl = GLib::GList.new($wl) but GList::Roles::ListData[GdkWindow];
    $raw ?? $wl.Array ?? $wl.Array.map({ GDK::Window.new($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_screen_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gdk_screen_get_width($!screen);
  }

  method get_width_mm is also<get-width-mm> {
    gdk_screen_get_width_mm($!screen);
  }

  method get_window_stack (:$glist = False, :$raw = False)
    is also<get-window-stack>
  {
    my $sl = gdk_screen_get_window_stack($!screen);

    return Nil unless $sl;
    return $sl if $glist;

    $sl = GLib::GList.new($sl) but GList::Roles::ListData[GdkWindow];
    $raw ?? $sl.Array !! $sl.Array.map({ GdkWindow.new($_) });
  }

  method is_composited is also<is-composited> {
    so gdk_screen_is_composited($!screen);
  }

  method list_visuals (:$glist = False, :$raw = False) is also<list-visuals> {
    my $vl = gdk_screen_list_visuals($!screen);

    return Nil unless $vl;
    return $vl if $glist;

    $vl = GLib::GList.new($vl) but GLib::Roles::ListData[GdkVisual];
    $raw ?? $vl.Array !! $vl.Array.map({ GDK::Visual.new($_) });
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
    my gint $mn = $monitor_num;

    gdk_x11_screen_get_monitor_output($!screen, $mn);
  }

  method x11_get_number_of_desktops {
    gdk_x11_screen_get_number_of_desktops($!screen);
  }

  method x11_get_screen_number {
    gdk_x11_screen_get_screen_number($!screen);
  }

  method x11_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_x11_screen_get_type, $n, $t );
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
