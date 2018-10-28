use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Container;

sub gtk_container_unset_focus_chain (GtkContainer $container)
  is native($LIBGTK)
  is export
  { * }

#sub gtk_container_class_list_child_properties (GObjectClass $cclass, guint $n_properties)
#  returns CArray[GParamSpec]
#  is native($LIBGTK)
#  is export
#  { * }

sub gtk_container_check_resize (GtkContainer $container)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_set_valist (GtkContainer $container, GtkWidget $child, gchar $first_property_name, va_list $var_args)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_foreach (GtkContainer $container, GtkCallback $callback, gpointer $callback_data)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_get_children (GtkContainer $container)
  returns GList
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_get_property (GtkContainer $container, GtkWidget $child, gchar $property_name, GValue $value)
  is native($LIBGTK)
  is export
  { * }

# sub gtk_container_class_find_child_property (GObjectClass $cclass, gchar $property_name)
#   returns GParamSpec
#   is native($LIBGTK)
#   is export
#   { * }

sub gtk_container_add (GtkContainer $container, GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_get_path_for_child (GtkContainer $container, GtkWidget $child)
  returns GtkWidgetPath
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_get_focus_chain (GtkContainer $container, GList $focusable_widgets)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_type (GtkContainer $container)
  returns GType
  is native($LIBGTK)
  is export
  { * }

# sub gtk_container_class_install_child_properties (GtkContainerClass $cclass, guint $n_pspecs, GParamSpec $pspecs)
#   is native($LIBGTK)
#   is export
#   { * }

sub gtk_container_resize_children (GtkContainer $container)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_propagate_draw (GtkContainer $container, GtkWidget $child, cairo_t $cr)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_get_valist (GtkContainer $container, GtkWidget $child, gchar $first_property_name, va_list $var_args)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_forall (GtkContainer $container, GtkCallback $callback, gpointer $callback_data)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_set_reallocate_redraws (GtkContainer $container, gboolean $needs_redraws)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_set_property (GtkContainer $container, GtkWidget $child, gchar $property_name, GValue $value)
  is native($LIBGTK)
  is export
  { * }

# sub gtk_container_class_handle_border_width (GtkContainerClass $klass)
#   is native($LIBGTK)
#   is export
#   { * }
#
# sub gtk_container_class_install_child_property (GtkContainerClass $cclass, guint $property_id, GParamSpec $pspec)
#   is native($LIBGTK)
#   is export
#   { * }

sub gtk_container_remove (GtkContainer $container, GtkWidget $widget)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_notify_by_pspec (GtkContainer $container, GtkWidget $child, GParamSpec $pspec)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_child_notify (GtkContainer $container, GtkWidget $child, gchar $child_property)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_get_border_width (GtkContainer $container)
  returns guint
  is native($LIBGTK)
  is export
  { * }

# --> GtkAdjustment
sub gtk_container_get_focus_vadjustment (GtkContainer $container)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# --> GtkResizeMode
sub gtk_container_get_resize_mode (GtkContainer $container)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

# -->  GtkAdjustment
sub gtk_container_get_focus_hadjustment (GtkContainer $container)
  returns uint32
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_get_focus_child (GtkContainer $container)
  returns GtkWidget
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_set_border_width (GtkContainer $container, guint $border_width)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_set_focus_vadjustment (GtkContainer $container, GtkAdjustment $adjustment)
  is native($LIBGTK)
  is export
  { * }

# GtkResizeMode $resize_mode
sub gtk_container_set_resize_mode (GtkContainer $container, uint32 $resize_mode)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_set_focus_hadjustment (GtkContainer $container, GtkAdjustment $adjustment)
  is native($LIBGTK)
  is export
  { * }

sub gtk_container_set_focus_child (GtkContainer $container, GtkWidget $child)
  is native($LIBGTK)
  is export
  { * }