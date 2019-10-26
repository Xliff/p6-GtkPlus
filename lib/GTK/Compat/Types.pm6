use v6.c;

use nqp;
use NativeCall;

use Cairo;

use GTK::Roles::Pointers;

# Number of times I've had to force compile the whole project.
constant forced = 29;

our $DEBUG is export = 0;

unit package GTK::Compat::Types;

# Cribbed from https://github.com/CurtTilmes/perl6-dbmysql/blob/master/lib/DB/MySQL/Native.pm6
sub malloc  (size_t --> Pointer)                   is export is native {}
sub realloc (Pointer, size_t --> Pointer)          is export is native {}
sub calloc  (size_t, size_t --> Pointer)           is export is native {}
sub memcpy  (Pointer, Pointer ,size_t --> Pointer) is export is native {}
sub memset  (Pointer, int32, size_t)               is export is native {}

our proto sub free (|) is export { * }
multi sub free (Pointer)                           is export is native {}

# Cribbed from https://stackoverflow.com/questions/1281686/determine-size-of-dynamically-allocated-memory-in-c
sub malloc_usable_size (Pointer --> size_t)        is export is native {}

# Implement memcpy_pattern. Take pattern and write pattern.^elem bytes to successive areas in dest.

sub cast($cast-to, $obj) is export {
  nativecast($cast-to, $obj);
}

sub sprintf-vv(Blob, Str, & () --> int64)
  is native is symbol('sprintf') { * }

sub sprintf-vp(Blob, Str, & (Pointer) --> int64 )
  is native is symbol('sprintf') { * }

sub set_func_pointer(
  \func,
  &sprint = &sprintf-vv
) is export {
  my $buf = buf8.allocate(20);
  my $len = &sprint($buf, '%lld', func);
  Pointer.new( $buf.subbuf(^$len).decode.Int );
}

constant glib       is export = 'glib-2.0',v0;
constant gio        is export = 'gio-2.0',v0;
constant gobject    is export = 'gobject-2.0',v0;
constant cairo      is export = 'cairo',v2;
constant gdk        is export = 'gdk-3',v0;
constant gdk-pixbuf is export = 'gdk_pixbuf-2.0',v0;
constant gtk        is export = 'gtk-3',v0;

sub g_destroy_none(Pointer)
  is export
{ * }

sub g_free (Pointer)
  is native(glib)
  is export
{ * }

class GError is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $!message;

  submethod BUILD (:$!domain, :$!code, :$message) {
    self.message = $message;
  }

  method new ($domain, $code, $message) {
    self.bless(:$domain, :$code, :$message);
  }

  method message is rw {
    Proxy.new:
      FETCH => -> $ { $!message },
      STORE => -> $, Str() $val {
        ::?CLASS.^attributes[* - 1].set_value(self, $val)
      };
  }
}

our $ERROR is export;

sub gerror is export {
  my $cge = CArray[Pointer[GError]].new;
  $cge[0] = Pointer[GError];
  $cge;
}

sub g_error_free(GError $err)
  is native(glib)
  is export
  { *  }

sub clear_error($error = $ERROR) is export {
  g_error_free($error) if $error.defined;
  $ERROR = Nil;
}

sub set_error(CArray $e) is export {
  $ERROR = $e[0].deref if $e[0].defined;
}

sub unstable_get_type($name, &sub, $n is rw, $t is rw) is export {
  return $t if ($n // 0) > 0;
  repeat {
    $t = &sub();
    die "{ $name }.get_type could not get stable result"
      if $n++ > 20;
  } until $t == &sub();
  $t;
}

constant GDK_MAX_TIMECOORD_AXES is export = 128;

constant cairo_t             is export := Cairo::cairo_t;
constant cairo_format_t      is export := Cairo::cairo_format_t;
constant cairo_pattern_t     is export := Cairo::cairo_pattern_t;
constant cairo_region_t      is export := Pointer;

constant gboolean            is export := uint32;
constant gchar               is export := Str;
constant gconstpointer       is export := Pointer;
constant gdouble             is export := num64;
constant gfloat              is export := num32;
constant gint                is export := int32;
constant gint8               is export := int8;
constant gint16              is export := int16;
constant gint32              is export := int32;
constant gint64              is export := int64;
constant glong               is export := int64;
constant goffset             is export := uint64;
constant gpointer            is export := Pointer;
constant gsize               is export := uint64;
constant gssize              is export := int64;
constant guchar              is export := Str;
constant gshort              is export := int8;
constant gushort             is export := uint8;
constant guint               is export := uint32;
constant guint8              is export := uint8;
constant guint16             is export := uint16;
constant guint32             is export := uint32;
constant guint64             is export := uint64;
constant gulong              is export := uint64;
constant gunichar            is export := uint32;
constant gunichar2           is export := uint16;
constant va_list             is export := Pointer;
constant time_t              is export := uint64;
constant uid_t               is export := uint32;
constant gid_t               is export := uint32;
constant pid_t               is export := int32;

# Function Pointers
constant GAsyncReadyCallback     is export := Pointer;
constant GBindingTransformFunc   is export := Pointer;
constant GCallback               is export := Pointer;
constant GCompareDataFunc        is export := Pointer;
constant GCompareFunc            is export := Pointer;
constant GCopyFunc               is export := Pointer;
constant GClosureNotify          is export := Pointer;
constant GDestroyNotify          is export := Pointer;
constant GEqualFunc              is export := Pointer;
constant GFunc                   is export := Pointer;
constant GHFunc                  is export := Pointer;
constant GIOFunc                 is export := Pointer;
constant GLogFunc                is export := Pointer;
constant GLogWriterFunc          is export := Pointer;
constant GPrintFunc              is export := Pointer;
constant GReallocFunc            is export := Pointer;
constant GSettingsBindGetMapping is export := Pointer;
constant GSettingsBindSetMapping is export := Pointer;
constant GSettingsGetMapping     is export := Pointer;
constant GSignalAccumulator      is export := Pointer;
constant GSignalEmissionHook     is export := Pointer;
constant GSignalCMarshaller      is export := Pointer;
constant GSignalCVaMarshaller    is export := Pointer;
constant GThreadFunc             is export := Pointer;
constant GVfsFileLookupFunc      is export := Pointer;

constant GDate                   is export := uint64;
constant GPid                    is export := gint;
constant GQuark                  is export := uint32;
constant GStrv                   is export := CArray[Str];
constant GTimeSpan               is export := int64;
constant GType                   is export := uint64;

constant GdkFilterFunc                  is export := Pointer;
constant GdkPixbufDestroyNotify         is export := Pointer;
constant GdkPixbufSaveFunc              is export := Pointer;
constant GdkSeatGrabPrepareFunc         is export := Pointer;
constant GdkWindowChildFunc             is export := Pointer;
constant GdkWindowInvalidateHandlerFunc is export := Pointer;
constant GdkWMFunction                  is export := Pointer;

class GTypeInstance is repr('CStruct') does GTK::Roles::Pointers is export { ... }

sub g_type_check_instance_is_a (
  GTypeInstance  $instance,
  GType          $iface_type
)
  returns uint32
  is native(gobject)
{ * }

sub real-resolve-uint64($v) is export {
  $v +& 0xffffffffffffffff;
}

class GTypeClass is repr('CStruct') does GTK::Roles::Pointers is export {
  has GType      $.g_type;
}
class GTypeInstance {
  has GTypeClass $.g_class;

  method checkType($compare_type) {
    my GType $ct = real-resolve-uint64($compare_type);
    self.g_class.defined ??
      $ct == self.g_class.g_type               !!
      g_type_check_instance_is_a(self, $ct) ;
  }

  method getType {
    self.g_class.g_type;
  }
}

# Used ONLY in those situations where cheating is just plain REQUIRED.
class GObjectStruct is repr('CStruct') does GTK::Roles::Pointers is export {
  HAS GTypeInstance  $.g_type_instance;
  has uint32         $.ref_count;
  has gpointer       $!qdata;

  method checkType ($compare_type) {
    self.g_type_instance.checkType($compare_type)
  }

  method getType {
    self.g_type_instance.getType
  }
}

class GInputVector  is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GInputMessage is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer       $.address;                # GSocketAddress **
  has GInputVector  $.vectors;                # GInputVector *
  has guint         $.num_vectors;
  has gsize         $.bytes_received;
  has gint          $.flags;
  has Pointer       $.control_messages;       # GSocketControlMessage ***
  has CArray[guint] $.num_control_messages;   # Pointer with 1 element == *guint
}

class GOutputVector is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $.buffer;
  has gssize  $.size;
}

class GOutputMessage is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer       $.address;
  has GOutputVector $.vectors;
  has guint         $.num_vectors;
  has guint         $.bytes_sent;
  has Pointer       $.control_messages;
  has guint         $.num_control_messages;
};


class GList is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!data;
  has GList   $.next;
  has GList   $.prev;

  method data is rw {
    Proxy.new:
      FETCH => -> $              { $!data },
      STORE => -> $, GList() $nv {
        # Thank GOD we can now replace this monstrosity:
        # nqp::bindattr(
        #   nqp::decont(self),
        #   GList,
        #   '$!data',
        #   nqp::decont( nativecast(Pointer, $nv) )
        # )
        # ...with this lesser one:
        ::?CLASS.^Attributes[0].set_value(self, $nv);
      };
  }
}

class GPermission is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint64 $.dummy1;
  has uint64 $.dummy2;
  has uint64 $.dummy3;
  has uint64 $.dummy4;
}

class GSList is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!data;
  has GSList  $.next;
}

class GString is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str     $.str;
  has uint64  $.len;              # NOTE: Should be processor wordsize, so using 64 bit.
  has uint64  $.allocated_len;    # NOTE: Should be processor wordsize, so using 64 bit.
}

class GTypeValueList is repr('CUnion') does GTK::Roles::Pointers is export {
  has int32	          $.v_int     is rw;
  has uint32          $.v_uint    is rw;
  has long            $.v_long    is rw;
  has ulong           $.v_ulong   is rw;
  has int64           $.v_int64   is rw;
  has uint64          $.v_uint64  is rw;
  has num32           $.v_float   is rw;
  has num64           $.v_double  is rw;
  has OpaquePointer   $.v_pointer is rw;
};

class GValue is repr('CStruct') does GTK::Roles::Pointers is export {
  has ulong           $.g_type is rw;
  HAS GTypeValueList  $.data1  is rw;
  HAS GTypeValueList  $.data2  is rw;
}

class GPtrArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has CArray[Pointer] $.pdata;
  has guint           $.len;
}

class GSignalInvocationHint is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has guint   $.signal_id;
  has GQuark  $.detail;
  has guint32 $.run_type;             # GSignalFlags
}

class GSignalQuery is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint          $.signal_id;
  has Str            $.signal_name;
  has GType          $.itype;
  has guint32        $.signal_flags;  # GSignalFlags
  has GType          $.return_type;
  has guint          $.n_params;
  has CArray[uint64] $.param_types;
}

