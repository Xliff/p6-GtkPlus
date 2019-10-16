use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::UnixMount;

sub g_unix_mount_at (Str $mount_path, guint64 $time_read is rw)
  returns GUnixMountEntry
  is native(gio)
  is export
{ * }

sub g_unix_mount_compare (GUnixMountEntry $mount1, GUnixMountEntry $mount2)
  returns gint
  is native(gio)
  is export
{ * }

sub g_unix_mount_copy (GUnixMountEntry $mount_entry)
  returns GUnixMountEntry
  is native(gio)
  is export
{ * }

sub g_unix_mount_entry_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_unix_mount_for (Str $file_path, guint64 $time_read is rw)
  returns GUnixMountEntry
  is native(gio)
  is export
{ * }

sub g_unix_mount_free (GUnixMountEntry $mount_entry)
  is native(gio)
  is export
{ * }

sub g_unix_is_mount_path_system_internal (Str $mount_path)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_is_system_device_path (Str $device_path)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_is_system_fs_type (Str $fs_type)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mounts_changed_since (guint64 $time)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mounts_get (guint64 $time_read is rw)
  returns GList
  is native(gio)
  is export
{ * }

sub g_unix_mount_get_device_path (GUnixMountEntry $mount_entry)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_get_fs_type (GUnixMountEntry $mount_entry)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_get_mount_path (GUnixMountEntry $mount_entry)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_get_options (GUnixMountEntry $mount_entry)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_get_root_path (GUnixMountEntry $mount_entry)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_guess_can_eject (GUnixMountEntry $mount_entry)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_guess_icon (GUnixMountEntry $mount_entry)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_unix_mount_guess_name (GUnixMountEntry $mount_entry)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_guess_should_display (GUnixMountEntry $mount_entry)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_guess_symbolic_icon (GUnixMountEntry $mount_entry)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_unix_mount_is_readonly (GUnixMountEntry $mount_entry)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_is_system_internal (GUnixMountEntry $mount_entry)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_monitor_get ()
  returns GUnixMountMonitor
  is native(gio)
  is export
{ * }

sub g_unix_mount_monitor_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

# Deprecated -- To be removed!
sub g_unix_mount_monitor_set_rate_limit (
  GUnixMountMonitor $mount_monitor,
  gint $limit_msec
)
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_compare (
  GUnixMountPoint $mount1,
  GUnixMountPoint $mount2
)
  returns gint
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_copy (GUnixMountPoint $mount_point)
  returns GUnixMountPoint
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_free (GUnixMountPoint $mount_point)
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_get_device_path (GUnixMountPoint $mount_point)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_get_fs_type (GUnixMountPoint $mount_point)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_get_mount_path (GUnixMountPoint $mount_point)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_get_options (GUnixMountPoint $mount_point)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_guess_can_eject (GUnixMountPoint $mount_point)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_guess_icon (GUnixMountPoint $mount_point)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_guess_name (GUnixMountPoint $mount_point)
  returns Str
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_guess_symbolic_icon (GUnixMountPoint $mount_point)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_is_loopback (GUnixMountPoint $mount_point)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_is_readonly (GUnixMountPoint $mount_point)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_point_is_user_mountable (GUnixMountPoint $mount_point)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_points_changed_since (guint64 $time)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_mount_points_get (guint64 $time_read is rw)
  returns GList
  is native(gio)
  is export
{ * }
