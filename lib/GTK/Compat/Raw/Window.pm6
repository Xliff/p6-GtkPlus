use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Compat::Raw::Window;

sub gdk_window_add_filter (
  GdkWindow $window,
  GdkFilterFunc $function,
  gpointer $data
)
  is native(gdk)
  is export
  { * }

sub gdk_window_at_pointer (gint $win_x, gint $win_y)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_beep (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_draw_frame (GdkWindow $window, cairo_region_t $region)
  returns GdkDrawingContext
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_move_drag (
  GdkWindow $window,
  gint $button,
  gint $root_x,
  gint $root_y,
  guint32 $timestamp
)
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_move_drag_for_device (
  GdkWindow $window,
  GdkDevice $device,
  gint $button,
  gint $root_x,
  gint $root_y,
  guint32 $timestamp
)
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_paint_rect (GdkWindow $window, GdkRectangle $rectangle)
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_paint_region (GdkWindow $window, cairo_region_t $region)
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_resize_drag (
  GdkWindow $window,
  uint32 $edge,                   # GdkWindowEdge $edge,
  gint $button,
  gint $root_x,
  gint $root_y,
  guint32 $timestamp
)
  is native(gdk)
  is export
  { * }

sub gdk_window_begin_resize_drag_for_device (
  GdkWindow $window,
  uint32 $edge,                   # GdkWindowEdge $edge,
  GdkDevice $device,
  gint $button,
  gint $root_x,
  gint $root_y,
  guint32 $timestamp
)
  is native(gdk)
  is export
  { * }

sub gdk_window_configure_finished (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_constrain_size (
  GdkGeometry $geometry,
  uint32 $flags,                  #GdkWindowHints
  gint $width,
  gint $height,
  gint $new_width,
  gint $new_height
)
  is native(gdk)
  is export
  { * }

sub gdk_window_coords_from_parent (
  GdkWindow $window,
  gdouble $parent_x,
  gdouble $parent_y,
  gdouble $x,
  gdouble $y
)
  is native(gdk)
  is export
  { * }

sub gdk_window_coords_to_parent (
  GdkWindow $window,
  gdouble $x,
  gdouble $y,
  gdouble $parent_x,
  gdouble $parent_y
)
  is native(gdk)
  is export
  { * }

sub gdk_window_create_gl_context (
  GdkWindow $window,
  CArray[Pointer[GError]] $error
)
  returns GdkGLContext
  is native(gdk)
  is export
  { * }

sub gdk_window_create_similar_image_surface (
  GdkWindow $window,
  uint32 $format,                 # cairo_format_t $format,
  gint $width,
  gint $height,
  gint $scale
)
  returns cairo_surface_t
  is native(gdk)
  is export
  { * }

sub gdk_window_create_similar_surface (
  GdkWindow $window,
  cairo_content_t $content,
  gint $width,
  gint $height
)
  returns cairo_surface_t
  is native(gdk)
  is export
  { * }

sub gdk_window_deiconify (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_destroy (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_enable_synchronized_configure (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_end_draw_frame (GdkWindow $window, GdkDrawingContext $context)
  is native(gdk)
  is export
  { * }

sub gdk_window_end_paint (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_ensure_native (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_flush (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_focus (GdkWindow $window, guint32 $timestamp)
  is native(gdk)
  is export
  { * }

sub gdk_window_freeze_toplevel_updates_libgtk_only (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_freeze_updates (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_fullscreen (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_fullscreen_on_monitor (GdkWindow $window, gint $monitor)
  is native(gdk)
  is export
  { * }

sub gdk_get_default_root_window ()
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_offscreen_window_get_surface (GdkWindow $window)
  returns cairo_surface_t
  is native(gdk)
  is export
  { * }

sub gdk_window_geometry_changed (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_children (GdkWindow $window)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_window_get_children_with_user_data (
  GdkWindow $window,
  gpointer $user_data
)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_window_get_clip_region (GdkWindow $window)
  returns cairo_region_t
  is native(gdk)
  is export
  { * }

sub gdk_window_get_decorations (
  GdkWindow $window,
  uint32 $decoorations            # GdkWMDecoration $decorations
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_device_cursor (GdkWindow $window, GdkDevice $device)
  returns GdkCursor
  is native(gdk)
  is export
  { * }

sub gdk_window_get_device_events (GdkWindow $window, GdkDevice $device)
  returns uint32 # GdkEventMask
  is native(gdk)
  is export
  { * }

sub gdk_window_get_device_position (
  GdkWindow $window,
  GdkDevice $device,
  gint $x,
  gint $y,
  uint32 $mask                    # GdkModifierType $mask
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_device_position_double (
  GdkWindow $window,
  GdkDevice $device,
  gdouble $x,
  gdouble $y,
  uint32 $mask                    # GdkModifierType $mask
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_display (GdkWindow $window)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_window_get_drag_protocol (GdkWindow $window, GdkWindow $target)
  returns GdkDragProtocol
  is native(gdk)
  is export
  { * }

sub gdk_window_get_effective_parent (GdkWindow $window)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_effective_toplevel (GdkWindow $window)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_frame_clock (GdkWindow $window)
  returns GdkFrameClock
  is native(gdk)
  is export
  { * }

sub gdk_window_get_frame_extents (GdkWindow $window, GdkRectangle $rect)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_geometry (
  GdkWindow $window,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_height (GdkWindow $window)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_window_get_origin (GdkWindow $window, gint $x, gint $y)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_window_get_parent (GdkWindow $window)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_pointer (
  GdkWindow $window,
  gint $x,
  gint $y,
  uint32 $mask                    # GdkModifierType $mask
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_position (GdkWindow $window, gint $x, gint $y)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_root_coords (
  GdkWindow $window,
  gint $x,
  gint $y,
  gint $root_x,
  gint $root_y
)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_root_origin (GdkWindow $window, gint $x, gint $y)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_scale_factor (GdkWindow $window)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_window_get_screen (GdkWindow $window)
  returns GdkScreen
  is native(gdk)
  is export
  { * }

sub gdk_window_get_source_events (GdkWindow $window, GdkInputSource $source)
  returns uint32 # GdkEventMask
  is native(gdk)
  is export
  { * }

sub gdk_window_get_state (GdkWindow $window)
  returns uint32 # GdkWindowState
  is native(gdk)
  is export
  { * }

sub gdk_window_get_toplevel (GdkWindow $window)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_window_get_update_area (GdkWindow $window)
  returns cairo_region_t
  is native(gdk)
  is export
  { * }

sub gdk_window_get_user_data (GdkWindow $window, gpointer $data)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_visible_region (GdkWindow $window)
  returns cairo_region_t
  is native(gdk)
  is export
  { * }

sub gdk_window_get_visual (GdkWindow $window)
  returns GdkVisual
  is native(gdk)
  is export
  { * }

sub gdk_window_get_width (GdkWindow $window)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_window_get_window_type (GdkWindow $window)
  returns uint32 # GdkWindowType
  is native(gdk)
  is export
  { * }

sub gdk_window_has_native (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_hide (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_iconify (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_input_shape_combine_region (
  GdkWindow $window,
  cairo_region_t $shape_region,
  gint $offset_x,
  gint $offset_y
)
  is native(gdk)
  is export
  { * }

sub gdk_window_invalidate_maybe_recurse (
  GdkWindow $window,
  cairo_region_t $region,
  GdkWindowChildFunc $child_func,
  gpointer $user_data
)
  is native(gdk)
  is export
  { * }

sub gdk_window_invalidate_rect (
  GdkWindow $window,
  GdkRectangle $rect,
  gboolean $invalidate_children
)
  is native(gdk)
  is export
  { * }

sub gdk_window_invalidate_region (
  GdkWindow $window,
  cairo_region_t $region,
  gboolean $invalidate_children
)
  is native(gdk)
  is export
  { * }

sub gdk_window_is_destroyed (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_is_input_only (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_is_shaped (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_is_viewable (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_is_visible (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_lower (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_mark_paint_from_clip (GdkWindow $window, cairo_t $cr)
  is native(gdk)
  is export
  { * }

sub gdk_window_maximize (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_merge_child_input_shapes (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_merge_child_shapes (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_move (GdkWindow $window, gint $x, gint $y)
  is native(gdk)
  is export
  { * }

sub gdk_window_move_region (
  GdkWindow $window,
  cairo_region_t $region,
  gint $dx,
  gint $dy
)
  is native(gdk)
  is export
  { * }

sub gdk_window_move_resize (
  GdkWindow $window,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(gdk)
  is export
  { * }

sub gdk_window_move_to_rect (
  GdkWindow $window,
  GdkRectangle $rect,
  uint32 $rect_anchor,            # GdkGravity
  uint32 $window_anchor,          # GdkGravity
  uint32 $anchor_hints,           # GdkAnchorHints
  gint $rect_anchor_dx,
  gint $rect_anchor_dy
)
  is native(gdk)
  is export
  { * }

sub gdk_window_new (
  GdkWindow $parent,
  GdkWindowAttr $attributes,
  gint $attributes_mask
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_peek_children (GdkWindow $window)
  returns GList
  is native(gdk)
  is export
  { * }

sub gdk_window_process_all_updates ()
  is native(gdk)
  is export
  { * }

sub gdk_window_process_updates (GdkWindow $window, gboolean $update_children)
  is native(gdk)
  is export
  { * }

sub gdk_window_raise (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_register_dnd (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_remove_filter (
  GdkWindow $window,
  GdkFilterFunc $function,
  gpointer $data
)
  is native(gdk)
  is export
  { * }

sub gdk_window_reparent (
  GdkWindow $window,
  GdkWindow $new_parent,
  gint $x,
  gint $y
)
  is native(gdk)
  is export
  { * }

sub gdk_window_resize (GdkWindow $window, gint $width, gint $height)
  is native(gdk)
  is export
  { * }

sub gdk_window_restack (
  GdkWindow $window,
  GdkWindow $sibling,
  gboolean $above
)
  is native(gdk)
  is export
  { * }

sub gdk_window_scroll (GdkWindow $window, gint $dx, gint $dy)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_background (GdkWindow $window, GdkColor $color)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_background_rgba (GdkWindow $window, GdkRGBA $rgba)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_child_input_shapes (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_child_shapes (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_debug_updates (gboolean $setting)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_decorations (
  GdkWindow $window,
  uint32 $decoorations            # GdkWMDecoration $decorations
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_device_cursor (
  GdkWindow $window,
  GdkDevice $device,
  GdkCursor $cursor
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_device_events (
  GdkWindow $window,
  GdkDevice $device,
  uint32 $event_mask              # GdkEventMask $event_mask
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_functions (GdkWindow $window, GdkWMFunction $functions)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_geometry_hints (
  GdkWindow $window,
  GdkGeometry $geometry,
  uint32 $mask,                  #GdkWindowHints
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_icon_list (GdkWindow $window, GList $pixbufs)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_icon_name (GdkWindow $window, gchar $name)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_invalidate_handler (
  GdkWindow $window,
  GdkWindowInvalidateHandlerFunc $handler
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_keep_above (GdkWindow $window, gboolean $setting)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_keep_below (GdkWindow $window, gboolean $setting)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_opacity (GdkWindow $window, gdouble $opacity)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_opaque_region (GdkWindow $window, cairo_region_t $region)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_override_redirect (
  GdkWindow $window,
  gboolean $override_redirect
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_role (GdkWindow $window, gchar $role)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_shadow_width (
  GdkWindow $window,
  gint $left,
  gint $right,
  gint $top,
  gint $bottom
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_skip_pager_hint (GdkWindow $window, gboolean $skips_pager)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_skip_taskbar_hint (
  GdkWindow $window,
  gboolean $skips_taskbar
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_source_events (
  GdkWindow $window,
  GdkInputSource $source,
  uint32 $event_mask              # GdkEventMask $event_mask
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_startup_id (GdkWindow $window, gchar $startup_id)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_static_gravities (GdkWindow $window, gboolean $use_static)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_set_title (GdkWindow $window, gchar $title)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_transient_for (GdkWindow $window, GdkWindow $parent)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_urgency_hint (GdkWindow $window, gboolean $urgent)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_user_data (GdkWindow $window, gpointer $user_data)
  is native(gdk)
  is export
  { * }

sub gdk_window_shape_combine_region (
  GdkWindow $window,
  cairo_region_t $shape_region,
  gint $offset_x,
  gint $offset_y
)
  is native(gdk)
  is export
  { * }

sub gdk_window_show (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_show_unraised (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_show_window_menu (GdkWindow $window, GdkEvent $event)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_stick (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_thaw_toplevel_updates_libgtk_only (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_thaw_updates (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_unfullscreen (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_unmaximize (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_unstick (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_withdraw (GdkWindow $window)
  is native(gdk)
  is export
  { * }

sub gdk_window_get_accept_focus (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_background_pattern (GdkWindow $window)
  returns cairo_pattern_t
  is native(gdk)
  is export
  { * }

sub gdk_window_get_pass_through (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_modal_hint (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_event_compression (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_events (GdkWindow $window)
  returns uint32 # GdkEventMask
  is native(gdk)
  is export
  { * }

sub gdk_window_get_focus_on_map (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_fullscreen_mode (GdkWindow $window)
  returns GdkFullscreenMode
  is native(gdk)
  is export
  { * }

sub gdk_window_get_group (GdkWindow $window)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_composited (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_get_type_hint (GdkWindow $window)
  returns uint32 # GdkWindowTypeHint
  is native(gdk)
  is export
  { * }

sub gdk_window_get_cursor (GdkWindow $window)
  returns GdkCursor
  is native(gdk)
  is export
  { * }

sub gdk_offscreen_window_get_embedder (GdkWindow $window)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_window_get_support_multidevice (GdkWindow $window)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_window_set_accept_focus (GdkWindow $window, gboolean $accept_focus)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_background_pattern (
  GdkWindow $window,
  cairo_pattern_t $pattern
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_pass_through (GdkWindow $window, gboolean $pass_through)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_modal_hint (GdkWindow $window, gboolean $modal)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_event_compression (
  GdkWindow $window,
  gboolean $event_compression
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_events (
  GdkWindow $window,
  uint32 $event_mask              # GdkEventMask $event_mask
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_focus_on_map (GdkWindow $window, gboolean $focus_on_map)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_fullscreen_mode (
  GdkWindow $window,
  GdkFullscreenMode $mode
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_group (GdkWindow $window, GdkWindow $leader)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_composited (GdkWindow $window, gboolean $composited)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_type_hint (
  GdkWindow $window,
  uint32 $hint                    # GdkWindowTypeHint
)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_cursor (GdkWindow $window, GdkCursor $cursor)
  is native(gdk)
  is export
  { * }

sub gdk_offscreen_window_set_embedder (GdkWindow $window, GdkWindow $embedder)
  is native(gdk)
  is export
  { * }

sub gdk_window_set_support_multidevice (
  GdkWindow $window,
  gboolean $support_multidevice
)
  is native(gdk)
  is export
  { * }
