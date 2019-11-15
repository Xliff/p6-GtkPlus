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

constant GTlsCertificateRequestFlags is export := guint;
our enum GTlsCertificateRequestFlagsEnum (
  G_TLS_CERTIFICATE_REQUEST_NONE => 0
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

constant GFileAttributeType is export := guint;
enum GFileAttributeTypeEnum (
  G_FILE_ATTRIBUTE_TYPE_INVALID => 0,
  'G_FILE_ATTRIBUTE_TYPE_STRING',
  'G_FILE_ATTRIBUTE_TYPE_BYTE_STRING',
  'G_FILE_ATTRIBUTE_TYPE_BOOLEAN',
  'G_FILE_ATTRIBUTE_TYPE_UINT32',
  'G_FILE_ATTRIBUTE_TYPE_INT32',
  'G_FILE_ATTRIBUTE_TYPE_UINT64',
  'G_FILE_ATTRIBUTE_TYPE_INT64',
  'G_FILE_ATTRIBUTE_TYPE_OBJECT',
  'G_FILE_ATTRIBUTE_TYPE_STRINGV'
);

constant GFileAttributeInfoFlags is export := guint;
our enum GFileAttributeInfoFlagsEnum is export (
  G_FILE_ATTRIBUTE_INFO_NONE            => 0,
  G_FILE_ATTRIBUTE_INFO_COPY_WITH_FILE  => 1,
  G_FILE_ATTRIBUTE_INFO_COPY_WHEN_MOVED => 2
);

constant GFileAttributeStatus is export := guint;
our enum GFileAttributeStatusEnum is export (
  'G_FILE_ATTRIBUTE_STATUS_UNSET' => 0,
  'G_FILE_ATTRIBUTE_STATUS_SET',
  'G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING'
);

constant GFileMonitorEvent is export := guint;
our enum GFileMonitorEventEnum is export <
  G_FILE_MONITOR_EVENT_CHANGED
  G_FILE_MONITOR_EVENT_CHANGES_DONE_HINT
  G_FILE_MONITOR_EVENT_DELETED
  G_FILE_MONITOR_EVENT_CREATED
  G_FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED
  G_FILE_MONITOR_EVENT_PRE_UNMOUNT
  G_FILE_MONITOR_EVENT_UNMOUNTED
  G_FILE_MONITOR_EVENT_MOVED
  G_FILE_MONITOR_EVENT_RENAMED
  G_FILE_MONITOR_EVENT_MOVED_IN
  G_FILE_MONITOR_EVENT_MOVED_OUT
>;

constant GFileType is export := guint;
our enum GFileTypeEnum is export (
  G_FILE_TYPE_UNKNOWN => 0,
  'G_FILE_TYPE_REGULAR',
  'G_FILE_TYPE_DIRECTORY',
  'G_FILE_TYPE_SYMBOLIC_LINK',
  'G_FILE_TYPE_SPECIAL',
  'G_FILE_TYPE_SHORTCUT',
  'G_FILE_TYPE_MOUNTABLE'
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

constant GSettingsBindFlags is export := guint;
our enum GSettingsBindFlagsEnum is export (
  'G_SETTINGS_BIND_DEFAULT',
  G_SETTINGS_BIND_GET            => 1,
  G_SETTINGS_BIND_SET            => 1 +<1,
  G_SETTINGS_BIND_NO_SENSITIVITY => 1 +<2,
  G_SETTINGS_BIND_GET_NO_CHANGES => 1 +<3,
  G_SETTINGS_BIND_INVERT_BOOLEAN => 1 +<4
);

constant GResourceError is export := guint;
our enum GResourceErrorEnum is export <
  G_RESOURCE_ERROR_NOT_FOUND
  G_RESOURCE_ERROR_INTERNAL
>;

constant GResourceFlags is export := guint;
our enum GResourceFlagsEnum is export (
  G_RESOURCE_FLAGS_NONE       => 0,
  G_RESOURCE_FLAGS_COMPRESSED => 1
);

constant GResourceLookupFlags is export := guint;
our enum GResourceLookupFlagsEnum is export (
  G_RESOURCE_LOOKUP_FLAGS_NONE  => 0
);

constant GSpawnError is export := guint;
our enum GSpawnErrorEnum is export (
  'G_SPAWN_ERROR_FORK',        # fork failed due to lack of memory */
  'G_SPAWN_ERROR_READ',        # read or select on pipes failed */
  'G_SPAWN_ERROR_CHDIR',       # changing to working dir failed */
  'G_SPAWN_ERROR_ACCES',       # execv() returned EACCES */
  'G_SPAWN_ERROR_PERM',        # execv() returned EPERM */
  'G_SPAWN_ERROR_TOO_BIG',     # execv() returned E2BIG */
  'G_SPAWN_ERROR_NOEXEC',      # execv() returned ENOEXEC */
  'G_SPAWN_ERROR_NAMETOOLONG', # ""  "" ENAMETOOLONG */
  'G_SPAWN_ERROR_NOENT',       # ""  "" ENOENT */
  'G_SPAWN_ERROR_NOMEM',       # ""  "" ENOMEM */
  'G_SPAWN_ERROR_NOTDIR',      # ""  "" ENOTDIR */
  'G_SPAWN_ERROR_LOOP',        # ""  "" ELOOP   */
  'G_SPAWN_ERROR_TXTBUSY',     # ""  "" ETXTBUSY */
  'G_SPAWN_ERROR_IO',          # ""  "" EIO */
  'G_SPAWN_ERROR_NFILE',       # ""  "" ENFILE */
  'G_SPAWN_ERROR_MFILE',       # ""  "" EMFLE */
  'G_SPAWN_ERROR_INVAL',       # ""  "" EINVAL */
  'G_SPAWN_ERROR_ISDIR',       # ""  "" EISDIR */
  'G_SPAWN_ERROR_LIBBAD',      # ""  "" ELIBBAD */
  'G_SPAWN_ERROR_FAILED'       # other fatal failure
);

our constant GSpawnFlags is export := guint32;
enum GSpawnFlagsEnum is export (
  G_SPAWN_DEFAULT                => 0,
  G_SPAWN_LEAVE_DESCRIPTORS_OPEN => 1,
  G_SPAWN_DO_NOT_REAP_CHILD      => 1 +< 1,
  G_SPAWN_SEARCH_PATH            => 1 +< 2,
  G_SPAWN_STDOUT_TO_DEV_NULL     => 1 +< 3,
  G_SPAWN_STDERR_TO_DEV_NULL     => 1 +< 4,
  G_SPAWN_CHILD_INHERITS_STDIN   => 1 +< 5,
  G_SPAWN_FILE_AND_ARGV_ZERO     => 1 +< 6,
  G_SPAWN_SEARCH_PATH_FROM_ENVP  => 1 +< 7,
  G_SPAWN_CLOEXEC_PIPES          => 1 +< 8
);

constant GTlsAuthenticationMode is export := guint;
our enum GTlsAuthenticationModeEnum is export <
  G_TLS_AUTHENTICATION_NONE
  G_TLS_AUTHENTICATION_REQUESTED
  G_TLS_AUTHENTICATION_REQUIRED
>;

constant GTlsCertificateFlags is export := guint;
our enum GTlsCertificateFlagsEnum is export (
  G_TLS_CERTIFICATE_UNKNOWN_CA    => (1 +< 0),
  G_TLS_CERTIFICATE_BAD_IDENTITY  => (1 +< 1),
  G_TLS_CERTIFICATE_NOT_ACTIVATED => (1 +< 2),
  G_TLS_CERTIFICATE_EXPIRED       => (1 +< 3),
  G_TLS_CERTIFICATE_REVOKED       => (1 +< 4),
  G_TLS_CERTIFICATE_INSECURE      => (1 +< 5),
  G_TLS_CERTIFICATE_GENERIC_ERROR => (1 +< 6),
  G_TLS_CERTIFICATE_VALIDATE_ALL  => 0x007f
);

constant GTlsDatabaseLookupFlags is export := guint;
our enum GTlsDatabaseLookupFlagsEnum is export (
  G_TLS_DATABASE_LOOKUP_NONE    => 0,
  G_TLS_DATABASE_LOOKUP_KEYPAIR => 1
);

constant GTlsDatabaseVerifyFlags is export := guint;
our enum GTlsDatabaseVerifyFlagsEnum is export (
  G_TLS_DATABASE_VERIFY_NONE => 0
);

constant GTlsInteractionResult is export := guint;
our enum GTlsInteractionResultEnum is export <
  G_TLS_INTERACTION_UNHANDLED
  G_TLS_INTERACTION_HANDLED
  G_TLS_INTERACTION_FAILED
>;

constant GTlsPasswordFlags is export := guint;
our enum GTlsPasswordFlagsEnum is export (
  G_TLS_PASSWORD_NONE       => 0,
  G_TLS_PASSWORD_RETRY      => 1 +< 1,
  G_TLS_PASSWORD_MANY_TRIES => 1 +< 2,
  G_TLS_PASSWORD_FINAL_TRY  => 1 +< 3
);
