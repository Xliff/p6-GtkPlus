use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::RGBA;
use GTK::Compat::Raw::Window;

use GTK::Compat::Roles::Signals::Window;

class GTK::Compat::Window {
  also does GTK::Compat::Roles::Signals::Window;

  has GdkWindow $!window;

  submethod BUILD(:$window) {
    $!window
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
    self.connect-from-embedder($!window, 'from-embedder');
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
    self.connect-to-embedder($!window, 'to-embedder');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method accept_focus is rw is also<accept-focus> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_accept_focus($!window);
      },
      STORE => sub ($, $accept_focus is copy) {
        gdk_window_set_accept_focus($!window, $accept_focus);
      }
    );
  }

  method background_pattern is rw is also<background-pattern> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_background_pattern($!window);
      },
      STORE => sub ($, $pattern is copy) {
        gdk_window_set_background_pattern($!window, $pattern);
      }
    );
  }

  method composited is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_composited($!window);
      },
      STORE => sub ($, $composited is copy) {
        gdk_window_set_composited($!window, $composited);
      }
    );
  }

  method cursor is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_cursor($!window);
      },
      STORE => sub ($, $cursor is copy) {
        gdk_window_set_cursor($!window, $cursor);
      }
    );
  }

  method offscreen_window_embedder
    is rw
    is also<offscreen-window-embedder>
  {
    Proxy.new(
      FETCH => sub ($) {
        gdk_offscreen_window_get_embedder($!window);
      },
      STORE => sub ($, $embedder is copy) {
        gdk_offscreen_window_set_embedder($!window, $embedder);
      }
    );
  }

  method event_compression is rw is also<event-compression> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_event_compression($!window);
      },
      STORE => sub ($, $event_compression is copy) {
        gdk_window_set_event_compression($!window, $event_compression);
      }
    );
  }

  method events is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_events($!window);
      },
      STORE => sub ($, $event_mask is copy) {
        gdk_window_set_events($!window, $event_mask);
      }
    );
  }

  method focus_on_map is rw is also<focus-on-map> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_focus_on_map($!window);
      },
      STORE => sub ($, $focus_on_map is copy) {
        gdk_window_set_focus_on_map($!window, $focus_on_map);
      }
    );
  }

  method fullscreen_mode is rw is also<fullscreen-mode> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_fullscreen_mode($!window);
      },
      STORE => sub ($, $mode is copy) {
        gdk_window_set_fullscreen_mode($!window, $mode);
      }
    );
  }

  method group is rw {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_group($!window);
      },
      STORE => sub ($, $leader is copy) {
        gdk_window_set_group($!window, $leader);
      }
    );
  }

  method modal_hint is rw is also<modal-hint> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_modal_hint($!window);
      },
      STORE => sub ($, $modal is copy) {
        gdk_window_set_modal_hint($!window, $modal);
      }
    );
  }

  method pass_through is rw is also<pass-through> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_pass_through($!window);
      },
      STORE => sub ($, $pass_through is copy) {
        gdk_window_set_pass_through($!window, $pass_through);
      }
    );
  }

  method support_multidevice is rw is also<support-multidevice> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_support_multidevice($!window);
      },
      STORE => sub ($, $support_multidevice is copy) {
        gdk_window_set_support_multidevice($!window, $support_multidevice);
      }
    );
  }

  method type_hint is rw is also<type-hint> {
    Proxy.new(
      FETCH => sub ($) {
        gdk_window_get_type_hint($!window);
      },
      STORE => sub ($, $hint is copy) {
        gdk_window_set_type_hint($!window, $hint);
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

  method at_pointer (gint $win_y) is also<at-pointer> {
    gdk_window_at_pointer($!window, $win_y);
  }

  method beep {
    gdk_window_beep($!window);
  }

  method begin_draw_frame (cairo_region_t $region) is also<begin-draw-frame> {
    gdk_window_begin_draw_frame($!window, $region);
  }

  method begin_move_drag (
    gint $button,
    gint $root_x,
    gint $root_y,
    guint $timestamp
  )
    is also<begin-move-drag>
  {
    gdk_window_begin_move_drag(
      $!window,
      $button,
      $root_x,
      $root_y,
      $timestamp
    );
  }

  method begin_move_drag_for_device (
    GdkDevice $device,
    gint $button,
    gint $root_x,
    gint $root_y,
    guint $timestamp
  )
    is also<begin-move-drag-for-device>
  {
    gdk_window_begin_move_drag_for_device(
      $!window,
      $device,
      $button,
      $root_x,
      $root_y,
      $timestamp
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
    GdkWindowEdge $edge,
    gint $button,
    gint $root_x,
    gint $root_y,
    guint $timestamp
  )
    is also<begin-resize-drag>
  {
    gdk_window_begin_resize_drag(
      $!window,
      $edge,
      $button,
      $root_x,
      $root_y,
      $timestamp
    );
  }

  method begin_resize_drag_for_device (
    GdkWindowEdge $edge,
    GdkDevice $device,
    gint $button,
    gint $root_x,
    gint $root_y,
    guint $timestamp
  )
    is also<begin-resize-drag-for-device>
  {
    gdk_window_begin_resize_drag_for_device(
      $!window,
      $edge,
      $device,
      $button,
      $root_x,
      $root_y,
      $timestamp
    );
  }

  method configure_finished is also<configure-finished> {
    gdk_window_configure_finished($!window);
  }

  method constrain_size (
    GdkGeometry $geometry,
    GdkWindowHints $flags,
    gint $width,
    gint $height,
    gint $new_width,
    gint $new_height
  )
    is also<constrain-size>
  {
    gdk_window_constrain_size(
      $geometry,
      $flags,
      $width,
      $height,
      $new_width,
      $new_height
    );
  }

  method coords_from_parent (
    gdouble $parent_x,
    gdouble $parent_y,
    gdouble $x,
    gdouble $y
  )
    is also<coords-from-parent>
  {
    gdk_window_coords_from_parent($!window, $parent_x, $parent_y, $x, $y);
  }

  method coords_to_parent (
    gdouble $x,
    gdouble $y,
    gdouble $parent_x,
    gdouble $parent_y
  )
    is also<coords-to-parent>
  {
    gdk_window_coords_to_parent($!window, $x, $y, $parent_x, $parent_y);
  }

  method create_gl_context (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-gl-context>
  {
    gdk_window_create_gl_context($!window, $error);
  }

  method create_similar_image_surface (
    cairo_format_t $format,
    gint $width,
    gint $height,
    gint $scale
  )
    is also<create-similar-image-surface>
  {
    gdk_window_create_similar_image_surface(
      $!window,
      $format,
      $width,
      $height,
      $scale
    );
  }

  method create_similar_surface (
    cairo_content_t $content,
    gint $width,
    gint $height
  )
    is also<create-similar-surface>
  {
    gdk_window_create_similar_surface($!window, $content, $width, $height);
  }

  method deiconify {
    gdk_window_deiconify($!window);
  }

  method destroy {
    gdk_window_destroy($!window);
  }

  method enable_synchronized_configure is also<enable-synchronized-configure> {
    gdk_window_enable_synchronized_configure($!window);
  }

  method end_draw_frame (GdkDrawingContext $context) is also<end-draw-frame> {
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

  method focus (guint $timestamp) {
    gdk_window_focus($!window, $timestamp);
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

  method fullscreen_on_monitor (gint $monitor)
    is also<fullscreen-on-monitor>
  {
    gdk_window_fullscreen_on_monitor($!window, $monitor);
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

  method get_device_cursor (GdkDevice $device) is also<get-device-cursor> {
    gdk_window_get_device_cursor($!window, $device);
  }

  method get_device_events (GdkDevice $device) is also<get-device-events> {
    gdk_window_get_device_events($!window, $device);
  }

  method get_device_position (
    GdkDevice $device,
    gint $x,
    gint $y,
    GdkModifierType $mask
  )
    is also<get-device-position>
  {
    gdk_window_get_device_position($!window, $device, $x, $y, $mask);
  }

  method get_device_position_double (
    GdkDevice $device,
    gdouble $x,
    gdouble $y,
    GdkModifierType $mask
  )
    is also<get-device-position-double>
  {
    gdk_window_get_device_position_double($!window, $device, $x, $y, $mask);
  }

  method get_display is also<get-display> {
    gdk_window_get_display($!window);
  }

  method get_drag_protocol (GdkWindow $target) is also<get-drag-protocol> {
    gdk_window_get_drag_protocol($!window, $target);
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

  method get_geometry (gint $x, gint $y, gint $width, gint $height)
    is also<get-geometry>
  {
    gdk_window_get_geometry($!window, $x, $y, $width, $height);
  }

  method get_height is also<get-height> {
    gdk_window_get_height($!window);
  }

  method get_origin (gint $x, gint $y) is also<get-origin> {
    gdk_window_get_origin($!window, $x, $y);
  }

  method get_parent is also<get-parent> {
    gdk_window_get_parent($!window);
  }

  method get_pointer (gint $x, gint $y, GdkModifierType $mask)
    is also<get-pointer>
  {
    gdk_window_get_pointer($!window, $x, $y, $mask);
  }

  method get_position (gint $x, gint $y) is also<get-position> {
    gdk_window_get_position($!window, $x, $y);
  }

  method get_root_coords (gint $x, gint $y, gint $root_x, gint $root_y)
    is also<get-root-coords>
  {
    gdk_window_get_root_coords($!window, $x, $y, $root_x, $root_y);
  }

  method get_root_origin (gint $x, gint $y) is also<get-root-origin> {
    gdk_window_get_root_origin($!window, $x, $y);
  }

  method get_scale_factor is also<get-scale-factor> {
    gdk_window_get_scale_factor($!window);
  }

  method get_screen is also<get-screen> {
    gdk_window_get_screen($!window);
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

  method get_width is also<get-width> {
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
    gint $offset_x,
    gint $offset_y
  )
    is also<input-shape-combine-region>
  {
    gdk_window_input_shape_combine_region(
      $!window,
      $shape_region,
      $offset_x,
      $offset_y
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
    gboolean $invalidate_children
  )
    is also<invalidate-region>
  {
    gdk_window_invalidate_region($!window, $region, $invalidate_children);
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

  method move (gint $x, gint $y) {
    gdk_window_move($!window, $x, $y);
  }

  method move_region (cairo_region_t $region, gint $dx, gint $dy)
    is also<move-region>
  {
    gdk_window_move_region($!window, $region, $dx, $dy);
  }

  method move_resize (gint $x, gint $y, gint $width, gint $height)
    is also<move-resize>
  {
    gdk_window_move_resize($!window, $x, $y, $width, $height);
  }

  method move_to_rect (
    GdkRectangle $rect,
    GdkGravity $rect_anchor,
    GdkGravity $window_anchor,
    GdkAnchorHints $anchor_hints,
    gint $rect_anchor_dx,
    gint $rect_anchor_dy
  )
    is also<move-to-rect>
  {
    gdk_window_move_to_rect(
      $!window,
      $rect,
      $rect_anchor,
      $window_anchor,
      $anchor_hints,
      $rect_anchor_dx,
      $rect_anchor_dy
    );
  }

  method new (GdkWindowAttr $attributes, gint $attributes_mask) {
    gdk_window_new($!window, $attributes, $attributes_mask);
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

  method reparent (GdkWindow $new_parent, gint $x, gint $y) {
    gdk_window_reparent($!window, $new_parent, $x, $y);
  }

  method resize (gint $width, gint $height) {
    gdk_window_resize($!window, $width, $height);
  }

  method restack (GdkWindow $sibling, gboolean $above) {
    gdk_window_restack($!window, $sibling, $above);
  }

  method scroll (gint $dx, gint $dy) {
    gdk_window_scroll($!window, $dx, $dy);
  }

  method set_background (GdkColor $color) is also<set-background> {
    gdk_window_set_background($!window, $color);
  }

  method set_background_rgba (GTK::Compat::RGBA $rgba)
    is also<set-background-rgba>
  {
    gdk_window_set_background_rgba($!window, $rgba);
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

  method set_device_cursor (GdkDevice $device, GdkCursor $cursor)
    is also<set-device-cursor>
  {
    gdk_window_set_device_cursor($!window, $device, $cursor);
  }

  method set_device_events (GdkDevice $device, GdkEventMask $event_mask)
    is also<set-device-events>
  {
    gdk_window_set_device_events($!window, $device, $event_mask);
  }

  method set_functions (GdkWMFunction $functions) is also<set-functions> {
    gdk_window_set_functions($!window, $functions);
  }

  method set_geometry_hints (
    GdkGeometry $geometry,
    GdkWindowHints $geom_mask
  )
    is also<set-geometry-hints>
  {
    gdk_window_set_geometry_hints($!window, $geometry, $geom_mask);
  }

  method set_icon_list (GList $pixbufs) is also<set-icon-list> {
    gdk_window_set_icon_list($!window, $pixbufs);
  }

  method set_icon_name (gchar $name) is also<set-icon-name> {
    gdk_window_set_icon_name($!window, $name);
  }

  method set_invalidate_handler (GdkWindowInvalidateHandlerFunc $handler)
    is also<set-invalidate-handler>
  {
    gdk_window_set_invalidate_handler($!window, $handler);
  }

  method set_keep_above (gboolean $setting) is also<set-keep-above> {
    gdk_window_set_keep_above($!window, $setting);
  }

  method set_keep_below (gboolean $setting) is also<set-keep-below> {
    gdk_window_set_keep_below($!window, $setting);
  }

  method set_opacity (gdouble $opacity) is also<set-opacity> {
    gdk_window_set_opacity($!window, $opacity);
  }

  method set_opaque_region (cairo_region_t $region) is also<set-opaque-region> {
    gdk_window_set_opaque_region($!window, $region);
  }

  method set_override_redirect (gboolean $override_redirect)
    is also<set-override-redirect>
  {
    gdk_window_set_override_redirect($!window, $override_redirect);
  }

  method set_role (gchar $role) is also<set-role> {
    gdk_window_set_role($!window, $role);
  }

  method set_shadow_width (
    gint $left,
    gint $right,
    gint $top,
    gint $bottom
  )
    is also<set-shadow-width>
  {
    gdk_window_set_shadow_width($!window, $left, $right, $top, $bottom);
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

  method set_startup_id (gchar $startup_id) is also<set-startup-id> {
    gdk_window_set_startup_id($!window, $startup_id);
  }

  method set_static_gravities (gboolean $use_static)
    is also<set-static-gravities>
  {
    gdk_window_set_static_gravities($!window, $use_static);
  }

  method set_title (gchar $title) is also<set-title> {
    gdk_window_set_title($!window, $title);
  }

  method set_transient_for (GdkWindow $parent) is also<set-transient-for> {
    gdk_window_set_transient_for($!window, $parent);
  }

  method set_urgency_hint (gboolean $urgent) is also<set-urgency-hint> {
    gdk_window_set_urgency_hint($!window, $urgent);
  }

  method set_user_data (gpointer $user_data) is also<set-user-data> {
    gdk_window_set_user_data($!window, $user_data);
  }

  method shape_combine_region (
    cairo_region_t $shape_region,
    gint $offset_x,
    gint $offset_y
  )
    is also<shape-combine-region>
  {
    gdk_window_shape_combine_region(
      $!window,
      $shape_region,
      $offset_x,
      $offset_y
    );
  }

  method show {
    gdk_window_show($!window);
  }

  method show_unraised is also<show-unraised> {
    gdk_window_show_unraised($!window);
  }

  method show_window_menu (GdkEvent $event) is also<show-window-menu> {
    gdk_window_show_window_menu($!window, $event);
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

}
