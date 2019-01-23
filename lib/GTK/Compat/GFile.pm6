use v6.c;

use Method::Also;

use GTK::Compat::Types;

# ******** DO NOT USE THIS FILE ********

# NOTE!! -- THIS FILE IS NOT YET PART OF GTK-PLUS. THIS IS A PLACEHOLDER
#           FOR A *POTENTIAL* ADDITION.

class GTK::Compat::GFile {
  has GFile $.file;

  method append_to (
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error
  ) is also<append-to> {
    g_file_append_to(self, $flags, $cancellable, $error);
  }

  method append_to_async (
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) is also<append-to-async> {
    g_file_append_to_async(
      self, $flags, $io_priority, $cancellable, $callback, $user_data
    );
  }

  method append_to_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error
  ) is also<append-to-finish> {
    g_file_append_to_finish(self, $res, $error);
  }

  method copy (
    GFile $destination,
    GFileCopyFlags $flags,
    GCancellable $cancellable,
    GFileProgressCallback $progress_callback,
    gpointer $progress_callback_data,
    CArray[Pointer[GError]] $error
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
    Int() $io_priority,
    GCancellable $cancellable,
    GFileProgressCallback $progress_callback,
    gpointer $progress_callback_data,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) is also<copy-async> {
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
    CArray[Pointer[GError]] $error
  ) is also<copy-attributes> {
    g_file_copy_attributes(
      self, $destination, $flags, $cancellable, $error
    );
  }

  method copy_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<copy-finish>
  {
    g_file_copy_finish(self, $res, $error);
  }

  method create (
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    g_file_create(self, $flags, $cancellable, $error);
  }

  method create_async (
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) is also<create-async> {
    g_file_create_async(
      self, $flags, $io_priority, $cancellable, $callback, $user_data
    );
  }

  method create_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-finish>
  {
    g_file_create_finish(self, $res, $error);
  }

  method create_readwrite (
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error
  )
    is also<create-readwrite>
  {
    g_file_create_readwrite(self, $flags, $cancellable, $error);
  }

  method create_readwrite_async (
    GFileCreateFlags $flags,
    int $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<create-readwrite-async>
  {
    g_file_create_readwrite_async(
      self, $flags, $io_priority, $cancellable, $callback, $user_data
    );
  }

  method create_readwrite_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error
  )
    is also<create-readwrite-finish>
  {
    g_file_create_readwrite_finish(self, $res, $error);
  }

  method delete (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error
  ) {
    g_file_delete(self, $cancellable, $error);
  }

  method delete_async (
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<delete-async>
  {
    g_file_delete_async(
      self, $io_priority, $cancellable, $callback, $user_data
    );
  }

  method delete_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<delete-finish>
  {
    g_file_delete_finish(self, $result, $error);
  }

  method dup {
    g_file_dup($!f);
  }

  method eject_mountable (
    GMountUnmountFlags $flags,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  ) is also<eject-mountable> {
    g_file_eject_mountable(
      self, $flags, $cancellable, $callback, $user_data
    );
  }

  method eject_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<eject-mountable-finish>
  {
    g_file_eject_mountable_finish(self, $result, $error);
  }

  method eject_mountable_with_operation (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<eject-mountable-with-operation>
  {
    g_file_eject_mountable_with_operation(
      self, $flags, $mount_operation, $cancellable, $callback, $user_data
    );
  }

  method eject_mountable_with_operation_finish (GAsyncResult $result, CArray[Pointer[GError]] $error = gerror) is also<eject-mountable-with-operation-finish> {
    g_file_eject_mountable_with_operation_finish(self, $result, $error);
  }

  method enumerate_children (Str() $attributes, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<enumerate-children> {
    g_file_enumerate_children(self, $attributes, $flags, $cancellable, $error);
  }

  method enumerate_children_async (Str() $attributes, GFileQueryInfoFlags $flags, int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<enumerate-children-async> {
    g_file_enumerate_children_async(self, $attributes, $flags, $io_priority, $cancellable, $callback, $user_data);
  }

  method enumerate_children_finish (GAsyncResult $res, CArray[Pointer[GError]] $error = gerror) is also<enumerate-children-finish> {
    g_file_enumerate_children_finish(self, $res, $error);
  }

  method equal (GFile $file2) {
    g_file_equal(self, $file2);
  }

  method find_enclosing_mount (GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<find-enclosing-mount> {
    g_file_find_enclosing_mount(self, $cancellable, $error);
  }

  method find_enclosing_mount_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<find-enclosing-mount-async> {
    g_file_find_enclosing_mount_async(self, $io_priority, $cancellable, $callback, $user_data);
  }

  method find_enclosing_mount_finish (GAsyncResult $res, CArray[Pointer[GError]] $error = gerror) is also<find-enclosing-mount-finish> {
    g_file_find_enclosing_mount_finish(self, $res, $error);
  }

  method get_basename is also<get-basename> {
    g_file_get_basename($!f);
  }

  method get_child (Str() $name) is also<get-child> {
    g_file_get_child(self, $name);
  }

  method get_child_for_display_name (Str() $display_name, CArray[Pointer[GError]] $error = gerror) is also<get-child-for-display-name> {
    g_file_get_child_for_display_name(self, $display_name, $error);
  }

  method get_parent is also<get-parent> {
    g_file_get_parent($!f);
  }

  method get_parse_name is also<get-parse-name> {
    g_file_get_parse_name($!f);
  }

  method get_path is also<get-path> {
    g_file_get_path($!f);
  }

  method get_relative_path (GFile $descendant) is also<get-relative-path> {
    g_file_get_relative_path(self, $descendant);
  }

  method get_type is also<get-type> {
    g_file_get_type();
  }

  method get_uri is also<get-uri> {
    g_file_get_uri($!f);
  }

  method get_uri_scheme is also<get-uri-scheme> {
    g_file_get_uri_scheme($!f);
  }

  method has_parent (GFile $parent) is also<has-parent> {
    g_file_has_parent(self, $parent);
  }

  method has_prefix (GFile $prefix) is also<has-prefix> {
    g_file_has_prefix(self, $prefix);
  }

  method has_uri_scheme (Str() $uri_scheme) is also<has-uri-scheme> {
    g_file_has_uri_scheme(self, $uri_scheme);
  }

  method hash {
    g_file_hash($!f);
  }

  method is_native is also<is-native> {
    g_file_is_native($!f);
  }

  method load_bytes (GCancellable $cancellable, gchar $etag_out, CArray[Pointer[GError]] $error = gerror) is also<load-bytes> {
    g_file_load_bytes(self, $cancellable, $etag_out, $error);
  }

  method load_bytes_async (GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<load-bytes-async> {
    g_file_load_bytes_async(self, $cancellable, $callback, $user_data);
  }

  method load_bytes_finish (GAsyncResult $result, gchar $etag_out, CArray[Pointer[GError]] $error = gerror) is also<load-bytes-finish> {
    g_file_load_bytes_finish(self, $result, $etag_out, $error);
  }

  method load_contents (GCancellable $cancellable, Str() $contents, gsize $length, Str() $etag_out, CArray[Pointer[GError]] $error = gerror) is also<load-contents> {
    g_file_load_contents(self, $cancellable, $contents, $length, $etag_out, $error);
  }

  method load_contents_async (GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<load-contents-async> {
    g_file_load_contents_async(self, $cancellable, $callback, $user_data);
  }

  method load_contents_finish (GAsyncResult $res, Str() $contents, gsize $length, Str() $etag_out, CArray[Pointer[GError]] $error = gerror) is also<load-contents-finish> {
    g_file_load_contents_finish(self, $res, $contents, $length, $etag_out, $error);
  }

  method load_partial_contents_async (GCancellable $cancellable, GFileReadMoreCallback $read_more_callback, GAsyncReadyCallback $callback, gpointer $user_data) is also<load-partial-contents-async> {
    g_file_load_partial_contents_async(self, $cancellable, $read_more_callback, $callback, $user_data);
  }

  method load_partial_contents_finish (GAsyncResult $res, Str() $contents, gsize $length, Str() $etag_out, CArray[Pointer[GError]] $error = gerror) is also<load-partial-contents-finish> {
    g_file_load_partial_contents_finish(self, $res, $contents, $length, $etag_out, $error);
  }

  method make_directory (GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<make-directory> {
    g_file_make_directory(self, $cancellable, $error);
  }

  method make_directory_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<make-directory-async> {
    g_file_make_directory_async(self, $io_priority, $cancellable, $callback, $user_data);
  }

  method make_directory_finish (GAsyncResult $result, CArray[Pointer[GError]] $error = gerror) is also<make-directory-finish> {
    g_file_make_directory_finish(self, $result, $error);
  }

  method make_directory_with_parents (GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<make-directory-with-parents> {
    g_file_make_directory_with_parents(self, $cancellable, $error);
  }

  method make_symbolic_link (Str() $symlink_value, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<make-symbolic-link> {
    g_file_make_symbolic_link(self, $symlink_value, $cancellable, $error);
  }

  method measure_disk_usage (GFileMeasureFlags $flags, GCancellable $cancellable, GFileMeasureProgressCallback $progress_callback, gpointer $progress_data, guint64 $disk_usage, guint64 $num_dirs, guint64 $num_files, CArray[Pointer[GError]] $error = gerror) is also<measure-disk-usage> {
    g_file_measure_disk_usage(self, $flags, $cancellable, $progress_callback, $progress_data, $disk_usage, $num_dirs, $num_files, $error);
  }

  method measure_disk_usage_async (GFileMeasureFlags $flags, gint $io_priority, GCancellable $cancellable, GFileMeasureProgressCallback $progress_callback, gpointer $progress_data, GAsyncReadyCallback $callback, gpointer $user_data) is also<measure-disk-usage-async> {
    g_file_measure_disk_usage_async(self, $flags, $io_priority, $cancellable, $progress_callback, $progress_data, $callback, $user_data);
  }

  method measure_disk_usage_finish (GAsyncResult $result, guint64 $disk_usage, guint64 $num_dirs, guint64 $num_files, CArray[Pointer[GError]] $error = gerror) is also<measure-disk-usage-finish> {
    g_file_measure_disk_usage_finish(self, $result, $disk_usage, $num_dirs, $num_files, $error);
  }

  method monitor (GFileMonitorFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) {
    g_file_monitor(self, $flags, $cancellable, $error);
  }

  method monitor_directory (GFileMonitorFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<monitor-directory> {
    g_file_monitor_directory(self, $flags, $cancellable, $error);
  }

  method monitor_file (GFileMonitorFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<monitor-file> {
    g_file_monitor_file(self, $flags, $cancellable, $error);
  }

  method mount_enclosing_volume (GMountMountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<mount-enclosing-volume> {
    g_file_mount_enclosing_volume(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
  }

  method mount_enclosing_volume_finish (GAsyncResult $result, CArray[Pointer[GError]] $error = gerror) is also<mount-enclosing-volume-finish> {
    g_file_mount_enclosing_volume_finish(self, $result, $error);
  }

  method mount_mountable (GMountMountFlags $flags, GMountOperation $mount_operation, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<mount-mountable> {
    g_file_mount_mountable(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
  }

  method mount_mountable_finish (GAsyncResult $result, CArray[Pointer[GError]] $error = gerror) is also<mount-mountable-finish> {
    g_file_mount_mountable_finish(self, $result, $error);
  }

  method move (GFile $destination, GFileCopyFlags $flags, GCancellable $cancellable, GFileProgressCallback $progress_callback, gpointer $progress_callback_data, CArray[Pointer[GError]] $error = gerror) {
    g_file_move(self, $destination, $flags, $cancellable, $progress_callback, $progress_callback_data, $error);
  }

  method new_for_commandline_arg () is also<new-for-commandline-arg> {
    g_file_new_for_commandline_arg($!f);
  }

  method new_for_commandline_arg_and_cwd (gchar $cwd) is also<new-for-commandline-arg-and-cwd> {
    g_file_new_for_commandline_arg_and_cwd(self, $cwd);
  }

  method new_for_path () is also<new-for-path> {
    g_file_new_for_path($!f);
  }

  method new_for_uri () is also<new-for-uri> {
    g_file_new_for_uri($!f);
  }

  method new_tmp (GFileIOStream $iostream, CArray[Pointer[GError]] $error = gerror) is also<new-tmp> {
    g_file_new_tmp(self, $iostream, $error);
  }

  method open_readwrite (GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<open-readwrite> {
    g_file_open_readwrite(self, $cancellable, $error);
  }

  method open_readwrite_async (int $io_priority, GCancellable $cancellable, GAsyncReadyCallback $callback, gpointer $user_data) is also<open-readwrite-async> {
    g_file_open_readwrite_async(self, $io_priority, $cancellable, $callback, $user_data);
  }

  method open_readwrite_finish (GAsyncResult $res, CArray[Pointer[GError]] $error = gerror) is also<open-readwrite-finish> {
    g_file_open_readwrite_finish(self, $res, $error);
  }

  method parse_name is also<parse-name> {
    g_file_parse_name($!f);
  }

  method peek_path is also<peek-path> {
    g_file_peek_path($!f);
  }

  method poll_mountable (
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<poll-mountable>
  {
    g_file_poll_mountable(self, $cancellable, $callback, $user_data);
  }

  method poll_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<poll-mountable-finish>
  {
    g_file_poll_mountable_finish(self, $result, $error);
  }

  method query_default_handler (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-default-handler>
  {
    g_file_query_default_handler(self, $cancellable, $error);
  }

  method query_exists (GCancellable $cancellable) is also<query-exists> {
    g_file_query_exists(self, $cancellable);
  }

  method query_file_type (
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable
  )
    is also<query-file-type>
  {
    g_file_query_file_type(self, $flags, $cancellable);
  }

  method query_filesystem_info (
    Str() $attributes,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-filesystem-info>
  {
    g_file_query_filesystem_info(self, $attributes, $cancellable, $error);
  }

  method query_filesystem_info_async (
    Str() $attributes,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<query-filesystem-info-async>
  {
    g_file_query_filesystem_info_async(
      self, $attributes, $io_priority, $cancellable, $callback, $user_data
    );
  }

  method query_filesystem_info_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-filesystem-info-finish>
  {
    g_file_query_filesystem_info_finish(self, $res, $error);
  }

  method query_info (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-info>
  {
    g_file_query_info(self, $attributes, $flags, $cancellable, $error);
  }

  method query_info_async (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<query-info-async>
  {
    g_file_query_info_async(
      self,
      $attributes,
      $flags,
      $io_priority,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method query_info_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-info-finish>
  {
    g_file_query_info_finish(self, $res, $error);
  }

  method query_settable_attributes (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) is also<query-settable-attributes> {
    g_file_query_settable_attributes(self, $cancellable, $error);
  }

  method query_writable_namespaces (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-writable-namespaces>
  {
    g_file_query_writable_namespaces(self, $cancellable, $error);
  }

  method read (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_file_read(self, $cancellable, $error);
  }

  method read_async (
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<read-async>
  {
    g_file_read_async(
      self, $io_priority, $cancellable, $callback, $user_data
    );
  }

  method read_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-finish>
  {
    g_file_read_finish(self, $res, $error);
  }

  method replace (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_file_replace(self, $etag, $make_backup, $flags, $cancellable, $error);
  }

  method replace_async (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    int $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<replace-async>
  {
    g_file_replace_async(
      self,
      $etag,
      $make_backup,
      $flags,
      $io_priority,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method replace_contents (
    Str() $contents,
    gsize $length,
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    Str() $new_etag,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-contents>
  {
    g_file_replace_contents(
      self,
      $contents,
      $length,
      $etag,
      $make_backup,
      $flags,
      $new_etag,
      $cancellable,
      $error
    );
  }

  method replace_contents_async (
    Str() $contents,
    gsize $length,
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<replace-contents-async>
  {
    g_file_replace_contents_async(
      self,
      $contents,
      $length,
      $etag,
      $make_backup,
      $flags,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method replace_contents_bytes_async (
    GBytes $contents,
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<replace-contents-bytes-async>
  {
    g_file_replace_contents_bytes_async(
      self,
      $contents,
      $etag,
      $make_backup,
      $flags,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method replace_contents_finish (
    GAsyncResult $res,
    Str() $new_etag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-contents-finish>
  {
    g_file_replace_contents_finish(self, $res, $new_etag, $error);
  }

  method replace_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-finish>
  {
    g_file_replace_finish(self, $res, $error);
  }

  method replace_readwrite (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-readwrite>
  {
    g_file_replace_readwrite(self, $etag, $make_backup, $flags, $cancellable, $error);
  }

  method replace_readwrite_async (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<replace-readwrite-async>
  {
    g_file_replace_readwrite_async(self, $etag, $make_backup, $flags, $io_priority, $cancellable, $callback, $user_data);
  }

  method replace_readwrite_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-readwrite-finish>
  {
    g_file_replace_readwrite_finish(self, $res, $error);
  }

  method resolve_relative_path (Str() $relative_path)
    is also<resolve-relative-path>
  {
    g_file_resolve_relative_path(self, $relative_path);
  }

  method set_attribute (
    Str() $attribute,
    GFileAttributeType $type,
    gpointer $value_p,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute>
  {
    g_file_set_attribute(self, $attribute, $type, $value_p, $flags, $cancellable, $error);
  }

  method set_attribute_byte_string (Str() $attribute, Str() $value, GFileQueryInfoFlags $flags, GCancellable $cancellable, CArray[Pointer[GError]] $error = gerror) is also<set-attribute-byte-string> {
    g_file_set_attribute_byte_string(self, $attribute, $value, $flags, $cancellable, $error);
  }

  method set_attribute_int32 (
    Str() $attribute,
    gint32 $value,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-int32>
  {
    g_file_set_attribute_int32(
      self, $attribute, $value, $flags, $cancellable, $error
    );
  }

  method set_attribute_int64 (
    Str() $attribute,
    gint64 $value,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-int64>
  {
    g_file_set_attribute_int64(
      self, $attribute, $value, $flags, $cancellable, $error
    );
  }

  method set_attribute_string (
    Str() $attribute,
    Str() $value,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-string>
  {
    g_file_set_attribute_string(
      self, $attribute, $value, $flags, $cancellable, $error
    );
  }

  method set_attribute_uint32 (
    Str() $attribute,
    guint32 $value,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-uint32>
  {
    g_file_set_attribute_uint32(self, $attribute, $value, $flags, $cancellable, $error);
  }

  method set_attribute_uint64 (
    Str() $attribute,
    guint64 $value,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-uint64>
  {
    g_file_set_attribute_uint64(self, $attribute, $value, $flags, $cancellable, $error);
  }

  method set_attributes_async (
    GFileInfo $info,
    GFileQueryInfoFlags $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<set-attributes-async>
  {
    g_file_set_attributes_async(self, $info, $flags, $io_priority, $cancellable, $callback, $user_data);
  }

  method set_attributes_finish (
    GAsyncResult $result,
    GFileInfo $info,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attributes-finish>
  {
    g_file_set_attributes_finish(self, $result, $info, $error);
  }

  method set_attributes_from_info (
    GFileInfo $info,
    GFileQueryInfoFlags $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) is also<set-attributes-from-info> {
    g_file_set_attributes_from_info(self, $info, $flags, $cancellable, $error);
  }

  method set_display_name (
    Str() $display_name,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-display-name>
  {
    g_file_set_display_name(self, $display_name, $cancellable, $error);
  }

  method set_display_name_async (
    Str() $display_name,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<set-display-name-async>
  {
    g_file_set_display_name_async(self, $display_name, $io_priority, $cancellable, $callback, $user_data);
  }

  method set_display_name_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-display-name-finish>
  {
    g_file_set_display_name_finish(self, $res, $error);
  }

  method start_mountable (
    GDriveStartFlags $flags,
    GMountOperation $start_operation,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<start-mountable>
  {
    g_file_start_mountable(self, $flags, $start_operation, $cancellable, $callback, $user_data);
  }

  method start_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<start-mountable-finish>
  {
    g_file_start_mountable_finish(self, $result, $error);
  }

  method stop_mountable (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<stop-mountable>
  {
    g_file_stop_mountable(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
  }

  method stop_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<stop-mountable-finish>
  {
    g_file_stop_mountable_finish(self, $result, $error);
  }

  method supports_thread_contexts is also<supports-thread-contexts> {
    g_file_supports_thread_contexts($!f);
  }

  method trash (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_file_trash(self, $cancellable, $error);
  }

  method trash_async (
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<trash-async>
  {
    g_file_trash_async(self, $io_priority, $cancellable, $callback, $user_data);
  }

  method trash_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  ) is also<trash-finish> {
    g_file_trash_finish(self, $result, $error);
  }

  method unmount_mountable (
    GMountUnmountFlags $flags,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<unmount-mountable>
  {
    g_file_unmount_mountable(self, $flags, $cancellable, $callback, $user_data);
  }

  method unmount_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<unmount-mountable-finish>
  {
    g_file_unmount_mountable_finish(self, $result, $error);
  }

  method unmount_mountable_with_operation (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<unmount-mountable-with-operation>
  {
    g_file_unmount_mountable_with_operation(self, $flags, $mount_operation, $cancellable, $callback, $user_data);
  }

  method unmount_mountable_with_operation_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error
  )
    is also<unmount-mountable-with-operation-finish>
  {
    g_file_unmount_mountable_with_operation_finish(self, $result, $error);
  }
}
