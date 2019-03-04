use v6.c;

use Method::Also;
use NativeCall;

use Cairo;

use GTK::Compat::Cursor;
use GTK::Compat::Types;
use GTK::Compat::RGBA;
use GTK::Compat::Raw::Window;
use GTK::Compat::Raw::X11_Window;

use GTK::Raw::Subs;

use GTK::Roles::Types;
use GTK::Compat::Roles::Signals::Window;

class GTK::Compat::Window {
  also does GTK::Roles::Types;
  also does GTK::Compat::Roles::Signals::Window;

  has GdkWindow $!window;

  submethod BUILD(:$window) {
    $!window = $window;
  }

  method GTK::Compat::Types::GdkWindow is also<gdkwindow> {
    $!window;
  }

  multi method new (GdkWindow $window) {
    self.bless(:$window);
  }
  multi method new (
    GdkWindow() $parent,
    GdkWindowAttr $attributes,
    Int() $attributes_mask
  ) {
    my gint $am = self.RESOLVE-INT($attributes_mask);
    self.bless(
      window => gdk_window_new($parent, $attributes, $am)
    );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GdkWindow, gint, gint, gpointer --> CairoSurface
  method create-surface is also<create_surface> {
    self.connect-create-surface($!window);
  }

  # Is originally:
  # GdkWindow, gdouble, gdouble, gpointer, gpointer, gpointer --> void
  method from-embedder is also<from_embedder> {
    self.connect-embedder($!window, 'from-embedder');
  }

  # Is originally:
  # GdkWindow, gpointer, gpointer, gboolean, gboolean, gpointer --> void
  method moved-to-rect is also<moved_to_rect> {
    self.connect-moved-to-rect($!window);
  }

  # Is originally:
  # GdkWindow, gdouble, gdouble, gpointer --> GdkWindow
  method pick-embedded-child is also<pick_embedded_child> {
    self.connect-pick-embedded-child($!window);
  }

  # Is originally:
  # GdkWindow, gdouble, gdouble, gpointer, gpointer, gpointer --> void
  method to-embedder is also<to_embedder> {
    self.connect-embedder($!window, 'to-embedder');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accept_focus is rw is also<accept-focus> {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_accept_focus($!window);
      },
      STORE => sub ($, Int() $accept_focus is copy) {
        my gboolean $af = self.RESOLVE-BOOL($accept_focus);
        gdk_window_set_accept_focus($!window, $af);
      }
    );
  }

  # SEVERELY DEPRECATED. Please remove immediately after initial release.
  method background_pattern is rw is also<background-pattern> {
    die qq:to/D/.chomp;
    GTK::Compat::Window.get/set_background_pattern is no longer {
    } supported by GTK.
    D
    
    # Proxy.new(
    #   FETCH => sub ($) {
    #     gdk_window_get_background_pattern($!window);
    #   },
    #   STORE => sub ($, cairo_pattern_t $pattern is copy) {
    #     gdk_window_set_background_pattern($!window, $pattern);
    #   }
    # );
  }

