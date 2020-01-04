use v6.c;

use Method::Also;
use NativeCall;

use Cairo;

use GLib::Raw::Subs;

use GDK::Cursor;
use GDK::Raw::Types;
use GDK::RGBA;
use GDK::Raw::Window;
use GDK::Raw::X11_Window;
use GDK::X11_Types;

use GDK::Roles::Signals::Window;

class GDK::Window {
  also does GDK::Roles::Signals::Window;

  has GdkWindow $!window is implementor;

  submethod BUILD(:$window) {
    $!window = $window;
  }

  method GDK::Raw::Definitions::GdkWindow
    is also<
      gdkwindow
      GdkWindow
    >
  { $!window }

  multi method new (GdkWindow $window) {
    $window ?? self.bless(:$window) !! Nil;
  }
  multi method new (
    GdkWindow() $parent,
    GdkWindowAttr $attributes,
    Int() $attributes_mask
  ) {
    my gint $am = $attributes_mask;
    my $window = gdk_window_new($parent, $attributes, $am);

    $window ?? self.bless($window) !! Nil;
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
        my gboolean $af = $accept_focus.so.Int;

        gdk_window_set_accept_focus($!window, $af);
      }
    );
  }

  # SEVERELY DEPRECATED. Please remove immediately after initial release.
  method background_pattern is rw is also<background-pattern> {
    die qq:to/D/.chomp;
    GDK::Window.get/set_background_pattern is no longer {
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
        my gboolean $c = $composited.so.Int;

        gdk_window_set_composited($!window, $c);
      }
    );
  }

  method cursor (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $c = gdk_window_get_cursor($!window);

        $c ??
          ( $raw ?? $c !! GDK::Cursor.new($c) )
          !!
          Nil;
      },
      STORE => sub ($, GdkCursor() $cursor is copy) {
        my $c = gdk_window_get_cursor($!window);

        # The unref/ref logic that used to be here makes no sense:
        #
        # g_object_unref($c.p) if $c
        gdk_window_set_cursor($!window, $cursor);
        # g_object_ref($c.p);
      }
    );
  }

  method offscreen_window_embedder
    is rw
    is also<offscreen-window-embedder>
  {
    Proxy.new(
      FETCH => sub ($) {
        GDK::Window.new( gdk_offscreen_window_get_embedder($!window) );
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
        my gboolean $ec = $event_compression.so.Int;

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
        my guint $em = $event_mask;

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
        my gboolean $fom = $focus_on_map.so.Int;

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
        my guint $m = $mode;

        gdk_window_set_fullscreen_mode($!window, $m);
      }
    );
  }

  method group is rw {
    Proxy.new(
      FETCH => sub ($) {
        GDK::Window.new( gdk_window_get_group($!window) );
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
        my gboolean $m = $modal.so.Int;

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
        my gboolean $pt = $pass_through.so.Int;

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
        my gboolean $sm = $support_multidevice.so.Int;

        gdk_window_set_support_multidevice($!window, $sm);
      }
    );
  }

  method type_hint is rw is also<type-hint> {
    Proxy.new(
      FETCH => sub ($) {
        GdkWindowTypeHintEnum( gdk_window_get_type_hint($!window) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my guint $h = $hint;

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
    my gint ($wx, $wy) = ($win_x, $win_y);

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
    my gint ($b, $rx, $ry) = ($button, $root_x, $root_y);
    my guint $t = $timestamp;

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
    my gint ($b, $rx, $ry) = ($button, $root_x, $root_y);
    my guint $t = $timestamp;

    gdk_window_begin_move_drag_for_device(
      $!window, $device, $b, $rx, $ry, $t
    );
  }

  method begin_paint_rect (GdkRectangle() $rectangle)
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
    my gint ($b, $rx, $ry) = ($button, $root_x, $root_y);
    my guint ($e, $t) = $edge, $timestamp;

    gdk_window_begin_resize_drag($!window, $e, $b, $rx, $ry, $t);
  }

  method begin_resize_drag_for_device (
    Int() $edge,
    GdkDevice() $device,
    Int() $button,
    Int() $root_x,
    Int() $root_y,
    Int() $timestamp
  )
    is also<begin-resize-drag-for-device>
  {
    my GdkWindowEdge $e = $edge;
    my gint ($b, $rx, $ry) = $button, $root_x, $root_y;
    my guint $t = $timestamp;

    gdk_window_begin_resize_drag_for_device(
      $!window,
      $e,
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

  proto method constrain_size (|)
    is also<constrain-size>
  { * }

  multi method constrain_size (
    GdkGeometry $geometry,
    Int() $flags,
    Int() $width,
    Int() $height,
  ) {
    samewith($geometry, $flags, $width, $height, $, $);
  }
  multi method constrain_size (
    GdkGeometry $geometry,
    Int() $flags,
    Int() $width,
    Int() $height,
    $new_width  is rw,
    $new_height is rw
  ) {
    my GdkWindowHints $f = $flags;
    my gint ($w, $h, $nw, $nh) = ($width, $height, 0, 0);

    my $rc = gdk_window_constrain_size($geometry, $f, $w, $h, $nw, $nh);
    ($width, $height) = ($nw, $nh);
    ($rc, $width, $height);
  }

  proto method coords_from_parent (|)
    is also<coords-from-parent>
  { * }

  multi method coords_from_parent (Num() $parent_x, Num() $parent_y) {
    samewith($parent_x, $parent_y, $, $);
  }
  method coords_from_parent (
    Num() $parent_x,
    Num() $parent_y,
    $x is rw,
    $y is rw
  ) {
    my gdouble ($px, $py, $xx, $yy) = ($parent_x, $parent_y, 0, 0);
    my $rc = gdk_window_coords_from_parent($!window, $px, $py, $xx, $yy);

    ($rc, $x = $xx, $y = $yy);
  }

  proto method coords_to_parent (|)
    is also<coords-to-parent>
  { * }

  method coords_to_parent (
    Num() $x,
    Num() $y,
    $parent_x is rw,
    $parent_y is rw
  ) {
    my gdouble ($px, $py, $xx, $yy) = (0, 0, $x, $y);
    my $rc = gdk_window_coords_to_parent($!window, $xx, $yy, $px, $py);

    ($rc, $parent_x = $px, $parent_y = $py);
  }

  method create_gl_context (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-gl-context>
  {
    clear_error;
    my $rv = gdk_window_create_gl_context($!window, $error);
    set_error($error);
    $rv;
  }

  method create_similar_image_surface (
    Int() $format,
    Int() $width,
    Int() $height,
    Int() $scale
  )
    is also<create-similar-image-surface>
  {
    my guint $f = $format; # cairo_format_t
    my gint ($w, $h, $s) = ($width, $height, $scale);

    gdk_window_create_similar_image_surface($!window, $f, $w, $h, $s);
  }

  method create_similar_surface (
    Int() $content,
    Int() $width,
    Int() $height
  )
    is also<create-similar-surface>
  {
    my guint $c = $content;
    my gint ($w, $h) = ($w, $h);

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
    my guint $t = $timestamp;

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
    my gint $m = $monitor;

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
    samewith($device, $, $, $);
  }
  multi method get_device_position (
    GdkDevice() $device,
    $x    is rw,
    $y    is rw,
    $mask is rw             # GdkModifierType $mask
  ) {
    my gint ($xx, $yy) = 0 xx 2;
    my guint $m = 0;
    gdk_window_get_device_position($!window, $device, $xx, $yy, $m);
    ($x, $y, $mask) = ($xx, $yy, $m);
  }

  proto method get_device_position_double (|c)
    is also<get-device-position-double>
    { * }

  multi method get_device_position_double (
    GdkDevice() $device,
    :$raw = False
  ) {
    samewith($device, $, $, $, :$raw);
  }
  multi method get_device_position_double (
    GdkDevice() $device,
    $x    is rw,
    $y    is rw,
    $mask is rw             # GdkModifierType $mask
    :$raw = False
  ) {
    my guint $m = 0;
    my gdouble ($xx, $yy) = 0e0 xx 2
    my $w = gdk_window_get_device_position_double(
      $!window, $device, $xx, $yy, $m
    );

    $w = $raw ?? $w !! GDK::Window.new($w) if $w;
    ($w, $x = $xx, $y = $yy, $mask = $m)
  }

  method get_display (:$raw = False) is also<get-display> {
    my $d = gdk_window_get_display($!window);

    # Late binding to prevent circular reference.
    $d ??
      ( $raw ?? $d !! ::('GDK::Display').new($d) )
      !!
      Nil;
  }

  method get_drag_protocol (GdkWindow() $target) is also<get-drag-protocol> {
    GdkDragProtocolEnum( gdk_window_get_drag_protocol($!window, $target) );
  }

  method get_effective_parent (:$raw = False) is also<get-effective-parent> {
    my $w = gdk_window_get_effective_parent($!window);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  method get_effective_toplevel is also<get-effective-toplevel> {
    my $w = gdk_window_get_effective_toplevel($!window);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  method get_frame_clock is also<get-frame-clock> {
    gdk_window_get_frame_clock($!window);
  }

  method get_frame_extents (GdkRectangle() $rect) is also<get-frame-extents> {
    gdk_window_get_frame_extents($!window, $rect);
  }

  proto method get_geometry (|)
    is also<
      get-geometry
      geometry
    >
  { * }

  multi method get_geometry {
    samewith($, $, $, $)
  }
  method get_geometry (
    $x      is rw,
    $y      is rw,
    $width  is rw,
    $height is rw
  ) {
    my gint ($xx, $yy, $w, $h) = 0 xx 4;

    gdk_window_get_geometry($!window, $xx, $yy, $w, $h);
    ($x, $y, $width, $height) = ($xx, $yy, $w, $h);
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    gdk_window_get_height($!window);
  }

  proto method get_origin (|)
    is also<
      get-origin
      origin
    >
  { * }

  multi method get_origin {
    my ($x, $y) = (0, 0);
    samewith($x, $y);
  }
  multi method get_origin (Int() $x is rw, Int() $y is rw) {
    my gint ($xx, $yy) = $x, $y;
    my $rc = gdk_window_get_origin($!window, $xx, $yy);

    ($rc, $x = $xx, $y = $yy);
  }

  method get_parent (:$raw = False)
    is also<
      get-parent
      parent
    >
  {
    my $w = gdk_window_get_parent($!window);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil;
  }

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position {
    samewith($, $);
  }
  multi method get_position ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;
    my $rc = gdk_window_get_position($!window, $xx, $yy);

    ($rc, $x = $xx, $y = $yy);
  }

  proto method get_root_coords (|)
    is also<get-root-coords>
  { * }

  multi method get_root_coords (Int() $x, Int() $y) {
    samewith($x, $y, $, $);
  }
  multi method get_root_coords (
    Int() $x,
    Int() $y,
    $root_x is rw,
    $root_y is rw
  ) {
    my gint ($xx, $yy, $rx, $ry) = ($x, $y, 0, 0);
    my $rc = gdk_window_get_root_coords($!window, $xx, $yy, $rx, $ry);

    ($rc, $root_x = $rx, $root_y = $ry)
  }

  proto method get_root_origin (|)
    is also<get-root-origin>
  { * }

  multi method get_root_origin {
    samewith($, $);
  }
  multi method get_root_origin ($x is rw, $y is rw) {
    my gint ($xx, $yy) = 0 xx 2;
    my $rc = gdk_window_get_root_origin($!window, $xx, $yy);

    ($rc, $x = $xx, $y = $yy);
  }

  method get_scale_factor is also<get-scale-factor> {
    gdk_window_get_scale_factor($!window);
  }

  method get_screen (:$raw = False) is also<get-screen> {
    my $s = gdk_window_get_screen($!window);

    $s ??
      ( $raw ?? $s !! GDK::Screen.new($s) )
      !!
      Nil;
  }

  method get_source_events (Int() $source)
    is also<get-source-events>
  {
    my GdkInputSource $s = $source;

    GdkEventMaskEnum( gdk_window_get_source_events($!window, $s) );
  }

  method get_state is also<get-state> {
    GdkWindowStateEnum( gdk_window_get_state($!window) );
  }

  method get_toplevel (:$raw = False) is also<get-toplevel> {
    my $w = gdk_window_get_toplevel($!window);

    $w ??
      ( $raw ?? $w !! GDK::Window.new($w) )
      !!
      Nil
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_window_get_type, $n, $t );
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

  method get_visual (:$raw = False) is also<get-visual> {
    my $v = gdk_window_get_visual($!window);

    $v ??
      ( $raw ?? $v !! GDK::Visual.new($v) )
      !!
      Nil;
  }

  method get_width is also<get-width width> {
    gdk_window_get_width($!window);
  }

  method get_window_type is also<get-window-type> {
    GdkWindowTypeEnum( gdk_window_get_window_type($!window) );
  }

  method has_native is also<has-native> {
    so gdk_window_has_native($!window);
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
    my gint ($ox, $oy) = ($offset_x, $offset_y);

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
    gpointer $user_data = gpointer
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
    GdkRectangle() $rect,
    Int() $invalidate_children
  )
    is also<invalidate-rect>
  {
    my gboolean $i = $invalidate_children.so.Int;

    gdk_window_invalidate_rect($!window, $rect, $i);
  }

  method invalidate_region (
    cairo_region_t $region,
    Int() $invalidate_children
  )
    is also<invalidate-region>
  {
    my gboolean $ic = $invalidate_children.so.Int;

    gdk_window_invalidate_region($!window, $region, $ic);
  }

  method is_destroyed is also<is-destroyed> {
    so gdk_window_is_destroyed($!window);
  }

  method is_input_only is also<is-input-only> {
    so gdk_window_is_input_only($!window);
  }

  method is_shaped is also<is-shaped> {
    so gdk_window_is_shaped($!window);
  }

  method is_viewable is also<is-viewable> {
    so gdk_window_is_viewable($!window);
  }

  method is_visible is also<is-visible> {
    so gdk_window_is_visible($!window);
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
    my gint ($xx, $yy) = ($x, $y);

    gdk_window_move($!window, $xx, $yy);
  }

  method move_region (cairo_region_t $region, Int() $dx, Int() $dy)
    is also<move-region>
  {
    my gint ($dxx, $dyy) = ($dx, $dy);

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
    my gint ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    gdk_window_move_resize($!window, $xx, $yy, $w, $h);
  }

  method move_to_rect (
    GdkRectangle() $rect,
    Int() $rect_anchor,
    Int() $window_anchor,
    Int() $anchor_hints,
    Int() $rect_anchor_dx,
    Int() $rect_anchor_dy
  )
    is also<move-to-rect>
  {
    my guint ($ra, $wa, $ah) = ($rect_anchor, $window_anchor, $anchor_hints);
    my gint ($rax, $ray) = $rect_anchor_dx, $rect_anchor_dy;

    gdk_window_move_to_rect($!window, $rect, $ra, $wa, $ah, $rax, $ray);
  }

  method peek_children (:$glist = False, :$raw = False)
    is also<peek-children>
  {
    my $cl = gdk_window_peek_children($!window);

    return Nil unless $cl;
    return $cl if $glist;

    $cl = GLib::GList.new($cl) but GLib::Roles::ListData[GdkWindow];
    $raw ?? $cl.Array !! $cl.Array.map({ GDK::Window.new($_) });
  }

  method raise {
    gdk_window_raise($!window);
  }

  method register_dnd is also<register-dnd> {
    gdk_window_register_dnd($!window);
  }

  method remove_filter (
    GdkFilterFunc $function,
    gpointer $data = gpointer
  )
    is also<remove-filter>
  {
    gdk_window_remove_filter($!window, $function, $data);
  }

  method reparent (
    GdkWindow() $new_parent,
    Int() $x,
    Int() $y
  ) {
    my gint ($xx, $yy) = ($x, $y);

    gdk_window_reparent($!window, $new_parent, $xx, $yy);
  }

  method resize (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gdk_window_resize($!window, $w, $h);
  }

  method restack (GdkWindow() $sibling, Int() $above) {
    my gboolean $a = $above.so.Int;

    gdk_window_restack($!window, $sibling, $a);
  }

  method scroll (Int() $dx, Int() $dy) {
    my gint ($dxx, $dyy) = ($dx, $dy);

    gdk_window_scroll($!window, $dxx, $dyy);
  }

  method set_child_input_shapes is also<set-child-input-shapes> {
    gdk_window_set_child_input_shapes($!window);
  }

  method set_child_shapes is also<set-child-shapes> {
    gdk_window_set_child_shapes($!window);
  }

  method set_decorations (Int() $decorations)
    is also<set-decorations>
  {
    my GdkWMDecoration $d = $decorations;

    gdk_window_set_decorations($!window, $d);
  }

  method set_device_cursor (GdkDevice() $device, GdkCursor() $cursor)
    is also<set-device-cursor>
  {
    gdk_window_set_device_cursor($!window, $device, $cursor);
  }

  method set_device_events (GdkDevice() $device, Int() $event_mask)
    is also<set-device-events>
  {
    my guint $m = $event_mask;

    gdk_window_set_device_events($!window, $device, $m);
  }

  method set_functions (Int() $functions) is also<set-functions> {
    my GdkWMFunction $f = $functions;

    gdk_window_set_functions($!window, $f);
  }

  method set_geometry_hints (
    GdkGeometry $geometry,
    Int() $geom_mask
  )
    is also<set-geometry-hints>
  {
    my guint $m = $geom_mask;

    gdk_window_set_geometry_hints($!window, $geometry, $m);
  }

  proto method set_icon_list (|)
    is also<set-icon-list>
  { * }

  multi method set_icon_list (@pixbufs) {
    @pixbufs .= map({
      if $_ ~~ GdkPixbuf {
        $_;
      } elsif .^can('GdkPixbuf').elems {
        .GdkPixbuf
      } else {
        die '@pixbufs can only contain GdkPixbuf-compatible items';
      }
    });
    samewith( GLib::GList.new(@pixbufs) );
  }
  multi method set_icon_list (GList() $pixbufs)  {
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
    my gboolean $s = $setting.so.Int;

    gdk_window_set_keep_above($!window, $s);
  }

  method set_keep_below (Int() $setting) is also<set-keep-below> {
    my gboolean $s = $setting.so.Int;

    gdk_window_set_keep_below($!window, $s);
  }

  method set_opacity (Num() $opacity) is also<set-opacity> {
    my gdouble $o = $opacity;

    gdk_window_set_opacity($!window, $o);
  }

  method set_opaque_region (cairo_region_t $region)
    is also<set-opaque-region>
  {
    gdk_window_set_opaque_region($!window, $region);
  }

  method set_override_redirect (Int() $override_redirect)
    is also<set-override-redirect>
  {
    my gboolean $or = $override_redirect.so.Int;

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
    my gint ($l, $r, $t, $b) = ($left, $right, $top, $bottom);

    gdk_window_set_shadow_width($!window, $l, $r, $t, $b);
  }

  method set_skip_pager_hint (Int() $skips_pager)
    is also<set-skip-pager-hint>
  {
    my gboolean $s = $skips_pager.so.Int;

    gdk_window_set_skip_pager_hint($!window, $s);
  }

  method set_skip_taskbar_hint (Int() $skips_taskbar)
    is also<set-skip-taskbar-hint>
  {
    my gboolean $s = $skips_taskbar.so.Int;

    gdk_window_set_skip_taskbar_hint($!window, $s);
  }

  method set_source_events (
    Int() $source,
    Int() $event_mask
  )
    is also<set-source-events>
  {
    my GdkInputSource $s = $source;
    my GdkEventMask $e = $event_mask;

    gdk_window_set_source_events($!window, $s, $e);
  }

  method set_startup_id (Str() $startup_id) is also<set-startup-id> {
    gdk_window_set_startup_id($!window, $startup_id);
  }

  method set_static_gravities (Int() $use_static)
    is also<set-static-gravities>
  {
    my gboolean $us = $use_static.so.Int;

    gdk_window_set_static_gravities($!window, $us);
  }

  method set_title (Str() $title) is also<set-title> {
    gdk_window_set_title($!window, $title);
  }

  method set_transient_for (GdkWindow() $parent) is also<set-transient-for> {
    gdk_window_set_transient_for($!window, $parent);
  }

  method set_urgency_hint (Int() $urgent) is also<set-urgency-hint> {
    my gboolean $u = $urgent.so.Int;

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
    my gint ($ox, $oy) = ($offset_x, $offset_y);

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

  method x11_get_server_time is also<x11-get-server-time> {
    gdk_x11_get_server_time($!window);
  }

  method x11_get_desktop is also<x11-get-desktop> {
    gdk_x11_window_get_desktop($!window);
  }

  method x11_get_type is also<x11-get-type> {
    gdk_x11_window_get_type();
  }

  method x11_get_xid is also<x11-get-xid> {
    gdk_x11_window_get_xid($!window);
  }

  method x11_move_to_current_desktop is also<x11-move-to-current-desktop> {
    gdk_x11_window_move_to_current_desktop($!window);
  }

  method x11_move_to_desktop (Int() $desktop) is also<x11-move-to-desktop> {
    my guint $d = $desktop;

    gdk_x11_window_move_to_desktop($!window, $d);
  }

  method x11_set_frame_sync_enabled (Int() $frame_sync_enabled)
    is also<x11-set-frame-sync-enabled>
  {
    my gboolean $fse = $frame_sync_enabled;

    gdk_x11_window_set_frame_sync_enabled($!window, $fse);
  }

  method x11_set_hide_titlebar_when_maximized (
    Int() $hide_titlebar_when_maximized
  )
    is also<x11-set-hide-titlebar-when-maximized>
  {
    my gboolean $htwm = $hide_titlebar_when_maximized;

    gdk_x11_window_set_hide_titlebar_when_maximized($!window, $htwm);
  }

  method x11_set_theme_variant (Str() $variant)
    is also<x11-set-theme-variant>
  {
    gdk_x11_window_set_theme_variant($!window, $variant);
  }

  method x11_set_user_time (Int() $timestamp) is also<x11-set-user-time> {
    my guint32 $t = $timestamp;

    gdk_x11_window_set_user_time($!window, $timestamp);
  }

  method x11_set_utf8_property (Str() $name, Str() $value)
    is also<x11-set-utf8-property>
  {
    gdk_x11_window_set_utf8_property($!window, $name, $value);
  }

}
