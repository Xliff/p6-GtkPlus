use v6.c;

use GTK::Compat::Types;

unit package GTK::Compat::FileTypes;

constant GAppInfoCreateFlags is export := guint;
our enum GAppInfoCreateFlagsEnum is export (
  G_APP_INFO_CREATE_NONE                           => 0,         # nick=none
  G_APP_INFO_CREATE_NEEDS_TERMINAL                 => 1,         # nick=needs-terminal
  G_APP_INFO_CREATE_SUPPORTS_URIS                  => (1 +< 1),  # nick=supports-uris
  G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION  => (1 +< 2)   # nick=supports-startup-notification
);

constant GEmblemOrigin is export := guint;
our enum GEmblemOriginEnum is export <
  G_EMBLEM_ORIGIN_UNKNOWN
  G_EMBLEM_ORIGIN_DEVICE
  G_EMBLEM_ORIGIN_LIVEMETADATA
  G_EMBLEM_ORIGIN_TAG
>;

constant GFileQueryInfoFlags is export := guint;
our enum GFileQueryInfoFlagsEnum is export (
  G_FILE_QUERY_INFO_NONE              => 0,
  G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS => 1   # nick=nofollow-symlinks
);

constant GFileCreateFlags is export := guint;
our enum GFileCreateFlagsEnum is export (
  G_FILE_CREATE_NONE                => 0,
  G_FILE_CREATE_PRIVATE             => 1,
  G_FILE_CREATE_REPLACE_DESTINATION => 2
);

constant GMountUnmountFlags is export := guint;
our enum GMountUnmountFlagsEnum is export (
  G_MOUNT_UNMOUNT_NONE  => 0,
  G_MOUNT_UNMOUNT_FORCE => 1
);

constant GDriveStartFlags is export := guint;
our enum GDriveStartFlagsEnum is export (
  G_DRIVE_START_NONE => 0
);

constant GDriveStartStopType is export := guint;
our enum GDriveStartStopTypeEnum is export <
  G_DRIVE_START_STOP_TYPE_UNKNOWN
  G_DRIVE_START_STOP_TYPE_SHUTDOWN
  G_DRIVE_START_STOP_TYPE_NETWORK
  G_DRIVE_START_STOP_TYPE_MULTIDISK
  G_DRIVE_START_STOP_TYPE_PASSWORD
>;

constant GFileMeasureFlags is export := guint;
our enum GFileMeasureFlagsEnum is export (
  G_FILE_MEASURE_NONE                 => 0,
  G_FILE_MEASURE_REPORT_ANY_ERROR     => (1 +< 1),
  G_FILE_MEASURE_APPARENT_SIZE        => (1 +< 2),
  G_FILE_MEASURE_NO_XDEV              => (1 +< 3)
);

constant GFileCopyFlags is export := guint;
our enum GFileCopyFlagsEnum is export (
  G_FILE_COPY_NONE                 => 0,          # nick=none
  G_FILE_COPY_OVERWRITE            => 1,
  G_FILE_COPY_BACKUP               => (1 +< 1),
  G_FILE_COPY_NOFOLLOW_SYMLINKS    => (1 +< 2),
  G_FILE_COPY_ALL_METADATA         => (1 +< 3),
  G_FILE_COPY_NO_FALLBACK_FOR_MOVE => (1 +< 4),
  G_FILE_COPY_TARGET_DEFAULT_PERMS => (1 +< 5)
);

constant GFileMonitorFlags is export := guint;
our enum GFileMonitorFlagsEnum is export (
  G_FILE_MONITOR_NONE             => 0,
  G_FILE_MONITOR_WATCH_MOUNTS     => 1,
  G_FILE_MONITOR_SEND_MOVED       => (1 +< 1),
  G_FILE_MONITOR_WATCH_HARD_LINKS => (1 +< 2),
  G_FILE_MONITOR_WATCH_MOVES      => (1 +< 3)
);
