use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::ActionGroup;

sub g_action_group_action_added (GActionGroup $action_group, Str $action_name)
  is native(gio)
  is export
{ * }

sub g_action_group_action_enabled_changed (
  GActionGroup $action_group,
  Str $action_name,
  gboolean $enabled
)
  is native(gio)
  is export
{ * }

sub g_action_group_action_removed (
  GActionGroup $action_group,
  Str $action_name
)
  is native(gio)
  is export
{ * }

sub g_action_group_action_state_changed (
  GActionGroup $action_group,
  Str $action_name,
  GVariant $state
)
  is native(gio)
  is export
{ * }

sub g_action_group_activate_action (
  GActionGroup $action_group,
  Str $action_name,
  GVariant $parameter
)
  is native(gio)
  is export
{ * }

sub g_action_group_change_action_state (
  GActionGroup $action_group,
  Str $action_name,
  GVariant $value
)
  is native(gio)
  is export
{ * }

sub g_action_group_get_action_enabled (
  GActionGroup $action_group,
  Str $action_name
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_action_group_get_action_parameter_type (
  GActionGroup $action_group,
  Str $action_name
)
  returns CArray[GVariantType]
  is native(gio)
  is export
{ * }

sub g_action_group_get_action_state (
  GActionGroup $action_group,
  Str $action_name
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_action_group_get_action_state_hint (
  GActionGroup $action_group,
  Str $action_name
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_action_group_get_action_state_type (
  GActionGroup $action_group,
  Str $action_name
)
  returns CArray[GVariantType]
  is native(gio)
  is export
{ * }

sub g_action_group_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_action_group_has_action (GActionGroup $action_group, Str $action_name)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_action_group_list_actions (GActionGroup $action_group)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_action_group_query_action (
  GActionGroup $action_group,
  Str $action_name,
  gboolean $enabled,
  GVariantType $parameter_type,
  GVariantType $state_type,
  GVariant $state_hint,
  GVariant $state
)
  returns uint32
  is native(gio)
  is export
{ * }
