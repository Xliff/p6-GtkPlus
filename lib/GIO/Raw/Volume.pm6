use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::Volume;

sub g_volume_can_eject (GVolume $volume)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_volume_can_mount (GVolume $volume)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_volume_eject_with_operation (
  GVolume $volume,
  GMountUnmountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_volume_eject_with_operation_finish (
  GVolume $volume,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_volume_enumerate_identifiers (GVolume $volume)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_volume_get_activation_root (GVolume $volume)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_volume_get_drive (GVolume $volume)
  returns GDrive
  is native(gio)
  is export
{ * }

sub g_volume_get_icon (GVolume $volume)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_volume_get_identifier (GVolume $volume, Str $kind)
  returns Str
  is native(gio)
  is export
{ * }

sub g_volume_get_mount (GVolume $volume)
  returns GMount
  is native(gio)
  is export
{ * }

sub g_volume_get_name (GVolume $volume)
  returns Str
  is native(gio)
  is export
{ * }

sub g_volume_get_sort_key (GVolume $volume)
  returns Str
  is native(gio)
  is export
{ * }

sub g_volume_get_symbolic_icon (GVolume $volume)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_volume_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_volume_get_uuid (GVolume $volume)
  returns Str
  is native(gio)
  is export
{ * }

sub g_volume_mount (
  GVolume $volume,
  GMountMountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data)

  is native(gio)
  is export
{ * }

sub g_volume_mount_finish (
  GVolume $volume,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_volume_should_automount (GVolume $volume)
  returns uint32
  is native(gio)
  is export
{ * }
