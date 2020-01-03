use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Definitions;

# GIO
constant gio        is export  = 'gio-2.0',v0;

constant GDesktopAppLaunchCallback      is export := Pointer;
constant GIOFunc                        is export := Pointer;
constant GSettingsBindGetMapping        is export := Pointer;
constant GSettingsBindSetMapping        is export := Pointer;
constant GSettingsGetMapping            is export := Pointer;
constant GSpawnChildSetupFunc           is export := Pointer;
constant GVfsFileLookupFunc             is export := Pointer;

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
