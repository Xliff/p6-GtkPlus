use v6.c;

unit package GTK::Compat::FileTypes;

our enum GAppInfoCreateFlags is export (
  G_APP_INFO_CREATE_NONE                           => 0,         # nick=none
  G_APP_INFO_CREATE_NEEDS_TERMINAL                 => 1,         # nick=needs-terminal
  G_APP_INFO_CREATE_SUPPORTS_URIS                  => (1 +< 1),  # nick=supports-uris
  G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION  => (1 +< 2)   # nick=supports-startup-notification
);

our enum GConverterFlags is export (
  G_CONVERTER_NO_FLAGS     => 0,  # nick=none
  G_CONVERTER_INPUT_AT_END => 1,  # nick=input-at-end
  G_CONVERTER_FLUSH        => 2   # nick=flush
);

our enum GConverterResult is export (
  G_CONVERTER_ERROR     => 0,  # nick=error
  G_CONVERTER_CONVERTED => 1,  # nick=converted
  G_CONVERTER_FINISHED  => 2,  # nick=finished
  G_CONVERTER_FLUSHED   => 3   # nick=flushed
);

our enum GDataStreamByteOrder is export <
  G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN
>;

our enum GDataStreamNewlineType is export <
  G_DATA_STREAM_NEWLINE_TYPE_LF
  G_DATA_STREAM_NEWLINE_TYPE_CR
  G_DATA_STREAM_NEWLINE_TYPE_CR_LF
  G_DATA_STREAM_NEWLINE_TYPE_ANY
>;

our enum GFileAttributeType is export (
  G_FILE_ATTRIBUTE_TYPE_INVALID      => 0,
  'G_FILE_ATTRIBUTE_TYPE_STRING',
  'G_FILE_ATTRIBUTE_TYPE_BYTE_STRING',    # zero terminated string of non-zero bytes
  'G_FILE_ATTRIBUTE_TYPE_BOOLEAN',
  'G_FILE_ATTRIBUTE_TYPE_UINT32',
  'G_FILE_ATTRIBUTE_TYPE_INT32',
  'G_FILE_ATTRIBUTE_TYPE_UINT64',
  'G_FILE_ATTRIBUTE_TYPE_INT64',
  'G_FILE_ATTRIBUTE_TYPE_OBJECT',
  'G_FILE_ATTRIBUTE_TYPE_STRINGV'
);

our enum GFileAttributeInfoFlags is export (
  G_FILE_ATTRIBUTE_INFO_NONE            => 0,
  G_FILE_ATTRIBUTE_INFO_COPY_WITH_FILE  => 1,
  G_FILE_ATTRIBUTE_INFO_COPY_WHEN_MOVED => 2
);

our enum GFileAttributeStatus is export (
  G_FILE_ATTRIBUTE_STATUS_UNSET => 0,
  'G_FILE_ATTRIBUTE_STATUS_SET',
  'G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING'
);

our enum GFileQueryInfoFlags is export (
  G_FILE_QUERY_INFO_NONE              => 0,
  G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS => 1   # nick=nofollow-symlinks
);

our enum GFileCreateFlags is export (
  G_FILE_CREATE_NONE                => 0,
  G_FILE_CREATE_PRIVATE             => 1,
  G_FILE_CREATE_REPLACE_DESTINATION => 2
);

our enum GMountMountFlags is export (
  G_MOUNT_MOUNT_NONE  => 0
);

our enum GMountUnmountFlags is export (
  G_MOUNT_UNMOUNT_NONE  => 0,
  G_MOUNT_UNMOUNT_FORCE => 1
);

our enum GDriveStartFlags is export (
  G_DRIVE_START_NONE => 0
);

our enum GDriveStartStopType is export <
  G_DRIVE_START_STOP_TYPE_UNKNOWN
  G_DRIVE_START_STOP_TYPE_SHUTDOWN
  G_DRIVE_START_STOP_TYPE_NETWORK
  G_DRIVE_START_STOP_TYPE_MULTIDISK
  G_DRIVE_START_STOP_TYPE_PASSWORD
>;

our enum GFileMeasureFlags is export (
  G_FILE_MEASURE_NONE                 => 0,
  G_FILE_MEASURE_REPORT_ANY_ERROR     => (1 +< 1),
  G_FILE_MEASURE_APPARENT_SIZE        => (1 +< 2),
  G_FILE_MEASURE_NO_XDEV              => (1 +< 3)
);

our enum GFileCopyFlags is export (
  G_FILE_COPY_NONE                 => 0,          # nick=none
  G_FILE_COPY_OVERWRITE            => 1,
  G_FILE_COPY_BACKUP               => (1 +< 1),
  G_FILE_COPY_NOFOLLOW_SYMLINKS    => (1 +< 2),
  G_FILE_COPY_ALL_METADATA         => (1 +< 3),
  G_FILE_COPY_NO_FALLBACK_FOR_MOVE => (1 +< 4),
  G_FILE_COPY_TARGET_DEFAULT_PERMS => (1 +< 5)
);

our enum GFileMonitorFlags is export (
  G_FILE_MONITOR_NONE             => 0,
  G_FILE_MONITOR_WATCH_MOUNTS     => 1,
  G_FILE_MONITOR_SEND_MOVED       => (1 +< 1),
  G_FILE_MONITOR_WATCH_HARD_LINKS => (1 +< 2),
  G_FILE_MONITOR_WATCH_MOVES      => (1 +< 3)
);

our enum GFileType is export (
  G_FILE_TYPE_UNKNOWN         => 0,
  'G_FILE_TYPE_REGULAR',
  'G_FILE_TYPE_DIRECTORY',
  'G_FILE_TYPE_SYMBOLIC_LINK',
  'G_FILE_TYPE_SPECIAL',        # socket, fifo, blockdev, chardev
  'G_FILE_TYPE_SHORTCUT',
  'G_FILE_TYPE_MOUNTABLE'
);
