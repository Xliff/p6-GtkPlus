use v6.c;

# ******** DO NOT USE THIS FILE ********

# NOTE!! -- THIS FILE IS NOT YET PART OF GTK-PLUS. THIS IS A PLACEHOLDER
#           FOR A *POTENTIAL* ADDITION.

unit class GFile is repr('CPointer') is export;

method append_to (
  GFileCreateFlags $flags,
  GCancellable $cancellable,
  GError $error
) {
  g_file_append_to(self, $flags, $cancellable, $error);
}

method append_to_async (
  GFileCreateFlags $flags,
  int $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_append_to_async(
    self, $flags, $io_priority, $cancellable, $callback, $user_data
  );
}

method append_to_finish (
  GAsyncResult $res,
  GError $error
) {
  g_file_append_to_finish(self, $res, $error);
}

method copy (
  GFile $destination,
  GFileCopyFlags $flags,
  GCancellable $cancellable,
  GFileProgressCallback $progress_callback,
  gpointer $progress_callback_data,
  GError $error
) {
  g_file_copy(
    self,
    $destination,
    $flags,
    $cancellable,
    $progress_callback,
    $progress_callback_data,
    $error
  );
}

method copy_async (
  GFile $destination,
  GFileCopyFlags $flags,
  int $io_priority,
  GCancellable $cancellable,
  GFileProgressCallback $progress_callback,
  gpointer $progress_callback_data,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_copy_async(
    self,
    $destination,
    $flags,
    $io_priority,
    $cancellable,
    $progress_callback,
    $progress_callback_data,
    $callback,
    $user_data
  );
}

method copy_attributes (
  GFile $destination,
  GFileCopyFlags $flags,
  GCancellable $cancellable,
  GError $error
) {
  g_file_copy_attributes(
    self, $destination, $flags, $cancellable, $error
  );
}

method copy_finish (GAsyncResult $res, GError $error) {
  g_file_copy_finish(self, $res, $error);
}

method create (
  GFileCreateFlags $flags,
  GCancellable $cancellable,
  GError $error
) {
  g_file_create(self, $flags, $cancellable, $error);
}

method create_async (
  GFileCreateFlags $flags,
  int $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_create_async(
    self, $flags, $io_priority, $cancellable, $callback, $user_data
  );
}

method create_finish (GAsyncResult $res, GError $error) {
  g_file_create_finish(self, $res, $error);
}

method create_readwrite (
  GFileCreateFlags $flags,
  GCancellable $cancellable,
  GError $error
) {
  g_file_create_readwrite(self, $flags, $cancellable, $error);
}

method create_readwrite_async (
  GFileCreateFlags $flags,
  int $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_create_readwrite_async(
    self, $flags, $io_priority, $cancellable, $callback, $user_data
  );
}

method create_readwrite_finish (
  GAsyncResult $res,
  GError $error
) {
  g_file_create_readwrite_finish(self, $res, $error);
}

method delete (
  GCancellable $cancellable,
  GError $error
) {
  g_file_delete(self, $cancellable, $error);
}

method delete_async (
  int $io_priority,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_delete_async(
    self, $io_priority, $cancellable, $callback, $user_data
  );
}

method delete_finish (GAsyncResult $result, GError $error) {
  g_file_delete_finish(self, $result, $error);
}

method dup () {
  g_file_dup($!f);
}

method eject_mountable (
  GMountUnmountFlags $flags,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_eject_mountable(
    self, $flags, $cancellable, $callback, $user_data
  );
}

method eject_mountable_finish (GAsyncResult $result, GError $error) {
  g_file_eject_mountable_finish(self, $result, $error);
}

method eject_mountable_with_operation (
  GMountUnmountFlags $flags,
  GMountOperation $mount_operation,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
) {
  g_file_eject_mountable_with_operation(
    self, $flags, $mount_operation, $cancellable, $callback, $user_data
  );
}

method eject_mountable_with_operation_finish (GAsyncResult $result, GError $error) {
  g_file_eject_mountable_with_operation_finish(self, $result, $error);
}

method enumerate_children (char $attributes, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_enumerate_children(self, $attributes, $flags, $cancellable, $error);
}

method enumerate_children_async (char $attributes, GFileQueryInfoFlags $flags, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_enumerate_children_async(self, $attributes, $flags, $io_priority, $cancellable, $callback, $user_data);
}

method enumerate_children_finish (GAsyncResult $res, GError $error) {
  g_file_enumerate_children_finish(self, $res, $error);
}

method equal (GFile $file2) {
  g_file_equal(self, $file2);
}

method find_enclosing_mount (GCancellable $cancellable, GError $error) {
  g_file_find_enclosing_mount(self, $cancellable, $error);
}

