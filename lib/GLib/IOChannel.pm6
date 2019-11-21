use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

use GLib::Raw::IOChannel;

use GTK::Compat::Source;

class GLib::IOChannel {
  has GIOChannel $!gio;

  submethod BUILD (:$io-channel) {
    $!gio = $io-channel;
  }

  method GTK::Compat::Types::GIOChannel
    is also<GIOChannel>
  { $!gio }

  multi method new (
    Int() $filedesc,
    :file-descriptor(:fle_descriptor(:$fd)) is required
  ) {
    self.new_fd($filedesc);
  }
  method new_fd (Int() $filedesc) is also<new-fd> {
    my gint $fd = $filedesc;
    my $io = $*DISTRO.is-win ??
      g_io_channel_win32_new_fd($filedesc)
      !!
      g_io_channel_unix_new($fd);

    $io ?? self.bless( io-channel => $io ) !! Nil;
  }

  multi method new (
    Str() $filename,
    Str() $mode,
    CArray[Pointer[GError]] $error = gerror,
    :$file is required
  ) {
    self.new_file($filename, $mode, $error);
  }
  method new_file (
    Str() $filename,
    Str() $mode,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-file>
  {
    clear_error;
    my $io = g_io_channel_new_file($filename, $mode, $error);
    set_error($error);
  }

  method win32_new_messages is also<win32-new-messages> {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_new_messages($!gio);
  }

  method win32_new_socket is also<win32-new-socket> {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_new_socket($!gio);
  }

  method buffer_size is rw is also<buffer-size> {
    Proxy.new(
      FETCH => sub ($) {
        g_io_channel_get_buffer_size($!gio);
      },
      STORE => sub ($, Int() $size is copy) {
        my gsize $s = $size;

        g_io_channel_set_buffer_size($!gio, $s);
      }
    );
  }

  method buffered is rw {
    Proxy.new(
      FETCH => sub ($) {
        so g_io_channel_get_buffered($!gio);
      },
      STORE => sub ($, Int() $buffered is copy) {
        my gboolean $b = (so $buffered).Int;

        g_io_channel_set_buffered($!gio, $b);
      }
    );
  }

  method close_on_unref is rw is also<close-on-unref> {
    Proxy.new(
      FETCH => sub ($) {
        so g_io_channel_get_close_on_unref($!gio);
      },
      STORE => sub ($, Int() $do_close is copy) {
        my gboolean $d = (so $do_close).Int;

        g_io_channel_set_close_on_unref($!gio, $d);
      }
    );
  }

  method flags is rw {
    Proxy.new:
      FETCH => -> $               { self.get_flags },
      STORE => -> $, Int() $flags { self.set_flags($flags) };
  }

  method line_term is rw is also<line-term> {
    Proxy.new:
      FETCH => -> $            { self.get_line_term( :!all ) },
      STORE => -> $, Str() $lt { self.set_line_term($lt, $lt.chars) };
  }

  method error_from_errno is also<error-from-errno> {
    GIOChannelErrorEnum( g_io_channel_error_from_errno($!gio) );
  }

  method error_quark ( GLib::IOChannel:U: )is also<error-quark> {
    g_io_channel_error_quark();
  }

  method flush (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = GIOStatusEnum( g_io_channel_flush($!gio, $error) );
    set_error($error);
    $rv;
  }

  method add_watch (
    Int() $condition,
    &func,
    gpointer $user_data = gpointer
  )
    is also<add-watch>
  {
    my guint $c = $condition,

    g_io_add_watch($!gio, $condition, &func, $user_data);
  }

  method add_watch_full (
    Int() $priority,
    Int() $condition,
    &func,
    gpointer $user_data    = gpointer,
    GDestroyNotify $notify = gpointer
  )
    is also<add-watch-full>
  {
    my gint  $p = $priority;
    my guint $c = $condition; # GIOCondition

    g_io_add_watch_full(
      $!gio,
      $p,
      $c,
      &func,
      $user_data,
      $notify
    );
  }

  method create_watch (Int() $condition, :$raw = False) is also<create-watch> {
    my GIOCondition $c = $condition;
    my $s = g_io_create_watch($!gio, $c);

    $s ??
      ( $raw ?? $s !! GTK::Compat::Source.new($s) )
      !!
      Nil;
  }

  method get_buffer_condition is also<get-buffer-condition> {
    GIOConditionEnum(
      g_io_channel_get_buffer_condition($!gio)
    );
  }

  method get_encoding is also<get-encoding> {
    g_io_channel_get_encoding($!gio);
  }

  method get_fd is also<get-fd> {
    $*DISTRO.is-win ??
      g_io_channel_win32_get_fd($!gio)
      !!
      g_io_channel_unix_get_fd($!gio)
  }

  method get_flags is also<get-flags> {
    GIOStatusEnum( g_io_channel_get_flags($!gio) );
  }

  proto method get_line_term (|)
      is also<get-line-term>
  { * }

  multi method get_line_term (:$all = True) {
    samewith($, :$all);
  }
  multi method get_line_term ($length is rw, :$all = False) {
    my gint $l = 0;
    my $rv = g_io_channel_get_line_term($!gio, $length);

    $length = $l;
    $all.not ?? $rv !! ($rv, $length);
  }

  method init (GLib::IOChannel:U: GIOChannel $io) {
    g_io_channel_init($io);
  }

  proto method read_chars (|)
      is also<read-chars>
  { * }

  multi method read_chars (
    Str() $buf,
    Int() $count,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($buf, $count, $, $error, :$all);
  }
  multi method read_chars (
    Str() $buf,
    Int() $count,
    $bytes_read is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize ($c, $br) = ($count, 0);

    clear_error;
    my $rv = GIOStatusEnum(
      g_io_channel_read_chars($!gio, $buf, $count, $bytes_read, $error)
    );
    set_error($error);
    $bytes_read = $br;
    $all.not ?? $rv !! ($rv, $bytes_read);
  }

  proto method read_line (|)
      is also<read-line>
  { * }

  multi method read_line (
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    samewith($, $, $, $error);
    set_error($error);
  }
  multi method read_line (
    $str_return     is rw,
    $length         is rw,
    $terminator_pos is rw,
    CArray[Pointer[GError]] $error = gerror,
  ) {
    my gsize ($l, $tp) = 0 xx 2;
    my $sa = CArray[Str].new;

    $sa[0] = Str;
    clear_error;
    my $rc = GIOStatus( g_io_channel_read_line($!gio, $sa, $l, $tp, $error) );
    set_error($error);

    ($str_return, $length, $terminator_pos) = ($sa[0], $l, $tp);
    ($rc, $str_return, $length, $terminator_pos);
  }

  proto method read_line_string (|)
      is also<read-line-string>
  { * }

  multi method read_line_string (
    GString() $buffer,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($buffer, $, $error);
  }
  multi method read_line_string (
    GString() $buffer,
    $terminator_pos is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $t = 0;

    clear_error;
    my $rc = GIOStatusEnum(
      g_io_channel_read_line_string($!gio, $buffer, $t, $error)
    );
    set_error($error);
    $terminator_pos = $t;
    $all.not ?? $rc !! ($rc, $terminator_pos);
  }

  proto method read_to_end (|)
      is also<read-to-end>
  { * }

  multi method read_to_end (
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($, $, $error, :$all);
  }
  multi method read_to_end (
    $str_return is rw,
    $length     is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $l = 0;
    my $sr = CArray[Str];
    $sr[0] = Str;

    clear_error;
    my $rc = GIOStatusEnum(
      g_io_channel_read_to_end($!gio, $sr, $l, $error)
    );
    set_error($error);
    ($str_return, $length) = ($sr[0], $l);
    $all.not ?? $rc !! ($rc, $str_return, $length);
  }

  proto method read_unichar (|)
      is also<read-unichar>
  { * }

  multi method read_unichar (
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($, $error, :$all);
  }
  multi method read_unichar (
    $thechar is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my guint $t = 0;

    clear_error;
    my $rc = GIOStatusEnum(
      g_io_channel_read_unichar($!gio, $t, $error)
    );
    set_error($error);
    $thechar = $t;
    $all.not ?? $rc !! ($rc, $thechar);
  }

  method ref {
    g_io_channel_ref($!gio);
    self;
  }

  method seek_position (
    Int() $offset,
    Int() $type,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<seek-position>
  {
    my gint64 $o = $offset;
    my GSeekType $t = $type,

    clear_error;
    my $rc = GIOStatus( g_io_channel_seek_position($!gio, $o, $t, $error) );
    set_error($error);
    $rc;
  }

  method set_encoding (
    Str() $encoding,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-encoding>
  {
    clear_error;
    my $rv = GIOStatusEnum(
      g_io_channel_set_encoding($!gio, $encoding, $error)
    );
    set_error($error);
    $rv;
  }

  method set_flags (
    Int() $flags,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-flags>
  {
    my GIOFlags $f = $flags;

    clear_error;
    my $rc = GIOStatusEnum( g_io_channel_set_flags($!gio, $flags, $error) );
    set_error($error);
    $rc;
  }

  method set_line_term (Str() $line_term, Int() $length)
    is also<set-line-term>
  {
    my gint $l = $length;

    g_io_channel_set_line_term($!gio, $line_term, $l);
  }

  method shutdown (
    Int() $flush,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gboolean $f = (so $flush).Int;

    clear_error;
    my $rc = GIOStatusEnum( g_io_channel_shutdown($!gio, $f, $error) );
    set_error($error);
    $rc;
  }

  method unref {
    g_io_channel_unref($!gio);
  }

  proto method win32_make_pollfd (|)
      is also<win32-make-pollfd>
  { * }

  multi method win32_make_pollfd (Int() $condition) {
    my $fd = GPollFD.new;

    samewith($condition, $fd);
  }
  multi method win32_make_pollfd (Int() $condition, GPollFD $fd) {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    my GIOCondition $c = $condition;

    g_io_channel_win32_make_pollfd($!gio, $condition, $fd);
    $fd
  }

  proto method win32_poll (|)
      is also<win32-poll>
  { * }

  multi method win32_poll (@fds, Int() $timeout) {
    die '@fds must only contain GPollFD objects!' unless @fds.all ~~ GPollFD;

    my $fds = GTK::Compat::Roles::TypedBuffer.new(@fds);

    samewith($fds.p, @fds.elems, $timeout);
  }
  multi method win32_poll (
    GLib::IOChannel:U:
    Pointer $fds,
    Int() $n_fds,
    Int() $timeout
  ) {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    my gint ($n, $t) = ($n_fds, $timeout);

    # Is there more to the return gint??
    g_io_channel_win32_poll($fds, $n, $t);
  }

  method win32_set_debug (gboolean $flag) is also<win32-set-debug> {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    my gboolean $f = $flag;

    g_io_channel_win32_set_debug($!gio, $f);
  }

  proto method write_chars (|)
      is also<write-chars>
  { * }

  multi method write_chars (
    Str() $buf,
    Int() $count,
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($buf, $count, $, $error, :$all);
  }
  multi method write_chars (
    Str() $buf,
    Int() $count,
    $bytes_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gssize $c = $count;
    my gsize $bw = 0;

    clear_error;
    my $rv = GIOStatusEnum(
      g_io_channel_write_chars($!gio, $buf, $count, $bw, $error)
    );
    set_error($error);
    $bytes_written = $bw;
    $all.not ?? $rv !! ($rv, $bytes_written)
  }

  method write_unichar (
    Int() $thechar,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<write-unichar>
  {
    my gunichar $t = $thechar;

    clear_error;
    GIOStatusEnum( g_io_channel_write_unichar($!gio, $t, $error) );
    set_error($error);
  }

}