class GLogField is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str     $.key;
  has Pointer $.value;
  has int64   $.length;
}

class GPollFDNonWin is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint	    $.fd;
  has gushort 	$.events;
  has gushort 	$.revents;
}
class GPollFDWin is repr('CStruct') does GTK::Roles::Pointers is export {
  has gushort 	$.events;
  has gushort 	$.revents;
}

constant GPollFD is export := GPollFDNonWin;

class GTimeVal is repr('CStruct') does GTK::Roles::Pointers is export {
  has glong $.tv_sec;
  has glong $.tv_usec;
};

class GValueArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint    $.n_values;
  has gpointer $.values; # GValue *
};

# Because an enum wasn't good enough due to:
# "Incompatible MROs in P6opaque rebless for types GLIB_SYSDEF_LINUX and GSocketFamily"
constant GLIB_SYSDEF_POLLIN        = 1;
constant GLIB_SYSDEF_POLLOUT       = 4;
constant GLIB_SYSDEF_POLLPRI       = 2;
constant GLIB_SYSDEF_POLLHUP       = 16;
constant GLIB_SYSDEF_POLLERR       = 8;
constant GLIB_SYSDEF_POLLNVAL      = 32;
constant GLIB_SYSDEF_AF_UNIX       = 1;
constant GLIB_SYSDEF_AF_INET       = 2;
constant GLIB_SYSDEF_AF_INET6      = 10;
constant GLIB_SYSDEF_MSG_OOB       = 1;
constant GLIB_SYSDEF_MSG_PEEK      = 2;
constant GLIB_SYSDEF_MSG_DONTROUTE = 4;

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

our enum GTypeEnum is export (
  G_TYPE_INVALID   => 0,
  G_TYPE_NONE      => (1  +< 2),
  G_TYPE_INTERFACE => (2  +< 2),
  G_TYPE_CHAR      => (3  +< 2),
  G_TYPE_UCHAR     => (4  +< 2),
  G_TYPE_BOOLEAN   => (5  +< 2),
  G_TYPE_INT       => (6  +< 2),
  G_TYPE_UINT      => (7  +< 2),
  G_TYPE_LONG      => (8  +< 2),
  G_TYPE_ULONG     => (9  +< 2),
  G_TYPE_INT64     => (10 +< 2),
  G_TYPE_UINT64    => (11 +< 2),
  G_TYPE_ENUM      => (12 +< 2),
  G_TYPE_FLAGS     => (13 +< 2),
  G_TYPE_FLOAT     => (14 +< 2),
  G_TYPE_DOUBLE    => (15 +< 2),
  G_TYPE_STRING    => (16 +< 2),
  G_TYPE_POINTER   => (17 +< 2),
  G_TYPE_BOXED     => (18 +< 2),
  G_TYPE_PARAM     => (19 +< 2),
  G_TYPE_OBJECT    => (20 +< 2),
  G_TYPE_VARIANT   => (21 +< 2),

  G_TYPE_RESERVED_GLIB_FIRST => 22,
  G_TYPE_RESERVED_GLIB_LAST  => 31,
  G_TYPE_RESERVED_BSE_FIRST  => 32,
  G_TYPE_RESERVED_BSE_LAST   => 48,
  G_TYPE_RESERVED_USER_FIRST => 49
);

constant GTimeType is export  := guint;
our enum GTimeTypeEnum is export <
  G_TIME_TYPE_STANDARD
  G_TIME_TYPE_DAYLIGHT
  G_TIME_TYPE_UNIVERSAL
>;

constant GPollableReturn is export := gint;
our enum GPollableReturnEnum is export (
  G_POLLABLE_RETURN_FAILED       => 0,
  G_POLLABLE_RETURN_OK           => 1,
  G_POLLABLE_RETURN_WOULD_BLOCK  => -27 # -G_IO_ERROR_WOULD_BLOCK
);

# Uint32. Be careful not to conflate this with GVariantType which is a pointer!
our enum GVariantTypeEnum is export <
  G_VARIANT_CLASS_BOOLEAN
  G_VARIANT_CLASS_BYTE
  G_VARIANT_CLASS_INT16
  G_VARIANT_CLASS_UINT16
  G_VARIANT_CLASS_INT32
  G_VARIANT_CLASS_UINT32
  G_VARIANT_CLASS_INT64
  G_VARIANT_CLASS_UINT64
  G_VARIANT_CLASS_HANDLE
  G_VARIANT_CLASS_DOUBLE
  G_VARIANT_CLASS_STRING
  G_VARIANT_CLASS_OBJECT_PATH
  G_VARIANT_CLASS_SIGNATURE
  G_VARIANT_CLASS_VARIANT
  G_VARIANT_CLASS_MAYBE
  G_VARIANT_CLASS_ARRAY
  G_VARIANT_CLASS_TUPLE
  G_VARIANT_CLASS_DICT_ENTRY
>;

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