method find_enclosing_mount_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_find_enclosing_mount_async(self, $io_priority, $cancellable, $callback, $user_data);
}

method find_enclosing_mount_finish (GAsyncResult $res, GError $error) {
  g_file_find_enclosing_mount_finish(self, $res, $error);
}

method get_basename () {
  g_file_get_basename($!f);
}

method get_child (char $name) {
  g_file_get_child(self, $name);
}

method get_child_for_display_name (char $display_name, GError $error) {
  g_file_get_child_for_display_name(self, $display_name, $error);
}

method get_parent () {
  g_file_get_parent($!f);
}

method get_parse_name () {
  g_file_get_parse_name($!f);
}

method get_path () {
  g_file_get_path($!f);
}

method get_relative_path (GFile $descendant) {
  g_file_get_relative_path(self, $descendant);
}

method get_type () {
  g_file_get_type($!f);
}

method get_uri () {
  g_file_get_uri($!f);
}

method get_uri_scheme () {
  g_file_get_uri_scheme($!f);
}

method has_parent (GFile $parent) {
  g_file_has_parent(self, $parent);
}

method has_prefix (GFile $prefix) {
  g_file_has_prefix(self, $prefix);
}

method has_uri_scheme (char $uri_scheme) {
  g_file_has_uri_scheme(self, $uri_scheme);
}

method hash () {
  g_file_hash($!f);
}

method is_native () {
  g_file_is_native($!f);
}

method load_bytes (GCancellable $cancellable, gchar $etag_out, GError $error) {
  g_file_load_bytes(self, $cancellable, $etag_out, $error);
}

method load_bytes_async (GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_load_bytes_async(self, $cancellable, $callback, $user_data);
}

method load_bytes_finish (GAsyncResult $result, gchar $etag_out, GError $error) {
  g_file_load_bytes_finish(self, $result, $etag_out, $error);
}

method load_contents (GCancellable $cancellable, char $contents, gsize $length, char $etag_out, GError $error) {
  g_file_load_contents(self, $cancellable, $contents, $length, $etag_out, $error);
}

method load_contents_async (GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_load_contents_async(self, $cancellable, $callback, $user_data);
}

method load_contents_finish (GAsyncResult $res, char $contents, gsize $length, char $etag_out, GError $error) {
  g_file_load_contents_finish(self, $res, $contents, $length, $etag_out, $error);
}

method load_partial_contents_async (GCancellable $cancellable, GFileReadMoreCallback $read_more_callback, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_load_partial_contents_async(self, $cancellable, $read_more_callback, $callback, $user_data);
}

method load_partial_contents_finish (GAsyncResult $res, char $contents, gsize $length, char $etag_out, GError $error) {
  g_file_load_partial_contents_finish(self, $res, $contents, $length, $etag_out, $error);
}

method make_directory (GCancellable $cancellable, GError $error) {
  g_file_make_directory(self, $cancellable, $error);
}

method make_directory_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_make_directory_async(self, $io_priority, $cancellable, $callback, $user_data);
}

method make_directory_finish (GAsyncResult $result, GError $error) {
  g_file_make_directory_finish(self, $result, $error);
}

method make_directory_with_parents (GCancellable $cancellable, GError $error) {
  g_file_make_directory_with_parents(self, $cancellable, $error);
}

method make_symbolic_link (char $symlink_value, GCancellable $cancellable, GError $error) {
  g_file_make_symbolic_link(self, $symlink_value, $cancellable, $error);
}

method measure_disk_usage (GFileMeasureFlags $flags, GCancellable $cancellable, GFileMeasureProgressCallback $progress_callback, gpointer $progress_data, guint64 $disk_usage, guint64 $num_dirs, guint64 $num_files, GError $error) {
  g_file_measure_disk_usage(self, $flags, $cancellable, $progress_callback, $progress_data, $disk_usage, $num_dirs, $num_files, $error);
}

method measure_disk_usage_async (GFileMeasureFlags $flags, gint $io_priority, GCancellable $cancellable, GFileMeasureProgressCallback $progress_callback, gpointer $progress_data, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_measure_disk_usage_async(self, $flags, $io_priority, $cancellable, $progress_callback, $progress_data, $callback, $user_data);
}

method measure_disk_usage_finish (GAsyncResult $result, guint64 $disk_usage, guint64 $num_dirs, guint64 $num_files, GError $error) {
  g_file_measure_disk_usage_finish(self, $result, $disk_usage, $num_dirs, $num_files, $error);
}

method monitor (GFileMonitorFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_monitor(self, $flags, $cancellable, $error);
}

method monitor_directory (GFileMonitorFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_monitor_directory(self, $flags, $cancellable, $error);
}

