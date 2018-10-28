use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

unit package GTK::Raw::Actionable;

sub gtk_actionable_get_type ()
  returns GType
  is native($LIBGTK)
  is export
  { * }

sub gtk_actionable_set_detailed_action_name (
  GtkActionable $actionable,
  gchar $detailed_action_name
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_actionable_get_action_target_value (GtkActionable $actionable)
  returns GVariant
  is native($LIBGTK)
  is export
  { * }

sub gtk_actionable_get_action_name (GtkActionable $actionable)
  returns Str
  is native($LIBGTK)
  is export
  { * }

sub gtk_actionable_set_action_target_value (
  GtkActionable $actionable,
  GVariant $target_value
)
  is native($LIBGTK)
  is export
  { * }

sub gtk_actionable_set_action_name (
  GtkActionable $actionable,
  gchar $action_name
)
  is native($LIBGTK)
  is export
  { * }