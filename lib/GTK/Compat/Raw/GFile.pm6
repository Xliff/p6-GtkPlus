use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::GFile;

sub g_file_append_to (
  GFile $file,
  GFileCreateFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_append_to_async (
  GFile $file,
  GFileCreateFlags $flags,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
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
  GFileCopyFlags $flags,
  GCancellable $cancellable,
  GFileProgressCallback $progress_callback,
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
  GFileCopyFlags $flags,
  gint $io_priority,
  GCancellable $cancellable,
  GFileProgressCallback $progress_callback,
  gpointer $progress_callback_data,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_copy_attributes (
  GFile $source,
  GFile $destination,
  GFileCopyFlags $flags,
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
  GFileCreateFlags $flags,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_create_async (
  GFile $file,
  GFileCreateFlags $flags,
  gint $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gio)
  is export
  { * }

sub g_file_create_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_create_readwrite (GFile $file, GFileCreateFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_create_readwrite_async (GFile $file, GFileCreateFlags $flags, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_create_readwrite_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_delete (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_delete_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_delete_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_dup (GFile $file)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_eject_mountable_with_operation (GFile $file, GMountUnmountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_eject_mountable_with_operation_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_enumerate_children (GFile $file, char $attributes, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileEnumerator
  is native(gio)
  is export
  { * }

sub g_file_enumerate_children_async (GFile $file, char $attributes, GFileQueryInfoFlags $flags, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_enumerate_children_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileEnumerator
  is native(gio)
  is export
  { * }

sub g_file_equal (GFile $file1, GFile $file2)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_find_enclosing_mount (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GMount
  is native(gio)
  is export
  { * }

sub g_file_find_enclosing_mount_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_find_enclosing_mount_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GMount
  is native(gio)
  is export
  { * }

sub g_file_get_basename (GFile $file)
  returns char
  is native(gio)
  is export
  { * }

sub g_file_get_child (GFile $file, char $name)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_get_child_for_display_name (GFile $file, char $display_name, CArray[Pointer[GError]] $error)
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
  returns char
  is native(gio)
  is export
  { * }

sub g_file_get_path (GFile $file)
  returns char
  is native(gio)
  is export
  { * }

sub g_file_get_relative_path (GFile $parent, GFile $descendant)
  returns char
  is native(gio)
  is export
  { * }

sub g_file_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_file_get_uri (GFile $file)
  returns char
  is native(gio)
  is export
  { * }

sub g_file_get_uri_scheme (GFile $file)
  returns char
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

sub g_file_has_uri_scheme (GFile $file, char $uri_scheme)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_hash (gconstpointer $file)
  returns guint
  is native(gio)
  is export
  { * }

sub g_file_is_native (GFile $file)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_load_bytes (GFile $file, GCancellable $cancellable, gchar $etag_out, CArray[Pointer[GError]] $error)
  returns GBytes
  is native(gio)
  is export
  { * }

sub g_file_load_bytes_async (GFile $file, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_load_bytes_finish (GFile $file, GAsyncResult $result, gchar $etag_out, CArray[Pointer[GError]] $error)
  returns GBytes
  is native(gio)
  is export
  { * }

sub g_file_load_contents (GFile $file, GCancellable $cancellable, char $contents, gsize $length, char $etag_out, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_load_contents_async (GFile $file, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_load_contents_finish (GFile $file, GAsyncResult $res, char $contents, gsize $length, char $etag_out, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_load_partial_contents_async (GFile $file, GCancellable $cancellable, GFileReadMoreCallback $read_more_callback, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_load_partial_contents_finish (GFile $file, GAsyncResult $res, char $contents, gsize $length, char $etag_out, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_directory (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_directory_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_make_directory_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_directory_with_parents (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_make_symbolic_link (GFile $file, char $symlink_value, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_measure_disk_usage (GFile $file, GFileMeasureFlags $flags, GCancellable $cancellable, GFileMeasureProgressCallback $progress_callback, gpointer $progress_data, guint64 $disk_usage, guint64 $num_dirs, guint64 $num_files, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_measure_disk_usage_async (GFile $file, GFileMeasureFlags $flags, ggint $io_priority, GCancellable $cancellable, GFileMeasureProgressCallback $progress_callback, gpointer $progress_data, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_measure_disk_usage_finish (GFile $file, GAsyncResult $result, guint64 $disk_usage, guint64 $num_dirs, guint64 $num_files, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_monitor (GFile $file, GFileMonitorFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileMonitor
  is native(gio)
  is export
  { * }

sub g_file_monitor_directory (GFile $file, GFileMonitorFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileMonitor
  is native(gio)
  is export
  { * }

sub g_file_monitor_file (GFile $file, GFileMonitorFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileMonitor
  is native(gio)
  is export
  { * }

sub g_file_mount_enclosing_volume (GFile $location, GMountMountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_mount_enclosing_volume_finish (GFile $location, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_mount_mountable (GFile $file, GMountMountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_mount_mountable_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_move (GFile $source, GFile $destination, GFileCopyFlags $flags, GCancellable $cancellable, GFileProgressCallback $progress_callback, gpointer $progress_callback_data, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_new_for_commandline_arg (char $arg)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_for_commandline_arg_and_cwd (gchar $arg, gchar $cwd)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_for_path (char $path)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_for_uri (char $uri)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_new_tmp (char $tmpl, GFileIOStream $iostream, CArray[Pointer[GError]] $error)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_open_readwrite (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_open_readwrite_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_open_readwrite_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_parse_name (char $parse_name)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_peek_path (GFile $file)
  returns char
  is native(gio)
  is export
  { * }

sub g_file_poll_mountable (GFile $file, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_poll_mountable_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_query_default_handler (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GAppInfo
  is native(gio)
  is export
  { * }

sub g_file_query_default_handler_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_query_default_handler_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns GAppInfo
  is native(gio)
  is export
  { * }

sub g_file_query_exists (GFile $file, GCancellable $cancellable)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_query_file_type (GFile $file, GFileQueryInfoFlags $flags, GCancellable $cancellable)
  returns GFileType
  is native(gio)
  is export
  { * }

sub g_file_query_filesystem_info (GFile $file, char $attributes, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_filesystem_info_async (GFile $file, char $attributes, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_query_filesystem_info_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_info (GFile $file, char $attributes, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_info_async (GFile $file, char $attributes, GFileQueryInfoFlags $flags, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_query_info_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileInfo
  is native(gio)
  is export
  { * }

sub g_file_query_settable_attributes (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileAttributeInfoList
  is native(gio)
  is export
  { * }

sub g_file_query_writable_namespaces (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileAttributeInfoList
  is native(gio)
  is export
  { * }

sub g_file_read (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileInputStream
  is native(gio)
  is export
  { * }

sub g_file_read_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_read_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileInputStream
  is native(gio)
  is export
  { * }

sub g_file_replace (GFile $file, char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_replace_async (GFile $file, char $etag, gboolean $make_backup, GFileCreateFlags $flags, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_replace_contents (GFile $file, char $contents, gsize $length, char $etag, gboolean $make_backup, GFileCreateFlags $flags, char $new_etag, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_replace_contents_async (GFile $file, char $contents, gsize $length, char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_replace_contents_bytes_async (GFile $file, GBytes $contents, char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_replace_contents_finish (GFile $file, GAsyncResult $res, char $new_etag, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_replace_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileOutputStream
  is native(gio)
  is export
  { * }

sub g_file_replace_readwrite (GFile $file, char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_replace_readwrite_async (GFile $file, char $etag, gboolean $make_backup, GFileCreateFlags $flags, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_replace_readwrite_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFileIOStream
  is native(gio)
  is export
  { * }

sub g_file_resolve_relative_path (GFile $file, char $relative_path)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_set_attribute (GFile $file, char $attribute, GFileAttributeType $type, gpointer $value_p, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_byte_string (GFile $file, char $attribute, char $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_int32 (GFile $file, char $attribute, gint32 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_int64 (GFile $file, char $attribute, gint64 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_string (GFile $file, char $attribute, char $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_uint32 (GFile $file, char $attribute, guint32 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attribute_uint64 (GFile $file, char $attribute, guint64 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attributes_async (GFile $file, GFileInfo $info, GFileQueryInfoFlags $flags, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_set_attributes_finish (GFile $file, GAsyncResult $result, GFileInfo $info, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_attributes_from_info (GFile $file, GFileInfo $info, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_set_display_name (GFile $file, char $display_name, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_set_display_name_async (GFile $file, char $display_name, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_set_display_name_finish (GFile $file, GAsyncResult $res, CArray[Pointer[GError]] $error)
  returns GFile
  is native(gio)
  is export
  { * }

sub g_file_start_mountable (GFile $file, GDriveStartFlags $flags, GMountOperation $start_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_start_mountable_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_stop_mountable (GFile $file, GMountUnmountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_stop_mountable_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_supports_thread_contexts (GFile $file)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_trash (GFile $file, GCancellable $cancellable, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_trash_async (GFile $file, gint $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_trash_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_file_unmount_mountable_with_operation (GFile $file, GMountUnmountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data)
  is native(gio)
  is export
  { * }

sub g_file_unmount_mountable_with_operation_finish (GFile $file, GAsyncResult $result, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gio)
  is export
  { * }
