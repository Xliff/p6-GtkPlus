use v6.c;

use GLib::Raw::Definitions;

unit package GIO::Roles::Enums;

constant GApplicationFlags               is export := guint32;
our enum GApplicationFlagsEnum           is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32,
  G_APPLICATION_CAN_OVERRIDE_APP_ID  => 64
);

constant GAppInfoCreateFlags             is export := guint;
our enum GAppInfoCreateFlagsEnum         is export (
  G_APP_INFO_CREATE_NONE                           => 0,         # nick=none
  G_APP_INFO_CREATE_NEEDS_TERMINAL                 => 1,         # nick=needs-terminal
  G_APP_INFO_CREATE_SUPPORTS_URIS                  => (1 +< 1),  # nick=supports-uris
  G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION  => (1 +< 2)   # nick=supports-startup-notification
);

constant GAskPasswordFlags               is export := guint;
our enum GAskPasswordFlagsEnum           is export (
  G_ASK_PASSWORD_NEED_PASSWORD           => 1,
  G_ASK_PASSWORD_NEED_USERNAME           => (1 +< 1),
  G_ASK_PASSWORD_NEED_DOMAIN             => (1 +< 2),
  G_ASK_PASSWORD_SAVING_SUPPORTED        => (1 +< 3),
  G_ASK_PASSWORD_ANONYMOUS_SUPPORTED     => (1 +< 4),
  G_ASK_PASSWORD_TCRYPT                  => (1 +< 5)
);

constant GCredentialsType                is export := guint;
our enum GCredentialsTypeEnum            is export <
  G_CREDENTIALS_TYPE_INVALID
  G_CREDENTIALS_TYPE_LINUX_UCRED
  G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED
  G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED
  G_CREDENTIALS_TYPE_SOLARIS_UCRED
  G_CREDENTIALS_TYPE_NETBSD_UNPCBID
>;

constant GConverterFlags                 is export := guint32;
our enum GConverterFlagsEnum             is export (
  G_CONVERTER_NO_FLAGS     => 0,         #< nick=none >
  G_CONVERTER_INPUT_AT_END => 1,         #< nick=input-at-end >
  G_CONVERTER_FLUSH        => (1 +< 1)   #< nick=flush >
);

constant GConverterResult                is export := guint32;
our enum GConverterResultEnum            is export (
  G_CONVERTER_ERROR     => 0,  # < nick=error >
  G_CONVERTER_CONVERTED => 1,  # < nick=converted >
  G_CONVERTER_FINISHED  => 2,  # < nick=finished >
  G_CONVERTER_FLUSHED   => 3   # < nick=flushed >
);

constant GDataStreamByteOrder            is export := guint;
our enum GDataStreamByteOrderEnum        is export <
  G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN
>;

constant GDataStreamNewlineType          is export := guint;
our enum GDataStreamNewlineTypeEnum      is export <
  G_DATA_STREAM_NEWLINE_TYPE_LF
  G_DATA_STREAM_NEWLINE_TYPE_CR
  G_DATA_STREAM_NEWLINE_TYPE_CR_LF
  G_DATA_STREAM_NEWLINE_TYPE_ANY
>;

constant GDriveStartFlags                is export := guint;
our enum GDriveStartFlagsEnum            is export (
  G_DRIVE_START_NONE => 0
);

constant GDriveStartStopType             is export := guint;
our enum GDriveStartStopTypeEnum         is export <
  G_DRIVE_START_STOP_TYPE_UNKNOWN
  G_DRIVE_START_STOP_TYPE_SHUTDOWN
  G_DRIVE_START_STOP_TYPE_NETWORK
  G_DRIVE_START_STOP_TYPE_MULTIDISK
  G_DRIVE_START_STOP_TYPE_PASSWORD
>;

constant GEmblemOrigin                   is export := guint;
our enum GEmblemOriginEnum               is export <
  G_EMBLEM_ORIGIN_UNKNOWN
  G_EMBLEM_ORIGIN_DEVICE
  G_EMBLEM_ORIGIN_LIVEMETADATA
  G_EMBLEM_ORIGIN_TAG
>;

