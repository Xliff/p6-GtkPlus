use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::Mount;

sub g_mount_can_eject (GMount $mount)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_can_unmount (GMount $mount)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_eject_with_operation (
  GMount $mount,
  GMountUnmountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_mount_eject_with_operation_finish (
  GMount $mount,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_get_default_location (GMount $mount)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_mount_get_drive (GMount $mount)
  returns GDrive
  is native(gio)
  is export
{ * }

sub g_mount_get_icon (GMount $mount)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_mount_get_name (GMount $mount)
  returns Str
  is native(gio)
  is export
{ * }

sub g_mount_get_root (GMount $mount)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_mount_get_sort_key (GMount $mount)
  returns Str
  is native(gio)
  is export
{ * }

sub g_mount_get_symbolic_icon (GMount $mount)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_mount_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_mount_get_uuid (GMount $mount)
  returns Str
  is native(gio)
  is export
{ * }

sub g_mount_get_volume (GMount $mount)
  returns GVolume
  is native(gio)
  is export
{ * }

sub g_mount_guess_content_type (
  GMount $mount,
  gboolean $force_rescan,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_mount_guess_content_type_finish (
  GMount $mount,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_mount_guess_content_type_sync (
  GMount $mount,
  gboolean $force_rescan,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_mount_is_shadowed (GMount $mount)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_remount (
  GMount $mount,
  GMountMountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_mount_remount_finish (
  GMount $mount,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_shadow (GMount $mount)
  is native(gio)
  is export
{ * }

sub g_mount_unmount_with_operation (
  GMount $mount,
  GMountUnmountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_mount_unmount_with_operation_finish (
  GMount $mount,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_mount_unshadow (GMount $mount)
  is native(gio)
  is export
{ * }
