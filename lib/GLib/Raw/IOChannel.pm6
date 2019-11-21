use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::IOChannel;

sub g_io_channel_error_from_errno (gint $en)
  returns uint32 # GIOChannelError
  is native(glib)
  is export
{ * }

sub g_io_channel_error_quark ()
  returns GQuark
  is native(glib)
  is export
{ * }

sub g_io_channel_flush (
  GIOChannel $channel,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_add_watch (
  GIOChannel $channel,
  guint $condition, # GIOCondition $condition,
  &func (GIOChannel, guint, gpointer --> gboolean),
  gpointer $user_data
)
  returns guint
  is native(glib)
  is export
{ * }

sub g_io_add_watch_full (
  GIOChannel $channel,
  gint $priority,
  guint $condition, # GIOCondition $condition,
  &func (GIOChannel, guint, gpointer --> gboolean),
  gpointer $user_data,
  GDestroyNotify $notify
)
  returns guint
  is native(glib)
  is export
{ * }

sub g_io_create_watch (
  GIOChannel $channel,
  guint $condition # GIOCondition $condition
)
  returns GSource
  is native(glib)
  is export
{ * }

sub g_io_channel_get_buffer_condition (GIOChannel $channel)
  returns guint # GIOCondition
  is native(glib)
  is export
{ * }

sub g_io_channel_get_encoding (GIOChannel $channel)
  returns Str
  is native(glib)
  is export
{ * }

sub g_io_channel_get_flags (GIOChannel $channel)
  returns guint # GIOFlags
  is native(glib)
  is export
{ * }

sub g_io_channel_get_line_term (GIOChannel $channel, gint $length)
  returns Str
  is native(glib)
  is export
{ * }

sub g_io_channel_init (GIOChannel $channel)
  is native(glib)
  is export
{ * }

sub g_io_channel_new_file (
  Str $filename,
  Str $mode,
  CArray[Pointer[GError]] $error
)
  returns GIOChannel
  is native(glib)
  is export
{ * }

sub g_io_channel_read_chars (
  GIOChannel $channel,
  Str $buf,
  gsize $count,
  gsize $bytes_read,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_read_line (
  GIOChannel $channel,
  CArray[Str] $str_return,
  gsize $length,
  gsize $terminator_pos,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_read_line_string (
  GIOChannel $channel,
  GString $buffer,
  gsize $terminator_pos,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_read_to_end (
  GIOChannel $channel,
  Str $str_return,
  gsize $length,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_read_unichar (
  GIOChannel $channel,
  gunichar $thechar,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_ref (GIOChannel $channel)
  returns GIOChannel
  is native(glib)
  is export
{ * }

sub g_io_channel_seek_position (
  GIOChannel $channel,
  gint64 $offset,
  guint $type, # GSeekType $type,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_set_encoding (
  GIOChannel $channel,
  Str $encoding,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_set_flags (
  GIOChannel $channel,
  guint $flags,  # GIOFlags $flags,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_set_line_term (
  GIOChannel $channel,
  Str $line_term,
  gint $length
)
  is native(glib)
  is export
{ * }

sub g_io_channel_shutdown (
  GIOChannel $channel,
  gboolean $flush,
  CArray[Pointer[GError]] $err
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_unix_get_fd (GIOChannel $channel)
  returns gint
  is native(glib)
  is export
{ * }

sub g_io_channel_unix_new (gint $fd)
  returns GIOChannel
  is native(glib)
  is export
{ * }

sub g_io_channel_unref (GIOChannel $channel)
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_get_fd (GIOChannel $channel)
  returns gint
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_make_pollfd (
  GIOChannel $channel,
  guint $condition, # GIOCondition $condition,
  GPollFD $fd
)
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_new_fd (gint $fd)
  returns GIOChannel
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_new_messages (guint $hwnd)
  returns GIOChannel
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_new_socket (gint $socket)
  returns GIOChannel
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_poll (GPollFD $fds, gint $n_fds, gint $timeout_)
  returns gint
  is native(glib)
  is export
{ * }

sub g_io_channel_win32_set_debug (GIOChannel $channel, gboolean $flag)
  is native(glib)
  is export
{ * }

sub g_io_channel_write_chars (
  GIOChannel $channel,
  Str $buf,
  gssize $count,
  gsize $bytes_written,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_write_unichar (
  GIOChannel $channel,
  gunichar $thechar,
  CArray[Pointer[GError]] $error
)
  returns guint # GIOStatus
  is native(glib)
  is export
{ * }

sub g_io_channel_get_buffer_size (GIOChannel $channel)
  returns gsize
  is native(glib)
  is export
{ * }

sub g_io_channel_get_buffered (GIOChannel $channel)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_io_channel_get_close_on_unref (GIOChannel $channel)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_io_channel_set_buffer_size (GIOChannel $channel, gsize $size)
  is native(glib)
  is export
{ * }

sub g_io_channel_set_buffered (GIOChannel $channel, gboolean $buffered)
  is native(glib)
  is export
{ * }

sub g_io_channel_set_close_on_unref (GIOChannel $channel, gboolean $do_close)
  is native(glib)
  is export
{ * }
