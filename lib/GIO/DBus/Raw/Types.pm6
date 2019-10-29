use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;

use GTK::Raw::Utils;

unit package GIO::DBus::Raw::Types;

constant GBusNameOwnerFlags is export := guint;
our enum GBusNameOwnerFlagsEnum is export (
  G_BUS_NAME_OWNER_FLAGS_NONE              => 0,
  G_BUS_NAME_OWNER_FLAGS_ALLOW_REPLACEMENT => 1,
  G_BUS_NAME_OWNER_FLAGS_REPLACE           => 1 +< 1,
  G_BUS_NAME_OWNER_FLAGS_DO_NOT_QUEUE      => 1 +< 2
);

constant GBusNameWatcherFlags is export := guint;
our enum GBusNameWatcherFlagsEnum is export (
  G_BUS_NAME_WATCHER_FLAGS_NONE       => 0,
  G_BUS_NAME_WATCHER_FLAGS_AUTO_START => 1,
);

constant GBusType is export := gint;
our enum GBusTypeEnum is export (
  G_BUS_TYPE_STARTER => -1,
  G_BUS_TYPE_NONE    => 0,
  G_BUS_TYPE_SYSTEM  => 1,
  G_BUS_TYPE_SESSION => 2
);

constant GDBusCapabilityFlags is export := guint;
our enum GDBusCapabilityFlagsEnum is export (
  G_DBUS_CAPABILITY_FLAGS_NONE            => 0,
  G_DBUS_CAPABILITY_FLAGS_UNIX_FD_PASSING => 1
);

constant GDBusCallFlags is export := guint;
our enum GDBusCallFlagsEnum is export (
  G_DBUS_CALL_FLAGS_NONE                            => 0,
  G_DBUS_CALL_FLAGS_NO_AUTO_START                   => 1,
  G_DBUS_CALL_FLAGS_ALLOW_INTERACTIVE_AUTHORIZATION => 2
);

constant GDBusConnectionFlags is export := guint;
our enum GDBusConnectionFlagsEnum is export (
  G_DBUS_CONNECTION_FLAGS_NONE                           => 0,
  G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT          => 1,
  G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_SERVER          => 1 +< 1,
  G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS => 1 +< 2,
  G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION         => 1 +< 3,
  G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING       => 1 +< 4
);

