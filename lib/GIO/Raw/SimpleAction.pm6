use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::SimpleAction;

sub g_simple_action_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_simple_action_new (
  Str $name,
  GVariantType $parameter_type
)
  returns GSimpleAction
  is native(gio)
  is export
  { * }

sub g_simple_action_new_stateful (
  Str $name,
  GVariantType $parameter_type,
  GVariant $state
)
  returns GSimpleAction
  is native(gio)
  is export
  { * }

sub g_simple_action_set_enabled (GSimpleAction $simple, gboolean $enabled)
  is native(gio)
  is export
  { * }

sub g_simple_action_set_state (GSimpleAction $simple, GVariant $value)
  is native(gio)
  is export
  { * }

sub g_simple_action_set_state_hint (
  GSimpleAction $simple,
  GVariant $state_hint
)
  is native(gio)
  is export
  { * }