method monitor_file (GFileMonitorFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_monitor_file(self, $flags, $cancellable, $error);
}

method mount_enclosing_volume (GMountMountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_mount_enclosing_volume(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
}

method mount_enclosing_volume_finish (GAsyncResult $result, GError $error) {
  g_file_mount_enclosing_volume_finish(self, $result, $error);
}

method mount_mountable (GMountMountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_mount_mountable(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
}

method mount_mountable_finish (GAsyncResult $result, GError $error) {
  g_file_mount_mountable_finish(self, $result, $error);
}

method move (GFile $destination, GFileCopyFlags $flags, GCancellable $cancellable, GFileProgressCallback $progress_callback, gpointer $progress_callback_data, GError $error) {
  g_file_move(self, $destination, $flags, $cancellable, $progress_callback, $progress_callback_data, $error);
}

method new_for_commandline_arg () {
  g_file_new_for_commandline_arg($!f);
}

method new_for_commandline_arg_and_cwd (gchar $cwd) {
  g_file_new_for_commandline_arg_and_cwd(self, $cwd);
}

method new_for_path () {
  g_file_new_for_path($!f);
}

method new_for_uri () {
  g_file_new_for_uri($!f);
}

method new_tmp (GFileIOStream $iostream, GError $error) {
  g_file_new_tmp(self, $iostream, $error);
}

method open_readwrite (GCancellable $cancellable, GError $error) {
  g_file_open_readwrite(self, $cancellable, $error);
}

method open_readwrite_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_open_readwrite_async(self, $io_priority, $cancellable, $callback, $user_data);
}

method open_readwrite_finish (GAsyncResult $res, GError $error) {
  g_file_open_readwrite_finish(self, $res, $error);
}

method parse_name {
  g_file_parse_name($!f);
}

method peek_path {
  g_file_peek_path($!f);
}

method poll_mountable (GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_poll_mountable(self, $cancellable, $callback, $user_data);
}

method poll_mountable_finish (GAsyncResult $result, GError $error) {
  g_file_poll_mountable_finish(self, $result, $error);
}

method query_default_handler (GCancellable $cancellable, GError $error) {
  g_file_query_default_handler(self, $cancellable, $error);
}

method query_exists (GCancellable $cancellable) {
  g_file_query_exists(self, $cancellable);
}

method query_file_type (GFileQueryInfoFlags $flags, GCancellable $cancellable) {
  g_file_query_file_type(self, $flags, $cancellable);
}

method query_filesystem_info (char $attributes, GCancellable $cancellable, GError $error) {
  g_file_query_filesystem_info(self, $attributes, $cancellable, $error);
}

method query_filesystem_info_async (char $attributes, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_query_filesystem_info_async(self, $attributes, $io_priority, $cancellable, $callback, $user_data);
}

method query_filesystem_info_finish (GAsyncResult $res, GError $error) {
  g_file_query_filesystem_info_finish(self, $res, $error);
}

method query_info (char $attributes, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_query_info(self, $attributes, $flags, $cancellable, $error);
}

method query_info_async (char $attributes, GFileQueryInfoFlags $flags, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_query_info_async(self, $attributes, $flags, $io_priority, $cancellable, $callback, $user_data);
}

method query_info_finish (GAsyncResult $res, GError $error) {
  g_file_query_info_finish(self, $res, $error);
}

method query_settable_attributes (GCancellable $cancellable, GError $error) {
  g_file_query_settable_attributes(self, $cancellable, $error);
}

method query_writable_namespaces (GCancellable $cancellable, GError $error) {
  g_file_query_writable_namespaces(self, $cancellable, $error);
}

method read (GCancellable $cancellable, GError $error) {
  g_file_read(self, $cancellable, $error);
}

method read_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_read_async(self, $io_priority, $cancellable, $callback, $user_data);
}

method read_finish (GAsyncResult $res, GError $error) {
  g_file_read_finish(self, $res, $error);
}

method replace (char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_replace(self, $etag, $make_backup, $flags, $cancellable, $error);
}

method replace_async (char $etag, gboolean $make_backup, GFileCreateFlags $flags, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_replace_async(self, $etag, $make_backup, $flags, $io_priority, $cancellable, $callback, $user_data);
}

method replace_contents (char $contents, gsize $length, char $etag, gboolean $make_backup, GFileCreateFlags $flags, char $new_etag, GCancellable $cancellable, GError $error) {
  g_file_replace_contents(self, $contents, $length, $etag, $make_backup, $flags, $new_etag, $cancellable, $error);
}

method replace_contents_async (char $contents, gsize $length, char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_replace_contents_async(self, $contents, $length, $etag, $make_backup, $flags, $cancellable, $callback, $user_data);
}

