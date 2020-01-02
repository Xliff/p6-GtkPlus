use v6.c;

use nqp;
use NativeCall;

use GLib::Roles::Pointers;

unit package GLib::Raw::Definitions;

our $ERROR is export;
our $DEBUG is export = 0;

# Forced compile count
constant forced = 33;

# Libs
constant glib       is export  = 'glib-2.0',v0;
constant gobject    is export  = 'gobject-2.0',v0;

constant realUInt is export = $*KERNEL.bits == 32 ?? uint32 !! uint64;

constant gboolean                       is export := uint32;
constant gchar                          is export := Str;
constant gconstpointer                  is export := Pointer;
constant gdouble                        is export := num64;
constant gfloat                         is export := num32;
constant gint                           is export := int32;
constant gint8                          is export := int8;
constant gint16                         is export := int16;
constant gint32                         is export := int32;
constant gint64                         is export := int64;
constant glong                          is export := int64;
constant goffset                        is export := uint64;
constant gpointer                       is export := Pointer;
constant gsize                          is export := uint64;
constant gssize                         is export := int64;
constant guchar                         is export := Str;
constant gshort                         is export := int8;
constant gushort                        is export := uint8;
constant guint                          is export := uint32;
constant guint8                         is export := uint8;
constant guint16                        is export := uint16;
constant guint32                        is export := uint32;
constant guint64                        is export := uint64;
constant gulong                         is export := uint64;
constant gunichar                       is export := uint32;
constant gunichar2                      is export := uint16;
constant va_list                        is export := Pointer;
constant time_t                         is export := uint64;
constant uid_t                          is export := uint32;
constant gid_t                          is export := uint32;
constant pid_t                          is export := int32;

# Conditionals!
constant GPid                           is export := realUInt;

# Function Pointers
constant GAsyncReadyCallback            is export := Pointer;
constant GBindingTransformFunc          is export := Pointer;
constant GCallback                      is export := Pointer;
constant GCompareDataFunc               is export := Pointer;
constant GCompareFunc                   is export := Pointer;
constant GCopyFunc                      is export := Pointer;
constant GClosureNotify                 is export := Pointer;
constant GDate                          is export := uint64;
constant GDestroyNotify                 is export := Pointer;
constant GQuark                         is export := uint32;
constant GEqualFunc                     is export := Pointer;
constant GFunc                          is export := Pointer;
constant GHFunc                         is export := Pointer;
constant GLogFunc                       is export := Pointer;
constant GLogWriterFunc                 is export := Pointer;
constant GPrintFunc                     is export := Pointer;
constant GReallocFunc                   is export := Pointer;
constant GSignalAccumulator             is export := Pointer;
constant GSignalEmissionHook            is export := Pointer;
constant GSignalCMarshaller             is export := Pointer;
constant GSignalCVaMarshaller           is export := Pointer;
constant GStrv                          is export := CArray[Str];
constant GThreadFunc                    is export := Pointer;
constant GTimeSpan                      is export := int64;
constant GType                          is export := uint64;

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

class GBinding                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GBytes                   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GDateTime                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTree                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GChecksum                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GClosure                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GHmac                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GHashTable               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GHashTableIter           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GKeyFile                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMainLoop                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMainContext             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMarkupParser            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMarkupParseContext      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GMutex                   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GModule                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GObject                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GParamSpec               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GParamSpecPool           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GRand                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GRWLock                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GSource                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GThread                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GThreadPool              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTimer                   is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTimeZone                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GTokenValue              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVariant                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVariantBuilder          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVariantDict             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVariantIter             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GVariantType             is repr('CPointer') is export does GLib::Roles::Pointers { }

our role Implementor is export {};

# Mark
multi sub trait_mod:<is>(Attribute:D \attr, :$implementor) is export {
  # YYY - Warning if a second attribute is marked?
  attr does Implementor;
}

# Find.
sub findProperImplementor ($attrs) is export {
  # Will need to search the entire attributes list for the
  # proper main variable. Then sort for the one with the largest
  # MRO.
  $attrs.grep( * ~~ Implementor ).sort( -*.package.^mro.elems )[0]
}
