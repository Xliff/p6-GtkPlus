use v6.c;

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
  method new_fd (Int() $filedesc) {
    my gint $fd = $filedesc;
    my $io = $*DISTRO.is-win ??
      g_io_channel_win32_new_fd($filedesc)
      !!
      g_io_channel_unix_new($fd)

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
  ) {
    clear_error;
    my $io = g_io_channel_new_file($filename, $mode, $error);
    set_error($error);
  }

  method win32_new_messages {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_new_messages($!gio);
  }

  method win32_new_socket {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_new_socket($!gio);
  }

  method buffer_size is rw {
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

  method close_on_unref is rw {
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

  method line_term is rw {
    Proxy.new:
      FETCH => -> $            { self.get_line_term( :!all ) },
      STORE => -> $, Str() $lt { self.set_line_term($lt, $lt.chars) };
  }

  method error_from_errno {
    GIOChannelErrorEnum( g_io_channel_error_from_errno($!gio) );
  }

  method error_quark ( GLib::IOChannel:U: ){
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
  ) {
    my guint $c = $condition,

    g_io_add_watch($!gio, $condition, &func, $user_data);
  }

  method add_watch_full (
    Int() $priority,
    Int() $condition,
    &func,
    gpointer $user_data    = gpointer,
    GDestroyNotify $notify = gpointer
  ) {
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

  method create_watch (Int() $condition, :$raw = False) {
    my GIOCondition $c = $condition;
    my $s = g_io_create_watch($!gio, $c);

    $s ??
      ( $raw ?? $s !! GTK::Compat::Source.new($s) )
      !!
      Nil;
  }

  method get_buffer_condition {
    GIOConditionEnum(
      g_io_channel_get_buffer_condition($!gio)
    );
  }

  method get_encoding {
    g_io_channel_get_encoding($!gio);
  }

  method get_fd {
    $*DISTRO.is-win ??
      g_io_channel_win32_get_fd($!gio)
      !!
      g_io_channel_unix_get_fd($!gio)
  }

  method get_flags {
    GIOStatusEnum( g_io_channel_get_flags($!gio) );
  }

  proto method get_line_term (|)
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
      g_io_channel_read_chars($!gio, $buf, $count, $bytes_read, $error
    );
    set_error($error);
    $bytes_read = $br;
    $all.not ?? $rv !! ($rv, $bytes_read);
  }

  proto method read_line (|)
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
  { * }

  multi method read_to_end (
    CArray[Pointer[GError]] $error = gerror,
    :$all = True
  ) {
    samewith($, $, $error, :$all);
  }
  method read_to_end (
    $str_return is rw,
    $length is rw,
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
    ($str_return, $length) = ($str[0], $l);
    $all.not ?? $rc !! ($rc, $str_return, $length);
  }

  proto method read_unichar (|)
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
    $the_char = $t;
    $all.not ?? $rc !! ($rc, $the_char);
  }

  method ref {
    g_io_channel_ref($!gio);
  }

  method seek_position (
    Int() $offset,
    Int() $type,
    CArray[Pointer[GError]] $error = gerror
  ) {
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
  ) {
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
  ) {
    my GIOFlags $f = $flags;

    clear_error;
    my $rc = GIOStatusEnum( g_io_channel_set_flags($!gio, $flags, $error) );
    set_error($error);
    $rc;
  }

  method set_line_term (Str() $line_term, Int() $length) {
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

  method win32_make_pollfd (GIOCondition $condition, GPollFD $fd) {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_make_pollfd($!gio, $condition, $fd);
  }

  method win32_poll (GPollFDNonWin $fds, gint $n_fds, gint $timeout) {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_poll($fds, $n_fds, $timeout=);
  }

  method win32_set_debug (gboolean $flag) {
    die 'This call only allowed on windows' unless $*DISTRO.is-win;

    g_io_channel_win32_set_debug($!gio, $flag);
  }

  method write_chars (
    Str $buf,
    gssize $count,
    gsize $bytes_written,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_write_chars($!gio, $buf, $count, $bytes_written, $error);
  }

  method write_unichar (
    gunichar $thechar,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_write_unichar($!gio, $thechar, $error);
  }

}