our enum GSettingsBindFlags is export (
  G_SETTINGS_BIND_DEFAULT        => 0,        # Assumption! See /usr/include/glib-2.0/gio/gsettings.h
  G_SETTINGS_BIND_GET            => 1,
  G_SETTINGS_BIND_SET            => 1 +< 1,
  G_SETTINGS_BIND_NO_SENSITIVITY => 1 +< 2,
  G_SETTINGS_BIND_GET_NO_CHANGES => 1 +< 3,
  G_SETTINGS_BIND_INVERT_BOOLEAN => 1 +< 4
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

our enum GBindingFlags is export (
  G_BINDING_DEFAULT        => 0,
  G_BINDING_BIDIRECTIONAL  => 1,
  G_BINDING_SYNC_CREATE    => 1 +< 1,
  G_BINDING_INVERT_BOOLEAN => 1 +< 2
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

our enum GNotificationPriority is export <
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

our enum GIOChannelError is export <
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

our enum GIOStatus is export <
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

our enum GIOFlags is export (
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

constant GChecksumType is export := guint;
our enum GChecksumTypeEnum is export <
  G_CHECKSUM_MD5,
  G_CHECKSUM_SHA1,
  G_CHECKSUM_SHA256,
  G_CHECKSUM_SHA512,
  G_CHECKSUM_SHA384
>;

constant GUnicodeType is export := guint;
our enum GUnicodeTypeEnum is export <
  G_UNICODE_CONTROL
  G_UNICODE_FORMAT
  G_UNICODE_UNASSIGNED
  G_UNICODE_PRIVATE_USE
  G_UNICODE_SURROGATE
  G_UNICODE_LOWERCASE_LETTER
  G_UNICODE_MODIFIER_LETTER
  G_UNICODE_OTHER_LETTER
  G_UNICODE_TITLECASE_LETTER
  G_UNICODE_UPPERCASE_LETTER
  G_UNICODE_SPACING_MARK
  G_UNICODE_ENCLOSING_MARK
  G_UNICODE_NON_SPACING_MARK
  G_UNICODE_DECIMAL_NUMBER
  G_UNICODE_LETTER_NUMBER
  G_UNICODE_OTHER_NUMBER
  G_UNICODE_CONNECT_PUNCTUATION
  G_UNICODE_DASH_PUNCTUATION
  G_UNICODE_CLOSE_PUNCTUATION
  G_UNICODE_FINAL_PUNCTUATION
  G_UNICODE_INITIAL_PUNCTUATION
  G_UNICODE_OTHER_PUNCTUATION
  G_UNICODE_OPEN_PUNCTUATION
  G_UNICODE_CURRENCY_SYMBOL
  G_UNICODE_MODIFIER_SYMBOL
  G_UNICODE_MATH_SYMBOL
  G_UNICODE_OTHER_SYMBOL
  G_UNICODE_LINE_SEPARATOR
  G_UNICODE_PARAGRAPH_SEPARATOR
  G_UNICODE_SPACE_SEPARATOR
>;

constant GUnicodeBreakType is export := guint;
our enum GUnicodeBreakTypeEnum is export <
  G_UNICODE_BREAK_MANDATORY
  G_UNICODE_BREAK_CARRIAGE_RETURN
  G_UNICODE_BREAK_LINE_FEED
  G_UNICODE_BREAK_COMBINING_MARK
  G_UNICODE_BREAK_SURROGATE
  G_UNICODE_BREAK_ZERO_WIDTH_SPACE
  G_UNICODE_BREAK_INSEPARABLE
  G_UNICODE_BREAK_NON_BREAKING_GLUE
  G_UNICODE_BREAK_CONTINGENT
  G_UNICODE_BREAK_SPACE
  G_UNICODE_BREAK_AFTER
  G_UNICODE_BREAK_BEFORE
  G_UNICODE_BREAK_BEFORE_AND_AFTER
  G_UNICODE_BREAK_HYPHEN
  G_UNICODE_BREAK_NON_STARTER
  G_UNICODE_BREAK_OPEN_PUNCTUATION
  G_UNICODE_BREAK_CLOSE_PUNCTUATION
  G_UNICODE_BREAK_QUOTATION
  G_UNICODE_BREAK_EXCLAMATION
  G_UNICODE_BREAK_IDEOGRAPHIC
  G_UNICODE_BREAK_NUMERIC
  G_UNICODE_BREAK_INFIX_SEPARATOR
  G_UNICODE_BREAK_SYMBOL
  G_UNICODE_BREAK_ALPHABETIC
  G_UNICODE_BREAK_PREFIX
  G_UNICODE_BREAK_POSTFIX
  G_UNICODE_BREAK_COMPLEX_CONTEXT
  G_UNICODE_BREAK_AMBIGUOUS
  G_UNICODE_BREAK_UNKNOWN
  G_UNICODE_BREAK_NEXT_LINE
  G_UNICODE_BREAK_WORD_JOINER
  G_UNICODE_BREAK_HANGUL_L_JAMO
  G_UNICODE_BREAK_HANGUL_V_JAMO
  G_UNICODE_BREAK_HANGUL_T_JAMO
  G_UNICODE_BREAK_HANGUL_LV_SYLLABLE
  G_UNICODE_BREAK_HANGUL_LVT_SYLLABLE
  G_UNICODE_BREAK_CLOSE_PARANTHESIS
  G_UNICODE_BREAK_CONDITIONAL_JAPANESE_STARTER
  G_UNICODE_BREAK_HEBREW_LETTER
  G_UNICODE_BREAK_REGIONAL_INDICATOR
  G_UNICODE_BREAK_EMOJI_BASE
  G_UNICODE_BREAK_EMOJI_MODIFIER
  G_UNICODE_BREAK_ZERO_WIDTH_JOINER
>;

constant GUnicodeScript is export := guint;
our enum GUnicodeScriptEnum is export (
  # ISO 15924 code
  G_UNICODE_SCRIPT_INVALID_CODE => -1,
  G_UNICODE_SCRIPT_COMMON       => 0,  # Zyyy
  'G_UNICODE_SCRIPT_INHERITED',          # Zinh (Qaai)
  'G_UNICODE_SCRIPT_ARABIC',             # Arab
  'G_UNICODE_SCRIPT_ARMENIAN',           # Armn
  'G_UNICODE_SCRIPT_BENGALI',            # Beng
  'G_UNICODE_SCRIPT_BOPOMOFO',           # Bopo
  'G_UNICODE_SCRIPT_CHEROKEE',           # Cher
  'G_UNICODE_SCRIPT_COPTIC',             # Copt (Qaac)
  'G_UNICODE_SCRIPT_CYRILLIC',           # Cyrl (Cyrs)
  'G_UNICODE_SCRIPT_DESERET',            # Dsrt
  'G_UNICODE_SCRIPT_DEVANAGARI',         # Deva
  'G_UNICODE_SCRIPT_ETHIOPIC',           # Ethi
  'G_UNICODE_SCRIPT_GEORGIAN',           # Geor (Geon, Geoa)
  'G_UNICODE_SCRIPT_GOTHIC',             # Goth
  'G_UNICODE_SCRIPT_GREEK',              # Grek
  'G_UNICODE_SCRIPT_GUJARATI',           # Gujr
  'G_UNICODE_SCRIPT_GURMUKHI',           # Guru
  'G_UNICODE_SCRIPT_HAN',                # Hani
  'G_UNICODE_SCRIPT_HANGUL',             # Hang
  'G_UNICODE_SCRIPT_HEBREW',             # Hebr
  'G_UNICODE_SCRIPT_HIRAGANA',           # Hira
  'G_UNICODE_SCRIPT_KANNADA',            # Knda
  'G_UNICODE_SCRIPT_KATAKANA',           # Kana
  'G_UNICODE_SCRIPT_KHMER',              # Khmr
  'G_UNICODE_SCRIPT_LAO',                # Laoo
  'G_UNICODE_SCRIPT_LATIN',              # Latn (Latf, Latg)
  'G_UNICODE_SCRIPT_MALAYALAM',          # Mlym
  'G_UNICODE_SCRIPT_MONGOLIAN',          # Mong
  'G_UNICODE_SCRIPT_MYANMAR',            # Mymr
  'G_UNICODE_SCRIPT_OGHAM',              # Ogam
  'G_UNICODE_SCRIPT_OLD_ITALIC',         # Ital
  'G_UNICODE_SCRIPT_ORIYA',              # Orya
  'G_UNICODE_SCRIPT_RUNIC',              # Runr
  'G_UNICODE_SCRIPT_SINHALA',            # Sinh
  'G_UNICODE_SCRIPT_SYRIAC',             # Syrc (Syrj, Syrn, Syre)
  'G_UNICODE_SCRIPT_TAMIL',              # Taml
  'G_UNICODE_SCRIPT_TELUGU',             # Telu
  'G_UNICODE_SCRIPT_THAANA',             # Thaa
  'G_UNICODE_SCRIPT_THAI',               # Thai
  'G_UNICODE_SCRIPT_TIBETAN',            # Tibt
  'G_UNICODE_SCRIPT_CANADIAN_ABORIGINAL',# Cans
  'G_UNICODE_SCRIPT_YI',                 # Yiii
  'G_UNICODE_SCRIPT_TAGALOG',            # Tglg
  'G_UNICODE_SCRIPT_HANUNOO',            # Hano
  'G_UNICODE_SCRIPT_BUHID',              # Buhd
  'G_UNICODE_SCRIPT_TAGBANWA',           # Tagb

  # Unicode-4.0 additions
  'G_UNICODE_SCRIPT_BRAILLE',            # Brai
  'G_UNICODE_SCRIPT_CYPRIOT',            # Cprt
  'G_UNICODE_SCRIPT_LIMBU',              # Limb
  'G_UNICODE_SCRIPT_OSMANYA',            # Osma
  'G_UNICODE_SCRIPT_SHAVIAN',            # Shaw
  'G_UNICODE_SCRIPT_LINEAR_B',           # Linb
  'G_UNICODE_SCRIPT_TAI_LE',             # Tale
  'G_UNICODE_SCRIPT_UGARITIC',           # Ugar

  # Unicode-4.1 additions
  'G_UNICODE_SCRIPT_NEW_TAI_LUE',        # Talu
  'G_UNICODE_SCRIPT_BUGINESE',           # Bugi
  'G_UNICODE_SCRIPT_GLAGOLITIC',         # Glag
  'G_UNICODE_SCRIPT_TIFINAGH',           # Tfng
  'G_UNICODE_SCRIPT_SYLOTI_NAGRI',       # Sylo
  'G_UNICODE_SCRIPT_OLD_PERSIAN',        # Xpeo
  'G_UNICODE_SCRIPT_KHAROSHTHI',         # Khar

  # Unicode-5.0 additions
  'G_UNICODE_SCRIPT_UNKNOWN',            # Zzzz
  'G_UNICODE_SCRIPT_BALINESE',           # Bali
  'G_UNICODE_SCRIPT_CUNEIFORM',          # Xsux
  'G_UNICODE_SCRIPT_PHOENICIAN',         # Phnx
  'G_UNICODE_SCRIPT_PHAGS_PA',           # Phag
  'G_UNICODE_SCRIPT_NKO',                # Nkoo

  # Unicode-5.1 additions
  'G_UNICODE_SCRIPT_KAYAH_LI',           # Kali
  'G_UNICODE_SCRIPT_LEPCHA',             # Lepc
  'G_UNICODE_SCRIPT_REJANG',             # Rjng
  'G_UNICODE_SCRIPT_SUNDANESE',          # Sund
  'G_UNICODE_SCRIPT_SAURASHTRA',         # Saur
  'G_UNICODE_SCRIPT_CHAM',               # Cham
  'G_UNICODE_SCRIPT_OL_CHIKI',           # Olck
  'G_UNICODE_SCRIPT_VAI',                # Vaii
  'G_UNICODE_SCRIPT_CARIAN',             # Cari
  'G_UNICODE_SCRIPT_LYCIAN',             # Lyci
  'G_UNICODE_SCRIPT_LYDIAN',             # Lydi

  # Unicode-5.2 additions
  'G_UNICODE_SCRIPT_AVESTAN',                # Avst
  'G_UNICODE_SCRIPT_BAMUM',                  # Bamu
  'G_UNICODE_SCRIPT_EGYPTIAN_HIEROGLYPHS',   # Egyp
  'G_UNICODE_SCRIPT_IMPERIAL_ARAMAIC',       # Armi
  'G_UNICODE_SCRIPT_INSCRIPTIONAL_PAHLAVI',  # Phli
  'G_UNICODE_SCRIPT_INSCRIPTIONAL_PARTHIAN', # Prti
  'G_UNICODE_SCRIPT_JAVANESE',               # Java
  'G_UNICODE_SCRIPT_KAITHI',                 # Kthi
  'G_UNICODE_SCRIPT_LISU',                   # Lisu
  'G_UNICODE_SCRIPT_MEETEI_MAYEK',           # Mtei
  'G_UNICODE_SCRIPT_OLD_SOUTH_ARABIAN',      # Sarb
  'G_UNICODE_SCRIPT_OLD_TURKIC',             # Orkh
  'G_UNICODE_SCRIPT_SAMARITAN',              # Samr
  'G_UNICODE_SCRIPT_TAI_THAM',               # Lana
  'G_UNICODE_SCRIPT_TAI_VIET',               # Tavt

  # Unicode-6.0 additions
  'G_UNICODE_SCRIPT_BATAK',                  # Batk
  'G_UNICODE_SCRIPT_BRAHMI',                 # Brah
  'G_UNICODE_SCRIPT_MANDAIC',                # Mand

  # Unicode-6.1 additions
  'G_UNICODE_SCRIPT_CHAKMA',                 # Cakm
  'G_UNICODE_SCRIPT_MEROITIC_CURSIVE',       # Merc
  'G_UNICODE_SCRIPT_MEROITIC_HIEROGLYPHS',   # Mero
  'G_UNICODE_SCRIPT_MIAO',                   # Plrd
  'G_UNICODE_SCRIPT_SHARADA',                # Shrd
  'G_UNICODE_SCRIPT_SORA_SOMPENG',           # Sora
  'G_UNICODE_SCRIPT_TAKRI',                  # Takr

  # Unicode 7.0 additions
  'G_UNICODE_SCRIPT_BASSA_VAH',              # Bass
  'G_UNICODE_SCRIPT_CAUCASIAN_ALBANIAN',     # Aghb
  'G_UNICODE_SCRIPT_DUPLOYAN',               # Dupl
  'G_UNICODE_SCRIPT_ELBASAN',                # Elba
  'G_UNICODE_SCRIPT_GRANTHA',                # Gran
  'G_UNICODE_SCRIPT_KHOJKI',                 # Khoj
  'G_UNICODE_SCRIPT_KHUDAWADI',              # Sind
  'G_UNICODE_SCRIPT_LINEAR_A',               # Lina
  'G_UNICODE_SCRIPT_MAHAJANI',               # Mahj
  'G_UNICODE_SCRIPT_MANICHAEAN',             # Manu
  'G_UNICODE_SCRIPT_MENDE_KIKAKUI',          # Mend
  'G_UNICODE_SCRIPT_MODI',                   # Modi
  'G_UNICODE_SCRIPT_MRO',                    # Mroo
  'G_UNICODE_SCRIPT_NABATAEAN',              # Nbat
  'G_UNICODE_SCRIPT_OLD_NORTH_ARABIAN',      # Narb
  'G_UNICODE_SCRIPT_OLD_PERMIC',             # Perm
  'G_UNICODE_SCRIPT_PAHAWH_HMONG',           # Hmng
  'G_UNICODE_SCRIPT_PALMYRENE',              # Palm
  'G_UNICODE_SCRIPT_PAU_CIN_HAU',            # Pauc
  'G_UNICODE_SCRIPT_PSALTER_PAHLAVI',        # Phlp
  'G_UNICODE_SCRIPT_SIDDHAM',                # Sidd
  'G_UNICODE_SCRIPT_TIRHUTA',                # Tirh
  'G_UNICODE_SCRIPT_WARANG_CITI',            # Wara

  # Unicode 8.0 additions
  'G_UNICODE_SCRIPT_AHOM',                   # Ahom
  'G_UNICODE_SCRIPT_ANATOLIAN_HIEROGLYPHS',  # Hluw
  'G_UNICODE_SCRIPT_HATRAN',                 # Hatr
  'G_UNICODE_SCRIPT_MULTANI',                # Mult
  'G_UNICODE_SCRIPT_OLD_HUNGARIAN',          # Hung
  'G_UNICODE_SCRIPT_SIGNWRITING',            # Sgnw

  # Unicode 9.0 additions
  'G_UNICODE_SCRIPT_ADLAM',                  # Adlm
  'G_UNICODE_SCRIPT_BHAIKSUKI',              # Bhks
  'G_UNICODE_SCRIPT_MARCHEN',                # Marc
  'G_UNICODE_SCRIPT_NEWA',                   # Newa
  'G_UNICODE_SCRIPT_OSAGE',                  # Osge
  'G_UNICODE_SCRIPT_TANGUT',                 # Tang

  # Unicode 10.0 additions
  'G_UNICODE_SCRIPT_MASARAM_GONDI',          # Gonm
  'G_UNICODE_SCRIPT_NUSHU',                  # Nshu
  'G_UNICODE_SCRIPT_SOYOMBO',                # Soyo
  'G_UNICODE_SCRIPT_ZANABAZAR_SQUARE',       # Zanb

  # Unicode 11.0 additions
  'G_UNICODE_SCRIPT_DOGRA',                  # Dogr
  'G_UNICODE_SCRIPT_GUNJALA_GONDI',          # Gong
  'G_UNICODE_SCRIPT_HANIFI_ROHINGYA',        # Rohg
  'G_UNICODE_SCRIPT_MAKASAR',                # Maka
  'G_UNICODE_SCRIPT_MEDEFAIDRIN',            # Medf
  'G_UNICODE_SCRIPT_OLD_SOGDIAN',            # Sogo
  'G_UNICODE_SCRIPT_SOGDIAN'                 # Sogd
);

constant GNormalizeMode is export := guint;
our enum GNormalizeModeEnum is export (
  G_NORMALIZE_DEFAULT           => 0,
  G_NORMALIZE_NFD               => 0,     # G_NORMALIZE_DEFAULT,
  G_NORMALIZE_DEFAULT_COMPOSE   => 1,
  G_NORMALIZE_NFC               => 1,     # G_NORMALIZE_DEFAULT_COMPOSE,
  G_NORMALIZE_ALL               => 2,
  G_NORMALIZE_NFKD              => 2,     # G_NORMALIZE_ALL,
  G_NORMALIZE_ALL_COMPOSE       => 3,
  G_NORMALIZE_NFKC              => 3      # G_NORMALIZE_ALL_COMPOSE
);

constant GUnixSocketAddressType is export := guint;
our enum GUnixSocketAddressTypeEnum is export <
  G_UNIX_SOCKET_ADDRESS_INVALID
  G_UNIX_SOCKET_ADDRESS_ANONYMOUS
  G_UNIX_SOCKET_ADDRESS_PATH
  G_UNIX_SOCKET_ADDRESS_ABSTRACT
  G_UNIX_SOCKET_ADDRESS_ABSTRACT_PADDED
>;

# In the future, this mechanism may need to be used via BEGIN block for all
# enums that vary by OS -- Kaiepi++!
#
# my constant TheseChangeByOS = Metamodel::EnumHOW.new_type: :name<TheseChangeByOS>, :base_type(Int);
# TheseChangeByOS.^add_role: NumericEnumeration;
# TheseChangeByOS.^set_package: OUR
# TheseChangeByOS.^compose;
# if $*DISTRO.is-win {
#     TheseChangeByOS.^add_enum_value: 'a' => ...;
#     TheseChangeByOS.^add_enum_value: 'b' => ...;
#     TheseChangeByOS.^add_enum_value: 'c' => ...;
#     TheseChangeByOS.^add_enum_value: 'd' => ...;
# } else {
#     TheseChangeByOS.^add_enum_value: 'a' => ...;
#     TheseChangeByOS.^add_enum_value: 'b' => ...;
#     TheseChangeByOS.^add_enum_value: 'c' => ...;
#     TheseChangeByOS.^add_enum_value: 'd' => ...;
# }
# TheseChangeByOS.^compose_values;

our enum GdkDragAction is export (
  GDK_ACTION_DEFAULT => 1,
  GDK_ACTION_COPY    => 2,
  GDK_ACTION_MOVE    => (1 +< 2),
  GDK_ACTION_LINK    => (1 +< 3),
  GDK_ACTION_PRIVATE => (1 +< 4),
  GDK_ACTION_ASK     => (1 +< 5)
);

our enum GdkGravity is export (
  'GDK_GRAVITY_NORTH_WEST' => 1,
  'GDK_GRAVITY_NORTH',
  'GDK_GRAVITY_NORTH_EAST',
  'GDK_GRAVITY_WEST',
  'GDK_GRAVITY_CENTER',
  'GDK_GRAVITY_EAST',
  'GDK_GRAVITY_SOUTH_WEST',
  'GDK_GRAVITY_SOUTH',
  'GDK_GRAVITY_SOUTH_EAST',
  'GDK_GRAVITY_STATIC'
);

our enum GdkWindowTypeHint is export <
  GDK_WINDOW_TYPE_HINT_NORMAL
  GDK_WINDOW_TYPE_HINT_DIALOG
  GDK_WINDOW_TYPE_HINT_MENU
  GDK_WINDOW_TYPE_HINT_TOOLBAR
  GDK_WINDOW_TYPE_HINT_SPLASHSCREEN
  GDK_WINDOW_TYPE_HINT_UTILITY
  GDK_WINDOW_TYPE_HINT_DOCK
  GDK_WINDOW_TYPE_HINT_DESKTOP
  GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU
  GDK_WINDOW_TYPE_HINT_POPUP_MENU
  GDK_WINDOW_TYPE_HINT_TOOLTIP
  GDK_WINDOW_TYPE_HINT_NOTIFICATION
  GDK_WINDOW_TYPE_HINT_COMBO
  GDK_WINDOW_TYPE_HINT_DND
>;

our enum GdkModifierType is export (
  GDK_SHIFT_MASK                 => 1,
  GDK_LOCK_MASK                  => 1 +< 1,
  GDK_CONTROL_MASK               => 1 +< 2,
  GDK_MOD1_MASK                  => 1 +< 3,
  GDK_MOD2_MASK                  => 1 +< 4,
  GDK_MOD3_MASK                  => 1 +< 5,
  GDK_MOD4_MASK                  => 1 +< 6,
  GDK_MOD5_MASK                  => 1 +< 7,
  GDK_BUTTON1_MASK               => 1 +< 8,
  GDK_BUTTON2_MASK               => 1 +< 9,
  GDK_BUTTON3_MASK               => 1 +< 10,
  GDK_BUTTON4_MASK               => 1 +< 11,
  GDK_BUTTON5_MASK               => 1 +< 12,

  GDK_MODIFIER_RESERVED_13_MASK  => 1 +< 13,
  GDK_MODIFIER_RESERVED_14_MASK  => 1 +< 14,
  GDK_MODIFIER_RESERVED_15_MASK  => 1 +< 15,
  GDK_MODIFIER_RESERVED_16_MASK  => 1 +< 16,
  GDK_MODIFIER_RESERVED_17_MASK  => 1 +< 17,
  GDK_MODIFIER_RESERVED_18_MASK  => 1 +< 18,
  GDK_MODIFIER_RESERVED_19_MASK  => 1 +< 19,
  GDK_MODIFIER_RESERVED_20_MASK  => 1 +< 20,
  GDK_MODIFIER_RESERVED_21_MASK  => 1 +< 21,
  GDK_MODIFIER_RESERVED_22_MASK  => 1 +< 22,
  GDK_MODIFIER_RESERVED_23_MASK  => 1 +< 23,
  GDK_MODIFIER_RESERVED_24_MASK  => 1 +< 24,
  GDK_MODIFIER_RESERVED_25_MASK  => 1 +< 25,

  GDK_SUPER_MASK                 => 1 +< 26,
  GDK_HYPER_MASK                 => 1 +< 27,
  GDK_META_MASK                  => 1 +< 28,

  GDK_MODIFIER_RESERVED_29_MASK  => 1 +< 29,

  GDK_RELEASE_MASK               => 1 +< 30,
  GDK_MODIFIER_MASK              => 0x5c001fff
);

our enum GdkEventMask is export (
  GDK_EXPOSURE_MASK             => 1,
  GDK_POINTER_MOTION_MASK       => 1 +< 2,
  GDK_POINTER_MOTION_HINT_MASK  => 1 +< 3,
  GDK_BUTTON_MOTION_MASK        => 1 +< 4,
  GDK_BUTTON1_MOTION_MASK       => 1 +< 5,
  GDK_BUTTON2_MOTION_MASK       => 1 +< 6,
  GDK_BUTTON3_MOTION_MASK       => 1 +< 7,
  GDK_BUTTON_PRESS_MASK         => 1 +< 8,
  GDK_BUTTON_RELEASE_MASK       => 1 +< 9,
  GDK_KEY_PRESS_MASK            => 1 +< 10,
  GDK_KEY_RELEASE_MASK          => 1 +< 11,
  GDK_ENTER_NOTIFY_MASK         => 1 +< 12,
  GDK_LEAVE_NOTIFY_MASK         => 1 +< 13,
  GDK_FOCUS_CHANGE_MASK         => 1 +< 14,
  GDK_STRUCTURE_MASK            => 1 +< 15,
  GDK_PROPERTY_CHANGE_MASK      => 1 +< 16,
  GDK_VISIBILITY_NOTIFY_MASK    => 1 +< 17,
  GDK_PROXIMITY_IN_MASK         => 1 +< 18,
  GDK_PROXIMITY_OUT_MASK        => 1 +< 19,
  GDK_SUBSTRUCTURE_MASK         => 1 +< 20,
  GDK_SCROLL_MASK               => 1 +< 21,
  GDK_TOUCH_MASK                => 1 +< 22,
  GDK_SMOOTH_SCROLL_MASK        => 1 +< 23,
  GDK_TOUCHPAD_GESTURE_MASK     => 1 +< 24,
  GDK_TABLET_PAD_MASK           => 1 +< 25,
  GDK_ALL_EVENTS_MASK           => 0x3FFFFFE
);

our enum GdkEventType is export (
  GDK_NOTHING             => -1,
  GDK_DELETE              => 0,
  GDK_DESTROY             => 1,
  GDK_EXPOSE              => 2,
  GDK_MOTION_NOTIFY       => 3,
  GDK_BUTTON_PRESS        => 4,
  GDK_2BUTTON_PRESS       => 5,
  GDK_DOUBLE_BUTTON_PRESS => 5,
  GDK_3BUTTON_PRESS       => 6,
  GDK_TRIPLE_BUTTON_PRESS => 6,
  GDK_BUTTON_RELEASE      => 7,
  GDK_KEY_PRESS           => 8,
  GDK_KEY_RELEASE         => 9,
  GDK_ENTER_NOTIFY        => 10,
  GDK_LEAVE_NOTIFY        => 11,
  GDK_FOCUS_CHANGE        => 12,
  GDK_CONFIGURE           => 13,
  GDK_MAP                 => 14,
  GDK_UNMAP               => 15,
  GDK_PROPERTY_NOTIFY     => 16,
  GDK_SELECTION_CLEAR     => 17,
  GDK_SELECTION_REQUEST   => 18,
  GDK_SELECTION_NOTIFY    => 19,
  GDK_PROXIMITY_IN        => 20,
  GDK_PROXIMITY_OUT       => 21,
  GDK_DRAG_ENTER          => 22,
  GDK_DRAG_LEAVE          => 23,
  GDK_DRAG_MOTION         => 24,
  GDK_DRAG_STATUS         => 25,
  GDK_DROP_START          => 26,
  GDK_DROP_FINISHED       => 27,
  GDK_CLIENT_EVENT        => 28,
  GDK_VISIBILITY_NOTIFY   => 29,
  GDK_SCROLL              => 31,
  GDK_WINDOW_STATE        => 32,
  GDK_SETTING             => 33,
  GDK_OWNER_CHANGE        => 34,
  GDK_GRAB_BROKEN         => 35,
  GDK_DAMAGE              => 36,
  GDK_TOUCH_BEGIN         => 37,
  GDK_TOUCH_UPDATE        => 38,
  GDK_TOUCH_END           => 39,
  GDK_TOUCH_CANCEL        => 40,
  GDK_TOUCHPAD_SWIPE      => 41,
  GDK_TOUCHPAD_PINCH      => 42,
  GDK_PAD_BUTTON_PRESS    => 43,
  GDK_PAD_BUTTON_RELEASE  => 44,
  GDK_PAD_RING            => 45,
  GDK_PAD_STRIP           => 46,
  GDK_PAD_GROUP_MODE      => 47,
  'GDK_EVENT_LAST'
);

our enum GdkWindowEdge is export <
  GDK_WINDOW_EDGE_NORTH_WEST
  GDK_WINDOW_EDGE_NORTH
  GDK_WINDOW_EDGE_NORTH_EAST
  GDK_WINDOW_EDGE_WEST
  GDK_WINDOW_EDGE_EAST
  GDK_WINDOW_EDGE_SOUTH_WEST
  GDK_WINDOW_EDGE_SOUTH
  GDK_WINDOW_EDGE_SOUTH_EAST
>;

our enum GdkCursorType is export (
  GDK_X_CURSOR            => 0,
  GDK_ARROW               => 2,
  GDK_BASED_ARROW_DOWN    => 4,
  GDK_BASED_ARROW_UP      => 6,
  GDK_BOAT                => 8,
  GDK_BOGOSITY            => 10,
  GDK_BOTTOM_LEFT_CORNER  => 12,
  GDK_BOTTOM_RIGHT_CORNER => 14,
  GDK_BOTTOM_SIDE         => 16,
  GDK_BOTTOM_TEE          => 18,
  GDK_BOX_SPIRAL          => 20,
  GDK_CENTER_PTR          => 22,
  GDK_CIRCLE              => 24,
  GDK_CLOCK               => 26,
  GDK_COFFEE_MUG          => 28,
  GDK_CROSS               => 30,
  GDK_CROSS_REVERSE       => 32,
  GDK_CROSSHAIR           => 34,
  GDK_DIAMOND_CROSS       => 36,
  GDK_DOT                 => 38,
  GDK_DOTBOX              => 40,
  GDK_DOUBLE_ARROW        => 42,
  GDK_DRAFT_LARGE         => 44,
  GDK_DRAFT_SMALL         => 46,
  GDK_DRAPED_BOX          => 48,
  GDK_EXCHANGE            => 50,
  GDK_FLEUR               => 52,
  GDK_GOBBLER             => 54,
  GDK_GUMBY               => 56,
  GDK_HAND1               => 58,
  GDK_HAND2               => 60,
  GDK_HEART               => 62,
  GDK_ICON                => 64,
  GDK_IRON_CROSS          => 66,
  GDK_LEFT_PTR            => 68,
  GDK_LEFT_SIDE           => 70,
  GDK_LEFT_TEE            => 72,
  GDK_LEFTBUTTON          => 74,
  GDK_LL_ANGLE            => 76,
  GDK_LR_ANGLE            => 78,
  GDK_MAN                 => 80,
  GDK_MIDDLEBUTTON        => 82,
  GDK_MOUSE               => 84,
  GDK_PENCIL              => 86,
  GDK_PIRATE              => 88,
  GDK_PLUS                => 90,
  GDK_QUESTION_ARROW      => 92,
  GDK_RIGHT_PTR           => 94,
  GDK_RIGHT_SIDE          => 96,
  GDK_RIGHT_TEE           => 98,
  GDK_RIGHTBUTTON         => 100,
  GDK_RTL_LOGO            => 102,
  GDK_SAILBOAT            => 104,
  GDK_SB_DOWN_ARROW       => 106,
  GDK_SB_H_DOUBLE_ARROW   => 108,
  GDK_SB_LEFT_ARROW       => 110,
  GDK_SB_RIGHT_ARROW      => 112,
  GDK_SB_UP_ARROW         => 114,
  GDK_SB_V_DOUBLE_ARROW   => 116,
  GDK_SHUTTLE             => 118,
  GDK_SIZING              => 120,
  GDK_SPIDER              => 122,
  GDK_SPRAYCAN            => 124,
  GDK_STAR                => 126,
  GDK_TARGET              => 128,
  GDK_TCROSS              => 130,
  GDK_TOP_LEFT_ARROW      => 132,
  GDK_TOP_LEFT_CORNER     => 134,
  GDK_TOP_RIGHT_CORNER    => 136,
  GDK_TOP_SIDE            => 138,
  GDK_TOP_TEE             => 140,
  GDK_TREK                => 142,
  GDK_UL_ANGLE            => 144,
  GDK_UMBRELLA            => 146,
  GDK_UR_ANGLE            => 148,
  GDK_WATCH               => 150,
  GDK_XTERM               => 152,
  GDK_LAST_CURSOR         => 153,
  GDK_BLANK_CURSOR        => -2,
  GDK_CURSOR_IS_PIXMAP    => -1
);

our enum GdkVisibilityState is export <
  GDK_VISIBILITY_UNOBSCURED
  GDK_VISIBILITY_PARTIAL
  GDK_VISIBILITY_FULLY_OBSCURED
>;

our enum GdkCrossingMode is export <
  GDK_CROSSING_NORMAL
  GDK_CROSSING_GRAB
  GDK_CROSSING_UNGRAB
  GDK_CROSSING_GTK_GRAB
  GDK_CROSSING_GTK_UNGRAB
  GDK_CROSSING_STATE_CHANGED
  GDK_CROSSING_TOUCH_BEGIN
  GDK_CROSSING_TOUCH_END
  GDK_CROSSING_DEVICE_SWITCH
>;

our enum GdkNotifyType is export (
  GDK_NOTIFY_ANCESTOR           => 0,
  GDK_NOTIFY_VIRTUAL            => 1,
  GDK_NOTIFY_INFERIOR           => 2,
  GDK_NOTIFY_NONLINEAR          => 3,
  GDK_NOTIFY_NONLINEAR_VIRTUAL  => 4,
  GDK_NOTIFY_UNKNOWN            => 5
);

our enum GdkWindowState is export (
  GDK_WINDOW_STATE_WITHDRAWN        => 1,
  GDK_WINDOW_STATE_ICONIFIED        => 1 +< 1,
  GDK_WINDOW_STATE_MAXIMIZED        => 1 +< 2,
  GDK_WINDOW_STATE_STICKY           => 1 +< 3,
  GDK_WINDOW_STATE_FULLSCREEN       => 1 +< 4,
  GDK_WINDOW_STATE_ABOVE            => 1 +< 5,
  GDK_WINDOW_STATE_BELOW            => 1 +< 6,
  GDK_WINDOW_STATE_FOCUSED          => 1 +< 7,
  GDK_WINDOW_STATE_TILED            => 1 +< 8,
  GDK_WINDOW_STATE_TOP_TILED        => 1 +< 9,
  GDK_WINDOW_STATE_TOP_RESIZABLE    => 1 +< 10,
  GDK_WINDOW_STATE_RIGHT_TILED      => 1 +< 11,
  GDK_WINDOW_STATE_RIGHT_RESIZABLE  => 1 +< 12,
  GDK_WINDOW_STATE_BOTTOM_TILED     => 1 +< 13,
  GDK_WINDOW_STATE_BOTTOM_RESIZABLE => 1 +< 14,
  GDK_WINDOW_STATE_LEFT_TILED       => 1 +< 15,
  GDK_WINDOW_STATE_LEFT_RESIZABLE   => 1 +< 16
);

our enum GKeyFileFlags is export (
  G_KEY_FILE_NONE              => 0,
  G_KEY_FILE_KEEP_COMMENTS     => 1,
  G_KEY_FILE_KEEP_TRANSLATIONS => 2
);

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

constant GErrorType is export := guint32;
our enum GErrorTypeEnum is export <
  G_ERR_UNKNOWN
  G_ERR_UNEXP_EOF
  G_ERR_UNEXP_EOF_IN_STRING
  G_ERR_UNEXP_EOF_IN_COMMENT
  G_ERR_NON_DIGIT_IN_CONST
  G_ERR_DIGIT_RADIX
  G_ERR_FLOAT_RADIX
  G_ERR_FLOAT_MALFORMED
>;

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

# Token types
constant GTokenType is export := uint32;
our enum GTokenTypeEnum is export (
  G_TOKEN_EOF                   =>  0,
  G_TOKEN_LEFT_PAREN            => '('.ord,
  G_TOKEN_RIGHT_PAREN           => ')'.ord,
  G_TOKEN_LEFT_CURLY            => '{'.ord,
  G_TOKEN_RIGHT_CURLY           => '}'.ord,
  G_TOKEN_LEFT_BRACE            => '['.ord,
  G_TOKEN_RIGHT_BRACE           => ']'.ord,
  G_TOKEN_EQUAL_SIGN            => '='.ord,
  G_TOKEN_COMMA                 => ','.ord,

  G_TOKEN_NONE                  => 256,

  'G_TOKEN_ERROR',
  'G_TOKEN_CHAR',
  'G_TOKEN_BINARY',
  'G_TOKEN_OCTAL',
  'G_TOKEN_INT',
  'G_TOKEN_HEX',
  'G_TOKEN_FLOAT',
  'G_TOKEN_STRING',
  'G_TOKEN_SYMBOL',
  'G_TOKEN_IDENTIFIER',
  'G_TOKEN_IDENTIFIER_NULL',
  'G_TOKEN_COMMENT_SINGLE',
  'G_TOKEN_COMMENT_MULTI',

  # Private
  'G_TOKEN_LAST'
);

our enum GSignalFlags is export (
  G_SIGNAL_RUN_FIRST    => 1,
  G_SIGNAL_RUN_LAST     => 1 +< 1,
  G_SIGNAL_RUN_CLEANUP  => 1 +< 2,
  G_SIGNAL_NO_RECURSE   => 1 +< 3,
  G_SIGNAL_DETAILED     => 1 +< 4,
  G_SIGNAL_ACTION       => 1 +< 5,
  G_SIGNAL_NO_HOOKS     => 1 +< 6,
  G_SIGNAL_MUST_COLLECT => 1 +< 7,
  G_SIGNAL_DEPRECATED   => 1 +< 8
);

our enum GConnectFlags is export (
  G_CONNECT_AFTER       => 1,
  G_CONNECT_SWAPPED     => 2
);

our enum GSignalMatchType is export (
  G_SIGNAL_MATCH_ID        => 1,
  G_SIGNAL_MATCH_DETAIL    => 1 +< 1,
  G_SIGNAL_MATCH_CLOSURE   => 1 +< 2,
  G_SIGNAL_MATCH_FUNC      => 1 +< 3,
  G_SIGNAL_MATCH_DATA      => 1 +< 4,
  G_SIGNAL_MATCH_UNBLOCKED => 1 +< 5
);

our constant G_SIGNAL_MATCH_MASK is export = 0x3f;

our enum GSourceReturn is export <
  G_SOURCE_REMOVE
  G_SOURCE_CONTINUE
>;

our enum GLogLevelFlags is export (
  # log flags
  G_LOG_FLAG_RECURSION          => 1,
  G_LOG_FLAG_FATAL              => 1 +< 1,

  # GLib log levels */>
  G_LOG_LEVEL_ERROR             => 1 +< 2,       # always fatal
  G_LOG_LEVEL_CRITICAL          => 1 +< 3,
  G_LOG_LEVEL_WARNING           => 1 +< 4,
  G_LOG_LEVEL_MESSAGE           => 1 +< 5,
  G_LOG_LEVEL_INFO              => 1 +< 6,
  G_LOG_LEVEL_DEBUG             => 1 +< 7,

  G_LOG_LEVEL_MASK              => 0xfffffffc   # ~(G_LOG_FLAG_RECURSION | G_LOG_FLAG_FATAL)
);

our enum GLogWriterOutput is export (
  G_LOG_WRITER_UNHANDLED => 0,
  G_LOG_WRITER_HANDLED   => 1,
);

constant GModuleFlags is export := guint;
our enum GModuleFlagsEnum is export (
  G_MODULE_BIND_LAZY    => 1,
  G_MODULE_BIND_LOCAL   => 1 +< 1,
  G_MODULE_BIND_MASK    => 0x03
);

our enum GOnceStatus is export <
  G_ONCE_STATUS_NOTCALLED
  G_ONCE_STATUS_PROGRESS
  G_ONCE_STATUS_READY
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

class cairo_font_options_t     is repr('CPointer') is export does GTK::Roles::Pointers { }
class cairo_surface_t          is repr('CPointer') is export does GTK::Roles::Pointers { }

class AtkObject                is repr('CPointer') is export does GTK::Roles::Pointers { }

# --- GLIB TYPES ---
class GAction                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GActionGroup             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GActionMap               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppInfo                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppInfoMonitor          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAppLaunchContext        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GApplication             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAsyncQueue              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GAsyncResult             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBinding                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBookmarkFile            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBufferedInputStream     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBytes                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GBytesIcon               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GCancellable             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDrive                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GCharsetConverter        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GChecksum                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GClosure                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GConverter               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GConverterInputStream    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GCredentials             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDataInputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDateTime                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDatagramBased           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDtlsClientConnection    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDtlsConnection          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDtlsServerConnection    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusAuthObserver        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusConnection          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusInterface           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusInterfaceSkeleton   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusMessage             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusMethodInvocation    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObject              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusObjectProxy         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GDBusServer              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GEmblem                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GEmblemedIcon            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFile                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileAttributeInfo       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileAttributeMatcher    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileIcon                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileInfo                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileDescriptorBased     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileEnumerator          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileInputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileIOStream            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileMonitor             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFilenameCompleter       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFileOutputStream        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GFilterInputStream       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHmac                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHashTable               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GHashTableIter           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIcon                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInetAddress             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInetAddressMask         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInetSocketAddress       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInitable                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GInputStream             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIOChannel               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GIOStream                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GKeyFile                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GListModel               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GLoadableIcon            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMainContext             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMainLoop                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMarkupParser            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMemoryInputStream       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMemoryOutputStream      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenu                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuItem                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuAttributeIter       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuLinkIter            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMenuModel               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GModule                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMount                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMountOperation          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GMutex                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNetworkAddress          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNetworkMonitor          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNetworkService          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GNotification            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GObject                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOptionEntry             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOptionGroup             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GOutputStream            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GParamSpec               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPollableInputStream     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPollableOutputStream    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPrivate                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GPropertyAction          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxy                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxyAddress            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxyAddressEnumerator  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GProxyResolver           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GRand                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GResource                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GRWLock                  is repr('CPointer') is export does GTK::Roles::Pointers { }
# To be converted into CStruct when I'm not so scurred of it.
# It has bits.... BITS! -- See https://stackoverflow.com/questions/1490092/c-c-force-bit-field-order-and-alignment
class GScannerConfig           is repr('CPointer') is export does GTK::Roles::Pointers { }
# Also has a CStruct representation, and should be converted.
class GScanner                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettings                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsBackend         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsSchema          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsSchemaKey       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSettingsSchemaSource    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimpleAction            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimpleActionGroup       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSimpleProxyResolver     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSliceConfig             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GResolver                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSeekable                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocket                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketClient            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketAddress           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketAddressEnumerator is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketConnectable       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketConnection        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketControlMessage    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketListener          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSocketService           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSource                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GSrvTarget               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTask                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTcpConnection           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTcpWrapperConnection    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThemedIcon              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThread                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThreadPool              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GThreadedSocketService   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTimer                   is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTimeZone                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsBackend              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsCertificate          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsClientConnection     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsConnection           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsDatabase             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsFileDatabase         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsInteraction          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsPassword             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTlsServerConnection     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GTokenValue              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixCredentialsMessage  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixConnection          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixFDList              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixFDMessage           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixMountEntry          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixMountMonitor        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixMountPoint          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixInputStream         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GUnixSocketAddress       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariant                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantBuilder          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantDict             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantIter             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVariantType             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVfs                     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVolume                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GVolumeMonitor           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GZlibCompressor          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GZlibDecompressor        is repr('CPointer') is export does GTK::Roles::Pointers { }

class GByteArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has CArray[uint8] $.data;
  has guint         $.len;

  method Blob {
    Blob.new( $.data[ ^$.len ] );
  }
}

class GFileAttributeInfoList is repr('CStruct') does GTK::Roles::Pointers is export {
  has GFileAttributeInfo $.infos;
  has gint               $.n_infos;
}

sub sprintf-a(Blob, Str, & (GSimpleAction, GVariant, gpointer) --> int64)
    is native is symbol('sprintf') {}

class GActionEntry is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str     $.name;
  has Pointer $.activate;
  has Str     $.parameter_type;
  has Str     $.state;
  has Pointer $.change_state;

  # Padding  - Not accessible
  has uint64  $!pad1;
  has uint64  $!pad2;
  has uint64  $!pad3;

  submethod BUILD (
    :$name,
    :$activate,
    :$parameter_type,
    :$state,
    :$change_state
  ) {
    self.name           = $name;
    self.parameter_type = $parameter_type;
    self.state          = $state;
    self.activate       = $activate     if $activate.defined;
    self.change_state   = $change_state if $change_state.defined
  }

  method change_state is rw {
    Proxy.new:
      FETCH => -> $        { $!activate },
      STORE => -> $, \func {
        $!change_state := set_func_pointer( &(func), &sprintf-a )
      };
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $ { $.name },
      STORE => -> $, Str() $val {
        nqp::bindattr(
          nqp::decont(self),
          GActionEntry,
          '$!name',
          nqp::decont( $val )
        );
      }
  }

  method parameter_type is rw {
    Proxy.new:
      FETCH => -> $ { $.parameter_type },
      STORE => -> $, Str() $val {
        nqp::bindattr(
          nqp::decont(self),
          GActionEntry,
          '$!parameter_type',
          nqp::decont( $val )
        );
      }
  }

  method state is rw {
    Proxy.new:
      FETCH => -> $ { $.state },
      STORE => -> $, Str() $val {
        nqp::bindattr(
          nqp::decont(self),
          GActionEntry,
          '$!state',
          nqp::decont( $val )
        );
      }
  }

  method new (
    $name,
    $activate       = Pointer,
    $state          = Str,
    $parameter_type = Str,
    $change_state   = Pointer
  ) {
    self.bless(:$name, :$activate, :$parameter_type, :$state, :$change_state);
  }

}

class GOnce                is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint    $.status;    # GOnceStatus
  has gpointer $.retval;
};

