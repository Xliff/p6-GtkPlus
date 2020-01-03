use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::UnixFDMessage;

sub g_unix_fd_message_append_fd (
  GUnixFDMessage $message,
  gint $fd,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_unix_fd_message_get_fd_list (GUnixFDMessage $message)
  returns GUnixFDList
  is native(gio)
  is export
{ * }

sub g_unix_fd_message_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_unix_fd_message_new ()
  returns GUnixFDMessage
  is native(gio)
  is export
{ * }

sub g_unix_fd_message_new_with_fd_list (GUnixFDList $fd_list)
  returns GUnixFDMessage
  is native(gio)
  is export
{ * }

sub g_unix_fd_message_steal_fds (GUnixFDMessage $message, gint $length)
  returns gint
  is native(gio)
  is export
{ * }
