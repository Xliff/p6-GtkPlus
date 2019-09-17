use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::OutputStream;

class GIO::OutputStream {
  has GOutputStream $!os;

  submethod BUILD (:$output-stream) {
    self.setOutputStream($output-stream) if $output-stream;
  }

  method setOutputStream (GOutputStream $output-stream) {
    $!os = $output-stream;
  }

  method GTK::Compat::Types::GOutputStream
    is also<GOutputStream>
  { $!os }

  method clear_pending is also<clear-pending> {
    g_output_stream_clear_pending($!os);
  }

  method close (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_output_stream_close($!os, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method close_async (
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<close-async>
  {
    my gint $io = $io_priority;

    g_output_stream_close_async($!os, $io, $cancellable, $callback, $user_data);
  }

  method close_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<close-finish>
  {
    clear_error;
    my $rc = g_output_stream_close_finish($!os, $result, $error);
    set_error($error);
    $rc;
  }

  method flush (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_output_stream_flush($!os, $cancellable, $error);
    set_error($error);
    $rc;
  }

  method flush_async (
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<flush-async>
  {
    my gint $io = $io_priority;

    g_output_stream_flush_async($!os, $io, $cancellable, $callback, $user_data);
  }

  method flush_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<flush-finish>
  {
    clear_error;
    my $rc = g_output_stream_flush_finish($!os, $result, $error);
    set_error($error);
    $rc;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_output_stream_get_type, $n, $t );
  }

  method has_pending is also<has-pending> {
    so g_output_stream_has_pending($!os);
  }

  method is_closed is also<is-closed> {
    so g_output_stream_is_closed($!os);
  }

  method is_closing is also<is-closing> {
    so g_output_stream_is_closing($!os);
  }

  method set_pending (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-pending>
  {
    clear_error;
    my $rc = g_output_stream_set_pending($!os, $error);
    set_error($error);
    $rc;
  }

  method splice (
    GInputStream() $source,
    Int() $flags,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my GOutputStreamSpliceFlags $f = $flags;

    g_output_stream_splice($!os, $source, $f, $cancellable, $error);
  }

  method splice_async (
    GInputStream() $source,
    Int() $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data
  )
    is also<splice-async>
  {
    my gint $io = $io_priority;
    my GOutputStreamSpliceFlags $f = $flags;

    g_output_stream_splice_async(
      $!os,
      $source,
      $f,
      $io,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method splice_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<splice-finish>
  {
    g_output_stream_splice_finish($!os, $result, $error);
  }

  method write (
    Pointer $buffer,
    Int() $count,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $c = $count;

    clear_error;
    my $rv = g_output_stream_write($!os, $buffer, $c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method write_all (
    Pointer $buffer,
    Int() $count,
    $bytes_written is rw,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  )
    is also<write-all>
  {
    my gsize ($c, $bw) = ($count, 0);

    clear_error;
    my $rc = g_output_stream_write_all(
      $!os,
      $buffer,
      $c,
      $bw,
      $cancellable,
      $error
    );
    set_error($error);
    $bytes_written = $rc ?? $bw !! Nil;
    $all ?? $bytes_written !! ($bytes_written, $rc);
  }

  method write_all_async (
    Pointer $buffer,
    Int() $count,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<write-all-async>
  {
    my gint $io = $io_priority;
    my gsize $c = $count;

    g_output_stream_write_all_async(
      $!os,
      $buffer,
      $c,
      $io,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method write_all_finish (
    GAsyncResult() $result,
    $bytes_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  )
    is also<write-all-finish>
  {
    my gsize $bw = 0;

    clear_error;
    my $rc = g_output_stream_write_all_finish($!os, $result, $bw, $error);
    set_error($error);
    $bytes_written = $rc ?? $bw !! Nil;
    $all ?? $bytes_written !! ($bytes_written, $rc);
  }

  method write_async (
    Pointer $buffer,
    Int() $count,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<write-async>
  {
    my gint $io = $io_priority;
    my gsize $c = $count;

    g_output_stream_write_async(
      $!os,
      $buffer,
      $c,
      $io,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method write_bytes (
    GBytes() $bytes,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<write-bytes>
  {
    clear_error;
    my $rv = g_output_stream_write_bytes($!os, $bytes, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method write_bytes_async (
    GBytes() $bytes,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<write-bytes-async>
  {
    my gint $io = $io_priority;

    g_output_stream_write_bytes_async(
      $!os,
      $bytes,
      $io,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method write_bytes_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<write-bytes-finish>
  {
    clear_error;
    my $rv = g_output_stream_write_bytes_finish($!os, $result, $error);
    set_error($error);
    $rv;
  }

  method write_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<write-finish>
  {
    clear_error;
    my $rv = g_output_stream_write_finish($!os, $result, $error);
    set_error($error);
    $rv;
  }

  method writev (
    GOutputVector() $vectors,
    Int() $n_vectors,
    $bytes_written is rw,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False;
  ) {
    my gsize ($nv, $bw) = ($n_vectors, 0);

    my $rv = g_output_stream_writev(
      $!os,
      $vectors,
      $nv,
      $bw,
      $cancellable,
      $error
    );
    $bytes_written = $rv ?? $bw !! Nil;
    $all ?? $bytes_written !! ($bytes_written, $rv);
  }

  method writev_all (
    GOutputVector() $vectors,
    Int() $n_vectors,
    $bytes_written is rw,
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  )
    is also<writev-all>
  {
    my gsize ($nv, $bw) = ($n_vectors, 0);

    clear_error;
    my $rv = g_output_stream_writev_all(
      $!os,
      $vectors,
      $nv,
      $bw,
      $cancellable,
      $error
    );
    set_error($error);
    $bytes_written = $rv ?? $bw !! Nil;
    $all ?? $bytes_written !! ($bytes_written, $rv);
  }

  method writev_all_async (
    GOutputVector() $vectors,
    Int() $n_vectors,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<writev-all-async>
  {
    my gint $io = $io_priority;
    my gsize $nv = $n_vectors;

    g_output_stream_writev_all_async(
      $!os,
      $vectors,
      $nv,
      $io,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method writev_all_finish (
    GAsyncResult() $result,
    $bytes_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  )
    is also<writev-all-finish>
  {
    my gsize $bw = 0;

    clear_error;
    my $rv = g_output_stream_writev_all_finish($!os, $result, $bw, $error);
    set_error($error);
    $bytes_written = $rv ?? $bw !! Nil;
    $all ?? $bytes_written !! ($bytes_written, $rv);
  }

  method writev_async (
    GOutputVector() $vectors,
    Int() $n_vectors,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<writev-async>
  {
    my gint $io = $io_priority;
    my gsize $nv = $n_vectors;

    g_output_stream_writev_async(
      $!os,
      $vectors,
      $nv,
      $io,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method writev_finish (
    GAsyncResult() $result,
    Int() $bytes_written,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<writev-finish>
  {
    my gsize $bw = $bytes_written;

    clear_error;
    my $rv = g_output_stream_writev_finish($!os, $result, $bw, $error);
    set_error($error);
    $rv;
  }

}