class GRecMutex            is repr('CStruct') does GTK::Roles::Pointers is export {
  # Private
  has gpointer $!p;
  has uint64   $!i    # guint i[2];
}

class GCond                is repr('CStruct') does GTK::Roles::Pointers is export {
  # Private
  has gpointer $!p;
  has uint64   $!i    # guint i[2];
}


sub sprintf-b(
  Blob,
  Str,
  & (gpointer, GSource, & (gpointer --> guint32),
  gpointer
) --> int64)
    is native is symbol('sprintf') {}

class GSourceCallbackFuncs is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!ref,   # (gpointer     cb_data);
  has Pointer $!unref, # (gpointer     cb_data);
  has Pointer $!get,   # (gpointer     cb_data,
                       #  GSource     *source,
                       #  GSourceFunc *func,
                       #  gpointer    *data);

   submethod BUILD (:$ref, :$unref, :$get) {
     self.ref   = $ref   if $ref.defined;
     self.unref = $unref if $unref.defined;
     self.get   = $get   if $get.defined;
   }

  method ref is rw {
    Proxy.new:
      FETCH => -> $        { $!ref },
      STORE => -> $, \func {
        $!ref := set_func_pointer( &(func), &sprintf-vp )
      };
  }

  method unref is rw {
    Proxy.new:
      FETCH => -> $        { $!unref },
      STORE => -> $, \func {
        $!unref := set_func_pointer( &(func), &sprintf-vp )
      };
  }

  method get is rw {
    Proxy.new:
      FETCH => -> $        { $!get },
      STORE => -> $, \func {
        $!get := set_func_pointer( &(func), &sprintf-b )
      };
  }
};