constant GDBusError is export := guint;
our enum GDBusErrorEnum is export (
  # Well-known errors in the org.freedesktop.DBus.Error namespace
  'G_DBUS_ERROR_FAILED',                           # org.freedesktop.DBus.Error.Failed
  'G_DBUS_ERROR_NO_MEMORY',                        # org.freedesktop.DBus.Error.NoMemory
  'G_DBUS_ERROR_SERVICE_UNKNOWN',                  # org.freedesktop.DBus.Error.ServiceUnknown
  'G_DBUS_ERROR_NAME_HAS_NO_OWNER',                # org.freedesktop.DBus.Error.NameHasNoOwner
  'G_DBUS_ERROR_NO_REPLY',                         # org.freedesktop.DBus.Error.NoReply
  'G_DBUS_ERROR_IO_ERROR',                         # org.freedesktop.DBus.Error.IOError
  'G_DBUS_ERROR_BAD_ADDRESS',                      # org.freedesktop.DBus.Error.BadAddress
  'G_DBUS_ERROR_NOT_SUPPORTED',                    # org.freedesktop.DBus.Error.NotSupported
  'G_DBUS_ERROR_LIMITS_EXCEEDED',                  # org.freedesktop.DBus.Error.LimitsExceeded
  'G_DBUS_ERROR_ACCESS_DENIED',                    # org.freedesktop.DBus.Error.AccessDenied
  'G_DBUS_ERROR_AUTH_FAILED',                      # org.freedesktop.DBus.Error.AuthFailed
  'G_DBUS_ERROR_NO_SERVER',                        # org.freedesktop.DBus.Error.NoServer
  'G_DBUS_ERROR_TIMEOUT',                          # org.freedesktop.DBus.Error.Timeout
  'G_DBUS_ERROR_NO_NETWORK',                       # org.freedesktop.DBus.Error.NoNetwork
  'G_DBUS_ERROR_ADDRESS_IN_USE',                   # org.freedesktop.DBus.Error.AddressInUse
  'G_DBUS_ERROR_DISCONNECTED',                     # org.freedesktop.DBus.Error.Disconnected
  'G_DBUS_ERROR_INVALID_ARGS',                     # org.freedesktop.DBus.Error.InvalidArgs
  'G_DBUS_ERROR_FILE_NOT_FOUND',                   # org.freedesktop.DBus.Error.FileNotFound
  'G_DBUS_ERROR_FILE_EXISTS',                      # org.freedesktop.DBus.Error.FileExists
  'G_DBUS_ERROR_UNKNOWN_METHOD',                   # org.freedesktop.DBus.Error.UnknownMethod
  'G_DBUS_ERROR_TIMED_OUT',                        # org.freedesktop.DBus.Error.TimedOut
  'G_DBUS_ERROR_MATCH_RULE_NOT_FOUND',             # org.freedesktop.DBus.Error.MatchRuleNotFound
  'G_DBUS_ERROR_MATCH_RULE_INVALID',               # org.freedesktop.DBus.Error.MatchRuleInvalid
  'G_DBUS_ERROR_SPAWN_EXEC_FAILED',                # org.freedesktop.DBus.Error.Spawn.ExecFailed
  'G_DBUS_ERROR_SPAWN_FORK_FAILED',                # org.freedesktop.DBus.Error.Spawn.ForkFailed
  'G_DBUS_ERROR_SPAWN_CHILD_EXITED',               # org.freedesktop.DBus.Error.Spawn.ChildExited
  'G_DBUS_ERROR_SPAWN_CHILD_SIGNALED',             # org.freedesktop.DBus.Error.Spawn.ChildSignaled
  'G_DBUS_ERROR_SPAWN_FAILED',                     # org.freedesktop.DBus.Error.Spawn.Failed
  'G_DBUS_ERROR_SPAWN_SETUP_FAILED',               # org.freedesktop.DBus.Error.Spawn.FailedToSetup
  'G_DBUS_ERROR_SPAWN_CONFIG_INVALID',             # org.freedesktop.DBus.Error.Spawn.ConfigInvalid
  'G_DBUS_ERROR_SPAWN_SERVICE_INVALID',            # org.freedesktop.DBus.Error.Spawn.ServiceNotValid
  'G_DBUS_ERROR_SPAWN_SERVICE_NOT_FOUND',          # org.freedesktop.DBus.Error.Spawn.ServiceNotFound
  'G_DBUS_ERROR_SPAWN_PERMISSIONS_INVALID',        # org.freedesktop.DBus.Error.Spawn.PermissionsInvalid
  'G_DBUS_ERROR_SPAWN_FILE_INVALID',               # org.freedesktop.DBus.Error.Spawn.FileInvalid
  'G_DBUS_ERROR_SPAWN_NO_MEMORY',                  # org.freedesktop.DBus.Error.Spawn.NoMemory
  'G_DBUS_ERROR_UNIX_PROCESS_ID_UNKNOWN',          # org.freedesktop.DBus.Error.UnixProcessIdUnknown
  'G_DBUS_ERROR_INVALID_SIGNATURE',                # org.freedesktop.DBus.Error.InvalidSignature
  'G_DBUS_ERROR_INVALID_FILE_CONTENT',             # org.freedesktop.DBus.Error.InvalidFileContent
  'G_DBUS_ERROR_SELINUX_SECURITY_CONTEXT_UNKNOWN', # org.freedesktop.DBus.Error.SELinuxSecurityContextUnknown
  'G_DBUS_ERROR_ADT_AUDIT_DATA_UNKNOWN',           # org.freedesktop.DBus.Error.AdtAuditDataUnknown
  'G_DBUS_ERROR_OBJECT_PATH_IN_USE',               # org.freedesktop.DBus.Error.ObjectPathInUse
  'G_DBUS_ERROR_UNKNOWN_OBJECT',                   # org.freedesktop.DBus.Error.UnknownObject
  'G_DBUS_ERROR_UNKNOWN_INTERFACE',                # org.freedesktop.DBus.Error.UnknownInterface
  'G_DBUS_ERROR_UNKNOWN_PROPERTY',                 # org.freedesktop.DBus.Error.UnknownProperty
  'G_DBUS_ERROR_PROPERTY_READ_ONLY'                # org.freedesktop.DBus.Error.PropertyReadOnly
);

