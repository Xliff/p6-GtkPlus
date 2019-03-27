use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Action;

sub g_action_activate (GAction $action, GVariant $parameter)
  is native(gio)
  is export
  { * }

sub g_action_change_state (GAction $action, GVariant $value)
  is native(gio)
  is export
  { * }

sub g_action_get_enabled (GAction $action)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_action_get_name (GAction $action)
  returns Str
  is native(gio)
  is export
  { * }

sub g_action_get_parameter_type (GAction $action)
  returns GVariantType
  is native(gio)
  is export
  { * }

sub g_action_get_state (GAction $action)
  returns GVariant
  is native(gio)
  is export
  { * }

sub g_action_get_state_hint (GAction $action)
  returns GVariant
  is native(gio)
  is export
  { * }

sub g_action_get_state_type (GAction $action)
  returns GVariantType
  is native(gio)
  is export
  { * }

sub g_action_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_action_name_is_valid (gchar $action_name)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_action_parse_detailed_name (
  gchar $detailed_name,
  gchar $action_name,
  GVariant $target_value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_action_print_detailed_name (
  gchar $action_name,
  GVariant $target_value
)
  returns Str
  is native(gio)
  is export
  { * }