sub sprintf-bp (
  Blob,
  Str,
  & (gpointer --> gboolean),
  gpointer
  --> int64
)
    is native is symbol('sprintf') { * }

sub sprintf-c (
  Blob,
  Str,
  & (GSource, gint --> gboolean),
  gpointer
 --> int64
)
    is native is symbol('sprintf') { * }


sub sprintf-d (
  Blob,
  Str,
  & (GSource, & (gpointer --> gboolean), gint --> gboolean),
  gpointer
  --> int64
)
    is native is symbol('sprintf') { * }

class GSourceFuncs is repr('CStruct') does GTK::Roles::Pointers is export {
  has Pointer $!prepare;     # (GSource    *source,
                             #  gint       *timeout);
  has Pointer $!check;       # (GSource    *source);
  has Pointer $!dispatch;    # (GSource    *source,
                             #  GSourceFunc callback,
                             #  gpointer    user_data);
  has Pointer $!finalize;    # (GSource    *source); /* Can be NULL */

  sub cd-default (GSource --> gboolean) { 1 };

  submethod BUILD (
    :$prepare   = -> GSource, gint $t is rw             --> gboolean { $t = 0;
                                                                       1 },
    :$check     = &cd-default,
    :$dispatch,
    :$finalize  = &cd-default
  ) {
    self.prepare  = $prepare;
    self.check    = $check;
    self.dispatch = $dispatch;
    self.finalize = $finalize;
  }

