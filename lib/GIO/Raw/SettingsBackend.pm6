use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::SettingsBackend;

### /usr/include/glib-2.0/gio/gsettingsbackend.h

sub g_settings_backend_changed (
  GSettingsBackend $backend,
  Str $key,
  gpointer $origin_tag
)
  is native(gio)
  is export
{ * }

sub g_settings_backend_changed_tree (
  GSettingsBackend $backend,
  GTree $tree,
  gpointer $origin_tag
)
  is native(gio)
  is export
{ * }

sub g_settings_backend_flatten_tree (
  GTree                    $tree,
  CArray[Str]              $path,
  CArray[CArray[Str]]      $keys,
  CArray[CArray[GVariant]] $values
)
  is native(gio)
  is export
{ * }

sub g_keyfile_settings_backend_new (
  Str $filename,
  Str $root_path,
  Str $root_group
)
  returns GSettingsBackend
  is native(gio)
  is export
{ * }

sub g_memory_settings_backend_new ()
  returns GSettingsBackend
  is native(gio)
  is export
{ * }

sub g_null_settings_backend_new ()
  returns GSettingsBackend
  is native(gio)
  is export
{ * }

sub g_settings_backend_get_default ()
  returns GSettingsBackend
  is native(gio)
  is export
{ * }

sub g_settings_backend_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_settings_backend_path_changed (
  GSettingsBackend $backend,
  Str $path,
  gpointer $origin_tag
)
  is native(gio)
  is export
{ * }

sub g_settings_backend_path_writable_changed (
  GSettingsBackend $backend,
  Str $path
)
  is native(gio)
  is export
{ * }

sub g_settings_backend_writable_changed (GSettingsBackend $backend, Str $key)
  is native(gio)
  is export
{ * }

sub g_settings_backend_keys_changed (
  GSettingsBackend $backend,
  Str              $path,
  CArray[Str]      $items,
  gpointer         $origin_tag
)
  is native(gio)
  is export
{ * }
