use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::Settings;

sub g_settings_apply (GSettings $settings)
  is native(gio)
  is export
{ * }

sub g_settings_bind (
  GSettings $settings,
  Str $key,
  GObject $object,
  Str $property,
  GSettingsBindFlags $flags
)
  is native(gio)
  is export
{ * }

sub g_settings_bind_with_mapping (
  GSettings $settings,
  Str $key,
  GObject $object,
  Str $property,
  GSettingsBindFlags $flags,
  GSettingsBindGetMapping $get_mapping,
  GSettingsBindSetMapping $set_mapping,
  gpointer $user_data,
  GDestroyNotify $destroy
)
  is native(gio)
  is export
{ * }

sub g_settings_bind_writable (
  GSettings $settings,
  Str $key,
  GObject $object,
  Str $property,
  gboolean $inverted
)
  is native(gio)
  is export
{ * }

sub g_settings_create_action (GSettings $settings, Str $key)
  returns GAction
  is native(gio)
  is export
{ * }

sub g_settings_delay (GSettings $settings)
  is native(gio)
  is export
{ * }

sub g_settings_get_boolean (GSettings $settings, Str $key)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_get_child (GSettings $settings, Str $name)
  returns GSettings
  is native(gio)
  is export
{ * }

sub g_settings_get_default_value (GSettings $settings, Str $key)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_settings_get_double (GSettings $settings, Str $key)
  returns gdouble
  is native(gio)
  is export
{ * }

sub g_settings_get_enum (GSettings $settings, Str $key)
  returns gint
  is native(gio)
  is export
{ * }

sub g_settings_get_flags (GSettings $settings, Str $key)
  returns guint
  is native(gio)
  is export
{ * }

sub g_settings_get_has_unapplied (GSettings $settings)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_get_int (GSettings $settings, Str $key)
  returns gint
  is native(gio)
  is export
{ * }

sub g_settings_get_int64 (GSettings $settings, Str $key)
  returns gint64
  is native(gio)
  is export
{ * }

sub g_settings_get_mapped (
  GSettings $settings,
  Str $key,
  GSettingsGetMapping $mapping,
  gpointer $user_data
)
  returns Pointer
  is native(gio)
  is export
{ * }

sub g_settings_get_string (GSettings $settings, Str $key)
  returns Str
  is native(gio)
  is export
{ * }

sub g_settings_get_strv (GSettings $settings, Str $key)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_settings_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_settings_get_uint (GSettings $settings, Str $key)
  returns guint
  is native(gio)
  is export
{ * }

sub g_settings_get_uint64 (GSettings $settings, Str $key)
  returns guint64
  is native(gio)
  is export
{ * }

sub g_settings_get_user_value (GSettings $settings, Str $key)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_settings_get_value (GSettings $settings, Str $key)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_settings_is_writable (GSettings $settings, Str $name)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_list_children (GSettings $settings)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_settings_new (Str $schema_id)
  returns GSettings
  is native(gio)
  is export
{ * }

sub g_settings_new_full (
  GSettingsSchema $schema,
  GSettingsBackend $backend,
  Str $path
)
  returns GSettings
  is native(gio)
  is export
{ * }

sub g_settings_new_with_backend (Str $schema_id, GSettingsBackend $backend)
  returns GSettings
  is native(gio)
  is export
{ * }

sub g_settings_new_with_backend_and_path (
  Str $schema_id,
  GSettingsBackend $backend,
  Str $path
)
  returns GSettings
  is native(gio)
  is export
{ * }

sub g_settings_new_with_path (Str $schema_id, Str $path)
  returns GSettings
  is native(gio)
  is export
{ * }

sub g_settings_reset (GSettings $settings, Str $key)
  is native(gio)
  is export
{ * }

sub g_settings_revert (GSettings $settings)
  is native(gio)
  is export
{ * }

sub g_settings_set_boolean (GSettings $settings, Str $key, gboolean $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_double (GSettings $settings, Str $key, gdouble $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_enum (GSettings $settings, Str $key, gint $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_flags (GSettings $settings, Str $key, guint $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_int (GSettings $settings, Str $key, gint $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_int64 (GSettings $settings, Str $key, gint64 $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_string (GSettings $settings, Str $key, Str $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_uint (GSettings $settings, Str $key, guint $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_uint64 (GSettings $settings, Str $key, guint64 $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_set_value (GSettings $settings, Str $key, GVariant $value)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_settings_sync ()
  is native(gio)
  is export
{ * }

sub g_settings_unbind (GObject $object, Str $property)
  is native(gio)
  is export
{ * }

sub g_settings_set_strv (
  GSettings   $settings,
  Str         $key,
  CArray[Str] $value
)
  returns gboolean
  is native(gio)
  is export
{ * }
