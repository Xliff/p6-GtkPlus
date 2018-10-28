use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Widget;

sub gtk_widget_set_device_events (
  GtkWidget $widget,
  GdkDevice $device,
  guint $events                 # GdkEventMask $events
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_style_get_valist (
  GtkWidget $widget,
  gchar $first_property_name,
  va_list $var_args
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_allocated_size (
  GtkWidget $widget,
  GtkAllocation $allocation,
  int32 $baseline
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_has_grab (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_override_cursor (
  GtkWidget $widget,
  GTK::Compat::RGBA $cursor,
  GTK::Compat::RGBA $secondary_cursor
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_allocated_height (GtkWidget $widget)
  returns int32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_redraw_on_allocate (GtkWidget $widget, gboolean $redraw_on_allocate)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_allocated_baseline (GtkWidget $widget)
  returns int32
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_set_template_from_resource (GtkWidgetClass $widget_class, gchar $resource_name)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_queue_compute_expand (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_shape_combine_region (GtkWidget $widget, cairo_region_t $region)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_scale_factor (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_region_intersect (GtkWidget $widget, cairo_region_t $region)
  returns cairo_region_t
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_queue_allocate (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

# GtkDirectionType $direction
sub gtk_widget_keynav_failed (GtkWidget $widget, uint32 $direction)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_requisition (GtkWidget $widget, GtkRequisition $requisition)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_has_default (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_add_events (GtkWidget $widget, gint $events)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_is_ancestor (GtkWidget $widget, GtkWidget $ancestor)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_accessible (GtkWidget $widget)
  returns AtkObject
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_path (GtkWidget $widget)
  returns GtkWidgetPath
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_remove_accelerator (
  GtkWidget $widget,
  GtkAccelGroup $accel_group,
  guint $accel_key,
  uint32 $accel_mods            # GdkModifierType $accel_mods
)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_has_screen (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_input_shape_combine_region (GtkWidget $widget, cairo_region_t $region)
  is native($LIBGTK)
  is export
  { * }

sub gtk_requisition_free (GtkRequisition $requisition)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_preferred_size (GtkWidget $widget, GtkRequisition $minimum_size, GtkRequisition $natural_size)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_size_request (GtkWidget $widget, gint $width, gint $height)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_is_composited (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_cairo_transform_to_window (cairo_t $cr, GtkWidget $widget, GdkWindow $window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_pango_context (GtkWidget $widget)
  returns PangoContext
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_display (GtkWidget $widget)
  returns GdkDisplay
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_queue_draw_region (GtkWidget $widget, cairo_region_t $region)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_map (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_add_mnemonic_label (GtkWidget $widget, GtkWidget $label)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_bind_template_child_full (GtkWidgetClass $widget_class, gchar $name, gboolean $internal_child, gssize $struct_offset)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_requisition_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_clipboard (GtkWidget $widget, GdkAtom $selection)
  returns GtkClipboard
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_grab_default (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_error_bell (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_install_style_property_parser (GtkWidgetClass $klass, GParamSpec $pspec, GtkRcPropertyParser $parser)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_get_allocated_width (GtkWidget $widget)
  returns int32
  is native($LIBGTK)
  is export
  { * }

# --> GtkAlign
sub gtk_widget_get_valign_with_baseline (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_preferred_width_for_height (GtkWidget $widget, gint $height, gint $minimum_width, gint $natural_width)
  is native($LIBGTK)
  is export
  { * }

# GtkTextDirection $dir
sub gtk_widget_set_default_direction (uint32 $dir)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_size_allocate_with_baseline (GtkWidget $widget, GtkAllocation $allocation, gint $baseline)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_set_template (GtkWidgetClass $widget_class, GBytes $template_bytes)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_is_visible (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_hide_on_delete (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# GtkIconSize $size
sub gtk_widget_render_icon_pixbuf (GtkWidget $widget, gchar $stock_id, uint32 $size)
  returns GdkPixbuf
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_add_tick_callback (GtkWidget $widget, GtkTickCallback $callback, gpointer $user_data, GDestroyNotify $notify)
  returns guint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_preferred_width (GtkWidget $widget, gint $minimum_width, gint $natural_width)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_has_focus (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_queue_draw (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

# GtkDirectionType $direction
sub gtk_widget_child_focus (GtkWidget $widget, uint32 $direction)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_remove_tick_callback (GtkWidget $widget, guint $id)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_preferred_height_and_baseline_for_width (GtkWidget $widget, gint $width, gint $minimum_height, gint $natural_height, gint $minimum_baseline, gint $natural_baseline)
  is native($LIBGTK)
  is export
  { * }

sub gtk_cairo_should_draw_window (cairo_t $cr, GdkWindow $window)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_unmap (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_install_style_property (GtkWidgetClass $klass, GParamSpec $pspec)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_get_ancestor (GtkWidget $widget, GType $widget_type)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_modifier_mask (GtkWidget $widget, GdkModifierIntent $intent)
  returns uint32 # GdkModifierType
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_allocation (GtkWidget $widget, GtkAllocation $allocation)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_set_accessible_type (GtkWidgetClass $widget_class, GType $type)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_get_device_enabled (GtkWidget $widget, GdkDevice $device)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_action_group (GtkWidget $widget, gchar $prefix)
  returns GActionGroup
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_list_accel_closures (GtkWidget $widget)
  returns GList
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_unparent (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_translate_coordinates (GtkWidget $src_widget, GtkWidget $dest_widget, gint $src_x, gint $src_y, gint $dest_x, gint $dest_y)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_style_get_property (GtkWidget $widget, gchar $property_name, GValue $value)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_settings (GtkWidget $widget)
  returns GtkSettings
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_set_accessible_role (GtkWidgetClass $widget_class, AtkRole $role)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_queue_draw_area (GtkWidget $widget, gint $x, gint $y, gint $width, gint $height)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_unrealize (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_requisition_copy (GtkRequisition $requisition)
  returns GtkRequisition
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_init_template (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_template_child (GtkWidget $widget, GType $widget_type, gchar $name)
  returns GObject
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_reparent (GtkWidget $widget, GtkWidget $new_parent)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_mnemonic_activate (GtkWidget $widget, gboolean $group_cycling)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_size_allocate (GtkWidget $widget, GtkAllocation $allocation)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_destroy (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

# GtkOrientation $orientation
sub gtk_widget_compute_expand (GtkWidget $widget, uint32 $orientation)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_create_pango_layout (GtkWidget $widget, gchar $text)
  returns PangoLayout
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_list_action_prefixes (GtkWidget $widget)
  returns CArray[Str]
  is native($LIBGTK)
  is export
  { * }

# GtkStateFlag $state
sub gtk_widget_override_color (
  GtkWidget $widget,uint32 $state,
  GTK::Compat::RGBA $color
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_pop_composite_child ()
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_remove_mnemonic_label (GtkWidget $widget, GtkWidget $label)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_queue_resize (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_realize (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_unregister_window (GtkWidget $widget, GdkWindow $window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_requisition_new ()
  returns GtkRequisition
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_intersect (GtkWidget $widget, GdkRectangle $area, GdkRectangle $intersection)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_destroyed (GtkWidget $widget, GtkWidget $widget_pointer)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_register_window (GtkWidget $widget, GdkWindow $window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_add_device_events (
  GtkWidget $widget,
  GdkDevice $device,
  guint $events                 # GdkEventMask $events
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_allocation (GtkWidget $widget, GtkAllocation $allocation)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_toplevel (GtkWidget $widget)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_has_visible_focus (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_is_drawable (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_push_composite_child ()
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_in_destruction (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_bind_template_callback_full (GtkWidgetClass $widget_class, gchar $callback_name, GCallback $callback_symbol)
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_set_clip (GtkWidget $widget, GtkAllocation $clip)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_device_enabled (GtkWidget $widget, GdkDevice $device, gboolean $enabled)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_freeze_child_notify (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_show_now (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_draw (GtkWidget $widget, cairo_t $cr)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_override_symbolic_color (
  GtkWidget $widget,
  gchar $name,
  GTK::Compat::RGBA $color
)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_find_style_property (GtkWidgetClass $klass, gchar $property_name)
#  returns GParamSpec
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_get_frame_clock (GtkWidget $widget)
  returns GdkFrameClock
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_is_sensitive (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_reset_style (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_device_events (GtkWidget $widget, GdkDevice $device)
  returns uint32 # GdkEventMask
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_thaw_child_notify (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_child_notify (GtkWidget $widget, gchar $child_property)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_activate (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_set_connect_func (GtkWidgetClass $widget_class, GtkBuilderConnectFunc $connect_func, gpointer $connect_data, GDestroyNotify $connect_data_destroy)
#  is native($LIBGTK)
#  is export
#  { * }

# --> GtkStyleContext
sub gtk_widget_get_style_context (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# --> GtkSizeRequestMode
sub gtk_widget_get_request_mode (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_accel_path (GtkWidget $widget, gchar $accel_path, GtkAccelGroup $accel_group)
  is native($LIBGTK)
  is export
  { * }

# --> GtkTextDirection
sub gtk_widget_get_default_direction ()
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_hide (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_list_mnemonic_labels (GtkWidget $widget)
  returns GList
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_preferred_height_for_width (GtkWidget $widget, gint $width, gint $minimum_height, gint $natural_height)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_clip (GtkWidget $widget, GtkAllocation $clip)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_can_activate_accel (GtkWidget $widget, guint $signal_id)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# GtkStateFlags $state
sub gtk_widget_override_background_color (
  GtkWidget $widget,
  uint32 $state,
  GTK::Compat::RGBA $color
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_create_pango_context (GtkWidget $widget)
  returns PangoContext
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_list_style_properties (GtkWidgetClass $klass, guint $n_properties)
#  returns CArray[GParamSpec]
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_widget_get_preferred_height (GtkWidget $widget, gint $minimum_height, gint $natural_height)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_screen (GtkWidget $widget)
  returns GdkScreen
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_grab_focus (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_send_focus_change (GtkWidget $widget, GdkEvent $event)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_event (GtkWidget $widget, GdkEvent $event)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_trigger_tooltip_query (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_insert_action_group (GtkWidget $widget, gchar $name, GActionGroup $group)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_root_window (GtkWidget $widget)
  returns GdkWindow
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_size_request (GtkWidget $widget, GtkRequisition $requisition)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_show_all (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_child_requisition (GtkWidget $widget, GtkRequisition $requisition)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_size_request (GtkWidget $widget, gint $width, gint $height)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_is_toplevel (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_device_is_shadowed (GtkWidget $widget, GdkDevice $device)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_is_focus (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_send_expose (GtkWidget $widget, GdkEvent $event)
  returns gint
  is native($LIBGTK)
  is export
  { * }

# GtkAccelGroup $accel_group
sub gtk_widget_add_accelerator (
  GtkWidget $widget,
  gchar $accel_signal,
  GtkAccelGroup $accel_group,
  guint $accel_key,
  uint32 $accel_mods,           # GdkModifierType $accel_mods,
  uint32 $accel_flags
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_show (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_override_font (GtkWidget $widget, PangoFontDescription $font_desc)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_queue_resize_no_redraw (GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_pointer (GtkWidget $widget, gint $x, gint $y)
  is native($LIBGTK)
  is export
  { * }

  sub gtk_widget_get_child_visible (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_margin_top (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_can_focus (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_support_multidevice (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_parent_window (GtkWidget $widget)
  returns GdkWindow
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_realized (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# --> GtkAlign
sub gtk_widget_get_halign (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# --> GtkAlign
sub gtk_widget_get_valign (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_tooltip_text (GtkWidget $widget)
  returns Str
  is native($LIBGTK)
  is export
  { * }

# --> GtkStateFlags
sub gtk_widget_get_state_flags (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_composite_name (GtkWidget $widget)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_hexpand_set (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_margin_bottom (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_visible (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_parent (GtkWidget $widget)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_margin_right (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_has_tooltip (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_can_default (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_opacity (GtkWidget $widget)
  returns num64
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_double_buffered (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_sensitive (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_hexpand (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_window (GtkWidget $widget)
  returns GdkWindow
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_app_paintable (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_visual (GtkWidget $widget)
  returns GdkVisual
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_font_map (GtkWidget $widget)
  returns PangoFontMap
  is native($LIBGTK)
  is export
  { * }

# --> GtkStateType
sub gtk_widget_get_state (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_receives_default (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_tooltip_window (GtkWidget $widget)
  returns GtkWindow
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_name (GtkWidget $widget)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_no_show_all (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_vexpand (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_has_window (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_focus_on_click (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_mapped (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_margin_start (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_events (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_vexpand_set (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_margin_left (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_get_css_name (GtkWidgetClass $widget_class)
#  returns char
#  is native($LIBGTK)
#  is export
#  { * }

# --> GtkTextDirection
sub gtk_widget_get_direction (GtkWidget $widget)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_font_options (GtkWidget $widget)
  returns cairo_font_options_t
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_tooltip_markup (GtkWidget $widget)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_get_margin_end (GtkWidget $widget)
  returns gint
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_child_visible (GtkWidget $widget, gboolean $is_visible)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_margin_top (GtkWidget $widget, gint $margin)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_can_focus (GtkWidget $widget, gboolean $can_focus)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_support_multidevice (GtkWidget $widget, gboolean $support_multidevice)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_parent_window (GtkWidget $widget, GdkWindow $parent_window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_realized (GtkWidget $widget, gboolean $realized)
  is native($LIBGTK)
  is export
  { * }

# GtkAlign $align
sub gtk_widget_set_halign (GtkWidget $widget, uint32 $align)
  is native($LIBGTK)
  is export
  { * }

# GtkAlign $align
sub gtk_widget_set_valign (GtkWidget $widget, uint32 $align)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_tooltip_text (GtkWidget $widget, gchar $text)
  is native($LIBGTK)
  is export
  { * }

# GtkStateFlags $flags
sub gtk_widget_unset_state_flags (GtkWidget $widget, uint32 $flags)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_composite_name (GtkWidget $widget, gchar $name)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_hexpand_set (GtkWidget $widget, gboolean $set)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_margin_bottom (GtkWidget $widget, gint $margin)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_visible (GtkWidget $widget, gboolean $visible)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_parent (GtkWidget $widget, GtkWidget $parent)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_margin_right (GtkWidget $widget, gint $margin)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_has_tooltip (GtkWidget $widget, gboolean $has_tooltip)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_can_default (GtkWidget $widget, gboolean $can_default)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_opacity (GtkWidget $widget, num64 $opacity)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_double_buffered (GtkWidget $widget, gboolean $double_buffered)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_sensitive (GtkWidget $widget, gboolean $sensitive)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_hexpand (GtkWidget $widget, gboolean $expand)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_window (GtkWidget $widget, GdkWindow $window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_app_paintable (GtkWidget $widget, gboolean $app_paintable)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_visual (GtkWidget $widget, GdkVisual $visual)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_font_map (GtkWidget $widget, PangoFontMap $font_map)
  is native($LIBGTK)
  is export
  { * }

# GtkStateType $state
sub gtk_widget_set_state (GtkWidget $widget, uint32 $state)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_receives_default (GtkWidget $widget, gboolean $receives_default)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_tooltip_window (GtkWidget $widget, GtkWindow $custom_window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_name (GtkWidget $widget, gchar $name)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_no_show_all (GtkWidget $widget, gboolean $no_show_all)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_vexpand (GtkWidget $widget, gboolean $expand)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_has_window (GtkWidget $widget, gboolean $has_window)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_focus_on_click (GtkWidget $widget, gboolean $focus_on_click)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_mapped (GtkWidget $widget, gboolean $mapped)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_margin_start (GtkWidget $widget, gint $margin)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_events (GtkWidget $widget, gint $events)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_vexpand_set (GtkWidget $widget, gboolean $set)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_margin_left (GtkWidget $widget, gint $margin)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_widget_class_set_css_name (GtkWidgetClass $widget_class, char $name)
#  is native($LIBGTK)
#  is export
#  { * }

# GtkTextDirection $dir
sub gtk_widget_set_direction (GtkWidget $widget, uint32 $dir)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_font_options (GtkWidget $widget, cairo_font_options_t $options)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_tooltip_markup (GtkWidget $widget, gchar $markup)
  is native($LIBGTK)
  is export
  { * }

sub gtk_widget_set_margin_end (GtkWidget $widget, gint $margin)
  is native($LIBGTK)
  is export
  { * }