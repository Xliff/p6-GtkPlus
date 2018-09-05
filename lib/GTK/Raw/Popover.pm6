use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Popover;

sub gtk_popover_bind_model (
  GtkPopover $popover,
  GMenuModel $model,
  gchar $action_namespace
)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_pointing_to (GtkPopover $popover, GdkRectangle $rect)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_type ()
  returns GType
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_new (GtkWidget $relative_to)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_new_from_model (GtkWidget $relative_to, GMenuModel $model)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_popdown (GtkPopover $popover)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_popup (GtkPopover $popover)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_pointing_to (GtkPopover $popover, GdkRectangle $rect)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_default_widget (GtkPopover $popover)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_modal (GtkPopover $popover)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_position (GtkPopover $popover)
  returns uint32 # GtkPositionType
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_relative_to (GtkPopover $popover)
  returns GtkWidget
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_constrain_to (GtkPopover $popover)
  returns uint32 # GtkPopoverConstraint
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_get_transitions_enabled (GtkPopover $popover)
  returns uint32
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_default_widget (GtkPopover $popover, GtkWidget $widget)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_modal (GtkPopover $popover, gboolean $modal)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_position (GtkPopover $popover, GtkPositionType $position)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_relative_to (GtkPopover $popover, GtkWidget $relative_to)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_constrain_to (
  GtkPopover $popover,
  GtkPopoverConstraint $constraint
)
  is native('gtk-3')
  is export
  { * }

sub gtk_popover_set_transitions_enabled (
  GtkPopover $popover,
  gboolean $transitions_enabled
)
  is native('gtk-3')
  is export
  { * }