  method composited is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_composited($!window);
      },
      STORE => sub ($, Int() $composited is copy) {
        my gboolean $c = self.RESOLVE-BOOL($composited);
        gdk_window_set_composited($!window, $c);
      }
    );
  }

  method cursor is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Cursor.new( gdk_window_get_cursor($!window) );
      },
      STORE => sub ($, GdkCursor() $cursor is copy) {
        my $c = gdk_window_get_cursor($!window);
        g_object_unref($c.p) with $c;
        gdk_window_set_cursor($!window, $cursor);
        g_object_ref($cursor.p);
      }
    );
  }

  method offscreen_window_embedder
    is rw
    is also<offscreen-window-embedder>
  {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Window.new( gdk_offscreen_window_get_embedder($!window) );
      },
      STORE => sub ($, GdkWindow() $embedder is copy) {
        gdk_offscreen_window_set_embedder($!window, $embedder);
      }
    );
  }

  method event_compression is rw is also<event-compression> {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_event_compression($!window);
      },
      STORE => sub ($, Int() $event_compression is copy) {
        my gboolean $ec = self.RESODLVE-BOOL($event_compression);
        gdk_window_set_event_compression($!window, $ec);
      }
    );
  }

  method events is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_events($!window);
      },
      STORE => sub ($, Int() $event_mask is copy) {
        my guint $em = self.RESOLVE-UINT($event_mask);
        gdk_window_set_events($!window, $event_mask);
      }
    );
  }

  method focus_on_map is rw is also<focus-on-map> {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_focus_on_map($!window);
      },
      STORE => sub ($, Int() $focus_on_map is copy) {
        my gboolean $fom = self.RESOLVE-BOOL($focus_on_map);
        gdk_window_set_focus_on_map($!window, $fom);
      }
    );
  }

  method fullscreen_mode is rw is also<fullscreen-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GdkFullscreenMode( gdk_window_get_fullscreen_mode($!window) );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = self.RESOLVE-UINT($mode);
        gdk_window_set_fullscreen_mode($!window, $m);
      }
    );
  }

  method group is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Window.new( gdk_window_get_group($!window) );
      },
      STORE => sub ($, GdkWindow() $leader is copy) {
        gdk_window_set_group($!window, $leader);
      }
    );
  }

  method modal_hint is rw is also<modal-hint> {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_modal_hint($!window);
      },
      STORE => sub ($, Int() $modal is copy) {
        my gboolean $m = self.RESOLVE-BOOL($modal);
        gdk_window_set_modal_hint($!window, $m);
      }
    );
  }

  method pass_through is rw is also<pass-through> {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_pass_through($!window);
      },
      STORE => sub ($, $pass_through is copy) {
        my gboolean $pt = self.RESOLVE-BOOL($pass_through);
        gdk_window_set_pass_through($!window, $pt);
      }
    );
  }

  method support_multidevice is rw is also<support-multidevice> {
    Proxy.new(
      FETCH => sub ($) {
        so gdk_window_get_support_multidevice($!window);
      },
      STORE => sub ($, $support_multidevice is copy) {
        my gboolean $sm = self.RESOLVE-BOOL($support_multidevice);
        gdk_window_set_support_multidevice($!window, $sm);
      }
    );
  }

  method type_hint is rw is also<type-hint> {
    Proxy.new(
      FETCH => sub ($) {
        GdkWindowTypeHint( gdk_window_get_type_hint($!window) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my guint $h = self.RESOLVE-UINT($hint);
        gdk_window_set_type_hint($!window, $h);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_filter (GdkFilterFunc $function, gpointer $data)
    is also<add-filter>
  {
    gdk_window_add_filter($!window, $function, $data);
  }

  method at_pointer (Int() $win_x, Int() $win_y) is also<at-pointer> {
    my gint ($wx, $wy) = self.RESOLVE-INT($win_x, $win_y);
    gdk_window_at_pointer($wx, $wy);
  }

  method beep {
    gdk_window_beep($!window);
  }

  method begin_draw_frame (cairo_region_t $region) is also<begin-draw-frame> {
    gdk_window_begin_draw_frame($!window, $region);
  }

  method begin_move_drag (
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  )
    is also<begin-move-drag>
  {
    my gint ($b, $rx, $ry) = self.RESOLVE-INT($button, $root_x, $root_y);
    my guint $t = self.RESOLVE-UINT($timestamp);
    gdk_window_begin_move_drag($!window, $b, $rx, $ry, $t);
  }

  method begin_move_drag_for_device (
    GdkDevice() $device,
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  )
    is also<begin-move-drag-for-device>
  {
    my gint ($b, $rx, $ry) = self.RESOLVE-INT($button, $root_x, $root_y);
    my guint $t = self.RESOLVE-UINT($timestamp);
    gdk_window_begin_move_drag_for_device(
      $!window, $device, $b, $rx, $ry, $t
    );
  }

  method begin_paint_rect (GdkRectangle $rectangle)
    is also<begin-paint-rect>
  {
    gdk_window_begin_paint_rect($!window, $rectangle);
  }

  method begin_paint_region (cairo_region_t $region)
    is also<begin-paint-region>
  {
    gdk_window_begin_paint_region($!window, $region);
  }

  method begin_resize_drag (
    Int() $edge,                        # GdkWindowEdge $edge,
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  )
    is also<begin-resize-drag>
  {
    my gint ($b, $rx, $ry) = self.RESOLVE-INT($button, $root_x, $root_y);
    my guint ($e, $t) = self.RESOLVE-UINT($edge, $timestamp);
    gdk_window_begin_resize_drag($!window, $e, $b, $rx, $ry, $t);
  }

  method begin_resize_drag_for_device (
    GdkWindowEdge $edge,
    GdkDevice() $device,
    gint $button,
    gint $root_x,
    gint $root_y,
    guint $timestamp
  )
    is also<begin-resize-drag-for-device>
  {
    my gint ($b, $rx, $ry) = self.RESOLVE-INT($button, $root_x, $root_y);
    my guint $t = self.RESODLVE-UINT($timestamp);
    gdk_window_begin_resize_drag_for_device(
      $!window,
      $edge,
      $device,
      $b,
      $rx,
      $ry,
      $t
    );
  }

  method configure_finished is also<configure-finished> {
    gdk_window_configure_finished($!window);
  }

  method constrain_size (
    GdkGeometry $geometry,
    GdkWindowHints $flags,
    Int() $width,
    Int() $height,
    Int() $new_width  is rw,
    Int() $new_height is rw
  )
    is also<constrain-size>
  {
    my gint ($w, $h, $nw, $nh) = self.RESOLVE-INT(
      $width, $height, $new_width, $new_height
    );
    my $rc = gdk_window_constrain_size(
      $geometry,
      $flags,
      $w,
      $h,
      $nw,
      $nh
    );
    ($width, $height) = ($nw, $nh);
    $rc;
  }

  method coords_from_parent (
    Num() $parent_x,
    Num() $parent_y,
    Num() $x is rw,
    Num() $y is rw
  )
    is also<coords-from-parent>
  {
    my gdouble ($px, $py, $xx, $yy) = ($parent_x, $parent_y, $x, $y);
    my $rc = gdk_window_coords_from_parent($!window, $px, $py, $xx, $yy);
    ($x, $y) = ($xx, $yy);
    $rc;
  }

  method coords_to_parent (
    Num() $x,
    Num() $y,
    Num() $parent_x is rw,
    Num() $parent_y is rw
  )
    is also<coords-to-parent>
  {
    my gdouble ($px, $py, $xx, $yy) = ($parent_x, $parent_y, $x, $y);
    my $rc = gdk_window_coords_to_parent($!window, $xx, $yy, $px, $py);
    ($parent_x, $parent_y) = ($px, $py);
    $rc;
  }

  method create_gl_context (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-gl-context>
  {
    gdk_window_create_gl_context($!window, $error);
  }

  method create_similar_image_surface (
    Int() $format,
    Int() $width,
    Int() $height,
    Int() $scale
  )
    is also<create-similar-image-surface>
  {
    my guint $f = self.RESOLVE-UINT($format); # cairo_format_t
    my gint ($w, $h, $s) = self.RESOLVE-INT($width, $height, $scale);
    gdk_window_create_similar_image_surface($!window, $f, $w, $h, $s);
  }

  method create_similar_surface (
    Int() $content,
    Int() $width,
    Int() $height
  )
    is also<create-similar-surface>
  {
    my guint $c = self.RESOLVE-UINT($content);
    my gint ($w, $h) = self.RESOLVE-INT($w, $h);
    gdk_window_create_similar_surface($!window, $c, $w, $h);
  }

  method deiconify {
    gdk_window_deiconify($!window);
  }

  method destroy {
    gdk_window_destroy($!window);
  }

  method enable_synchronized_configure
    is also<enable-synchronized-configure>
  {
    gdk_window_enable_synchronized_configure($!window);
  }

  method end_draw_frame (GdkDrawingContext $context)
    is also<end-draw-frame>
  {
    gdk_window_end_draw_frame($!window, $context);
  }

  method end_paint is also<end-paint> {
    gdk_window_end_paint($!window);
  }

  method ensure_native is also<ensure-native> {
    gdk_window_ensure_native($!window);
  }

  method flush {
    gdk_window_flush($!window);
  }

  method focus (Int() $timestamp) {
    my guint $t = self.RESOLVE-UINT($timestamp);
    gdk_window_focus($!window, $t);
  }

  method freeze_toplevel_updates_libgtk_only
    is also<freeze-toplevel-updates-libgtk-only>
  {
    gdk_window_freeze_toplevel_updates_libgtk_only($!window);
  }

  method freeze_updates is also<freeze-updates> {
    gdk_window_freeze_updates($!window);
  }

  method fullscreen {
    gdk_window_fullscreen($!window);
  }

  method fullscreen_on_monitor (Int() $monitor)
    is also<fullscreen-on-monitor>
  {
    my gint $m = self.RESOLVE-INT($monitor);
    gdk_window_fullscreen_on_monitor($!window, $m);
  }

  method gdk_get_default_root_window
    is also<gdk-get-default-root-window>
  {
    gdk_get_default_root_window();
  }

  method offscreen_window_get_surface
    is also<offscreen-window-get-surface>
  {
    gdk_offscreen_window_get_surface($!window);
  }

  method geometry_changed is also<geometry-changed> {
    gdk_window_geometry_changed($!window);
  }

  method get_children is also<get-children> {
    gdk_window_get_children($!window);
  }

  method get_children_with_user_data (gpointer $user_data)
    is also<get-children-with-user-data>
  {
    gdk_window_get_children_with_user_data($!window, $user_data);
  }

  method get_clip_region is also<get-clip-region> {
    gdk_window_get_clip_region($!window);
  }

  method get_decorations (GdkWMDecoration $decorations)
    is also<get-decorations>
  {
    gdk_window_get_decorations($!window, $decorations);
  }

  method get_device_cursor (GdkDevice() $device) is also<get-device-cursor> {
    gdk_window_get_device_cursor($!window, $device);
  }

  method get_device_events (GdkDevice() $device) is also<get-device-events> {
    gdk_window_get_device_events($!window, $device);
  }

  proto method get_device_position(|c)
    is also<get-device-position>
    { * }

  multi method get_device_position($device) {
    my ($x, $y, $m) = (0, 0, 0);
    samewith($device, $x, $y, $m);
    ($x, $y, $m);
  }
  multi method get_device_position (
    GdkDevice() $device,
    Int() $x is rw,
    Int() $y is rw,
    Int() $mask is rw             # GdkModifierType $mask
  ) {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    my guint $m = self.RESOLVE-UINT($mask);
    gdk_window_get_device_position($!window, $device, $xx, $yy, $m);
    ($x, $y, $mask) = ($xx, $yy, $m);
  }

  proto method get_device_position_double (|c)
    is also<get-device-position-double>
    { * }

  multi method get_device_position_double (
    GdkDevice() $device
  ) {
    my ($x, $y, $m) = (0, 0, 0);
    samewith($device, $x, $y, $m);
  }

  multi method get_device_position_double (
    GdkDevice() $device,
    Num() $x is rw,
    Num() $y is rw,
    Int() $mask is rw             # GdkModifierType $mask
  ) {
    my guint $m = self.RESOLVE-UINT($mask);
    gdk_window_get_device_position_double($!window, $device, $x, $y, $m);
    ($x, $y, $mask = $m);
  }

  method get_display is also<get-display> {
    gdk_window_get_display($!window);
  }

  method get_drag_protocol (GdkWindow() $target) is also<get-drag-protocol> {
    GdkDragProtocol( gdk_window_get_drag_protocol($!window, $target) );
  }

  method get_effective_parent is also<get-effective-parent> {
    gdk_window_get_effective_parent($!window);
  }

  method get_effective_toplevel is also<get-effective-toplevel> {
    gdk_window_get_effective_toplevel($!window);
  }

  method get_frame_clock is also<get-frame-clock> {
    gdk_window_get_frame_clock($!window);
  }

  method get_frame_extents (GdkRectangle $rect) is also<get-frame-extents> {
    gdk_window_get_frame_extents($!window, $rect);
  }

  method get_geometry (
    Int() $x, 
    Int() $y, 
    Int() $width, 
    Int() $height)
    is also<get-geometry geometry>
  {
    my gint ($xx, $yy, $w, $h) = self.RESOLVE-INT($x, $y, $width, $height);
    gdk_window_get_geometry($!window, $xx, $yy, $w, $h);
  }

  method get_height is also<get-height height> {
    gdk_window_get_height($!window);
  }

  proto method get_origin (|)
    is also<get-origin origin>
    { * }
    
  multi method get_origin {
    my ($x, $y) = (0, 0);
    samewith($x, $y);
    ($x, $y);
  }
  multi method get_origin (Int() $x is rw, Int() $y is rw) {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    my $rc = gdk_window_get_origin($!window, $xx, $yy);
    ($x, $y) = ($xx, $yy);
    $rc;
  }

  method get_parent is also<get-parent> {
    gdk_window_get_parent($!window);
  }

  method get_pointer (Int() $x is rw, Int() $y is rw, Int() $mask is rw)
    is also<get-pointer>
    is DEPRECATED<GTK::Compat::Window.get_device_position()>
  {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    my guint $m = self.RESOLVE-UINT($mask);
    my $w = GTK::Compat::Window.new( 
      gdk_window_get_pointer($!window, $xx, $yy, $m) 
    );
    ($x, $y, $mask) = ($xx, $yy, $m);
    $w;
  }

  method get_position (Int() $x is rw, Int() $y is rw) 
    is also<get-position> 
  {
    my gint ($xx, $yy) = ($x, $y);
    my $rc = gdk_window_get_position($!window, $xx, $yy);
    ($x, $y) = ($xx, $yy);
    $rc;
  }

  method get_root_coords (gint $x, gint $y, gint $root_x, gint $root_y)
    is also<get-root-coords>
  {
    my gint ($xx, $yy, $rx, $ry) = self.RESOLVE-INT($x, $y, $root_x, $root_y);
    my $rc = gdk_window_get_root_coords($!window, $xx, $yy, $rx, $ry);
    ($x, $y, $root_x, $root_y) = ($xx, $yy, $rx, $ry);
    $rc;
  }

  method get_root_origin (Int() $x is rw, Int() $y is rw) 
    is also<get-root-origin> 
  {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    my $rc = gdk_window_get_root_origin($!window, $x, $y);
    ($x, $y) = ($xx, $yy);
    $rc;
  }

  method get_scale_factor is also<get-scale-factor> {
    gdk_window_get_scale_factor($!window);
  }

  method get_screen is also<get-screen> {
    GTK::Compat::Screen.new( gdk_window_get_screen($!window) );
  }

  method get_source_events (GdkInputSource $source)
    is also<get-source-events>
  {
    gdk_window_get_source_events($!window, $source);
  }

  method get_state is also<get-state> {
    gdk_window_get_state($!window);
  }

  method get_toplevel is also<get-toplevel> {
    gdk_window_get_toplevel($!window);
  }

  method get_type is also<get-type> {
    gdk_window_get_type();
  }

  method get_update_area is also<get-update-area> {
    gdk_window_get_update_area($!window);
  }

  method get_user_data (gpointer $data) is also<get-user-data> {
    gdk_window_get_user_data($!window, $data);
  }

  method get_visible_region is also<get-visible-region> {
    gdk_window_get_visible_region($!window);
  }

  method get_visual is also<get-visual> {
    gdk_window_get_visual($!window);
  }

  method get_width is also<get-width width> {
    gdk_window_get_width($!window);
  }

  method get_window_type is also<get-window-type> {
    gdk_window_get_window_type($!window);
  }

  method has_native is also<has-native> {
    gdk_window_has_native($!window);
  }

  method hide {
    gdk_window_hide($!window);
  }

  method iconify {
    gdk_window_iconify($!window);
  }

  method input_shape_combine_region (
    cairo_region_t $shape_region,
    Int() $offset_x,
    Int() $offset_y
  )
    is also<input-shape-combine-region>
  {
    my gint ($ox, $oy) = self.RESOLVE-INT($offset_x, $offset_y);
    gdk_window_input_shape_combine_region(
      $!window,
      $shape_region,
      $ox,
      $oy
    );
  }

  method invalidate_maybe_recurse (
    cairo_region_t $region,
    GdkWindowChildFunc $child_func,
    gpointer $user_data
  )
    is also<invalidate-maybe-recurse>
  {
    gdk_window_invalidate_maybe_recurse(
      $!window,
      $region,
      $child_func,
      $user_data
    );
  }

  method invalidate_rect (
    GdkRectangle $rect,
    gboolean $invalidate_children
  )
    is also<invalidate-rect>
  {
    gdk_window_invalidate_rect($!window, $rect, $invalidate_children);
  }

  method invalidate_region (
    cairo_region_t $region,
    Int() $invalidate_children
  )
    is also<invalidate-region>
  {
    my gboolean $ic = self.RESOLVE-BOOL($invalidate_children);
    gdk_window_invalidate_region($!window, $region, $ic);
  }

  method is_destroyed is also<is-destroyed> {
    gdk_window_is_destroyed($!window);
  }

  method is_input_only is also<is-input-only> {
    gdk_window_is_input_only($!window);
  }

  method is_shaped is also<is-shaped> {
    gdk_window_is_shaped($!window);
  }

  method is_viewable is also<is-viewable> {
    gdk_window_is_viewable($!window);
  }

  method is_visible is also<is-visible> {
    gdk_window_is_visible($!window);
  }

  method lower {
    gdk_window_lower($!window);
  }

  method mark_paint_from_clip (cairo_t $cr) is also<mark-paint-from-clip> {
    gdk_window_mark_paint_from_clip($!window, $cr);
  }

  method maximize {
    gdk_window_maximize($!window);
  }

  method merge_child_input_shapes is also<merge-child-input-shapes> {
    gdk_window_merge_child_input_shapes($!window);
  }

  method merge_child_shapes is also<merge-child-shapes> {
    gdk_window_merge_child_shapes($!window);
  }

  method move (Int() $x, Int() $y) {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    gdk_window_move($!window, $xx, $yy);
  }

  method move_region (cairo_region_t $region, Int() $dx, Int() $dy)  
    is also<move-region>
  {
    my gint ($dxx, $dyy) = self.RESOLVE-INT($dx, $dy);
    gdk_window_move_region($!window, $region, $dxx, $dyy);
  }

  method move_resize (
    Int() $x, 
    Int() $y, 
    Int() $width, 
    Int() $height
  )
    is also<move-resize>
  {
    my gint ($xx, $yy, $w, $h) = self.RESOLVE-INT($x, $y, $width, $height);
    gdk_window_move_resize($!window, $xx, $yy, $w, $h);
  }

  method move_to_rect (
    GdkRectangle $rect,
    Int() $rect_anchor,
    Int() $window_anchor,
    Int() $anchor_hints,
    Int() $rect_anchor_dx,
    Int() $rect_anchor_dy
  )
    is also<move-to-rect>
  {
    my guint ($ra, $wa, $ah) = self.RESOLVE-UINT(
      $rect_anchor, $window_anchor, $anchor_hints
    );
    my gint ($rax, $ray) = self.RESOLVE-INT($rect_anchor_dx, $rect_anchor_dy);
    gdk_window_move_to_rect($!window, $rect, $ra, $wa, $ah, $rax, $ray);
  }

  method peek_children is also<peek-children> {
    gdk_window_peek_children($!window);
  }

  method process_all_updates is also<process-all-updates> {
    gdk_window_process_all_updates();
  }

  method process_updates (gboolean $update_children)
    is also<process-updates>
  {
    gdk_window_process_updates($!window, $update_children);
  }

  method raise {
    gdk_window_raise($!window);
  }

  method register_dnd is also<register-dnd> {
    gdk_window_register_dnd($!window);
  }

  method remove_filter (GdkFilterFunc $function, gpointer $data)
    is also<remove-filter>
  {
    gdk_window_remove_filter($!window, $function, $data);
  }

  method reparent (
    GdkWindow() $new_parent, 
    Int() $x, 
    Int() $y
  ) {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    gdk_window_reparent($!window, $new_parent, $xx, $yy);
  }

  method resize (Int() $width, Int() $height) {
    my gint ($w, $h) = self.RESOLVE-INT($width, $height);
    gdk_window_resize($!window, $w, $h);
  }

  method restack (GdkWindow() $sibling, Int() $above) {
    my gboolean $a = self.RESOLVE-BOOL($above);
    gdk_window_restack($!window, $sibling, $a);
  }

  method scroll (Int() $dx, Int() $dy) {
    my gint ($dxx, $dyy) = self.RESOLVE-INT($dx, $dy);
    gdk_window_scroll($!window, $dxx, $dyy);
  }

  # SEVERELY DEPRECATED, PLEASE REMOVE AFTER INITIAL RELEASE!
  method set_background (GdkColor $color) is also<set-background> {
    die 'GTK::Window.set_background is no longer supported, please use CSS'
    #gdk_window_set_background($!window, $color);
  }

  # SEVERELY DEPRECATED, PLEASE REMOVE AFTER INITIAL RELEASE!
  method set_background_rgba (GTK::Compat::RGBA $rgba)
    is also<set-background-rgba>
  {
    die 
      'GTK::Window.set_background_rgba is no longer supported, please use CSS'
    # gdk_window_set_background_rgba($!window, $rgba);
  }

  method set_child_input_shapes is also<set-child-input-shapes> {
    gdk_window_set_child_input_shapes($!window);
  }

  method set_child_shapes is also<set-child-shapes> {
    gdk_window_set_child_shapes($!window);
  }

  method set_debug_updates is also<set-debug-updates> {
    gdk_window_set_debug_updates($!window);
  }

  method set_decorations (GdkWMDecoration $decorations)
    is also<set-decorations>
  {
    gdk_window_set_decorations($!window, $decorations);
  }

  method set_device_cursor (GdkDevice() $device, GdkCursor $cursor)
    is also<set-device-cursor>
  {
    gdk_window_set_device_cursor($!window, $device, $cursor);
  }

  method set_device_events (GdkDevice() $device, Int() $event_mask)
    is also<set-device-events>
  {
    my guint $m = self.RESOLVE-UINT($event_mask);
    gdk_window_set_device_events($!window, $device, $m);
  }

  method set_functions (GdkWMFunction $functions) is also<set-functions> {
    gdk_window_set_functions($!window, $functions);
  }

  method set_geometry_hints (
    GdkGeometry $geometry,
    Int() $geom_mask
  )
    is also<set-geometry-hints>
  {
    my guint $m = self.RESOLVE-UINT($geom_mask);
    gdk_window_set_geometry_hints($!window, $geometry, $m);
  }

  method set_icon_list (GList $pixbufs) is also<set-icon-list> {
    gdk_window_set_icon_list($!window, $pixbufs);
  }

  method set_icon_name (Str() $name) is also<set-icon-name> {
    gdk_window_set_icon_name($!window, $name);
  }

  method set_invalidate_handler (GdkWindowInvalidateHandlerFunc $handler)
    is also<set-invalidate-handler>
  {
    gdk_window_set_invalidate_handler($!window, $handler);
  }

  method set_keep_above (Int() $setting) is also<set-keep-above> {
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gdk_window_set_keep_above($!window, $s);
  }

  method set_keep_below (Int() $setting) is also<set-keep-below> {
    my gboolean $s = self.RESOLVE-BOOL($setting);
    gdk_window_set_keep_below($!window, $s);
  }

  method set_opacity (Num() $opacity) is also<set-opacity> {
    my gdouble $o = $opacity;
    gdk_window_set_opacity($!window, $o);
  }

  method set_opaque_region (cairo_region_t $region) is also<set-opaque-region> {
    gdk_window_set_opaque_region($!window, $region);
  }

  method set_override_redirect (Int() $override_redirect)
    is also<set-override-redirect>
  {
    my gboolean $or = self.RESOLVE-BOOL($override_redirect);
    gdk_window_set_override_redirect($!window, $or);
  }

  method set_role (Str() $role) is also<set-role> {
    gdk_window_set_role($!window, $role);
  }

  method set_shadow_width (
    Int() $left,
    Int() $right,
    Int() $top,
    Int() $bottom
  )
    is also<set-shadow-width>
  {
    my gint ($l, $r, $t, $b) = self.RESOLVE-INT($left, $right, $top, $bottom);
    gdk_window_set_shadow_width($!window, $l, $r, $t, $b);
  }

  method set_skip_pager_hint (gboolean $skips_pager)
    is also<set-skip-pager-hint>
  {
    gdk_window_set_skip_pager_hint($!window, $skips_pager);
  }

  method set_skip_taskbar_hint (gboolean $skips_taskbar)
    is also<set-skip-taskbar-hint>
  {
    gdk_window_set_skip_taskbar_hint($!window, $skips_taskbar);
  }

  method set_source_events (
    GdkInputSource $source,
    GdkEventMask $event_mask
  )
    is also<set-source-events>
  {
    gdk_window_set_source_events($!window, $source, $event_mask);
  }

  method set_startup_id (Str() $startup_id) is also<set-startup-id> {
    gdk_window_set_startup_id($!window, $startup_id);
  }

  method set_static_gravities (Int() $use_static)
    is also<set-static-gravities>
  {
    my gboolean $us = self.RESOLVE-BOOL($use_static);
    gdk_window_set_static_gravities($!window, $use_static);
  }

  method set_title (Str() $title) is also<set-title> {
    gdk_window_set_title($!window, $title);
  }

  method set_transient_for (GdkWindow() $parent) is also<set-transient-for> {
    gdk_window_set_transient_for($!window, $parent);
  }

  method set_urgency_hint (Int() $urgent) is also<set-urgency-hint> {
    my gboolean $u = self.RESOLVE-BOOL($urgent);
    gdk_window_set_urgency_hint($!window, $u);
  }

  method set_user_data (gpointer $user_data) is also<set-user-data> {
    gdk_window_set_user_data($!window, $user_data);
  }

  method shape_combine_region (
    cairo_region_t $shape_region,
    Int() $offset_x,
    Int() $offset_y
  )
    is also<shape-combine-region>
  {
    my gint ($ox, $oy) = self.RESOLVE-INT($offset_x, $offset_y);
    gdk_window_shape_combine_region($!window, $shape_region, $ox, $oy);
  }

  method show {
    gdk_window_show($!window);
  }

  method show_unraised is also<show-unraised> {
    gdk_window_show_unraised($!window);
  }

  method show_window_menu (GdkEvents() $event) is also<show-window-menu> {
    gdk_window_show_window_menu( $!window, nativecast(GdkEvent, $event) );
  }

  method stick {
    gdk_window_stick($!window);
  }

  method thaw_toplevel_updates_libgtk_only
    is also<thaw-toplevel-updates-libgtk-only>
  {
    gdk_window_thaw_toplevel_updates_libgtk_only($!window);
  }

  method thaw_updates is also<thaw-updates> {
    gdk_window_thaw_updates($!window);
  }

  method unfullscreen {
    gdk_window_unfullscreen($!window);
  }

  method unmaximize {
    gdk_window_unmaximize($!window);
  }

  method unstick {
    gdk_window_unstick($!window);
  }

  method withdraw {
    gdk_window_withdraw($!window);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method x11_get_server_time {
    gdk_x11_get_server_time($!window);
  }

  # Move to GTK::Compat::Display
  method x11_window_foreign_new_for_display (
    GdkDisplay() $display, 
    X11Window $window
  ) {
    GTK::Compat::Window.new( 
      gdk_x11_window_foreign_new_for_display($display, $window)
    );
  }

  method x11_window_get_desktop {
    gdk_x11_window_get_desktop($!window);
  }

  method x11_window_get_type {
    gdk_x11_window_get_type();
  }

  method x11_window_get_xid {
    gdk_x11_window_get_xid($!window);
  }

  # Should be moved to GTK::Compat::Display
  method x11_window_lookup_for_display (
    GdkDisplay() $display, 
    X11Window $win
  ) {
    gdk_x11_window_lookup_for_display($display, $win);
  }

  method x11_window_move_to_current_desktop {
    gdk_x11_window_move_to_current_desktop($!window);
  }

  method x11_window_move_to_desktop (Int() $desktop) {
    my guint $d = self.RESOLVE-UINT($desktop);
    gdk_x11_window_move_to_desktop($!window, $d);
  }

  method x11_window_set_frame_sync_enabled (Int() $frame_sync_enabled) {
    my gboolean $fse = self.RESOLVE-BOOL($frame_sync_enabled);
    gdk_x11_window_set_frame_sync_enabled($!window, $fse);
  }

  method x11_window_set_hide_titlebar_when_maximized (
    Int() $hide_titlebar_when_maximized
  ) {
    my gboolean $htwm = self.RESOLVE-BOOL($hide_titlebar_when_maximized);
    gdk_x11_window_set_hide_titlebar_when_maximized($!window, $htwm);
  }

  method x11_window_set_theme_variant (Str() $variant) {
    gdk_x11_window_set_theme_variant($!window, $variant);
  }

  method x11_window_set_user_time (Int() $timestamp) {
    my guint32 $t = self.RESOLVE-UINT($timestamp);
    gdk_x11_window_set_user_time($!window, $timestamp);
  }

  method x11_window_set_utf8_property (Str() $name, Str() $value) {
    gdk_x11_window_set_utf8_property($!window, $name, $value);
  }

}