  method prepare is rw {
    Proxy.new:
      FETCH => -> $ { $!prepare },
      STORE => -> $, \func {
        $!prepare := set_func_pointer( &(func), &sprintf-c);
      };
  }

  method check is rw {
    Proxy.new:
      FETCH => -> $ { $!check },
      STORE => -> $, \func {
        $!check := set_func_pointer( &(func), &sprintf-bp);
      }
  }

  method dispatch is rw {
    Proxy.new:
      FETCH => -> $ { $!dispatch },
      STORE => -> $, \func {
        $!dispatch := set_func_pointer( &(func), &sprintf-d);
      }
  }

  method finalize is rw {
    Proxy.new:
      FETCH => -> $ { $!finalize },
      STORE => -> $, \func {
        $!finalize := set_func_pointer( &(func), &sprintf-vp);
      }
  }

  method size-of (GSourceFuncs:U:) { return nativesizeof(GSourceFuncs) }

};

# --- GDK TYPES ---
class GdkAppLaunchContext    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkAtom                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkCursor              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDevice              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDeviceManager       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDeviceTool          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDisplay             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDisplayManager      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDragContext         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkDrawingContext      is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkEventSequence       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkFrameClock          is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkFrameTimings        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkGLContext           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkKeymap              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkMonitor             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkPixbuf              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkPixbufAnimation     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkPixbufAnimationIter is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkScreen              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkSeat                is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkStyleProvider       is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkVisual              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GdkWindow              is repr('CPointer') is export does GTK::Roles::Pointers { }