method replace_contents_bytes_async (GBytes $contents, char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_replace_contents_bytes_async(self, $contents, $etag, $make_backup, $flags, $cancellable, $callback, $user_data);
}

method replace_contents_finish (GAsyncResult $res, char $new_etag, GError $error) {
  g_file_replace_contents_finish(self, $res, $new_etag, $error);
}

method replace_finish (GAsyncResult $res, GError $error) {
  g_file_replace_finish(self, $res, $error);
}

method replace_readwrite (char $etag, gboolean $make_backup, GFileCreateFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_replace_readwrite(self, $etag, $make_backup, $flags, $cancellable, $error);
}

method replace_readwrite_async (char $etag, gboolean $make_backup, GFileCreateFlags $flags, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_replace_readwrite_async(self, $etag, $make_backup, $flags, $io_priority, $cancellable, $callback, $user_data);
}

method replace_readwrite_finish (GAsyncResult $res, GError $error) {
  g_file_replace_readwrite_finish(self, $res, $error);
}

method resolve_relative_path (char $relative_path) {
  g_file_resolve_relative_path(self, $relative_path);
}

method set_attribute (char $attribute, GFileAttributeType $type, gpointer $value_p, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute(self, $attribute, $type, $value_p, $flags, $cancellable, $error);
}

method set_attribute_byte_string (char $attribute, char $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute_byte_string(self, $attribute, $value, $flags, $cancellable, $error);
}

method set_attribute_int32 (char $attribute, gint32 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute_int32(self, $attribute, $value, $flags, $cancellable, $error);
}

method set_attribute_int64 (char $attribute, gint64 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute_int64(self, $attribute, $value, $flags, $cancellable, $error);
}

method set_attribute_string (char $attribute, char $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute_string(self, $attribute, $value, $flags, $cancellable, $error);
}

method set_attribute_uint32 (char $attribute, guint32 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute_uint32(self, $attribute, $value, $flags, $cancellable, $error);
}

method set_attribute_uint64 (char $attribute, guint64 $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attribute_uint64(self, $attribute, $value, $flags, $cancellable, $error);
}

method set_attributes_async (GFileInfo $info, GFileQueryInfoFlags $flags, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_set_attributes_async(self, $info, $flags, $io_priority, $cancellable, $callback, $user_data);
}

method set_attributes_finish (GAsyncResult $result, GFileInfo $info, GError $error) {
  g_file_set_attributes_finish(self, $result, $info, $error);
}

method set_attributes_from_info (GFileInfo $info, GFileQueryInfoFlags $flags, GCancellable $cancellable, GError $error) {
  g_file_set_attributes_from_info(self, $info, $flags, $cancellable, $error);
}

method set_display_name (char $display_name, GCancellable $cancellable, GError $error) {
  g_file_set_display_name(self, $display_name, $cancellable, $error);
}

method set_display_name_async (char $display_name, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_set_display_name_async(self, $display_name, $io_priority, $cancellable, $callback, $user_data);
}

method set_display_name_finish (GAsyncResult $res, GError $error) {
  g_file_set_display_name_finish(self, $res, $error);
}

method start_mountable (GDriveStartFlags $flags, GMountOperation $start_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_start_mountable(self, $flags, $start_operation, $cancellable, $callback, $user_data);
}

method start_mountable_finish (GAsyncResult $result, GError $error) {
  g_file_start_mountable_finish(self, $result, $error);
}

method stop_mountable (GMountUnmountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_stop_mountable(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
}

method stop_mountable_finish (GAsyncResult $result, GError $error) {
  g_file_stop_mountable_finish(self, $result, $error);
}

method supports_thread_contexts {
  g_file_supports_thread_contexts($!f);
}

method trash (GCancellable $cancellable, GError $error) {
  g_file_trash(self, $cancellable, $error);
}

method trash_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_trash_async(self, $io_priority, $cancellable, $callback, $user_data);
}

method trash_finish (GAsyncResult $result, GError $error) {
  g_file_trash_finish(self, $result, $error);
}

method unmount_mountable (GMountUnmountFlags $flags, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_unmount_mountable(self, $flags, $cancellable, $callback, $user_data);
}

method unmount_mountable_finish (GAsyncResult $result, GError $error) {
  g_file_unmount_mountable_finish(self, $result, $error);
}

method unmount_mountable_with_operation (GMountUnmountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) {
  g_file_unmount_mountable_with_operation(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
}

method unmount_mountable_with_operation_finish (GAsyncResult $result, GError $error) {
  g_file_unmount_mountable_with_operation_finish(self, $result, $error);
}
