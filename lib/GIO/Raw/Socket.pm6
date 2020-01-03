use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Socket;

sub g_socket_accept (
  GSocket $socket,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GSocket
  is native(gio)
  is export
{ * }

sub g_socket_bind (
  GSocket $socket,
  GSocketAddress $address,
  gboolean $allow_reuse,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_check_connect_result (
  GSocket $socket,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_close (GSocket $socket, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_condition_check (GSocket $socket, GIOCondition $condition)
  returns GIOCondition
  is native(gio)
  is export
{ * }

sub g_socket_condition_timed_wait (
  GSocket $socket,
  GIOCondition $condition,
  gint64 $timeout_us,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_condition_wait (
  GSocket $socket,
  GIOCondition $condition,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_connect (
  GSocket $socket,
  GSocketAddress $address,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_create_source (
  GSocket $socket,
  GIOCondition $condition,
  GCancellable $cancellable
)
  returns GSource
  is native(gio)
  is export
{ * }

sub g_socket_get_available_bytes (GSocket $socket)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_get_credentials (
  GSocket $socket,
  CArray[Pointer[GError]] $error
)
  returns GCredentials
  is native(gio)
  is export
{ * }

sub g_socket_get_family (GSocket $socket)
  returns GSocketFamily
  is native(gio)
  is export
{ * }

sub g_socket_get_fd (GSocket $socket)
  returns gint
  is native(gio)
  is export
{ * }

sub g_socket_get_local_address (
  GSocket $socket,
  CArray[Pointer[GError]] $error
)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_socket_get_option (
  GSocket $socket,
  gint $level,
  gint $optname,
  gint $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_get_protocol (GSocket $socket)
  returns GSocketProtocol
  is native(gio)
  is export
{ * }

sub g_socket_get_remote_address (
  GSocket $socket,
  CArray[Pointer[GError]] $error
)
  returns GSocketAddress
  is native(gio)
  is export
{ * }

sub g_socket_get_socket_type (GSocket $socket)
  returns GSocketType
  is native(gio)
  is export
{ * }

sub g_socket_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_socket_is_closed (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_is_connected (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_join_multicast_group (
  GSocket $socket ,
  GInetAddress $group,
  gboolean $source_specific,
  Str $iface,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_join_multicast_group_ssm (
  GSocket $socket,
  GInetAddress $group,
  GInetAddress $source_specific,
  Str $iface,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_leave_multicast_group (
  GSocket $socket,
  GInetAddress $group,
  gboolean $source_specific,
  Str $iface,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_leave_multicast_group_ssm (
  GSocket $socket,
  GInetAddress $group,
  GInetAddress $source_specific,
  Str $iface,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_listen (GSocket $socket, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_new (
  GSocketFamily $family,
  GSocketType $type,
  GSocketProtocol $protocol,
  CArray[Pointer[GError]] $error
)
  returns GSocket
  is native(gio)
  is export
{ * }

sub g_socket_new_from_fd (gint $fd, CArray[Pointer[GError]] $error)
  returns GSocket
  is native(gio)
  is export
{ * }

sub g_socket_receive (
  GSocket $socket,
  Str $buffer,
  gsize $size,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_receive_from (
  GSocket $socket,
  GSocketAddress $address,
  Str $buffer,
  gsize $size,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_receive_message (
  GSocket $socket,
  GSocketAddress $address,
  GInputVector $vectors,
  gint $num_vectors,
  GSocketControlMessage $messages,
  gint $num_messages,
  gint $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_receive_messages (
  GSocket $socket,
  Pointer $messages,              # GInputMessage * == Array
  guint $num_messages,
  gint $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gio)
  is export
{ * }

sub g_socket_receive_with_blocking (
  GSocket $socket,
  Str $buffer,
  gsize $size,
  gboolean $blocking,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_send (
  GSocket $socket,
  Str $buffer,
  gsize $size,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_send_message (
  GSocket $socket,
  GSocketAddress $address,
  GOutputVector $vectors,
  gint $num_vectors,
  GSocketControlMessage $messages,
  gint $num_messages,
  gint $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_send_message_with_timeout (
  GSocket $socket,
  GSocketAddress $address,
  GOutputVector $vectors,
  gint $num_vectors,
  GSocketControlMessage $messages,
  gint $num_messages,
  gint $flags,
  gint64 $timeout_us,
  gsize $bytes_written,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GPollableReturn
  is native(gio)
  is export
{ * }

sub g_socket_send_messages (
  GSocket $socket,
  Pointer $messages,                # GOutputMessage * == Array
  guint $num_messages,
  gint $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gio)
  is export
{ * }

sub g_socket_send_to (
  GSocket $socket,
  GSocketAddress $address,
  Str $buffer,
  gsize $size,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_send_with_blocking (
  GSocket $socket,
  Str $buffer,
  gsize $size,
  gboolean $blocking,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns gssize
  is native(gio)
  is export
{ * }

sub g_socket_set_option (
  GSocket $socket,
  gint $level,
  gint $optname,
  gint $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_shutdown (
  GSocket $socket,
  gboolean $shutdown_read,
  gboolean $shutdown_write,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_speaks_ipv4 (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_get_blocking (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_get_broadcast (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_get_keepalive (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_get_listen_backlog (GSocket $socket)
  returns gint
  is native(gio)
  is export
{ * }

sub g_socket_get_multicast_loopback (GSocket $socket)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_socket_get_multicast_ttl (GSocket $socket)
  returns guint
  is native(gio)
  is export
{ * }

sub g_socket_get_timeout (GSocket $socket)
  returns guint
  is native(gio)
  is export
{ * }

sub g_socket_get_ttl (GSocket $socket)
  returns guint
  is native(gio)
  is export
{ * }

sub g_socket_set_blocking (GSocket $socket, gboolean $blocking)
  is native(gio)
  is export
{ * }

sub g_socket_set_broadcast (GSocket $socket, gboolean $broadcast)
  is native(gio)
  is export
{ * }

sub g_socket_set_keepalive (GSocket $socket, gboolean $keepalive)
  is native(gio)
  is export
{ * }

sub g_socket_set_listen_backlog (GSocket $socket, gint $backlog)
  is native(gio)
  is export
{ * }

sub g_socket_set_multicast_loopback (GSocket $socket, gboolean $loopback)
  is native(gio)
  is export
{ * }

sub g_socket_set_multicast_ttl (GSocket $socket, guint $ttl)
  is native(gio)
  is export
{ * }

sub g_socket_set_timeout (GSocket $socket, guint $timeout)
  is native(gio)
  is export
{ * }

sub g_socket_set_ttl (GSocket $socket, guint $ttl)
  is native(gio)
  is export
{ * }