constant GDBusMessageByteOrder is export := guint;
our enum GDBusMessageByteOrderEnum is export (
  G_DBUS_MESSAGE_BYTE_ORDER_BIG_ENDIAN    => 'B',
  G_DBUS_MESSAGE_BYTE_ORDER_LITTLE_ENDIAN => 'l'
);

constant GDBusMessageFlags is export := guint;
our enum GDBusMessageFlagsEnum is export (
  G_DBUS_MESSAGE_FLAGS_NONE                            => 0,
  G_DBUS_MESSAGE_FLAGS_NO_REPLY_EXPECTED               => 1,
  G_DBUS_MESSAGE_FLAGS_NO_AUTO_START                   => 1 +< 1,
  G_DBUS_MESSAGE_FLAGS_ALLOW_INTERACTIVE_AUTHORIZATION => 1 +< 2
);

constant GDBusMessageHeaderField is export := guint;
our enum GDBusMessageHeaderFieldEnum is export <
  G_DBUS_MESSAGE_HEADER_FIELD_INVALID
  G_DBUS_MESSAGE_HEADER_FIELD_PATH
  G_DBUS_MESSAGE_HEADER_FIELD_INTERFACE
  G_DBUS_MESSAGE_HEADER_FIELD_MEMBER
  G_DBUS_MESSAGE_HEADER_FIELD_ERROR_NAME
  G_DBUS_MESSAGE_HEADER_FIELD_REPLY_SERIAL
  G_DBUS_MESSAGE_HEADER_FIELD_DESTINATION
  G_DBUS_MESSAGE_HEADER_FIELD_SENDER
  G_DBUS_MESSAGE_HEADER_FIELD_SIGNATURE
  G_DBUS_MESSAGE_HEADER_FIELD_NUM_UNIX_FD
>;

constant GDBusMessageType is export := guint;
our enum GDBusMessageTypeEnum is export <
  G_DBUS_MESSAGE_TYPE_INVALID
  G_DBUS_MESSAGE_TYPE_METHOD_CALL
  G_DBUS_MESSAGE_TYPE_METHOD_RETURN
  G_DBUS_MESSAGE_TYPE_ERROR
  G_DBUS_MESSAGE_TYPE_SIGNAL
>;

constant GDBusObjectManagerClientFlags is export := guint;
our enum GDBusObjectManagerClientFlagsEnums is export (
  G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_NONE              => 0,
  G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_DO_NOT_AUTO_START => 1
);

constant GDBusPropertyInfoFlags is export := guint;
our enum GDBusPropertyInfoFlagsEnum is export (
  G_DBUS_PROPERTY_INFO_FLAGS_NONE     => 0,
  G_DBUS_PROPERTY_INFO_FLAGS_READABLE => 1,
  G_DBUS_PROPERTY_INFO_FLAGS_WRITABLE => 2
);

constant GDBusProxyFlags is export := guint;
our enum GDBusProxyFlagsEnum is export (
  G_DBUS_PROXY_FLAGS_NONE                              => 0,
  G_DBUS_PROXY_FLAGS_DO_NOT_LOAD_PROPERTIES            => 1,
  G_DBUS_PROXY_FLAGS_DO_NOT_CONNECT_SIGNALS            => 1 +<1,
  G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START                 => 1 +<2,
  G_DBUS_PROXY_FLAGS_GET_INVALIDATED_PROPERTIES        => 1 +<3,
  G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START_AT_CONSTRUCTION => 1 +<4
);

