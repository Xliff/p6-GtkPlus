use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GIO::Raw::FileEnumerator;

sub g_file_enumerator_close (
  GFileEnumerator $enumerator,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_enumerator_close_async (
  GFileEnumerator $enumerator,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_file_enumerator_close_finish (
  GFileEnumerator $enumerator,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_enumerator_get_child (GFileEnumerator $enumerator, GFileInfo $info)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_file_enumerator_get_container (GFileEnumerator $enumerator)
  returns GFile
  is native(gio)
  is export
{ * }

sub g_file_enumerator_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_file_enumerator_has_pending (GFileEnumerator $enumerator)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_enumerator_is_closed (GFileEnumerator $enumerator)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_enumerator_iterate (
  GFileEnumerator $direnum,
  GFileInfo $out_info,
  GFile $out_child,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_file_enumerator_next_file (
  GFileEnumerator $enumerator,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
{ * }

sub g_file_enumerator_next_files_async (
  GFileEnumerator $enumerator,
  gint $num_files,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
{ * }

sub g_file_enumerator_next_files_finish (
  GFileEnumerator $enumerator,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GList
  is native(gio)
  is export
{ * }

sub g_file_enumerator_set_pending (
  GFileEnumerator $enumerator,
  gboolean $pending
)
  is native(gio)
  is export
{ * }
