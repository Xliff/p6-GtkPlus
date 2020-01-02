use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Types;

# GIO

constant gio        is export  = 'gio-2.0',v0;

constant GDesktopAppLaunchCallback      is export := Pointer;
constant GIOFunc                        is export := Pointer;
constant GSettingsBindGetMapping        is export := Pointer;
constant GSettingsBindSetMapping        is export := Pointer;
constant GSettingsGetMapping            is export := Pointer;
constant GSpawnChildSetupFunc           is export := Pointer;
constant GVfsFileLookupFunc             is export := Pointer;

class GInputVector  is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GOutputVector is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GInputMessage is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer       $.address;                # GSocketAddress **
  has GInputVector  $.vectors;                # GInputVector *
  has guint         $.num_vectors;
  has gsize         $.bytes_received;
  has gint          $.flags;
  has Pointer       $.control_messages;       # GSocketControlMessage ***
  has CArray[guint] $.num_control_messages;   # Pointer with 1 element == *guint
}

class GOutputMessage is repr('CStruct') does GLib::Roles::Pointers is export {
  has Pointer       $.address;
  has GOutputVector $.vectors;
  has guint         $.num_vectors;
  has guint         $.bytes_sent;
  has Pointer       $.control_messages;
  has guint         $.num_control_messages;
};

class GPermission is repr('CStruct') does GLib::Roles::Pointers is export {
  has uint64 $.dummy1;
  has uint64 $.dummy2;
  has uint64 $.dummy3;
  has uint64 $.dummy4;
}

constant GIOStreamSpliceFlags is export := uint32;
our enum GIOStreamSpliceFlagsEnum is export (
  G_IO_STREAM_SPLICE_NONE          => 0,
  G_IO_STREAM_SPLICE_CLOSE_STREAM1 => 1,
  G_IO_STREAM_SPLICE_CLOSE_STREAM2 => (1 +< 1),
  G_IO_STREAM_SPLICE_WAIT_FOR_BOTH => (1 +< 2)
);

constant GOutputStreamSpliceFlags is export := uint32;
our enum GOutputStreamSpliceFlagsEnum is export (
  G_OUTPUT_STREAM_SPLICE_NONE         => 0,
  G_OUTPUT_STREAM_SPLICE_CLOSE_SOURCE => 1,
  G_OUTPUT_STREAM_SPLICE_CLOSE_TARGET => (1 +< 1)
);

our enum GApplicationFlags is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32,
  G_APPLICATION_CAN_OVERRIDE_APP_ID  => 64
);

constant GAskPasswordFlags is export := guint;
our enum GAskPasswordFlagsEnum is export (
  G_ASK_PASSWORD_NEED_PASSWORD           => 1,
  G_ASK_PASSWORD_NEED_USERNAME           => (1 +< 1),
  G_ASK_PASSWORD_NEED_DOMAIN             => (1 +< 2),
  G_ASK_PASSWORD_SAVING_SUPPORTED        => (1 +< 3),
  G_ASK_PASSWORD_ANONYMOUS_SUPPORTED     => (1 +< 4),
  G_ASK_PASSWORD_TCRYPT                  => (1 +< 5)
);

constant GCredentialsType is export := guint;
our enum GCredentialsTypeEnum is export <
  G_CREDENTIALS_TYPE_INVALID
  G_CREDENTIALS_TYPE_LINUX_UCRED
  G_CREDENTIALS_TYPE_FREEBSD_CMSGCRED
  G_CREDENTIALS_TYPE_OPENBSD_SOCKPEERCRED
  G_CREDENTIALS_TYPE_SOLARIS_UCRED
  G_CREDENTIALS_TYPE_NETBSD_UNPCBID
>;

our constant GMountMountFlags is export := guint;
our enum GMountMountFlagsEnum is export (
  G_MOUNT_MOUNT_NONE => 0
);

constant GMountOperationResult is export := guint;
our enum GMountOperationResultEnum is export <
  G_MOUNT_OPERATION_HANDLED
  G_MOUNT_OPERATION_ABORTED
  G_MOUNT_OPERATION_UNHANDLED
>;

constant GNotificationPriority is export := guint;
our enum GNotificationPriorityEnum is export <
  G_NOTIFICATION_PRIORITY_NORMAL
  G_NOTIFICATION_PRIORITY_LOW
  G_NOTIFICATION_PRIORITY_HIGH
  G_NOTIFICATION_PRIORITY_URGENT
>;