constant GDBusSendMessageFlags is export := guint;
our enum GDBusSendMessageFlagsEnum is export (
  G_DBUS_SEND_MESSAGE_FLAGS_NONE            => 0,
  G_DBUS_SEND_MESSAGE_FLAGS_PRESERVE_SERIAL => 1
);

constant GDBusServerFlags is export := guint;
our enum GDBusServerFlagsEnum is export (
  G_DBUS_SERVER_FLAGS_NONE                           => 0,
  G_DBUS_SERVER_FLAGS_RUN_IN_THREAD                  => 1,
  G_DBUS_SERVER_FLAGS_AUTHENTICATION_ALLOW_ANONYMOUS => 2
);

constant GDBusSignalFlags is export := guint;
our enum GDBusSignalFlagsEnum is export (
  G_DBUS_SIGNAL_FLAGS_NONE                 => 0,
  G_DBUS_SIGNAL_FLAGS_NO_MATCH_RULE        => 1,
  G_DBUS_SIGNAL_FLAGS_MATCH_ARG0_NAMESPACE => 2,
  G_DBUS_SIGNAL_FLAGS_MATCH_ARG0_PATH      => 4
);

constant GDBusInterfaceSkeletonFlags is export := guint;
enum GDBusInterfaceSkeletonFlagsEnum is export (
  G_DBUS_INTERFACE_SKELETON_FLAGS_NONE                                => 0,
  G_DBUS_INTERFACE_SKELETON_FLAGS_HANDLE_METHOD_INVOCATIONS_IN_THREAD => 1
);

constant GDBusSubtreeFlags is export := guint;
our enum GDBusSubtreeFlagsEnum is export (
  G_DBUS_SUBTREE_FLAGS_NONE                           => 0,
  G_DBUS_SUBTREE_FLAGS_DISPATCH_TO_UNENUMERATED_NODES => 1
);

role Annotations {
  method lookup (Str() $name) {
    g_dbus_annotation_info_lookup(self.annotations, $name);
  }
}

class GDBusAnnotationInfo is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint     $!ref_count;
  has Str      $!key;
  has Str      $!value;
  has Pointer  $!annotations;   # GDBusAnnotationInfo **

  submethod BUILD {
    $!ref_count = 1;
  }

  submethod DESTROY {
    self.unref;
  }

  method key is rw {
    Proxy.new:
      FETCH => -> $             { $!key },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method value is rw {
    Proxy.new:
      FETCH => -> $             { $!value },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method annotations ($raw = False) is rw {
    Proxy.new:
      FETCH => -> $ { $!annotations },

      STORE => -> $, Pointer $val {
        self.^attributes(:local)[3].set_value(self, $val)
      };
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_annotation_info_get_type, $n, $t );
  }

  method ref {
    g_dbus_annotation_info_ref(self);
    self;
  }

  method unref {
    g_dbus_annotation_info_unref(self);
  }
}

