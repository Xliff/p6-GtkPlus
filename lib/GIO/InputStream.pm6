use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::InputStream;

use GTK::Raw::Utils;

use GTK::Compat::Roles::Object;

class GIO::InputStream {
  also does GTK::Compat::Roles::Object;

  has GInputStream $!is;

  submethod BUILD (:$stream) {
    $!is = $stream;

    self.roleInit-Object;
  }

  method clear_pending {
    g_input_stream_clear_pending($!is);
  }

  method close (
    GCancellable $cancellable      = Pointer,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    g_input_stream_close($!is, $cancellable, $error);
  }

  multi method close_async (
    Int() $io_priority,
    &callback,
    GCancellable $cancellable = Pointer,
    gpointer $user_data       = Pointer
  ) {
    samewith($io_priority, $cancellable, &callback, $user_data);
  }
  multi method close_async (
    Int() $io_priority,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my int32 $io = resolve-int($io_priority);
    g_input_stream_close_async(
      $!is,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method close_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so g_input_stream_close_finish($!is, $result, $error);
    set_error($error);
    $rc;
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &g_input_stream_get_type, $n, $t );
  }

  method has_pending {
    so g_input_stream_has_pending($!is);
  }

  method is_closed {
    so g_input_stream_is_closed($!is);
  }

  method read (
    Pointer $buffer,
    Int() $count,
    GCancellable $cancellable      = Pointer,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my uint64 $c = resolve-uint64($count);
    my $rc = g_input_stream_read($!is, $buffer, $count, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method read_all (
    Pointer $buffer,
    Int() $count,
    Int() $bytes_read,
    GCancellable $cancellable      = Pointer,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gsize ($c, $b) = resolve-uint64($count, $bytes_read);
    clear_error;
    my $rc = so g_input_stream_read_all(
      $!is,
      $buffer,
      $count,
      $bytes_read,
      $cancellable,
      $error
    );
    set_error($error);
    $rc;
  }

  multi method read_all_async (
    Pointer $buffer,
    Int() $count,
    Int() $io_priority,
    &callback,
    gpointer $user_data       = Pointer,
    GCancellable $cancellable = Pointer
  ) {
    samewith(
      $buffer,
      $count,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method read_all_async (
    Pointer $buffer,
    Int() $count,
    Int() $io_priority,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my int32 $io = resolve-int($io_priority);
    my gsize $c = resolve-uint64($count);
    g_input_stream_read_all_async(
      $!is,
      $buffer,
      $c,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_all_finish (
    GAsyncResult() $result,
    Int() $bytes_read,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gsize $b = resolve-uint64($bytes_read);
    clear_error;
    my $rc = so g_input_stream_read_all_finish($!is, $result, $b, $error);
    set_error($error);
    $rc;
  }

  multi method read_async (
    Pointer $buffer,
    Int() $count,
    Int() $io_priority,
    &callback,
    gpointer $user_data       = Pointer,
    GCancellable $cancellable = Pointer
  ) {
    samewith(
      $buffer,
      $count,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method read_async (
    Pointer $buffer,
    Int() $count,
    Int() $io_priority,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data
  ) {
    my gsize $c = resolve-uint64($count);
    my guint $io = resolve-uint($io_priority);
    g_input_stream_read_async(
      $!is,
      $buffer,
      $c,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_bytes (
    Int() $count,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gsize $c = resolve-uint64($count);
    clear_error;
    my $rc = so g_input_stream_read_bytes($!is, $c, $cancellable, $error);
    set_error($error);
    $rc;
  }

  multi method read_bytes_async (
    Int() $count,
    Int() $io_priority,
    &callback,
    gpointer $user_data       = Pointer,
    GCancellable $cancellable = Pointer
  ) {
    samewith($count, $io_priority, $cancellable, &callback, $user_data);
  }
  multi method read_bytes_async (
    Int() $count,
    Int() $io_priority,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data
  ) {
    my uint32 $io = resolve-uint($io_priority);
    my gsize $c = resolve-uint64($count);
    g_input_stream_read_bytes_async(
      $!is,
      $c,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_bytes_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so g_input_stream_read_bytes_finish($!is, $result, $error);
    set_error($error);
    $rc;
  }

  method read_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = so g_input_stream_read_finish($!is, $result, $error);
    set_error($error);
    $rc;
  }

  method set_pending (CArray[Pointer[GError]] $error = gerror()) {
    clear_error;
    my $rc = so g_input_stream_set_pending($!is, $error);
    set_error($error);
    $rc;
  }

  method skip (
    Int() $count,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gsize $c = resolve-uint64($count);
    clear_error;
    my $rc = g_input_stream_skip($!is, $c, $cancellable, $error);
    set_error($rc);
    $rc;
  }

  multi method skip_async (
    Int() $count,
    Int() $io_priority,
    &callback,
    gpointer $user_data       = Pointer,
    GCancellable $cancellable = Pointer
  ) {
    samewith($count, $io_priority, $cancellable, &callback, $user_data);
  }
  multi method skip_async (
    Int() $count,
    Int() $io_priority,
    GCancellable $cancellable,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my uint32 $io = resolve-uint($io_priority);
    my gsize $c = resolve-uint64($count);
    g_input_stream_skip_async(
      $!is,
      $c,
      $io,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method skip_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my $rc = g_input_stream_skip_finish($!is, $result, $error);
    set_error($error);
    $rc;
  }

}
