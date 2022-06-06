use v6.c;

use NativeCall;


use GTK::Raw::Types:ver<3.0.1146>;

unit package GTK::Raw::Actionable:ver<3.0.1146>;

sub gtk_actionable_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub gtk_actionable_set_detailed_action_name (
  GtkActionable $actionable,
  gchar $detailed_action_name
)
  is native(gtk)
  is export
  { * }

sub gtk_actionable_get_action_target_value (GtkActionable $actionable)
  returns GVariant
  is native(gtk)
  is export
  { * }

sub gtk_actionable_get_action_name (GtkActionable $actionable)
  returns Str
  is native(gtk)
  is export
  { * }

sub gtk_actionable_set_action_target_value (
  GtkActionable $actionable,
  GVariant $target_value
)
  is native(gtk)
  is export
  { * }

sub gtk_actionable_set_action_name (
  GtkActionable $actionable,
  gchar $action_name
)
  is native(gtk)
  is export
  { * }