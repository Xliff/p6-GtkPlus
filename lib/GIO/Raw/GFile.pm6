use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::GFile;

sub g_file_append_to (
  GFile $file,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_append_to_async (
  GFile $file,
  guint $flags,										# GFileCreateFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_append_to_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_copy (
  GFile $source,
  GFile $destination,
  guint $flags,										# GFileCopyFlags
  GCancellable $cancellable,
  &progress_callback (goffset, goffset, Pointer),		# GFileProgressCallback,
  gpointer $progress_callback_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_copy_async (
  GFile $source,
  GFile $destination,
  guint $flags,										# GFileCopyFlags
  gint $io_priority,
  GCancellable $cancellable,
  &progress_callback (goffset, goffset, Pointer),		# GFileProgressCallback,
  gpointer $progress_callback_data,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_copy_attributes (
  GFile $source,
  GFile $destination,
  guint $flags,										# GFileCopyFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_copy_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_create (
  GFile $file,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_create_async (
  GFile $file,
  guint $flags,										# GFileCreateFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_create_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_create_readwrite (
  GFile $file,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_create_readwrite_async (
  GFile $file,
  guint $flags,										# GFileCreateFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_create_readwrite_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_delete (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_delete_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_delete_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_dup (GFile $file)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_eject_mountable_with_operation (
  GFile $file,
  guint $flags,										# GMountUnmountFlags
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_eject_mountable_with_operation_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_enumerate_children (
  GFile $file,
  Str $attributes,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileEnumerator
  is native(gio)
  is export
  { * }

sub g_file_enumerate_children_async (
  GFile $file,
  Str $attributes,
  guint $flags,										# GFileQueryInfoFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_enumerate_children_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileEnumerator
  is native(gio)
  is export
  { * }

sub g_file_equal (GFile $file1, GFile $file2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_find_enclosing_mount (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GMount
  is native(gio)
  is export
  { * }

sub g_file_find_enclosing_mount_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_find_enclosing_mount_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GMount
  is native(gio)
  is export
  { * }

sub g_file_get_basename (GFile $file)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_get_child (GFile $file, Str $name)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_get_child_for_display_name (
  GFile $file,
  Str $display_name,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_get_parent (GFile $file)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_get_parse_name (GFile $file)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_get_path (GFile $file)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_get_relative_path (GFile $parent, GFile $descendant)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_file_get_uri (GFile $file)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_get_uri_scheme (GFile $file)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_has_parent (GFile $file, GFile $parent)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_has_prefix (GFile $file, GFile $prefix)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_has_uri_scheme (GFile $file, Str $uri_scheme)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_hash (GFile $file)
  returns guint
  is native(gio)
  is export
  { * }

sub g_file_is_native (GFile $file)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_load_bytes (
  GFile $file,
  GCancellable $cancellable,
  CArray[Str] $etag_out,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is native(gio)
  is export
  { * }

sub g_file_load_bytes_async (
  GFile $file,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_load_bytes_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Str] $etag_out,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is native(gio)
  is export
  { * }

sub g_file_load_contents (
  GFile $file,
  GCancellable $cancellable,
  CArray[Str] $contents,
  gsize $length is rw,
  CArray[Str] $etag_out,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_load_contents_async (
  GFile $file,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_load_contents_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Str] $contents,
  gsize $length is rw,
  CArray[Str] $etag_out,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_load_partial_contents_async (
  GFile $file,
  GCancellable $cancellable,
  &read_more_callback (Str, goffset, Pointer),	# GFileReadMoreCallback,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_load_partial_contents_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Str] $contents,
  gsize $length is rw,
  CArray[Str] $etag_out,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_directory (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_directory_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_make_directory_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_directory_with_parents (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_symbolic_link (
  GFile $file,
  Str $symlink_value,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_measure_disk_usage (
  GFile $file,
  guint $flags,										# GFileMeasureFlags
  GCancellable $cancellable,
  &progress (gboolean, guint64, guint64, guint64, Pointer),	# GFileMeasureProgressCallback,
  gpointer $progress_data,
  guint64 $disk_usage is rw,
  guint64 $num_dirs   is rw,
  guint64 $num_files  is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_measure_disk_usage_async (
  GFile $file,
  guint $flags,										# GFileMeasureFlags
  gint $io_priority,
  GCancellable $cancellable,
  &progress (gboolean, guint64, guint64, guint64, Pointer),	# GFileMeasureProgressCallback,
  gpointer $progress_data,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_measure_disk_usage_finish (
  GFile $file,
  GAsyncResult $result,
  guint64 $disk_usage is rw,
  guint64 $num_dirs   is rw,
  guint64 $num_files  is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_monitor (
  GFile $file,
  guint $flags,										# GFileMonitorFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileMonitor
  is native(gio)
  is export
  { * }

sub g_file_monitor_directory (
  GFile $file,
  guint $flags,										# GFileMonitorFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileMonitor
  is native(gio)
  is export
  { * }

sub g_file_monitor_file (
  GFile $file,
  guint $flags,										# GFileMonitorFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileMonitor
  is native(gio)
  is export
  { * }

sub g_file_mount_enclosing_volume (
  GFile $location,
  guint $flags,										# GMountMountFlags
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_mount_enclosing_volume_finish (
  GFile $location,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_mount_mountable (
  GFile $file,
  guint $flags,										# GMountMountFlags
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_mount_mountable_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_move (
  GFile $source,
  GFile $destination,
  guint $flags,										# GFileCopyFlags
  GCancellable $cancellable,
  &progress_callback (goffset, goffset, Pointer),		# GFileProgressCallback,
  gpointer $progress_callback_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_new_for_commandline_arg (Str $arg)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_for_commandline_arg_and_cwd (Str $arg, Str $cwd)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_for_path (Str $path)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_for_uri (Str $uri)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_tmp (
  Str $tmpl,
  GFileIOStream $iostream,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_open_readwrite (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_open_readwrite_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_open_readwrite_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_parse_name (Str $parse_name)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_peek_path (GFile $file)
  returns Str
  is native(gio)
  is export
  { * }

sub g_file_poll_mountable (
  GFile $file,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_poll_mountable_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_query_default_handler (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GAppInfo
  is native(gio)
  is export
  { * }

sub g_file_query_default_handler_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_query_default_handler_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns GAppInfo
  is native(gio)
  is export
  { * }

sub g_file_query_exists (GFile $file, GCancellable $cancellable)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_query_file_type (
  GFile $file,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable
)
  returns uint32 # GFileType
  is native(gio)
  is export
  { * }

sub g_file_query_filesystem_info (
  GFile $file,
  Str $attributes,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_filesystem_info_async (
  GFile $file,
  Str $attributes,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_query_filesystem_info_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_info (
  GFile $file,
  Str $attributes,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_info_async (
  GFile $file,
  Str $attributes,
  guint $flags,										# GFileQueryInfoFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_query_info_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_settable_attributes (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileAttributeInfoList
  is native(gio)
  is export
  { * }

sub g_file_query_writable_namespaces (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileAttributeInfoList
  is native(gio)
  is export
  { * }

sub g_file_read (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileInputStream
  is native(gio)
  is export
  { * }

sub g_file_read_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_read_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileInputStream
  is native(gio)
  is export
  { * }

sub g_file_replace (
  GFile $file,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_replace_async (
  GFile $file,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_replace_contents (
  GFile $file,
  Str $contents,
  gsize $length,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  CArray[Str] $new_etag,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_replace_contents_async (
  GFile $file,
  Str $contents,
  gsize $length,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_replace_contents_bytes_async (
  GFile $file,
  GBytes $contents,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_replace_contents_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Str] $new_etag,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_replace_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_replace_readwrite (
  GFile $file,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_replace_readwrite_async (
  GFile $file,
  Str $etag,
  gboolean $make_backup,
  guint $flags,										# GFileCreateFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_replace_readwrite_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_resolve_relative_path (GFile $file, Str $relative_path)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_set_attribute (
  GFile $file,
  Str $attribute,
  uint32 $type,
  gpointer $value_p,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_byte_string (
  GFile $file,
  Str $attribute,
  Str $value,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_int32 (
  GFile $file,
  Str $attribute,
  gint32 $value,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_int64 (
  GFile $file,
  Str $attribute,
  gint64 $value,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_string (
  GFile $file,
  Str $attribute,
  Str $value,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_uint32 (
  GFile $file,
  Str $attribute,
  guint32 $value,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_uint64 (
  GFile $file,
  Str $attribute,
  guint64 $value,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attributes_async (
  GFile $file,
  GFileInfo $info,
  guint $flags,										# GFileQueryInfoFlags
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_set_attributes_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GFileInfo]] $info,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attributes_from_info (
  GFile $file,
  GFileInfo $info,
  guint $flags,										# GFileQueryInfoFlags
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_display_name (
  GFile $file,
  Str $display_name,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_set_display_name_async (
  GFile $file,
  Str $display_name,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_set_display_name_finish (
  GFile $file,
  GAsyncResult $res,
  CArray[Pointer[GError]] $error
)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_start_mountable (
  GFile $file,
  guint $flags,										# GDriveStartFlags
  GMountOperation $start_operation,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_start_mountable_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_stop_mountable (
  GFile $file,
  guint $flags,										# GMountUnmountFlags
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_stop_mountable_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_supports_thread_contexts (GFile $file)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_trash (
  GFile $file,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_trash_async (
  GFile $file,
  gint $io_priority,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_trash_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_unmount_mountable_with_operation (
  GFile $file,
  guint $flags,										# GMountUnmountFlags
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, Pointer),		# GAsyncReadyCallback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_unmount_mountable_with_operation_finish (
  GFile $file,
  GAsyncResult $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
  { * }