sub gdk_atom_name(GdkAtom)
  returns Str
  is native(gdk)
  is export
  { * }

class GdkColor is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint   $.pixel;
  has guint16 $.red;
  has guint16 $.green;
  has guint16 $.blue;
}

class GdkEventAny is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32       $.type;              # GdkEventType
  has GdkWindow    $.window;
  has int8         $.send_event;
}

constant GdkEvent is export := GdkEventAny;

class GdkGeometry is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint       $.min_width;
  has gint       $.min_height;
  has gint       $.max_width;
  has gint       $.max_height;
  has gint       $.base_width;
  has gint       $.base_height;
  has gint       $.width_inc;
  has gint       $.height_inc;
  has gdouble    $.min_aspect;
  has gdouble    $.max_aspect;
  has guint      $.win_gravity;         # GdkGravity
}

class GdkRectangle is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint $.x is rw;
  has gint $.y is rw;
  has gint $.width is rw;
  has gint $.height is rw;
}

class GdkPixbufModulePattern is repr('CStruct') does GTK::Roles::Pointers is export {
	has Str $.prefix;
	has Str $.mask;
	has int $.relevance;
}

class GdkPixbufFormat is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str                     $.name;
  has GdkPixbufModulePattern  $.signature;
  has Str                     $.domain;
  has Str                     $.description;
  has CArray[Str]             $.mime_types;
  has CArray[Str]             $.extensions;
  has guint32                 $.flags;
  has gboolean                $.disabled;
  has Str                     $.license;
}

class GdkPoint is repr('CStruct') does GTK::Roles::Pointers is export {
  has gint $.x is rw;
  has gint $.y is rw;
}

class GdkEventKey is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32       $.type;              # GdkEventType
  has GdkWindow    $.window;
  has int8         $.send_event;
  has uint32       $.time;
  has uint32       $.state;
  has uint32       $.keyval;
  has int32        $.length;
  has Str          $.string;
  has uint16       $.hardware_keycode;
  has uint8        $.group;
  has uint32       $.is_modifier;
}

class GdkEventButton is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has guint32        $.time;
  has gdouble        $.x;
  has gdouble        $.y;
  has gdouble        $.axes is rw;
  has guint          $.state;
  has guint          $.button;
  has GdkDevice      $.device;
  has gdouble        $.x_root;
  has gdouble        $.y_root;
}

class GdkEventExpose is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkRectangle   $.area;
  has cairo_region_t $.region;
  has int32          $.count;
}

class GdkEventCrossing is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkWindow      $.subwindow;
  has uint32         $.time;
  has num64          $.x;
  has num64          $.y;
  has num64          $.x_root;
  has num64          $.y_root;
  has uint32         $.mode;            # GdkCrossingMode
  has uint32         $.detail;          # GdkNotifyType
  has gboolean       $.focus;
  has guint          $.state;
}

class GdkEventFocus is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has int16          $.in;
}

class GdkEventConfigure is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has int32          $.x;
  has int32          $.y;
  has int32          $.width;
  has int32          $.height;
}

class GdkEventProperty is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkAtom        $.atom;
  has uint32         $.time;
  has uint32         $.state;
}

class GdkEventSelection is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkAtom        $.selection;
  has GdkAtom        $.target;
  has GdkAtom        $.property;
  has uint32         $.time;
  has GdkWindow      $.requestor;
}

class GdkEventDnD is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkDragContext $.context;
  has uint32         $.time;
  has int16          $.x_root;
  has int16          $.y_root;
}

class GdkEventProximity is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.time;
  has GdkDevice      $.device;
}

class GdkEventWindowState is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.changed_mask;
  has uint32         $.new_window_state;
}

class GdkEventSetting is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has uint32         $.action;
  has Str            $.name;
}

class GdkEventOwnerChange is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has GdkWindow      $.owner;
  has uint32         $.reason;          # GdkOwnerChange
  has GdkAtom        $.selection;
  has uint32         $.time;
  has uint32         $.selection_time;
}

class GdkEventMotion is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has guint32        $.time;
  has gdouble        $.x;
  has gdouble        $.y;
  has gdouble        $.axes;
  has guint          $.state;
  has gint16         $.is_hint;
  has GdkDevice      $.device;
  has gdouble        $.x_root;
  has gdouble        $.y_root;
}

class GdkEventGrabBroken is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has uint32         $.type;            # GdkEventType
  has GdkWindow      $.window;
  has int8           $.send_event;
  has gboolean       $.keyboard;
  has gboolean       $.implicit;
  has GdkWindow      $.grab_window;
}

# class GdkEventTouchpadSwipe
# class GdkEventTouchpadPinch
# class GdkEventPadButton
# class GdkEventPadAxis
# class GdkEventPadGroupMode

our subset GdkEvents is export where
  GdkEventAny        | GdkEventButton      | GdkEventExpose    |
  GdkEventDnD        | GdkEventProperty    | GdkEventFocus     |
  GdkEventSetting    | GdkEventProximity   | GdkEventSelection |
  GdkEventConfigure  | GdkEventWindowState | GdkEventCrossing  |
  GdkEventGrabBroken | GdkEventOwnerChange | GdkEventMotion    |
  GdkEventKey;

class GdkWindowAttr is repr('CStruct')
  does GTK::Roles::Pointers
  is export
{
  has Str       $.title             is rw;
  has gint      $.event_mask        is rw;
  has gint      $.x                 is rw;
  has gint      $.y                 is rw;
  has gint      $.width             is rw;
  has gint      $.height            is rw;
  has uint32    $.wclass            is rw;    # GdkWindowWindowClass
  has GdkVisual $!visual                 ;
  has uint32    $.window_type       is rw;    # GdkWindowType
  has GdkCursor $.cursor            is rw;
  has Str       $.wmclass_name;
  has Str       $.wmclass_class;
  has gboolean  $.override_redirect is rw;
  has uint32    $.type_hint         is rw;    # GdkWindowTypeHint

  method cursor is rw {
		Proxy.new:
			FETCH => -> $ { $.cursor },
			STORE => -> $, GdkCursor() $val {
				nqp::bindattr(
				nqp::decont(self),
  				GdkWindowAttr,
  				'$!cursor',
  				nqp::decont( $val )
  			);
      }
	}

  method wmclass_name is rw {
		Proxy.new:
			FETCH => -> $ { $.wmclass_name },
			STORE => -> $, Str() $val {
				nqp::bindattr(
  				nqp::decont(self),
  				GdkWindowAttr,
  				'$!wmclass_name',
  				nqp::decont( $val )
  			);
      }
	}

  method wmclass_class is rw {
    Proxy.new:
      FETCH => -> $ { $.label_name },
      STORE => -> $, Str() $val {
        nqp::bindattr(
          nqp::decont(self),
          GdkWindowAttr,
          '$!wmclass_class',
          nqp::decont( $val )
        );
      }
  }

  method visual is rw {
    Proxy.new:
      FETCH => -> $ { $!visual },
      STORE => -> $, Str() $new {
        nqp::bindattr(
          nqp::decont(self),
          GdkWindowAttr,
          '$!visual',
          nqp::decont($new)
        );
      }
  }

}

class GArray is repr('CStruct') does GTK::Roles::Pointers is export {
  has Str    $.data;
  has uint32 $.len;
}

class GdkTimeCoord is repr('CStruct') does GTK::Roles::Pointers is export {
  has uint32        $.time;
  has CArray[num64] $.axes;
}

class GdkKeymapKey is repr('CStruct') does GTK::Roles::Pointers is export {
  has guint $.keycode;
  has gint  $.group;
  has gint  $.level;
}

our enum GdkWindowWindowClass is export (
  'GDK_INPUT_OUTPUT',             # nick=input-output
  'GDK_INPUT_ONLY'                # nick=input-only
);

our enum GdkWindowHints is export (
  GDK_HINT_POS         => 1,
  GDK_HINT_MIN_SIZE    => 1 +< 1,
  GDK_HINT_MAX_SIZE    => 1 +< 2,
  GDK_HINT_BASE_SIZE   => 1 +< 3,
  GDK_HINT_ASPECT      => 1 +< 4,
  GDK_HINT_RESIZE_INC  => 1 +< 5,
  GDK_HINT_WIN_GRAVITY => 1 +< 6,
  GDK_HINT_USER_POS    => 1 +< 7,
  GDK_HINT_USER_SIZE   => 1 +< 8
);

our enum GdkWMDecoration is export (
  GDK_DECOR_ALL         => 1,
  GDK_DECOR_BORDER      => 1 +< 1,
  GDK_DECOR_RESIZEH     => 1 +< 2,
  GDK_DECOR_TITLE       => 1 +< 3,
  GDK_DECOR_MENU        => 1 +< 4,
  GDK_DECOR_MINIMIZE    => 1 +< 5,
  GDK_DECOR_MAXIMIZE    => 1 +< 6
);

