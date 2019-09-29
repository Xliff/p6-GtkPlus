use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Raw::GFile;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Compat::Roles::Object;

# This WILL be renamed to ::File
role GTK::Compat::Roles::GFile {
  has GFile $!file;

  submethod BUILD (:$file) {
    self!GFileRoleInit($file);
  }

  method !GFileRoleInit (GFile $file) {
    $!file = $file;
  }

  method GTK::Compat::Types::GFile
    is also<GFile>
  { $!file }

  method new-file-obj (GFile $file)
    is also<
      new_file_obj
      new_gfile_obj
      new-gfile-obj
    >
  {
    self.bless( :$file );
  }

  multi method new (GFile $file) {
    die 'Role constructor called.' unless ::?CLASS.^name eq ::?ROLE.^name;
    self.bless(:$file);
  }
  # XXX - To be replaced with multiple dispatchers!
  multi method new (
    :$path,
    :$uri,
    :$cwd,
    :$arg,
    :$iostream,
    :$tmpl,
    :$error
  ) {
    # Can insert more rpbust parameter checking, here... however
    # the priorities established below should be fine.
    my $file = do {
      with $arg {
        with $cwd {
          self.new_for_commandline_arg_and_cwd($arg, $cwd);
        } else {
          self.new_for_commandline_arg($arg);
        }
      } orwith $path {
        self.new_for_path($path);
      } orwith $uri {
        self.new_for_uri($uri);
      } orwith $iostream {
        my $e = $error // gerror;
        with $tmpl {
          self.new_tmp($tmpl, $iostream, $e);
        } else {
          self.new_tmp($iostream, $e);
        }
      } else {
        self.new_tmpl;
      }
    }
    self.bless(:$file);
  }

  method new_for_commandline_arg (Str() $cmd)
    is also<new-for-commandline-arg>
  {
    g_file_new_for_commandline_arg($cmd);
  }

  method new_for_commandline_arg_and_cwd (Str() $cmd, Str() $cwd)
    is also<new-for-commandline-arg-and-cwd>
  {
    g_file_new_for_commandline_arg_and_cwd($cmd, $cwd);
  }

  method new_for_path (Str() $path) is also<new-for-path> {
    g_file_new_for_path($path);
  }

  method new_for_uri (Str() $uri) is also<new-for-uri> {
    g_file_new_for_uri($uri);
  }

  proto method new_tmp (|)
    is also<new-tmp>
  { * }

  multi method new_tmp {
    my $ios = CArray[Pointer[GFileIOStream]].new;
    samewith($ios);
  }
  multi method new_tmp (
    CArray[Pointer[GFileIOStream]] $iostream,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith(Str, $iostream, $error);
  }
  multi method new_tmp (
    Str() $tmpl,
    CArray[Pointer[GFileIOStream]] $iostream,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_file_new_tmp($tmpl, $iostream, $error);
    set_error($error);
    $rc;
  }

  method append_to (
    Int() $flags,                       # GFileCreateFlags $flags,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<append-to>
  {
    clear_error;
    my guint $f = resolve-uint($flags);
    my $rc = g_file_append_to($!file, $f, $cancellable, $error);
    set_error($error);
    $rc;
  }

  proto method append_to_async (|)
    is also<append-to-async>
  { * }

  multi method append_to_async (
    Int() $flags,                       # GFileCreateFlags $flags,
    Int() $io_priority,
    &callback,
    GCancellable() $cancellable = GCancellable,
    gpointer $user_data         = Pointer
  ) {
    samewith($flags, $io_priority, $cancellable, &callback, $user_data);
  }
  multi method append_to_async (
    Int() $flags,                       # GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_append_to_async(
      $!file, $f, $io, $cancellable, &callback, $user_data
    );
  }

  method append_to_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<append-to-finish>
  {
    clear_error;
    my $rc = g_file_append_to_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  multi method copy (
    GFile() $destination,
    Int() $flags,                       # GFileCreateFlags $flags,
    &progress_callback               = -> $, $, $ { },
    gpointer $progress_callback_data = Pointer,
    GCancellable() $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    samewith(
      $destination,
      $flags,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $error
    );
  }
  multi method copy (
    GFile() $destination,
    Int() $flags,                       # GFileCreateFlags $flags,
    GCancellable() $cancellable,
    &progress_callback,
    gpointer $progress_callback_data = Pointer,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my guint $f = resolve-uint($flags);
    my $rc = g_file_copy(
      $!file,
      $destination,
      $f,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $error
    );
    set_error($error);
    $rc;
  }

  proto method copy_async (|)
    is also<copy-async>
  { * }

  multi method copy_async (
    GFile() $destination,
    Int() $flags,                       # GFileCreateFlags $flags,
    Int() $io_priority,
    &callback,
    &progress_callback               = -> $, $, $ { },
    gpointer $progress_callback_data = Pointer,
    gpointer $user_data              = Pointer,
    GCancellable() $cancellable      = GCancellable
  ) {
    samewith(
      $destination,
      $flags,
      $io_priority,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      &callback,
      $user_data
    );
  }
  multi method copy_async (
    GFile() $destination,
    Int() $flags,                       # GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &progress_callback,
    gpointer $progress_callback_data,
    &callback,
    gpointer $user_data = Pointer
  )  {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_copy_async(
      $!file,
      $destination,
      $f,
      $io,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      &callback,
      $user_data
    );
  }

  method copy_attributes (
    GFile() $destination,
    Int() $flags,                       # GFileCreateFlags $flags,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<copy-attributes>
  {
    my guint $f = resolve-uint($flags);
    g_file_copy_attributes(
      $!file, $destination, $f, $cancellable, $error
    );
  }

  method copy_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<copy-finish>
  {
    clear_error;
    my $rc = g_file_copy_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method create (
    Int() $flags,                       # GFileCreateFlags $flags,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $f = resolve-uint($flags);
    g_file_create($!file, $f, $cancellable, $error);
  }

  proto method create_async (|)
    is also<create-async>
  { * }

  multi method create_async (
    GFileCreateFlags $flags,
    Int() $io_priority,
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($flags, $io_priority, $cancellable, &callback, $user_data);
  }
  multi method create_async (
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-uint($io_priority);
    g_file_create_async(
      $!file, $f, $io, $cancellable, &callback, $user_data
    );
  }

  method create_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-finish>
  {
    clear_error;
    my $rc = g_file_create_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method create_readwrite (
    GFileCreateFlags $flags,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-readwrite>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_create_readwrite($!file, $f, $cancellable, $error);
    set_error($error);
    $rc;
  }

  proto method create_readwrite_async (|)
    is also<create-readwrite-async>
  { * }

  multi method create_readwrite_async (
    GFileCreateFlags $flags,
    Int() $io_priority,
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($flags, $io_priority, $cancellable, &callback, $user_data);
  }
  multi method create_readwrite_async (
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-uint($io_priority);
    g_file_create_readwrite_async(
      $!file, $f, $io, $cancellable, &callback, $user_data
    );
  }

  method create_readwrite_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<create-readwrite-finish>
  {
    clear_error;
    my $rc = g_file_create_readwrite_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method delete (
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_file_delete($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  proto method delete_async (|)
    is also<delete-async>
  { * }

  multi method delete_async (
    Int() $io_priority,
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($io_priority, $cancellable, &callback, $user_data);
  }
  multi method delete_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    g_file_delete_async(
      $!file, $io_priority, $cancellable, &callback, $user_data
    );
  }

  method delete_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<delete-finish>
  {
    clear_error;
    my $rc = g_file_delete_finish($!file, $result, $error);
  }

  method dup {
    g_file_dup($!file);
  }

  # proto method eject_mountable (|)
  #   is also<eject-mountable>
  # { * }
  #
  # multi method eject_mountable (
  #   GMountUnmountFlags $flags,
  #   &callback,
  #   gpointer $user_data       = Pointer,
  #   GCancellable $cancellable = Pointer
  # ) {
  #   samewith($flags, $cancellable, &callback, $user_data);
  # }
  # multi method eject_mountable (
  #   GMountUnmountFlags $flags,
  #   GCancellable $cancellable,
  #   &callback,
  #   gpointer $user_data = Pointer
  # ) {
  #   my guint $f = resolve-uint($flags);
  #   g_file_eject_mountable(
  #     $!file, $f, $cancellable, &callback, $user_data
  #   );
  # }
  #
  # method eject_mountable_finish (
  #   GAsyncResult $result,
  #   CArray[Pointer[GError]] $error = gerror
  # )
  #   is also<eject-mountable-finish>
  # {
  #   clear_error;
  #   my $rc = g_file_eject_mountable_finish($!file, $result, $error);
  #   set_error($error);
  #   $rc;
  # }

  proto method eject_mountable_with_operation (|)
    is also<eject-mountable-with-operation>
  { * }

  multi method eject_mountable_with_operation (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($flags, $mount_operation, $cancellable, &callback, $user_data);
  }
  multi method eject_mountable_with_operation (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my guint $f = resolve-uint($flags);
    g_file_eject_mountable_with_operation(
      $!file, $f, $mount_operation, $cancellable, &callback, $user_data
    );
  }

  method eject_mountable_with_operation_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<eject-mountable-with-operation-finish>
  {
    clear_error;
    my $rc = g_file_eject_mountable_with_operation_finish(
      $!file,
      $result,
      $error
    );
    set_error($error);
    $rc;
  }

  method enumerate_children (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<enumerate-children>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_enumerate_children(
      $!file,
      $attributes,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }


  proto method enumerate_children_async (|)
    is also<enumerate-children-async>
  { * }

  multi method enumerate_children_async (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    Int() $io_priority,
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith(
      $attributes,
      $flags,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method enumerate_children_async (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-uint($io_priority);
    g_file_enumerate_children_async(
      $!file,
      $attributes,
      $f,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method enumerate_children_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<enumerate-children-finish>
  {
    clear_error;
    my $rc = g_file_enumerate_children_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method equal (GFile() $file2) {
    g_file_equal($!file, $file2);
  }

  method find_enclosing_mount (
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<find-enclosing-mount>
  {
    clear_error;
    my $rc = g_file_find_enclosing_mount($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  proto method find_enclosing_mount_async (|)
    is also<find-enclosing-mount-async>
  { * }

  multi method find_enclosing_mount_async (
    Int() $io_priority,
    &callback,
    gpointer $user_data         = Pointer,
    GCancellable() $cancellable = GCancellable
  ) {
    samewith($io_priority, $cancellable, &callback, $user_data);
  }
  multi method find_enclosing_mount_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    g_file_find_enclosing_mount_async(
      $!file,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method find_enclosing_mount_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<find-enclosing-mount-finish>
  {
    clear_error;
    my $rc = g_file_find_enclosing_mount_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method get_basename
    is also<
      get-basename
      basename
    >
  {
    g_file_get_basename($!file);
  }

  method get_child (Str() $name) is also<get-child> {
    g_file_get_child($!file, $name);
  }

  method get_child_for_display_name (
    Str() $display_name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<get-child-for-display-name>
  {
    clear_error;
    my $rc = g_file_get_child_for_display_name(
      $!file,
      $display_name,
      $error
    );
    set_error($error);
    $rc;
  }

  method get_parent
    is also<
      get-parent
      parent
    >
  {
    g_file_get_parent($!file);
  }

  # Cannot use shorter variant due to conflict with the method parse_name()
  method get_parse_name
    is also<
      get-parse-name
    >
  {
    g_file_get_parse_name($!file);
  }

  method get_path
    is also<
      get-path
      path
    >
  {
    g_file_get_path($!file);
  }

  method get_relative_path (GFile() $descendant) is also<get-relative-path> {
    g_file_get_relative_path($!file, $descendant);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &g_file_get_type, $n, $t );
  }

  method get_uri
    is also<
      get-uri
      uri
    >
  {
    g_file_get_uri($!file);
  }

  method get_uri_scheme
    is also<
      get-uri-scheme
      uri_scheme
      uri-scheme
    >
  {
    g_file_get_uri_scheme($!file);
  }

  method has_parent (GFile() $parent) is also<has-parent> {
    g_file_has_parent($!file, $parent);
  }

  method has_prefix (GFile() $prefix) is also<has-prefix> {
    g_file_has_prefix($!file, $prefix);
  }

  method has_uri_scheme (Str() $uri_scheme) is also<has-uri-scheme> {
    g_file_has_uri_scheme($!file, $uri_scheme);
  }

  method hash {
    g_file_hash($!file);
  }

  method is_native is also<is-native> {
    g_file_is_native($!file);
  }

  method load_bytes (
    GCancellable() $cancellable,
    Str() $etag_out,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-bytes>
  {
    clear_error;
    my $rc = g_file_load_bytes($!file, $cancellable, $etag_out, $error);
    set_error($error);
    $rc;
  }

  method load_bytes_async (
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<load-bytes-async>
  {
    g_file_load_bytes_async($!file, $cancellable, &callback, $user_data);
  }

  method load_bytes_finish (
    GAsyncResult $result,
    Str() $etag_out,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-bytes-finish>
  {
    clear_error;
    my $rc = g_file_load_bytes_finish($!file, $result, $etag_out, $error);
    set_error($error);
    $rc;
  }

  method load_contents (
    GCancellable() $cancellable,
    Str() $contents,
    gsize $length,
    Str() $etag_out,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-contents>
  {
    clear_error;
    my $rc = g_file_load_contents(
      $!file,
      $cancellable,
      $contents,
      $length,
      $etag_out,
      $error
    );
    set_error($error);
    $rc;
  }

  method load_contents_async (
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<load-contents-async>
  {
    g_file_load_contents_async($!file, $cancellable, &callback, $user_data);
  }

  method load_contents_finish (
    GAsyncResult $res,
    Str() $contents,
    gsize $length,
    Str() $etag_out,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-contents-finish>
  {
    clear_error;
    my $rc = g_file_load_contents_finish(
      $!file,
      $res,
      $contents,
      $length,
      $etag_out,
      $error
    );
    set_error($error);
    $rc;
  }

  method load_partial_contents_async (
    GCancellable() $cancellable,
    &read_more_callback,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<load-partial-contents-async>
  {
    g_file_load_partial_contents_async(
      $!file,
      $cancellable,
      &read_more_callback,
      &callback,
      $user_data
    );
  }

  method load_partial_contents_finish (
    GAsyncResult $res,
    Str() $contents,
    gsize $length,
    Str() $etag_out,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-partial-contents-finish>
  {
    clear_error;
    my $rc = g_file_load_partial_contents_finish(
      $!file,
      $res,
      $contents,
      $length,
      $etag_out,
      $error
    );
    set_error($error);
    $rc;
  }

  method make_directory (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<make-directory>
  {
    clear_error;
    my $rc = g_file_make_directory($!file, $cancellable, $error);
    set_error($error);
    $rc
  }

  method make_directory_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<make-directory-async>
  {
    my gint $io = resolve-uint($io_priority);
    g_file_make_directory_async(
      $!file,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method make_directory_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<make-directory-finish>
  {
    clear_error;
    my $rc = g_file_make_directory_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  method make_directory_with_parents (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<make-directory-with-parents>
  {
    clear_error;
    my $rc = g_file_make_directory_with_parents($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method make_symbolic_link (
    Str() $symlink_value,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<make-symbolic-link>
  {
    clear_error;
    my $rc = g_file_make_symbolic_link(
      $!file,
      $symlink_value,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method measure_disk_usage (
    GFileMeasureFlags $flags,
    GCancellable() $cancellable,
    &progress_callback,
    gpointer $progress_data,
    Int() $disk_usage,
    Int() $num_dirs,
    Int() $num_files,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<measure-disk-usage>
  {
    my guint $f = resolve-uint($flags);
    my @ul = ($disk_usage, $num_dirs, $num_files);
    my guint64 ($du, $nd, $nf) = resolve-uint64(@ul);
    clear_error;
    my $rc = g_file_measure_disk_usage(
      $!file,
      $f,
      $cancellable,
      &progress_callback,
      $progress_data,
      $disk_usage,
      $num_dirs,
      $num_files,
      $error
    );
    set_error($error);
    $rc;
  }

  method measure_disk_usage_async (
    GFileMeasureFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &progress_callback,
    gpointer $progress_data,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<measure-disk-usage-async>
  {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_measure_disk_usage_async(
      $!file,
      $f,
      $io,
      $cancellable,
      &progress_callback,
      $progress_data,
      &callback,
      $user_data
    );
  }

  method measure_disk_usage_finish (
    GAsyncResult $result,
    Int() $disk_usage,
    Int() $num_dirs,
    Int() $num_files,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<measure-disk-usage-finish>
  {
    my @ul = ($disk_usage, $num_dirs, $num_files);
    my guint64 ($du, $nd, $nf) = resolve-uint64(@ul);
    clear_error;
    my $rc = g_file_measure_disk_usage_finish(
      $!file,
      $result,
      $disk_usage,
      $num_dirs,
      $num_files,
      $error
    );
    set_error($error);
    $rc;
  }

  method monitor (
    GFileMonitorFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_monitor($!file, $f, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method monitor_directory (
    GFileMonitorFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<monitor-directory>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_monitor_directory($!file, $f, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method monitor_file (
    GFileMonitorFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<monitor-file>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_monitor_file($!file, $f, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method mount_enclosing_volume (
    GMountMountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<mount-enclosing-volume>
  {
    my guint $f = resolve-uint($flags);
    g_file_mount_enclosing_volume(
      $!file,
      $f,
      $mount_operation,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method mount_enclosing_volume_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<mount-enclosing-volume-finish>
  {
    clear_error;
    my $rc = g_file_mount_enclosing_volume_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  method mount_mountable (
    GMountMountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<mount-mountable>
  {
    my guint $f = resolve-uint($flags);
    g_file_mount_mountable(
      $!file,
      $f,
      $mount_operation,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method mount_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<mount-mountable-finish>
  {
    clear_error;
    my $rc = g_file_mount_mountable_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  multi method move (
    GFile() $destination,
    Int() $flags,
    &progress_callback               = -> $, $, $ { },
    gpointer $progress_callback_data = Pointer,
    GCancellable() $cancellable      = GCancellable,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    samewith(
      $destination,
      $flags,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $error
    );
  }
  multi method move (
    GFile() $destination,
    Int() $flags,
    GCancellable() $cancellable      = GCancellable,
    &progress_callback               = -> $, $, $ { },
    gpointer $progress_callback_data = Pointer,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_move(
      $!file,
      $destination,
      $f,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $error
    );
    set_error($error);
    $rc;
  }

  method open_readwrite (
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<open-readwrite>
  {
    clear_error;
    my $rc = g_file_open_readwrite($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method open_readwrite_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data  = Pointer
  )
    is also<open-readwrite-async>
  {
    my gint $io = resolve-uint($io_priority);
    g_file_open_readwrite_async(
      $!file,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method open_readwrite_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<open-readwrite-finish>
  {
    clear_error;
    my $rc = g_file_open_readwrite_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method parse_name (
    GTK::Compat::Roles::GFile:U:
    Str() $name
  )
    is also<parse-name>
  {
    g_file_parse_name($name);
  }

  method peek_path is also<peek-path> {
    g_file_peek_path($!file);
  }

  method poll_mountable (
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<poll-mountable>
  {
    g_file_poll_mountable($!file, $cancellable, &callback, $user_data);
  }

  method poll_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<poll-mountable-finish>
  {
    clear_error;
    my $rc = g_file_poll_mountable_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  method query_default_handler (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-default-handler>
  {
    clear_error;
    my $rc = g_file_query_default_handler($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method query_exists (GCancellable() $cancellable) is also<query-exists> {
    g_file_query_exists($!file, $cancellable);
  }

  method query_file_type (
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable
  )
    is also<query-file-type>
  {
    my guint $f = resolve-uint($flags);
    g_file_query_file_type($!file, $f, $cancellable);
  }

  method query_filesystem_info (
    Str() $attributes,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-filesystem-info>
  {
    g_file_query_filesystem_info($!file, $attributes, $cancellable, $error);
  }

  method query_filesystem_info_async (
    Str() $attributes,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<query-filesystem-info-async>
  {
    my gint $io = resolve-uint($io_priority);
    g_file_query_filesystem_info_async(
      $!file,
      $attributes,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method query_filesystem_info_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-filesystem-info-finish>
  {
    clear_error;
    my $rc = g_file_query_filesystem_info_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method query_info (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-info>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_query_info($!file, $attributes, $f, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method query_info_async (
    Str() $attributes,
    GFileQueryInfoFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<query-info-async>
  {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_query_info_async(
      $!file,
      $attributes,
      $f,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method query_info_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-info-finish>
  {
    clear_error;
    my $rc = g_file_query_info_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method query_settable_attributes (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-settable-attributes>
  {
    clear_error;
    my $rc = g_file_query_settable_attributes($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method query_writable_namespaces (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<query-writable-namespaces>
  {
    clear_error;
    my $rc = g_file_query_writable_namespaces($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method read (
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_file_read($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method read_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data
  )
    is also<read-async>
  {
    g_file_read_async(
      $!file, $io_priority, $cancellable, &callback, $user_data
    );
  }

  method read_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-finish>
  {
    clear_error;
    my $rc = g_file_read_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method replace (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    g_file_replace($!file, $etag, $make_backup, $flags, $cancellable, $error);
  }

  method replace_async (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<replace-async>
  {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_replace_async(
      $!file,
      $etag,
      $make_backup,
      $flags,
      $io_priority,
      $cancellable,
      &callback,
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
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-contents>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_replace_contents(
      $!file,
      $contents,
      $length,
      $etag,
      $make_backup,
      $f,
      $new_etag,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method replace_contents_async (
    Str() $contents,
    gsize $length,
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<replace-contents-async>
  {
    my guint $f = resolve-uint($flags);
    g_file_replace_contents_async(
      $!file,
      $contents,
      $length,
      $etag,
      $make_backup,
      $f,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method replace_contents_bytes_async (
    GBytes $contents,
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<replace-contents-bytes-async>
  {
    my guint $f = resolve-uint($flags);
    g_file_replace_contents_bytes_async(
      $!file,
      $contents,
      $etag,
      $make_backup,
      $f,
      $cancellable,
      &callback,
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
    clear_error;
    my $rc = g_file_replace_contents_finish($!file, $res, $new_etag, $error);
    set_error($error);
    $rc;
  }

  method replace_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-finish>
  {
    clear_error;
    my $rc = g_file_replace_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method replace_readwrite (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-readwrite>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_replace_readwrite(
      $!file,
      $etag,
      $make_backup,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method replace_readwrite_async (
    Str() $etag,
    gboolean $make_backup,
    GFileCreateFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<replace-readwrite-async>
  {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_replace_readwrite_async(
      $!file,
      $etag,
      $make_backup,
      $f,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method replace_readwrite_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<replace-readwrite-finish>
  {
    clear_error;
    my $rc = g_file_replace_readwrite_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method resolve_relative_path (Str() $relative_path)
    is also<resolve-relative-path>
  {
    g_file_resolve_relative_path($!file, $relative_path);
  }

  method set_attribute (
    Str() $attribute,
    GFileAttributeType $type,
    gpointer $value_p,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_set_attribute(
      $!file,
      $attribute,
      $type,
      $value_p,
      $flags,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attribute_byte_string (
    Str() $attribute,
    Str() $value,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-byte-string>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_set_attribute_byte_string(
      $!file,
      $attribute,
      $value,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attribute_int32 (
    Str() $attribute,
    gint32 $value,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-int32>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_set_attribute_int32(
      $!file,
      $attribute,
      $value,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attribute_int64 (
    Str() $attribute,
    gint64 $value,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-int64>
  {
    my guint $f = resolve-uint($flags);
    my gint64 $v = resolve-int64($value);
    my $rc = g_file_set_attribute_int64(
      $!file,
      $attribute,
      $v,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attribute_string (
    Str() $attribute,
    Str() $value,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-string>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_set_attribute_string(
      $!file,
      $attribute,
      $value,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attribute_uint32 (
    Str() $attribute,
    guint32 $value,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-uint32>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_set_attribute_uint32(
      $!file,
      $attribute,
      $value,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attribute_uint64 (
    Str() $attribute,
    guint64 $value,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attribute-uint64>
  {
    my guint $f = resolve-uint($flags);
    my guint64 $v = resolve-uint64($value);
    clear_error;
    my $rc = g_file_set_attribute_uint64(
      $!file,
      $attribute,
      $v,
      $f,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_attributes_async (
    GFileInfo $info,
    GFileQueryInfoFlags $flags,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<set-attributes-async>
  {
    my guint $f = resolve-uint($flags);
    my gint $io = resolve-int($io_priority);
    g_file_set_attributes_async(
      $!file,
      $info,
      $f,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method set_attributes_finish (
    GAsyncResult $result,
    CArray[Pointer[GFileInfo]] $info,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attributes-finish>
  {
    clear_error;
    my $rc = g_file_set_attributes_finish($!file, $result, $info, $error);
    set_error($error);
    $rc;
  }

  method set_attributes_from_info (
    GFileInfo $info,
    GFileQueryInfoFlags $flags,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-attributes-from-info>
  {
    my guint $f = resolve-uint($flags);
    clear_error;
    my $rc = g_file_set_attributes_from_info(
      $!file,
      $info,
      $flags,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_display_name (
    Str() $display_name,
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-display-name>
  {
    clear_error;
    my $rc = g_file_set_display_name(
      $!file,
      $display_name,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  method set_display_name_async (
    Str() $display_name,
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<set-display-name-async>
  {
    my gint $io = resolve-int($io_priority);
    g_file_set_display_name_async(
      $!file,
      $display_name,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }


  method set_display_name_finish (
    GAsyncResult $res,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-display-name-finish>
  {
    clear_error;
    my $rc = g_file_set_display_name_finish($!file, $res, $error);
    set_error($error);
    $rc;
  }

  method start_mountable (
    GDriveStartFlags $flags,
    GMountOperation $start_operation,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<start-mountable>
  {
    my guint $f = resolve-uint($flags);
    g_file_start_mountable(
      $!file,
      $f,
      $start_operation,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method start_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<start-mountable-finish>
  {
    clear_error;
    my $rc = g_file_start_mountable_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  method stop_mountable (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<stop-mountable>
  {
    my guint $f = resolve-uint($flags);
    g_file_stop_mountable(
      $!file,
      $f,
      $mount_operation,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method stop_mountable_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<stop-mountable-finish>
  {
    clear_error;
    my $rc = g_file_stop_mountable_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  method supports_thread_contexts is also<supports-thread-contexts> {
    so g_file_supports_thread_contexts($!file);
  }

  method trash (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_file_trash($!file, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method trash_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = Pointer
  )
    is also<trash-async>
  {
    my gint $io = resolve-int($io_priority);
    g_file_trash_async(
      $!file,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method trash_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<trash-finish>
  {
    clear_error;
    my $rc = g_file_trash_finish($!file, $result, $error);
    set_error($error);
    $rc;
  }

  # method unmount_mountable (
  #   GMountUnmountFlags $flags,
  #   GCancellable $cancellable,
  #   &callback,
  #   gpointer $user_data = Pointer
  # )
  #   is also<unmount-mountable>
  # {
  #   my gint $f = resolve-int($flags);
  #   g_file_unmount_mountable($!file, $f, $cancellable, &callback, $user_data);
  # }
  #
  # method unmount_mountable_finish (
  #   GAsyncResult $result,
  #   CArray[Pointer[GError]] $error = gerror
  # )
  #   is also<unmount-mountable-finish>
  # {
  #   clear_error;
  #   my $rc = g_file_unmount_mountable_finish($!file, $result, $error);
  #   set_error($error);
  #   $rc;
  # }

  method unmount_mountable_with_operation (
    GMountUnmountFlags $flags,
    GMountOperation $mount_operation,
    GCancellable() $cancellable,
    GAsyncReadyCallback &callback,
    gpointer $user_data = Pointer
  )
    is also<unmount-mountable-with-operation>
  {
    my guint $f = resolve-uint($flags);
    g_file_unmount_mountable_with_operation(
      $!file,
      $f,
      $mount_operation,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method unmount_mountable_with_operation_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<unmount-mountable-with-operation-finish>
  {
    clear_error;
    my $rc = g_file_unmount_mountable_with_operation_finish(
      $!file,
      $result,
      $error
    );
    set_error($error);
    $rc;
  }

}
