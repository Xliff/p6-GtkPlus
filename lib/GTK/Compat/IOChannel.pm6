use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::IOChannel;

class GTK::Compat::IOChannel {
  has GIOChannel $!gio;
  
  method buffer_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_io_channel_get_buffer_size($!gio);
      },
      STORE => sub ($, $size is copy) {
        g_io_channel_set_buffer_size($!gio, $size);
      }
    );
  }

  method buffered is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_io_channel_get_buffered($!gio);
      },
      STORE => sub ($, $buffered is copy) {
        g_io_channel_set_buffered($!gio, $buffered);
      }
    );
  }

  method close_on_unref is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_io_channel_get_close_on_unref($!gio);
      },
      STORE => sub ($, $do_close is copy) {
        g_io_channel_set_close_on_unref($!gio, $do_close);
      }
    );
  }
  
  method error_from_errno {
    g_io_channel_error_from_errno($!gio);
  }

  method error_quark {
    g_io_channel_error_quark();
  }

  method flush (CArray[Pointer[GError]] $error) {
    g_io_channel_flush($!gio, $error);
  }

  method g_io_add_watch (
    GIOCondition $condition, 
    GIOFunc $func, 
    gpointer $user_data = gpointer
  ) {
    g_io_add_watch($!gio, $condition, $func, $user_data);
  }

  method g_io_add_watch_full (
    gint $priority, 
    GIOCondition $condition, 
    GIOFunc $func, 
    gpointer $user_data    = gpointer, 
    GDestroyNotify $notify = gpointer
  ) {
    g_io_add_watch_full(
      $!gio, 
      $priority, 
      $condition, 
      $func, 
      $user_data, 
      $notify
    );
  }

  method g_io_create_watch (GIOCondition $condition) {
    g_io_create_watch($!gio, $condition);
  }

  method get_buffer_condition {
    g_io_channel_get_buffer_condition($!gio);
  }

  method get_encoding {
    g_io_channel_get_encoding($!gio);
  }

  method get_flags {
    g_io_channel_get_flags($!gio);
  }

  method get_line_term (gint $length) {
    g_io_channel_get_line_term($!gio, $length);
  }

  method init {
    g_io_channel_init($!gio);
  }

  method new_file (
    Str() $filename,
    Str() $mode, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_new_file($filename, $mode, $error);
  }

  method read_chars (
    Str $buf, 
    gsize $count, 
    gsize $bytes_read, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_read_chars($!gio, $buf, $count, $bytes_read, $error);
  }

  method read_line (
    Str $str_return, 
    gsize $length, 
    gsize $terminator_pos, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_read_line(
      $!gio, 
      $str_return, 
      $length, 
      $terminator_pos, 
      $error
    );
  }

  method read_line_string (
    GString $buffer, 
    gsize $terminator_pos, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_read_line_string($!gio, $buffer, $terminator_pos, $error);
  }

  method read_to_end (
    Str $str_return, 
    gsize $length, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_read_to_end($!gio, $str_return, $length, $error);
  }

  method read_unichar (
    gunichar $thechar, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_read_unichar($!gio, $thechar, $error);
  }

  method ref {
    g_io_channel_ref($!gio);
  }

  method seek_position (
    gint64 $offset, 
    GSeekType $type, 
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_io_channel_seek_position($!gio, $offset, $type, $error);
  }

  method set_encoding (Str $encoding, CArray[Pointer[GError]] $error) {
    g_io_channel_set_encoding($!gio, $encoding, $error);
  }

  method set_flags (GIOFlags $flags, CArray[Pointer[GError]] $error) {
    g_io_channel_set_flags($!gio, $flags, $error);
  }

  method set_line_term (Str $line_term, gint $length) {
    g_io_channel_set_line_term($!gio, $line_term, $length);
  }

  method shutdown (
    gboolean $flush, 
    CArray[Pointer[GError]] $err = gerror
  ) {
    g_io_channel_shutdown($!gio, $flush, $err);
  }

  method unix_get_fd {
    g_io_channel_unix_get_fd($!gio);
  }

  method unix_new(Int() $filedesc) {
    my gint $fd = resolve-int($filedesc);
    g_io_channel_unix_new($fd);
  }

  method unref {
    g_io_channel_unref($!gio);
  }

  method win32_get_fd {
    g_io_channel_win32_get_fd($!gio);
  }

  method win32_make_pollfd (GIOCondition $condition, GPollFD $fd) {
    g_io_channel_win32_make_pollfd($!gio, $condition, $fd);
  }

  method win32_new_fd {
    g_io_channel_win32_new_fd($!gio);
  }

  method win32_new_messages {
    g_io_channel_win32_new_messages($!gio);
  }

  method win32_new_socket {
    g_io_channel_win32_new_socket($!gio);
  }

  method win32_poll (GPollFDNonWin $fds, gint $n_fds, gint $timeout_) {
    g_io_channel_win32_poll($fds, $n_fds, $timeout_);
  }

  method win32_set_debug (gboolean $flag) {
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
