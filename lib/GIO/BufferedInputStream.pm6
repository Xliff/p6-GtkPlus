use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::BufferedInputStream;

use GIO::FilterInputStream;

use GIO::Roles::Seekable;

our subset BufferedInputStreamAncestry is export of Mu
  where GBufferedInputStream | GSeekable | FilterInputStreamAncestry;

class GIO::BufferedInputStream is GIO::FilterInputStream {
  also does GIO::Roles::Seekable;

  has GBufferedInputStream $!bis;

  submethod BUILD (:$buffered-stream) {
    given $buffered-stream {
      when BufferedInputStreamAncestry {
        self.setBufferedInputStream($_);
      }

      when GIO::BufferedInputStream {
      }

      default {
      }
    }
  }

  method setBufferedInputStream (BufferedInputStreamAncestry $_) {
    my $to-parent;

    $!bis = do {
      when GBufferedInputStream {
        $to-parent = cast(GFilterInputStream, $_);
        $_;
      }

      when GSeekable {
        $to-parent = cast(GFilterInputStream, $_);
        $!s = $_;
        cast(GBufferedInputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GBufferedInputStream, $_);
      }
    }
    self.roleInit-Seekable unless $!s;
    self.setFilterInputStream($to-parent);
  }

  method GTK::Compat::Types::GBufferedInputStream
  { $!bis }

  proto method new (|)
  { * }

  multi method new (BufferedInputStreamAncestry $buffered-stream) {
    self.bless( :$buffered-stream );
  }
  multi method new (GIO::InputStream $base) {
    self.bless(
      buffered-stream => g_buffered_input_stream_new($base.GInputStream)
    );
  }

  method new_sized (GInputStream() $base, Int() $size) {
    my gsize $s = $size;

    self.bless(
      buffered-stream => g_buffered_input_stream_new_sized($base, $size)
    );
  }

  method fill (
    Int() $count,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gsize $c = $count;

    clear_error;
    my $rv = g_buffered_input_stream_fill($!bis, $c, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method fill_async (
    Int() $count,
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  ) {
    my gsize $c = $count;
    my gint $i = $io_priority;

    g_buffered_input_stream_fill_async(
      $!bis,
      $c,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  method fill_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_buffered_input_stream_fill_finish($!bis, $result, $error);
    set_error($error);
    $rv;
  }

  method get_available {
    g_buffered_input_stream_get_available($!bis);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_buffered_input_stream_get_type, $n, $t );
  }

  method peek (Pointer $buffer, Int() $offset, Int() $count) {
    my gsize ($o, $c) = ($offset, $count);

    g_buffered_input_stream_peek($!bis, $buffer, $offset, $count);
  }

  method peek_buffer (Int() $count) {
    my gsize $c = $count;

    g_buffered_input_stream_peek_buffer($!bis, $c);
  }

  method read_byte (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_buffered_input_stream_read_byte($!bis, $cancellable, $error);
    set_error($error);
    $rv;
  }

}