constant GFileAttributeType              is export := guint;
enum GFileAttributeTypeEnum              is export (
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

constant GFileAttributeInfoFlags         is export := guint;
our enum GFileAttributeInfoFlagsEnum     is export (
  G_FILE_ATTRIBUTE_INFO_NONE            => 0,
  G_FILE_ATTRIBUTE_INFO_COPY_WITH_FILE  => 1,
  G_FILE_ATTRIBUTE_INFO_COPY_WHEN_MOVED => 2
);

constant GFileAttributeStatus            is export := guint;
our enum GFileAttributeStatusEnum        is export (
  'G_FILE_ATTRIBUTE_STATUS_UNSET' => 0,
  'G_FILE_ATTRIBUTE_STATUS_SET',
  'G_FILE_ATTRIBUTE_STATUS_ERROR_SETTING'
);

constant GFileCreateFlags                is export := guint;
our enum GFileCreateFlagsEnum            is export (
  G_FILE_CREATE_NONE                => 0,
  G_FILE_CREATE_PRIVATE             => 1,
  G_FILE_CREATE_REPLACE_DESTINATION => 2
);

constant GFileCopyFlags                  is export := guint;
our enum GFileCopyFlagsEnum              is export (
  G_FILE_COPY_NONE                 => 0,          # nick=none
  G_FILE_COPY_OVERWRITE            => 1,
  G_FILE_COPY_BACKUP               => (1 +< 1),
  G_FILE_COPY_NOFOLLOW_SYMLINKS    => (1 +< 2),
  G_FILE_COPY_ALL_METADATA         => (1 +< 3),
  G_FILE_COPY_NO_FALLBACK_FOR_MOVE => (1 +< 4),
  G_FILE_COPY_TARGET_DEFAULT_PERMS => (1 +< 5)
  );

constant GFileType                       is export := guint;
our enum GFileTypeEnum                   is export (
  G_FILE_TYPE_UNKNOWN => 0,
  'G_FILE_TYPE_REGULAR',
  'G_FILE_TYPE_DIRECTORY',
  'G_FILE_TYPE_SYMBOLIC_LINK',
  'G_FILE_TYPE_SPECIAL',
  'G_FILE_TYPE_SHORTCUT',
  'G_FILE_TYPE_MOUNTABLE'
);

constant GFileMeasureFlags               is export := guint;
our enum GFileMeasureFlagsEnum           is export (
  G_FILE_MEASURE_NONE                 => 0,
  G_FILE_MEASURE_REPORT_ANY_ERROR     => (1 +< 1),
  G_FILE_MEASURE_APPARENT_SIZE        => (1 +< 2),
  G_FILE_MEASURE_NO_XDEV              => (1 +< 3)
  );

constant GFileMonitorEvent               is export := guint;
our enum GFileMonitorEventEnum           is export <
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

constant GFileMonitorFlags               is export := guint;
our enum GFileMonitorFlagsEnum           is export (
  G_FILE_MONITOR_NONE             => 0,
  G_FILE_MONITOR_WATCH_MOUNTS     => 1,
  G_FILE_MONITOR_SEND_MOVED       => (1 +< 1),
  G_FILE_MONITOR_WATCH_HARD_LINKS => (1 +< 2),
  G_FILE_MONITOR_WATCH_MOVES      => (1 +< 3)
  );

constant GFileQueryInfoFlags             is export := guint;
our enum GFileQueryInfoFlagsEnum         is export (
  G_FILE_QUERY_INFO_NONE              => 0,
  G_FILE_QUERY_INFO_NOFOLLOW_SYMLINKS => 1   # nick=nofollow-symlinks
  );

constant GIOError                        is export := guint32;
our enum GIOErrorEnum                    is export (
  'G_IO_ERROR_FAILED',
  'G_IO_ERROR_NOT_FOUND',
  'G_IO_ERROR_EXISTS',
  'G_IO_ERROR_IS_DIRECTORY',
  'G_IO_ERROR_NOT_DIRECTORY',
  'G_IO_ERROR_NOT_EMPTY',
  'G_IO_ERROR_NOT_REGULAR_FILE',
  'G_IO_ERROR_NOT_SYMBOLIC_LINK',
  'G_IO_ERROR_NOT_MOUNTABLE_FILE',
  'G_IO_ERROR_FILENAME_TOO_LONG',
  'G_IO_ERROR_INVALID_FILENAME',
  'G_IO_ERROR_TOO_MANY_LINKS',
  'G_IO_ERROR_NO_SPACE',
  'G_IO_ERROR_INVALID_ARGUMENT',
  'G_IO_ERROR_PERMISSION_DENIED',
  'G_IO_ERROR_NOT_SUPPORTED',
  'G_IO_ERROR_NOT_MOUNTED',
  'G_IO_ERROR_ALREADY_MOUNTED',
  'G_IO_ERROR_CLOSED',
  'G_IO_ERROR_CANCELLED',
  'G_IO_ERROR_PENDING',
  'G_IO_ERROR_READ_ONLY',
  'G_IO_ERROR_CANT_CREATE_BACKUP',
  'G_IO_ERROR_WRONG_ETAG',
  'G_IO_ERROR_TIMED_OUT',
  'G_IO_ERROR_WOULD_RECURSE',
  'G_IO_ERROR_BUSY',
  'G_IO_ERROR_WOULD_BLOCK',
  'G_IO_ERROR_HOST_NOT_FOUND',
  'G_IO_ERROR_WOULD_MERGE',
  'G_IO_ERROR_FAILED_HANDLED',
  'G_IO_ERROR_TOO_MANY_OPEN_FILES',
  'G_IO_ERROR_NOT_INITIALIZED',
  'G_IO_ERROR_ADDRESS_IN_USE',
  'G_IO_ERROR_PARTIAL_INPUT',
  'G_IO_ERROR_INVALID_DATA',
  'G_IO_ERROR_DBUS_ERROR',
  'G_IO_ERROR_HOST_UNREACHABLE',
  'G_IO_ERROR_NETWORK_UNREACHABLE',
  'G_IO_ERROR_CONNECTION_REFUSED',
  'G_IO_ERROR_PROXY_FAILED',
  'G_IO_ERROR_PROXY_AUTH_FAILED',
  'G_IO_ERROR_PROXY_NEED_AUTH',
  'G_IO_ERROR_PROXY_NOT_ALLOWED',
  'G_IO_ERROR_BROKEN_PIPE',
  G_IO_ERROR_CONNECTION_CLOSED => 44, # G_IO_ERROR_BROKEN_PIPE,
  'G_IO_ERROR_NOT_CONNECTED',
  'G_IO_ERROR_MESSAGE_TOO_LARGE',

  # Restart from the beginning.
  G_IO_ERROR_NONE      => 0,
  G_IO_ERROR_AGAIN     => 1,
  G_IO_ERROR_INVAL     => 2,
  G_IO_ERROR_UNKNOWN   => 3
);

constant GIOStreamSpliceFlags            is export := uint32;
our enum GIOStreamSpliceFlagsEnum        is export (
  G_IO_STREAM_SPLICE_NONE          => 0,
  G_IO_STREAM_SPLICE_CLOSE_STREAM1 => 1,
  G_IO_STREAM_SPLICE_CLOSE_STREAM2 => (1 +< 1),
  G_IO_STREAM_SPLICE_WAIT_FOR_BOTH => (1 +< 2)
);

constant GModuleFlags                    is export := guint;
our enum GModuleFlagsEnum                is export (
  G_MODULE_BIND_LAZY    => 1,
  G_MODULE_BIND_LOCAL   => 1 +< 1,
  G_MODULE_BIND_MASK    => 0x03
);

constant GMountMountFlags                is export := guint;
our enum GMountMountFlagsEnum            is export (
  G_MOUNT_MOUNT_NONE => 0
);

constant GMountOperationResult           is export := guint;
our enum GMountOperationResultEnum       is export <
  G_MOUNT_OPERATION_HANDLED
  G_MOUNT_OPERATION_ABORTED
  G_MOUNT_OPERATION_UNHANDLED
>;

constant GMountUnmountFlags              is export := guint;
our enum GMountUnmountFlagsEnum          is export (
  G_MOUNT_UNMOUNT_NONE  => 0,
  G_MOUNT_UNMOUNT_FORCE => 1
  );

constant GNetworkConnectivity            is export := guint;
enum GNetworkConnectivityEnum            is export (
  G_NETWORK_CONNECTIVITY_LOCAL       => 1,
  G_NETWORK_CONNECTIVITY_LIMITED     => 2,
  G_NETWORK_CONNECTIVITY_PORTAL      => 3,
  G_NETWORK_CONNECTIVITY_FULL        => 4
);

constant GNotificationPriority           is export := guint;
our enum GNotificationPriorityEnum       is export <
  G_NOTIFICATION_PRIORITY_NORMAL
  G_NOTIFICATION_PRIORITY_LOW
  G_NOTIFICATION_PRIORITY_HIGH
  G_NOTIFICATION_PRIORITY_URGENT
>;

constant GOutputStreamSpliceFlags        is export := uint32;
our enum GOutputStreamSpliceFlagsEnum    is export (
  G_OUTPUT_STREAM_SPLICE_NONE         => 0,
  G_OUTPUT_STREAM_SPLICE_CLOSE_SOURCE => 1,
  G_OUTPUT_STREAM_SPLICE_CLOSE_TARGET => (1 +< 1)
);

constant GResourceError                  is export := guint;
our enum GResourceErrorEnum              is export <
  G_RESOURCE_ERROR_NOT_FOUND
  G_RESOURCE_ERROR_INTERNAL
>;

constant GPasswordSave                   is export := guint;
our enum GPasswordSaveEnum               is export <
  G_PASSWORD_SAVE_NEVER
  G_PASSWORD_SAVE_FOR_SESSION
  G_PASSWORD_SAVE_PERMANENTLY
>;

constant GResourceFlags                  is export := guint;
our enum GResourceFlagsEnum              is export (
  G_RESOURCE_FLAGS_NONE       => 0,
  G_RESOURCE_FLAGS_COMPRESSED => 1
);

constant GResourceLookupFlags            is export := guint;
our enum GResourceLookupFlagsEnum        is export (
  G_RESOURCE_LOOKUP_FLAGS_NONE  => 0
);

constant GResolverNameLookupFlags        is export := guint;
our enum GResolverNameLookupFlagsEnum    is export (
  G_RESOLVER_NAME_LOOKUP_FLAGS_DEFAULT   => 0,
  G_RESOLVER_NAME_LOOKUP_FLAGS_IPV4_ONLY => 1,
  G_RESOLVER_NAME_LOOKUP_FLAGS_IPV6_ONLY => 1 +< 1,
);

constant GResolverError                  is export := guint;
our enum GResolverErrorEnum              is export <
  G_RESOLVER_ERROR_NOT_FOUND
  G_RESOLVER_ERROR_TEMPORARY_FAILURE
  G_RESOLVER_ERROR_INTERNAL
>;

constant GResolverRecordType             is export := guint;
our enum GResolverRecordTypeEnum         is export (
  'G_RESOLVER_RECORD_SRV' => 1,
  'G_RESOLVER_RECORD_MX',
  'G_RESOLVER_RECORD_TXT',
  'G_RESOLVER_RECORD_SOA',
  'G_RESOLVER_RECORD_NS'
);

constant GSettingsBindFlags              is export := guint;
our enum GSettingsBindFlagsEnum          is export (
  'G_SETTINGS_BIND_DEFAULT',
  G_SETTINGS_BIND_GET            => 1,
  G_SETTINGS_BIND_SET            => 1 +<1,
  G_SETTINGS_BIND_NO_SENSITIVITY => 1 +<2,
  G_SETTINGS_BIND_GET_NO_CHANGES => 1 +<3,
  G_SETTINGS_BIND_INVERT_BOOLEAN => 1 +<4
  );

constant GSocketProtocol                 is export := gint;
our enum GSocketProtocolEnum             is export (
  G_SOCKET_PROTOCOL_UNKNOWN => -1,
  G_SOCKET_PROTOCOL_DEFAULT => 0,
  G_SOCKET_PROTOCOL_TCP     => 6,
  G_SOCKET_PROTOCOL_UDP     => 17,
  G_SOCKET_PROTOCOL_SCTP    => 132
);

constant GSocketFamily                   is export := guint;
our enum GSocketFamilyEnum               is export (
  'G_SOCKET_FAMILY_INVALID',
  G_SOCKET_FAMILY_UNIX => GLIB_SYSDEF_AF_UNIX,
  G_SOCKET_FAMILY_IPV4 => GLIB_SYSDEF_AF_INET,
  G_SOCKET_FAMILY_IPV6 => GLIB_SYSDEF_AF_INET6
);

constant GSocketType                     is export := guint;
our enum GSocketTypeEnum                 is export <
  G_SOCKET_TYPE_INVALID
  G_SOCKET_TYPE_STREAM
  G_SOCKET_TYPE_DATAGRAM
  G_SOCKET_TYPE_SEQPACKET
>;

constant GSpawnError                     is export := guint;
our enum GSpawnErrorEnum                 is export (
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

constant GSpawnFlags                     is export := guint32;
our enum GSpawnFlagsEnum                 is export (
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

constant GTlsAuthenticationMode          is export := guint;
our enum GTlsAuthenticationModeEnum      is export <
  G_TLS_AUTHENTICATION_NONE
  G_TLS_AUTHENTICATION_REQUESTED
  G_TLS_AUTHENTICATION_REQUIRED
>;

constant GTlsCertificateFlags            is export := guint;
our enum GTlsCertificateFlagsEnum        is export (
  G_TLS_CERTIFICATE_UNKNOWN_CA    => (1 +< 0),
  G_TLS_CERTIFICATE_BAD_IDENTITY  => (1 +< 1),
  G_TLS_CERTIFICATE_NOT_ACTIVATED => (1 +< 2),
  G_TLS_CERTIFICATE_EXPIRED       => (1 +< 3),
  G_TLS_CERTIFICATE_REVOKED       => (1 +< 4),
  G_TLS_CERTIFICATE_INSECURE      => (1 +< 5),
  G_TLS_CERTIFICATE_GENERIC_ERROR => (1 +< 6),
  G_TLS_CERTIFICATE_VALIDATE_ALL  => 0x007f
);

constant GTlsDatabaseLookupFlags         is export := guint;
our enum GTlsDatabaseLookupFlagsEnum     is export (
  G_TLS_DATABASE_LOOKUP_NONE    => 0,
  G_TLS_DATABASE_LOOKUP_KEYPAIR => 1
);

constant GTlsCertificateRequestFlags     is export := guint;
our enum GTlsCertificateRequestFlagsEnum is export (
  G_TLS_CERTIFICATE_REQUEST_NONE => 0
);

constant GTlsDatabaseVerifyFlags         is export := guint;
our enum GTlsDatabaseVerifyFlagsEnum     is export (
  G_TLS_DATABASE_VERIFY_NONE => 0
);

constant GTlsInteractionResult           is export := guint;
our enum GTlsInteractionResultEnum       is export <
  G_TLS_INTERACTION_UNHANDLED
  G_TLS_INTERACTION_HANDLED
  G_TLS_INTERACTION_FAILED
>;

constant GTlsPasswordFlags               is export := guint;
our enum GTlsPasswordFlagsEnum           is export (
  G_TLS_PASSWORD_NONE       => 0,
  G_TLS_PASSWORD_RETRY      => 1 +< 1,
  G_TLS_PASSWORD_MANY_TRIES => 1 +< 2,
  G_TLS_PASSWORD_FINAL_TRY  => 1 +< 3
);

constant GUnixSocketAddressType          is export := guint;
our enum GUnixSocketAddressTypeEnum      is export <
  G_UNIX_SOCKET_ADDRESS_INVALID
  G_UNIX_SOCKET_ADDRESS_ANONYMOUS
  G_UNIX_SOCKET_ADDRESS_PATH
  G_UNIX_SOCKET_ADDRESS_ABSTRACT
  G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
>;

constant GZlibCompressorFormat           is export := guint;
our enum GZlibCompressorFormatEnum       is export <
  G_ZLIB_COMPRESSOR_FORMAT_ZLIB
  G_ZLIB_COMPRESSOR_FORMAT_GZIP
  G_ZLIB_COMPRESSOR_FORMAT_RAW
>;
