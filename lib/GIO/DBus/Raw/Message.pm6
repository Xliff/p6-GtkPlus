use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GIO::DBus::Raw::Types;

unit package GIO::DBus::Raw::Message;

sub g_dbus_message_bytes_needed (
  Blob $blob,
  gsize $blob_len,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_dbus_message_copy (
  GDBusMessage $message,
  CArray[Pointer[GError]] $error
)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_arg0 (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_header (
  GDBusMessage $message,
  GDBusMessageHeaderField $header_field
)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_header_fields (GDBusMessage $message)
  returns CArray[uint8]
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_locked (GDBusMessage $message)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_dbus_message_lock (GDBusMessage $message)
  is native(gio)
  is export
{ * }

sub g_dbus_message_new ()
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_message_new_from_blob (
  Blob $blob,
  gsize $blob_len,
  GDBusCapabilityFlags $capabilities,
  CArray[Pointer[GError]] $error
)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_message_new_method_call (
  Str $name,
  Str $path,
  Str $interface,
  Str $method
)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_message_new_method_error_literal (
  GDBusMessage $method_call_message,
  Str $error_name,
  Str $error_message
)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

# sub g_dbus_message_new_method_error_valist (
#   GDBusMessage $method_call_message,
#   Str $error_name,
#   Str $error_message_format,
#   va_list $var_args
# )
#   returns GDBusMessage
#   is native(gio)
#   is export
# { * }

sub g_dbus_message_new_method_reply (GDBusMessage $method_call_message)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_message_new_signal (Str $path, Str $interface_, Str $signal)
  returns GDBusMessage
  is native(gio)
  is export
{ * }

sub g_dbus_message_print (GDBusMessage $message, guint $indent)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_header (
  GDBusMessage $message,
  GDBusMessageHeaderField $header_field,
  GVariant $value
)
  is native(gio)
  is export
{ * }

sub g_dbus_message_to_blob (
  GDBusMessage $message,
  gsize $out_size is rw,
  GDBusCapabilityFlags $capabilities,
  CArray[Pointer[GError]] $error
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_dbus_message_to_gerror (
  GDBusMessage $message,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_body (GDBusMessage $message)
  returns GVariant
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_byte_order (GDBusMessage $message)
  returns GDBusMessageByteOrder
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_destination (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_error_name (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_flags (GDBusMessage $message)
  returns GDBusMessageFlags
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_interface (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_member (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_message_type (GDBusMessage $message)
  returns GDBusMessageType
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_num_unix_fds (GDBusMessage $message)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_path (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_reply_serial (GDBusMessage $message)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_sender (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_serial (GDBusMessage $message)
  returns guint32
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_signature (GDBusMessage $message)
  returns Str
  is native(gio)
  is export
{ * }

sub g_dbus_message_get_unix_fd_list (GDBusMessage $message)
  returns GUnixFDList
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_body (GDBusMessage $message, GVariant $body)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_byte_order (
  GDBusMessage $message,
  GDBusMessageByteOrder $byte_order
)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_destination (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_error_name (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_flags (GDBusMessage $message, GDBusMessageFlags $flags)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_interface (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_member (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_message_type (
  GDBusMessage $message,
  GDBusMessageType $type
)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_num_unix_fds (GDBusMessage $message, guint32 $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_path (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_reply_serial (GDBusMessage $message, guint32 $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_sender (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_serial (GDBusMessage $message, guint32 $serial)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_signature (GDBusMessage $message, Str $value)
  is native(gio)
  is export
{ * }

sub g_dbus_message_set_unix_fd_list (
  GDBusMessage $message,
  GUnixFDList $fd_list
)
  is native(gio)
  is export
{ * }