constant GPasswordSave is export := guint;
our enum GPasswordSaveEnum is export <
  G_PASSWORD_SAVE_NEVER
  G_PASSWORD_SAVE_FOR_SESSION
  G_PASSWORD_SAVE_PERMANENTLY
>;

constant GIOChannelError is export := guint;
our enum GIOChannelErrorEnum is export <
  G_IO_CHANNEL_ERROR_FBIG
  G_IO_CHANNEL_ERROR_INVAL
  G_IO_CHANNEL_ERROR_IO
  G_IO_CHANNEL_ERROR_ISDIR
  G_IO_CHANNEL_ERROR_NOSPC
  G_IO_CHANNEL_ERROR_NXIO
  G_IO_CHANNEL_ERROR_OVERFLOW
  G_IO_CHANNEL_ERROR_PIPE
  G_IO_CHANNEL_ERROR_FAILED
>;

our enum GIOError is export (
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

constant GIOStatus is export := guint;
our enum GIOStatusEnum is export <
  G_IO_STATUS_ERROR
  G_IO_STATUS_NORMAL
  G_IO_STATUS_EOF
  G_IO_STATUS_AGAIN
>;

constant GSeekType is export := guint;
our enum GSeekTypeEnum is export <
  G_SEEK_CUR
  G_SEEK_SET
  G_SEEK_END
>;

constant GIOFlags is export := guint;
our enum GIOFlagsEnum is export (
  G_IO_FLAG_APPEND       => 1,
  G_IO_FLAG_NONBLOCK     => 2,
  G_IO_FLAG_IS_READABLE  => 1 +< 2,      # Read only flag
  G_IO_FLAG_IS_WRITABLE  => 1 +< 3,      # Read only flag
  G_IO_FLAG_IS_WRITEABLE => 1 +< 3,      # Misspelling in 2.29.10 and earlier
  G_IO_FLAG_IS_SEEKABLE  => 1 +< 4,      # Read only flag
  G_IO_FLAG_MASK         => (1 +< 5) - 1,
  G_IO_FLAG_GET_MASK     => (1 +< 5) - 1,
  G_IO_FLAG_SET_MASK     => 1 +| 2
);

# cw: These values are for LINUX!
constant GIOCondition is export := guint;
our enum GIOConditionEnum is export (
  G_IO_IN     => 1,
  G_IO_OUT    => 4,
  G_IO_PRI    => 2,
  G_IO_ERR    => 8,
  G_IO_HUP    => 16,
  G_IO_NVAL   => 32,
);

constant GResolverNameLookupFlags is export := guint;
our enum GResolverNameLookupFlagsEnum is export (
  G_RESOLVER_NAME_LOOKUP_FLAGS_DEFAULT   => 0,
  G_RESOLVER_NAME_LOOKUP_FLAGS_IPV4_ONLY => 1,
  G_RESOLVER_NAME_LOOKUP_FLAGS_IPV6_ONLY => 1 +< 1,
);

constant GResolverError is export := guint;
our enum GResolverErrorEnum is export <
  G_RESOLVER_ERROR_NOT_FOUND
  G_RESOLVER_ERROR_TEMPORARY_FAILURE
  G_RESOLVER_ERROR_INTERNAL
>;

constant GResolverRecordType is export := guint;
our enum GResolverRecordTypeEnum is export (
  'G_RESOLVER_RECORD_SRV' => 1,
  'G_RESOLVER_RECORD_MX',
  'G_RESOLVER_RECORD_TXT',
  'G_RESOLVER_RECORD_SOA',
  'G_RESOLVER_RECORD_NS'
);

constant GSocketProtocol is export := gint;
enum GSocketProtocolEnum is export (
  G_SOCKET_PROTOCOL_UNKNOWN => -1,
  G_SOCKET_PROTOCOL_DEFAULT => 0,
  G_SOCKET_PROTOCOL_TCP     => 6,
  G_SOCKET_PROTOCOL_UDP     => 17,
  G_SOCKET_PROTOCOL_SCTP    => 132
);

constant GSocketFamily is export := guint;
our enum GSocketFamilyEnum is export (
  'G_SOCKET_FAMILY_INVALID',
  G_SOCKET_FAMILY_UNIX => GLIB_SYSDEF_AF_UNIX,
  G_SOCKET_FAMILY_IPV4 => GLIB_SYSDEF_AF_INET,
  G_SOCKET_FAMILY_IPV6 => GLIB_SYSDEF_AF_INET6
);

constant GSocketType is export := guint;
our enum GSocketTypeEnum is export <
  G_SOCKET_TYPE_INVALID
  G_SOCKET_TYPE_STREAM
  G_SOCKET_TYPE_DATAGRAM
  G_SOCKET_TYPE_SEQPACKET
>;

constant GNetworkConnectivity is export := guint;
enum GNetworkConnectivityEnum is export (
  G_NETWORK_CONNECTIVITY_LOCAL       => 1,
  G_NETWORK_CONNECTIVITY_LIMITED     => 2,
  G_NETWORK_CONNECTIVITY_PORTAL      => 3,
  G_NETWORK_CONNECTIVITY_FULL        => 4
);

constant GUnixSocketAddressType is export := guint;
our enum GUnixSocketAddressTypeEnum is export <
  G_UNIX_SOCKET_ADDRESS_INVALID
  G_UNIX_SOCKET_ADDRESS_ANONYMOUS
  G_UNIX_SOCKET_ADDRESS_PATH
  G_UNIX_SOCKET_ADDRESS_ABSTRACT
  G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
>;

constant GConverterFlags is export := guint32;
our enum GConverterFlagsEnum is export (
  G_CONVERTER_NO_FLAGS     => 0,         #< nick=none >
  G_CONVERTER_INPUT_AT_END => 1,         #< nick=input-at-end >
  G_CONVERTER_FLUSH        => (1 +< 1)   #< nick=flush >
);

constant GConverterResult is export := guint32;
our enum GConverterResultEnum is export (
  G_CONVERTER_ERROR     => 0,  # < nick=error >
  G_CONVERTER_CONVERTED => 1,  # < nick=converted >
  G_CONVERTER_FINISHED  => 2,  # < nick=finished >
  G_CONVERTER_FLUSHED   => 3   # < nick=flushed >
);

constant GDataStreamByteOrder is export := guint;
our enum GDataStreamByteOrderEnum is export <
  G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN
  G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN
>;

constant GDataStreamNewlineType is export := guint;
our enum GDataStreamNewlineTypeEnum is export <
  G_DATA_STREAM_NEWLINE_TYPE_LF
  G_DATA_STREAM_NEWLINE_TYPE_CR
  G_DATA_STREAM_NEWLINE_TYPE_CR_LF
  G_DATA_STREAM_NEWLINE_TYPE_ANY
>;

our enum GPriority is export (
  G_PRIORITY_HIGH         => -100,
  G_PRIORITY_DEFAULT      => 0,
  G_PRIORITY_HIGH_IDLE    => 100,
  G_PRIORITY_DEFAULT_IDLE => 200,
  G_PRIORITY_LOW          => 300
);

constant GZlibCompressorFormat is export := guint;
our enum GZlibCompressorFormatEnum is export <
  G_ZLIB_COMPRESSOR_FORMAT_ZLIB
  G_ZLIB_COMPRESSOR_FORMAT_GZIP
  G_ZLIB_COMPRESSOR_FORMAT_RAW
>;

# --- GIO TYPES ---
class GAction                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GActionGroup             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GActionMap               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GAppInfo                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GAppInfoMonitor          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GAppLaunchContext        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GApplication             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GAsyncInitable           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GAsyncQueue              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GAsyncResult             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GBookmarkFile            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GBufferedInputStream     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GBufferedOutputStream    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GBytesIcon               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GCancellable             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDesktopAppInfo          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDesktopAppInfoLookup    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDrive                   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GCharsetConverter        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GConverter               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GConverterInputStream    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GConverterOutputStream   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GCredentials             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDataInputStream         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDataOutputStream        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDatagramBased           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDtlsClientConnection    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDtlsConnection          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDtlsServerConnection    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusActionGroup         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusAuthObserver        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusConnection          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusInterface           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusInterfaceSkeleton   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusMessage             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusMethodInvocation    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusObject              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusObjectManager       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusObjectManagerClient is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusObjectManagerServer is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusObjectSkeleton      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusProxy               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusObjectProxy         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDBusServer              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GEmblem                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GEmblemedIcon            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFile                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileAttributeInfo       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileAttributeMatcher    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileDescriptorBased     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileEnumerator          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileIcon                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileInfo                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileInputStream         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileIOStream            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileMonitor             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFilenameCompleter       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFileOutputStream        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFilterInputStream       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GFilterOutputStream      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GIcon                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GInetAddress             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GInetAddressMask         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GInetSocketAddress       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GInitable                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GInputStream             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GIOChannel               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GIOStream                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GListModel               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GListStore               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GLoadableIcon            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMemoryInputStream       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMemoryOutputStream      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMenu                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMenuItem                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMenuAttributeIter       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMenuLinkIter            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMenuModel               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMount                   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMountOperation          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GNetworkAddress          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GNetworkMonitor          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GNetworkService          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GNotification            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GOptionEntry             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GOptionGroup             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GOutputStream            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GPatternSpec             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GPollableInputStream     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GPollableOutputStream    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GPrivate                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GPropertyAction          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GProxy                   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GProxyAddress            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GProxyAddressEnumerator  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GProxyResolver           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GResource                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GRemoteActionGroup       is repr('CPointer') is export does GLib::Roles::Pointers { }
# To be converted into CStruct when I'm not so scurred of it.
# It has bits.... BITS! -- See https://stackoverflow.com/questions/1490092/c-c-force-bit-field-order-and-alignment
class GScannerConfig           is repr('CPointer') is export does GLib::Roles::Pointers { }
# Also has a CStruct representation, and should be converted.
class GScanner                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSettings                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSettingsBackend         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSettingsSchema          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSettingsSchemaKey       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSettingsSchemaSource    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSimpleAction            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSimpleActionGroup       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSimplePermission        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSimpleProxyResolver     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GResolver                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSeekable                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocket                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketClient            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketAddress           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketAddressEnumerator is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketConnectable       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketConnection        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketControlMessage    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketListener          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSocketService           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSrvTarget               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTask                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTcpConnection           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTcpWrapperConnection    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GThemedIcon              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GThreadedSocketService   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsBackend              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsCertificate          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsClientConnection     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsConnection           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsDatabase             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsFileDatabase         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsInteraction          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsPassword             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTlsServerConnection     is repr('CPointer') is export does GLib::Roles::Pointers { }

class GUnixCredentialsMessage  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixConnection          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixFDList              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixFDMessage           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixMountEntry          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixMountMonitor        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixMountPoint          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixInputStream         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixOutputStream        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GUnixSocketAddress       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVfs                     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVolume                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVolumeMonitor           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GZlibCompressor          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GZlibDecompressor        is repr('CPointer') is export does GLib::Roles::Pointers { }

class GFileAttributeInfoList is repr('CStruct') does GLib::Roles::Pointers is export {
  has GFileAttributeInfo $.infos;
  has gint               $.n_infos;
}

class GActionEntry is repr('CStruct') does GLib::Roles::Pointers is export {
  has Str     $!name;
  has Pointer $!activate;
  has Str     $!parameter_type;
  has Str     $!state;
  has Pointer $!change_state;

  # Padding  - Not accessible
  has uint64  $!pad1;
  has uint64  $!pad2;
  has uint64  $!pad3;

  submethod BUILD (
    :$name,
    :&activate,
    :$parameter_type = '',
    :$state          = '',
    :&change_state
  ) {
    self.name           = $name;
    self.activate       = &activate     if &activate.defined;
    self.parameter_type = $parameter_type;
    self.state          = $state;
    self.change_state   = &change_state if &change_state.defined
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $                { $!name },
      STORE => -> $, Str() $val    { self.^attributes(:local)[0]
                                         .set_value(self, $val)    };
  }

  method activate is rw {
    Proxy.new:
      FETCH => -> $ { $!activate },
      STORE => -> $, \func {
        $!activate := set_func_pointer( &(func), &sprintf-SaVP);
      };
  }

  method parameter_type is rw {
    Proxy.new:
      FETCH => -> $                { $!parameter_type },
      STORE => -> $, Str() $val    { self.^attributes(:local)[2]
                                         .set_value(self, $val)    };
  }

  method state is rw {
    Proxy.new:
      FETCH => -> $                { $!state },
      STORE => -> $, Str() $val    { self.^attributes(:local)[3]
                                         .set_value(self, $val)    };
  }

  method change_state is rw {
    Proxy.new:
      FETCH => -> $        { $!activate },
      STORE => -> $, \func {
        $!change_state := set_func_pointer( &(func), &sprintf-SaVP )
      };
  }

  method new (
    $name,
    &activate       = Callable,
    $state          = Str,
    $parameter_type = Str,
    &change_state   = Callable
  ) {
    self.bless(:$name, :&activate, :$parameter_type, :$state, :&change_state);
  }

}

# This should be left to GIO!
sub sprintf-SaVp(Blob, Str, & (GSimpleAction, GVariant, gpointer) --> int64)
    is native is symbol('sprintf') {}
