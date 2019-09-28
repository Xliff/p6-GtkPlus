use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::VolumeMonitor;

sub g_volume_monitor_adopt_orphan_mount (GMount $mount)
  returns GVolume
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get ()
  returns GVolumeMonitor
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get_connected_drives (GVolumeMonitor $volume_monitor)
  returns GList
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get_mount_for_uuid (
  GVolumeMonitor $volume_monitor,
  Str $uuid
)
  returns GMount
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get_mounts (GVolumeMonitor $volume_monitor)
  returns GList
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get_volume_for_uuid (
  GVolumeMonitor $volume_monitor,
  Str $uuid
)
  returns GVolume
  is native(gio)
  is export
{ * }

sub g_volume_monitor_get_volumes (GVolumeMonitor $volume_monitor)
  returns GList
  is native(gio)
  is export
{ * }