our enum GdkWindowType is export <
  GDK_WINDOW_ROOT
  GDK_WINDOW_TOPLEVEL
  GDK_WINDOW_CHILD
  GDK_WINDOW_TEMP
  GDK_WINDOW_FOREIGN
  GDK_WINDOW_OFFSCREEN
  GDK_WINDOW_SUBSURFACE
>;

our enum GdkAnchorHints is export (
  GDK_ANCHOR_FLIP_X   => 1,
  GDK_ANCHOR_FLIP_Y   => 1 +< 1,
  GDK_ANCHOR_SLIDE_X  => 1 +< 2,
  GDK_ANCHOR_SLIDE_Y  => 1 +< 3,
  GDK_ANCHOR_RESIZE_X => 1 +< 4,
  GDK_ANCHOR_RESIZE_Y => 1 +< 5,
  GDK_ANCHOR_FLIP     =>        1 +| (1 +< 1),
  GDK_ANCHOR_SLIDE    => (1 +< 2) +| (1 +< 3),
  GDK_ANCHOR_RESIZE   => (1 +< 4) +| (1 +< 4)
);

our enum GdkFullscreenMode is export <
  GDK_FULLSCREEN_ON_CURRENT_MONITOR
  GDK_FULLSCREEN_ON_ALL_MONITORS
>;

our enum GdkWindowAttributesType is export (
  GDK_WA_TITLE     => 1,
  GDK_WA_X         => 1 +< 2,
  GDK_WA_Y         => 1 +< 3,
  GDK_WA_CURSOR    => 1 +< 4,
  GDK_WA_VISUAL    => 1 +< 5,
  GDK_WA_WMCLASS   => 1 +< 6,
  GDK_WA_NOREDIR   => 1 +< 7,
  GDK_WA_TYPE_HINT => 1 +< 8
);

our enum GdkVisualType is export <
  GDK_VISUAL_STATIC_GRAY
  GDK_VISUAL_GRAYSCALE
  GDK_VISUAL_STATIC_COLOR
  GDK_VISUAL_PSEUDO_COLOR
  GDK_VISUAL_TRUE_COLOR
  GDK_VISUAL_DIRECT_COLOR
>;

our enum GdkByteOrder is export <
  GDK_LSB_FIRST
  GDK_MSB_FIRST
>;

our enum GdkSubpixelLayout is export <
  GDK_SUBPIXEL_LAYOUT_UNKNOWN
  GDK_SUBPIXEL_LAYOUT_NONE
  GDK_SUBPIXEL_LAYOUT_HORIZONTAL_RGB
  GDK_SUBPIXEL_LAYOUT_HORIZONTAL_BGR
  GDK_SUBPIXEL_LAYOUT_VERTICAL_RGB
  GDK_SUBPIXEL_LAYOUT_VERTICAL_BGR
>;

our enum GdkDragProtocol is export (
  GDK_DRAG_PROTO_NONE => 0,
  'GDK_DRAG_PROTO_MOTIF',
  'GDK_DRAG_PROTO_XDND',
  'GDK_DRAG_PROTO_ROOTWIN',
  'GDK_DRAG_PROTO_WIN32_DROPFILES',
  'GDK_DRAG_PROTO_OLE2',
  'GDK_DRAG_PROTO_LOCAL',
  'GDK_DRAG_PROTO_WAYLAND'
);

sub gdkMakeAtom($i) is export {
  my gint $ii = $i +& 0x7fff;
  my $c = CArray[int64].new($ii);
  nativecast(GdkAtom, $c);
}

our enum GdkSelectionAtom is export (
  GDK_SELECTION_PRIMARY        => 1,
  GDK_SELECTION_SECONDARY      => 2,
  GDK_SELECTION_CLIPBOARD      => 69,
  GDK_TARGET_BITMAP            => 5,
  GDK_TARGET_COLORMAP          => 7,
  GDK_TARGET_DRAWABLE          => 17,
  GDK_TARGET_PIXMAP            => 20,
  GDK_TARGET_STRING            => 31,
  GDK_SELECTION_TYPE_ATOM      => 4,
  GDK_SELECTION_TYPE_BITMAP    => 5,
  GDK_SELECTION_TYPE_COLORMAP  => 7,
  GDK_SELECTION_TYPE_DRAWABLE  => 17,
  GDK_SELECTION_TYPE_INTEGER   => 19,
  GDK_SELECTION_TYPE           => 20,
  GDK_SELECTION_TYPE_WINDOW    => 33,
  GDK_SELECTION_TYPE_STRING    => 31,
);

our enum GdkButtons is export (
  GDK_BUTTON_PRIMARY           => 1,
  GDK_BUTTON_MIDDLE            => 2,
  GDK_BUTTON_SECONDARY         => 3
);

our enum GdkColorspace is export <GDK_COLORSPACE_RGB>;

our enum GdkPixbufError is export (
  # image data hosed */
  'GDK_PIXBUF_ERROR_CORRUPT_IMAGE',
  # no mem to load image
  'GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY',
  # bad option passed to save routine
  'GDK_PIXBUF_ERROR_BAD_OPTION',
  # unsupported image type (sort of an ENOSYS)
  'GDK_PIXBUF_ERROR_UNKNOWN_TYPE',
  # unsupported operation (load, save) for image type
  'GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION',
  'GDK_PIXBUF_ERROR_FAILED',
  'GDK_PIXBUF_ERROR_INCOMPLETE_ANIMATION'
);

our enum GdkPixbufAlphaMode is export <
  GDK_PIXBUF_ALPHA_BILEVEL
  GDK_PIXBUF_ALPHA_FULL
>;

our enum GdkInterpType is export <
  GDK_INTERP_NEAREST
  GDK_INTERP_TILES
  GDK_INTERP_BILINEAR
  GDK_INTERP_HYPER
>;

our enum GdkPixbufRotation is export (
  GDK_PIXBUF_ROTATE_NONE             =>   0,
  GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE =>  90,
  GDK_PIXBUF_ROTATE_UPSIDEDOWN       => 180,
  GDK_PIXBUF_ROTATE_CLOCKWISE        => 270
);

our enum GdkDragCancelReason is export <
  GDK_DRAG_CANCEL_NO_TARGET
  GDK_DRAG_CANCEL_USER_CANCELLED
  GDK_DRAG_CANCEL_ERROR
>;

our enum GdkInputSource is export <
  GDK_SOURCE_MOUSE
  GDK_SOURCE_PEN
  GDK_SOURCE_ERASER
  GDK_SOURCE_CURSOR
  GDK_SOURCE_KEYBOARD
  GDK_SOURCE_TOUCHSCREEN
  GDK_SOURCE_TOUCHPAD
  GDK_SOURCE_TRACKPOINT
  GDK_SOURCE_TABLET_PAD
>;

our enum GdkInputMode is export <
  GDK_MODE_DISABLED
  GDK_MODE_SCREEN
  GDK_MODE_WINDOW
>;

our enum GdkDeviceType is export <
  GDK_DEVICE_TYPE_MASTER
  GDK_DEVICE_TYPE_SLAVE
  GDK_DEVICE_TYPE_FLOATING
>;

our enum GdkAxisUse is export <
  GDK_AXIS_IGNORE
  GDK_AXIS_X
  GDK_AXIS_Y
  GDK_AXIS_PRESSURE
  GDK_AXIS_XTILT
  GDK_AXIS_YTILT
  GDK_AXIS_WHEEL
  GDK_AXIS_DISTANCE
  GDK_AXIS_ROTATION
  GDK_AXIS_SLIDER
  GDK_AXIS_LAST
>;

our enum GdkAxisFlags is export (
  GDK_AXIS_FLAG_X        => 1 +< GDK_AXIS_X,
  GDK_AXIS_FLAG_Y        => 1 +< GDK_AXIS_Y,
  GDK_AXIS_FLAG_PRESSURE => 1 +< GDK_AXIS_PRESSURE,
  GDK_AXIS_FLAG_XTILT    => 1 +< GDK_AXIS_XTILT,
  GDK_AXIS_FLAG_YTILT    => 1 +< GDK_AXIS_YTILT,
  GDK_AXIS_FLAG_WHEEL    => 1 +< GDK_AXIS_WHEEL,
  GDK_AXIS_FLAG_DISTANCE => 1 +< GDK_AXIS_DISTANCE,
  GDK_AXIS_FLAG_ROTATION => 1 +< GDK_AXIS_ROTATION,
  GDK_AXIS_FLAG_SLIDER   => 1 +< GDK_AXIS_SLIDER,
);

our enum GdkModifierIntent is export <
  GDK_MODIFIER_INTENT_PRIMARY_ACCELERATOR
  GDK_MODIFIER_INTENT_CONTEXT_MENU
  GDK_MODIFIER_INTENT_EXTEND_SELECTION
  GDK_MODIFIER_INTENT_MODIFY_SELECTION
  GDK_MODIFIER_INTENT_NO_TEXT_INPUT
  GDK_MODIFIER_INTENT_SHIFT_GROUP
  GDK_MODIFIER_INTENT_DEFAULT_MOD_MASK
>;

our enum GdkSeatCapabilities is export (
 GDK_SEAT_CAPABILITY_NONE          => 0,
 GDK_SEAT_CAPABILITY_POINTER       => 1,
 GDK_SEAT_CAPABILITY_TOUCH         => 1 +< 1,
 GDK_SEAT_CAPABILITY_TABLET_STYLUS => 1 +< 2,
 GDK_SEAT_CAPABILITY_KEYBOARD      => 1 +< 3,
 GDK_SEAT_CAPABILITY_ALL_POINTING  => (1 +| 1 +< 1 +| 1 +< 2),
 GDK_SEAT_CAPABILITY_ALL           => (1 +| 1 +< 1 +| 1 +< 2 +| 1 +< 3)
);

our enum GdkGrabStatus is export (
  GDK_GRAB_SUCCESS         => 0,
  GDK_GRAB_ALREADY_GRABBED => 1,
  GDK_GRAB_INVALID_TIME    => 2,
  GDK_GRAB_NOT_VIEWABLE    => 3,
  GDK_GRAB_FROZEN          => 4,
  GDK_GRAB_FAILED          => 5
);

# GLib-level
sub typeToGType (\t) is export {
  do given t {
    when Str             { G_TYPE_STRING  }
    when int16  | int32  { G_TYPE_INT     }
    when uint16 | uint32 { G_TYPE_UINT    }
    when int64           { G_TYPE_INT64   }
    when uint64          { G_TYPE_UINT64  }
    when num32           { G_TYPE_FLOAT   }
    when num64           { G_TYPE_DOUBLE  }
    when Pointer         { G_TYPE_POINTER }
    when Bool            { G_TYPE_BOOLEAN }
    when GObject         { G_TYPE_OBJECT  }
  }
}
