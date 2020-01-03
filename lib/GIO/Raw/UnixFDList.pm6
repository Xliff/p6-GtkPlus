use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::UnixFDList;

sub g_unix_fd_list_append (
  GUnixFDList $list,
  gint $fd,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_get (
  GUnixFDList $list,
  gint $index_,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_get_length (GUnixFDList $list)
  returns gint
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_get_type ()
  returns GType
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_new ()
  returns GUnixFDList
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_new_from_array (CArray[gint] $fds, gint $n_fds)
  returns GUnixFDList
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_peek_fds (GUnixFDList $list, gint $length is rw)
  returns CArray[gint]
  is native(gtk)
  is export
{ * }

sub g_unix_fd_list_steal_fds (GUnixFDList $list, gint $length is rw)
  returns CArray[gint]
  is native(gtk)
  is export
{ * }
