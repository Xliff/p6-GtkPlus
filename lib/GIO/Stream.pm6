use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::Stream;

use GTK::Compat::InputStream;

class GIO::Stream {
  has GIOStream $!ios;

  submethod BUILD (:$stream) {
    self.setStream($stream) if $stream;
  }

  method setStream (GIOStream $stream) {
    $!ios = $stream
  }

  method GTK::Compat::Types::GIOStream
    is also<GIOStream>
  { $!ios }

  method clear_pending is also<clear-pending> {
    g_io_stream_clear_pending($!ios);
  }

  method close (
    GCancellable $cancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_io_stream_close($!ios, $cancellable, $error);
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

    g_io_stream_close_async($!ios, $io, $cancellable, $callback, $user_data);
  }

  method close_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<close-finish>
  {
    clear_error;
    my $rc = so g_io_stream_close_finish($!ios, $result, $error);
    set_error($error);
    $rc;
  }

  method get_input_stream (:$raw = False)
    is also<get-input-stream>
  {
    my $is = g_io_stream_get_input_stream($!ios);

    $is ??
      ( $raw ?? $is !! GTK::Compat::InputStream.new($is) )
      !!
      Nil
  }

  method get_output_stream (:$raw = False)
    is also<get-output-stream>
  {
    my $os = g_io_stream_get_output_stream($!ios);

    $os ??
      ( $raw ?? $os !! GIO::OutputStream.new($os) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_io_stream_get_type, $n, $t );
  }

  method has_pending is also<has-pending> {
    so g_io_stream_has_pending($!ios);
  }

  method is_closed is also<is-closed> {
    so g_io_stream_is_closed($!ios);
  }

  method set_pending (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-pending>
  {
    g_io_stream_set_pending($!ios, $error);
  }

  method splice_async (
    GIOStream() $stream2,
    Int() $flags,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<splice-async>
  {
    my gint $io = $io_priority;
    my GIOStreamSpliceFlags $f = $flags;

    g_io_stream_splice_async(
      $!ios,
      $stream2,
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
    clear_error;
    my $rc = so g_io_stream_splice_finish($result, $error);
    set_error($error);
    $rc;
  }

}
