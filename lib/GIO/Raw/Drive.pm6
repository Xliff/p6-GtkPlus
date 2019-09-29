use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::Drive;

sub g_drive_can_eject (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_can_poll_for_media (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_can_start (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_can_start_degraded (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_can_stop (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_eject_with_operation (
  GDrive $drive,
  GMountUnmountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_drive_eject_with_operation_finish (
  GDrive $drive,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_enumerate_identifiers (GDrive $drive)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_drive_get_icon (GDrive $drive)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_drive_get_identifier (GDrive $drive, Str $kind)
  returns Str
  is native(gio)
  is export
{ * }

sub g_drive_get_name (GDrive $drive)
  returns Str
  is native(gio)
  is export
{ * }

sub g_drive_get_sort_key (GDrive $drive)
  returns Str
  is native(gio)
  is export
{ * }

sub g_drive_get_start_stop_type (GDrive $drive)
  returns GDriveStartStopType
  is native(gio)
  is export
{ * }

sub g_drive_get_symbolic_icon (GDrive $drive)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_drive_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_drive_get_volumes (GDrive $drive)
  returns GList
  is native(gio)
  is export
{ * }

sub g_drive_has_media (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_has_volumes (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_is_media_check_automatic (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_is_media_removable (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_is_removable (GDrive $drive)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_poll_for_media (
  GDrive $drive,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_drive_poll_for_media_finish (
  GDrive $drive,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_start (
  GDrive $drive,
  GDriveStartFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_drive_start_finish (
  GDrive $drive,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_drive_stop (
  GDrive $drive,
  GMountUnmountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_drive_stop_finish (
  GDrive $drive,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
