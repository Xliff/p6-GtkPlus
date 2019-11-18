use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::Socket;

use GIO::SocketAddress;

use GTK::Compat::Roles::Object;
use GIO::Roles::Initable;
use GIO::Roles::DatagramBased;

class GIO::Socket {
  also does GTK::Compat::Roles::Object;
  also does GIO::Roles::Initable;
  also does GIO::Roles::DatagramBased;

  has GSocket $!s is implementor;

  submethod BUILD (:$socket) {
    $!s = $socket;

    # Needs ancestry logic!
    self.roleInit-Object;
    self.roleInit-Initable;
    self.roleInit-DatagramBased;
  }

  method GTK::Compat::Types::GSocket
    is also<GSocket>
  { $!s }

  multi method new (GSocket $socket) {
    self.bless( :$socket );
  }
  multi method new (
    Int() $family,
    Int() $type,
    Int() $protocol,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GSocketFamily $f = $family;
    my GSocketType $t = $type;
    my GSocketProtocol $p = $protocol;

    clear_error;
    my $socket = g_socket_new($f, $t, $p, $error);
    set_error($error);
    self.bless( :$socket );
  }

  method new_from_fd (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-fd>
  {
    clear_error;
    my $socket = g_socket_new_from_fd($!s, $error);
    set_error($error);
    self.bless( :$socket );
  }

  method blocking is rw {
    Proxy.new(
      FETCH => sub ($) {
        so g_socket_get_blocking($!s);
      },
      STORE => sub ($, Int() $blocking is copy) {
        my gboolean $b = $blocking;

        g_socket_set_blocking($!s, $b);
      }
    );
  }

  method broadcast is rw {
    Proxy.new(
      FETCH => sub ($) {
        so g_socket_get_broadcast($!s);
      },
      STORE => sub ($, Int() $broadcast is copy) {
        my gboolean $b = $broadcast;

        g_socket_set_broadcast($!s, $b);
      }
    );
  }

  method keepalive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so g_socket_get_keepalive($!s);
      },
      STORE => sub ($, Int() $keepalive is copy) {
        my gboolean $k = $keepalive;

        g_socket_set_keepalive($!s, $k);
      }
    );
  }

  method listen_backlog is rw is also<listen-backlog> {
    Proxy.new(
      FETCH => sub ($) {
        g_socket_get_listen_backlog($!s);
      },
      STORE => sub ($, Int() $backlog is copy) {
        my gint $b = $backlog;

        g_socket_set_listen_backlog($!s, $b);
      }
    );
  }

  method multicast_loopback is rw is also<multicast-loopback> {
    Proxy.new(
      FETCH => sub ($) {
        so g_socket_get_multicast_loopback($!s);
      },
      STORE => sub ($, Int() $loopback is copy) {
        my gboolean $l = $loopback;

        g_socket_set_multicast_loopback($!s, $l);
      }
    );
  }

  method multicast_ttl is rw is also<multicast-ttl> {
    Proxy.new(
      FETCH => sub ($) {
        g_socket_get_multicast_ttl($!s);
      },
      STORE => sub ($, Int() $ttl is copy) {
        my guint $t = $ttl;

        g_socket_set_multicast_ttl($!s, $t);
      }
    );
  }

  method timeout is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_socket_get_timeout($!s);
      },
      STORE => sub ($, Int() $timeout is copy) {
        my guint $t = $timeout;

        g_socket_set_timeout($!s, $t);
      }
    );
  }

  method ttl is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_socket_get_ttl($!s);
      },
      STORE => sub ($, Int() $ttl is copy) {
        my guint $t = $ttl;

        g_socket_set_ttl($!s, $t);
      }
    );
  }

  method accept (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  ) {
    clear_error;
    my $s = g_socket_accept($!s, $cancellable, $error);
    set_error($error);
    $raw ?? $s !! GIO::Socket.new($s);
  }

  method bind (
    GSocketAddress $address,
    Int() $allow_reuse,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gboolean $ar = $allow_reuse;
    clear_error;
    my $rv = so g_socket_bind($!s, $address, $ar, $error);
    set_error($error);
    $rv;
  }

  method check_connect_result (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<check-connect-result>
  {
    clear_error;
    my $rv = so g_socket_check_connect_result($!s, $error);
    set_error($error);
    $rv;
  }

  method close (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = g_socket_close($!s, $error);
    set_error($error);
    $rv;
  }

  method condition_check (Int() $condition) is also<condition-check> {
    my GIOCondition $c = $condition;

    GIOConditionEnum( g_socket_condition_check($!s, $c) );
  }

  method condition_timed_wait (
    GIOCondition $condition,
    gint64 $timeout_us,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<condition-timed-wait>
  {
    my GIOCondition $c = $condition;
    my gint64 $to-μs = $timeout_us;

    clear_error;
    my $rv =
     so g_socket_condition_timed_wait($!s, $c, $to-μs, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method condition_wait (
    Int() $condition,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<condition-wait>
  {
    my GIOCondition $c = $condition;

    clear_error;
    my $rv = g_socket_condition_wait($!s, $c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method connect (
    GSocketAddress() $address,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_socket_connect($!s, $address, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method create_source (
    Int() $condition,
    GCancellable $cancellable
  )
    is also<create-source>
  {
    my GIOCondition $c = $condition;

    g_socket_create_source($!s, $c, $cancellable);
  }

  method get_available_bytes
    is also<
      get-available-bytes
      available_bytes
      available-bytes
    >
  {
    g_socket_get_available_bytes($!s);
  }

  method credentials {
    self.get_credentials;
  }

  method get_credentials (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-credentials>
  {
    clear_error;
    g_socket_get_credentials($!s, $error);
    set_error($error);
  }

  method get_family
    is also<
      get-family
      family
    >
  {
    GSocketFamilyEnum( g_socket_get_family($!s) );
  }

  method get_fd
    is also<
      get-fd
      fd
    >
  {
    g_socket_get_fd($!s);
  }

  method get_local_address (
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False;
  )
    is also<get-local-address>
  {
    clear_error;
    my $la = g_socket_get_local_address($!s, $error);
    set_error($error);

    $raw ?? $la !! GIO::SocketAddress.new($la);
  }

  method get_option (
    Int() $level,
    Int() $optname,
    Int() $value,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-option>
  {
    my gint ($l, $o, $v) = ($level, $optname, $value);

    clear_error;
    my $rv = so g_socket_get_option($!s, $l, $o, $v, $error);
    set_error($error);
    $rv;
  }

  method get_protocol
    is also<
      get-protocol
      protocol
    >
  {
    GSocketProtocolEnum( g_socket_get_protocol($!s) );
  }

  method remote_address (:$raw = False) is also<remote-address> {
    self.get_remote_address(:$raw);
  }

  method get_remote_address (
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
  )
    is also<get-remote-address>
  {
    clear_error;
    my $rv = g_socket_get_remote_address($!s, $error);
    set_error($error);
    $raw ?? $rv !! GIO::SocketAddress($rv);
  }

  method get_socket_type
    is also<
      get-socket-type
      socket_type
      socket-type
    >
  {
    GSocketTypeEnum( g_socket_get_socket_type($!s) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_socket_get_type, $n, $t );
  }

  method is_closed is also<is-closed> {
    so g_socket_is_closed($!s);
  }

  method is_connected is also<is-connected> {
    so g_socket_is_connected($!s);
  }

  method join_multicast_group (
    GInetAddress() $group,
    Int() $source_specific,
    Str() $iface,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<join-multicast-group>
  {
    my gboolean $ss = $source_specific;

    clear_error;
    my $rc = so g_socket_join_multicast_group($!s, $group, $ss, $iface, $error);
    set_error($error);
    $rc;
  }

  method join_multicast_group_ssm (
    GInetAddress() $group,
    GInetAddress() $source_specific,
    Str() $iface,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<join-multicast-group-ssm>
  {
    clear_error;
    my $rv = so g_socket_join_multicast_group_ssm(
      $!s,
      $group,
      $source_specific,
      $iface,
      $error
    );
    set_error($error);
    $rv;
  }

  method leave_multicast_group (
    GInetAddress() $group,
    Int() $source_specific,
    Str() $iface,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<leave-multicast-group>
  {
    my gboolean $ss = $source_specific;

    clear_error;
    my $rv =
      so g_socket_leave_multicast_group($!s, $group, $ss, $iface, $error);
    set_error($error);
    $rv;
  }

  method leave_multicast_group_ssm (
    GInetAddress() $group,
    GInetAddress() $source_specific,
    Str() $iface,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<leave-multicast-group-ssm>
  {
    clear_error;
    my $rv = g_socket_leave_multicast_group_ssm(
      $!s,
      $group,
      $source_specific,
      $iface,
      $error
    );
    set_error($error);
    $rv;
  }

  method listen (
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so g_socket_listen($!s, $error);
    set_error($error);
    $rv;
  }

  method receive (
    Str() $buffer,
    Int() $size,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $s = $size;

    clear_error;
    my $rv = g_socket_receive($!s, $buffer, $s, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method receive_from (
    GSocketAddress() $address,
    Str() $buffer,
    Int() $size,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<receive-from>
  {
    my gsize $s = $size;

    clear_error;
    my $rv = g_socket_receive_from(
      $!s,
      $address,
      $buffer,
      $s,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method receive_message (
    GSocketAddress() $address,
    GInputVector $vectors,
    Int() $num_vectors,
    CArray[Pointer[Pointer[GSocketControlMessage]]] $messages,
    $num_messages is rw,
    $flags is rw,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  )
    is also<receive-message>
  {
    my gint ($nv, $nm, $f) = ($num_vectors, 0, $flags);

    clear_error;
    my $rv = g_socket_receive_message(
      $!s,
      $address,
      $vectors,
      $nv,
      $messages,
      $nm,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $num_messages = $messages;
    $all ?? $rv !! ($rv, $messages);
  }

  method receive_messages (
    Pointer $messages,        # GInputMessage() $messages,
    Int() $num_messages,
    Int() $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<receive-messages>
  {
    my guint $nm = $num_messages;
    my gint $f = $flags;

    clear_error;
    my $rv = so g_socket_receive_messages(
      $!s,
      $messages,
      $nm,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method receive_with_blocking (
    Str() $buffer,
    Int() $size,
    Int() $blocking,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<receive-with-blocking>
  {
    my gsize $s = $size;
    my gboolean $b = $blocking;

    clear_error;
    my $rv = so g_socket_receive_with_blocking(
      $!s,
      $buffer,
      $s,
      $b,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method send (
    Str() $buffer,
    Int() $size,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $s = $size;

    clear_error;
    my $rv = g_socket_send($!s, $buffer, $s, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method send_message (
    GSocketAddress() $address,
    GOutputVector $vectors,
    Int() $num_vectors,
    CArray[Pointer[GSocketControlMessage]] $messages,
    Int() $num_messages,
    Int() $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-message>
  {
    my gint ($nv, $nm, $f) = ($num_vectors, $num_messages, $flags);

    clear_error;
    my $rv = g_socket_send_message(
      $!s,
      $address,
      $vectors,
      $nv,
      $messages,
      $nm,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method send_message_with_timeout (
    GSocketAddress() $address,
    GOutputVector $vectors,
    Int() $num_vectors,
    CArray[Pointer[GSocketControlMessage]] $messages,
    Int() $num_messages,
    Int() $flags,
    Int() $timeout_us,
    Int() $bytes_written,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-message-with-timeout>
  {
    my gint ($nv, $nm, $f) = ($num_vectors, $num_messages, $flags);
    my gint64 $to-μs = $timeout_us;
    my gsize $bw = $bytes_written;

    clear_error;
    my $rv = g_socket_send_message_with_timeout(
      $!s,
      $address,
      $vectors,
      $nv,
      $messages,
      $nm,
      $f,
      $to-μs,
      $bw,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method send_messages (
    Pointer $messages,
    Int() $num_messages,
    Int() $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-messages>
  {
    my guint $nm = $num_messages;
    my gint $f = $flags;

    clear_error;
    my $rv =
      g_socket_send_messages($!s, $messages, $nm, $f, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method send_to (
    GSocketAddress() $address,
    Str() $buffer,
    Int() $size,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-to>
  {
    my gsize $s = $size;

    clear_error;
    my $rv = g_socket_send_to($!s, $address, $buffer, $s, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method send_with_blocking (
    Str() $buffer,
    Int() $size,
    Int() $blocking,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<send-with-blocking>
  {
    my gsize    $s = $size;
    my gboolean $b = $blocking;

    clear_error;
    my $rv =
      g_socket_send_with_blocking($!s, $buffer, $s, $b, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method set_option (
    Int() $level,
    Int() $optname,
    Int() $value,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-option>
  {
    my gint ($l, $o, $v) = ($level, $optname, $value);

    clear_error;
    my $rv = so g_socket_set_option($!s, $l, $o, $v, $error);
    set_error($error);
    $rv;
  }

  method shutdown (
    Int() $shutdown_read,
    Int() $shutdown_write,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gboolean $sr = $shutdown_read;
    my gboolean $sw = $shutdown_write;

    clear_error;
    my $rv = so g_socket_shutdown($!s, $sr, $sw, $error);
    set_error($error);
    $rv;
  }

  method speaks_ipv4 is also<speaks-ipv4> {
    so g_socket_speaks_ipv4($!s);
  }

}