class GDBusArgInfo is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint                                  $!ref_count;
  has Str                                   $!name;
  has Str                                   $!signature;
  has CArray[Pointer[GDBusAnnotationInfo]]  $!annotations;

  submethod BUILD {
    $!ref_count = 1;
  }

  submethod DESTROY {
    self.unref;
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $             { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method signature is rw {
    Proxy.new:
      FETCH => -> $             { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method annotations ($raw = False) is rw {
    Proxy.new:
      FETCH => -> $ { $raw ?? $!annotations !! CArrayToArray($!annotations) },

      STORE => -> $, CArray[Pointer[GDBusAnnotationInfo]] $val {
        self.^attributes(:local)[3].set_value(self, $val)
      };
  }

  method get_type {
    g_dbus_arg_info_get_type();
  }

  method ref {
    g_dbus_arg_info_ref(self);
    self;
  }

  method unref {
    g_dbus_arg_info_unref(self);
  }
}

class GDBusErrorEntry is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint $!error-code;
  has Str  $!dbus-error-name;

  submethod DESTROY {
    self.unref;
  }

  method unref {
    g_free(self.p);
  }

  method error-code is rw is also<error_code> {
    Proxy.new:
      FETCH => -> $             { $!error-code },
      STORE => -> $, Int() $val { $!error-code = $val };
  }

  method dbus-error-name is rw is also<dbus_error_name> {
    Proxy.new:
      FETCH => -> $ { $!dbus-error-name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }
}

class GDBusMethodInfo is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint                                  $!ref_count;
  has Str                                   $!name;
  has CArray[Pointer[GDBusArgInfo]]         $!in_args;
  has CArray[Pointer[GDBusArgInfo]]         $!out_args;
  has CArray[Pointer[GDBusAnnotationInfo]]  $!annotations;

  submethod BUILD {
    $!ref_count = 1;
  }

  submethod DESTROY {
    self.unref;
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $ { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method in_args is rw is also<in-args> {
    Proxy.new:
      FETCH => -> $ { $!in_args },

      STORE => -> $, CArray[Pointer[GDBusArgInfo]] $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method out_args is rw is also<out-args> {
    Proxy.new:
      FETCH => -> $ { $!out_args },

      STORE => -> $, CArray[Pointer[GDBusArgInfo]] $val {
        self.^attributes(:local)[3].set_value(self, $val)
      };
  }

  method annotations is rw {
    Proxy.new:
      FETCH => -> $ { $!annotations },

      STORE => -> $, CArray[Pointer[GDBusAnnotationInfo]] $val {
        self.^attributes(:local)[4].set_value(self, $val)
      };
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_method_info_get_type, $n, $t );
  }

  method ref {
    g_dbus_method_info_ref(self);
    self;
  }

  method unref {
    g_dbus_method_info_unref(self);
  }
}

class GDBusPropertyInfo is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint                                 $!ref_count;
  has Str                                  $!name;
  has Str                                  $!signature;
  has GDBusPropertyInfoFlags               $!flags;
  has CArray[Pointer[GDBusAnnotationInfo]] $!annotations;

  submethod BUILD {
    $!ref_count = 1;
  }

  submethod DESTROY {
    self.unref;
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $ { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method signature is rw {
    Proxy.new:
      FETCH => -> $             { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method flags is rw {
    Proxy.new:
      FETCH => -> $             { GDBusPropertyInfoFlagsEnum($!flags) },
      STORE => -> $, Int() $val { $!flags = $val                      };
  }

  method annotations is rw {
    Proxy.new:
      FETCH => -> $ { $!annotations },

      STORE => -> $, CArray[Pointer[GDBusAnnotationInfo]] $val {
        self.^attributes(:local)[4].set_value(self, $val)
      };
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_property_info_get_type, $n, $t );
  }

  method ref {
    g_dbus_property_info_ref(self);
    self;
  }

  method unref {
    g_dbus_property_info_unref(self);
  }
}

class GDBusSignalInfo is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint                                 $!ref_count;
  has Str                                  $!name;
  has CArray[Pointer[GDBusArgInfo]]        $!args;
  has CArray[Pointer[GDBusAnnotationInfo]] $!annotations;

  submethod BUILD {
    $!ref_count = 1;
  }

  submethod DESTROY {
    self.unref;
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $ { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method args is rw {
    Proxy.new:
      FETCH => -> $ { $!args },

      STORE => -> $, CArray[Pointer[GDBusArgInfo]] $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method annotations is rw {
    Proxy.new:
      FETCH => -> $ { $!annotations },

      STORE => -> $, CArray[Pointer[GDBusAnnotationInfo]] $val {
        self.^attributes(:local)[3].set_value(self, $val)
      };
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_signal_info_get_type, $n, $t );
  }

  method ref {
    g_dbus_signal_info_ref(self);
    self;
  }

  method unref {
    g_dbus_signal_info_unref(self);
  }
}

class GDBusInterfaceInfo is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint                                 $!ref_count;
  has Str                                  $!name;
  has CArray[Pointer[GDBusMethodInfo]]     $!methods;
  has CArray[Pointer[GDBusSignalInfo]]     $!signals;
  has CArray[Pointer[GDBusPropertyInfo]]   $!properties;
  has CArray[Pointer[GDBusAnnotationInfo]] $!annotations;

  submethod BUILD {
    $!ref_count = 1;
  }

  submethod DESTROY {
    self.unref;
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $ { $!name },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method methods is rw {
    Proxy.new:
      FETCH => -> $ { $!methods },

      STORE => -> $, CArray[Pointer[GDBusMethodInfo]] $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method signals is rw {
    Proxy.new:
      FETCH => -> $ { $!signals },

      STORE => -> $, CArray[Pointer[GDBusSignalInfo]] $val {
        self.^attributes(:local)[3].set_value(self, $val)
      };
  }

  method properties is rw {
    Proxy.new:
      FETCH => -> $ { $!properties },

      STORE => -> $, CArray[Pointer[GDBusPropertyInfo]] $val {
        self.^attributes(:local)[4].set_value(self, $val)
      };
  }

  method annotations is rw {
    Proxy.new:
      FETCH => -> $ { $!annotations },

      STORE => -> $, CArray[Pointer[GDBusAnnotationInfo]] $val {
        self.^attributes(:local)[5].set_value(self, $val)
      };
  }

  method cache_build {
    g_dbus_interface_info_cache_build(self);
  }

  method cache_release {
    g_dbus_interface_info_cache_release(self);
  }

  method generate_xml (Int() $indent, GString() $string_builder) {
    my guint $i = $indent;

    g_dbus_interface_info_generate_xml(self, $i, $string_builder);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_interface_info_get_type, $n, $t );
  }

  method lookup_method (Str() $name) {
    g_dbus_interface_info_lookup_method(self, $name);
  }

  method lookup_property (Str() $name) {
    g_dbus_interface_info_lookup_property(self, $name);
  }

  method lookup_signal (Str() $name) {
    g_dbus_interface_info_lookup_signal(self, $name);
  }

  method ref {
    g_dbus_interface_info_ref(self);
    self;
  }

  method unref {
    g_dbus_interface_info_unref(self);
  }
}

class GDBusNodeInfo  is export is repr<CStruct> does GTK::Roles::Pointers does Annotations {
  has gint                                 $!ref_count;
  has Str                                  $!path;
  has CArray[Pointer[GDBusInterfaceInfo]]  $!interfaces;
  has Pointer                              $!nodes;  # GDBusNodeInfo **
  has CArray[Pointer[GDBusAnnotationInfo]] $!annotations;

  method path is rw {
    Proxy.new:
      FETCH => -> $ { $!path },

      STORE => -> $, Str() $val {
        self.^attributes(:local)[1].set_value(self, $val)
      };
  }

  method interfaces is rw {
    Proxy.new:
      FETCH => -> $ { $!interfaces },

      STORE => -> $, CArray[Pointer[GDBusInterfaceInfo]] $val {
        self.^attributes(:local)[2].set_value(self, $val)
      };
  }

  method nodes is rw {
    Proxy.new:
      FETCH => -> $ { $!nodes },

      STORE => -> $, Pointer $val {
        self.^attributes(:local)[3].set_value(self, $val)
      };
  }

  method annotations is rw {
    Proxy.new:
      FETCH => -> $ { $!annotations },

      STORE => -> $, CArray[Pointer[GDBusAnnotationInfo]] $val {
        self.^attributes(:local)[4].set_value(self, $val)
      };
  }

  method new_for_xml (
    Str() $xml_data,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $ni = g_dbus_node_info_new_for_xml($xml_data, $error);
    set_error($error);
    $ni;
  }

  method generate_xml (Int() $indent, GString() $string_builder) {
    my guint $i = $indent;

    g_dbus_node_info_generate_xml(self, $i, $string_builder);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_dbus_node_info_get_type, $n, $t );
  }

  method lookup_interface (Str() $name) {
    g_dbus_node_info_lookup_interface(self, $name);
  }

  method ref {
    g_dbus_node_info_ref(self);
    self;
  }

  method unref {
    g_dbus_node_info_unref(self);
  }
}

class GDBusInterfaceVTable is export is repr<CStruct> does GTK::Roles::Pointers {
  has Pointer $.method_call;  # GDBusInterfaceMethodCallFunc
  has Pointer $.get_property; # GDBusInterfaceGetPropertyFunc
  has Pointer $.set_property; # GDBusInterfaceSetPropertyFunc
}

class GDBusSubtreeVTable is export is repr<CStruct> does GTK::Roles::Pointers {
  has Pointer $.enumerate;
  has Pointer $.introspect;
  has Pointer $.dispatch;
}

sub g_dbus_annotation_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_annotation_info_lookup (Pointer $annotations, Str $name)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_annotation_info_ref (GDBusAnnotationInfo $info)
  returns GDBusAnnotationInfo
  is native(gio)
  is export
{ * }

sub g_dbus_annotation_info_unref (GDBusAnnotationInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_arg_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_arg_info_ref (GDBusArgInfo $info)
  returns GDBusArgInfo
  is native(gio)
  is export
{ * }

sub g_dbus_arg_info_unref (GDBusArgInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_cache_build (GDBusInterfaceInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_cache_release (GDBusInterfaceInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_generate_xml (
  GDBusInterfaceInfo $info,
  guint $indent,
  GString $string_builder
)
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_lookup_method (GDBusInterfaceInfo $info, Str $name)
  returns GDBusMethodInfo
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_lookup_property (GDBusInterfaceInfo $info, Str $name)
  returns GDBusPropertyInfo
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_lookup_signal (GDBusInterfaceInfo $info, Str $name)
  returns GDBusSignalInfo
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_ref (GDBusInterfaceInfo $info)
  returns GDBusInterfaceInfo
  is native(gio)
  is export
{ * }

sub g_dbus_interface_info_unref (GDBusInterfaceInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_method_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_method_info_ref (GDBusMethodInfo $info)
  returns GDBusMethodInfo
  is native(gio)
  is export
{ * }

sub g_dbus_method_info_unref (GDBusMethodInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_node_info_generate_xml (
  GDBusNodeInfo $info,
  guint $indent,
  GString $string_builder
)
  is native(gio)
  is export
{ * }

sub g_dbus_node_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_node_info_lookup_interface (GDBusNodeInfo $info, Str $name)
  returns GDBusInterfaceInfo
  is native(gio)
  is export
{ * }

sub g_dbus_node_info_new_for_xml (
  Str $xml_data,
  CArray[Pointer[GError]] $error
)
  returns GDBusNodeInfo
  is native(gio)
  is export
{ * }

sub g_dbus_node_info_ref (GDBusNodeInfo $info)
  returns GDBusNodeInfo
  is native(gio)
  is export
{ * }

sub g_dbus_node_info_unref (GDBusNodeInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_property_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_property_info_ref (GDBusPropertyInfo $info)
  returns GDBusPropertyInfo
  is native(gio)
  is export
{ * }

sub g_dbus_property_info_unref (GDBusPropertyInfo $info)
  is native(gio)
  is export
{ * }

sub g_dbus_signal_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_signal_info_ref (GDBusSignalInfo $info)
  returns GDBusSignalInfo
  is native(gio)
  is export
{ * }

sub g_dbus_signal_info_unref (GDBusSignalInfo $info)
  is native(gio)
  is export
{ * }
