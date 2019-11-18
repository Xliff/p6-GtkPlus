use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::DataInputStream;

use GIO::BufferedInputStream;
use GIO::Roles::Seekable;

our subset DataInputStreamAncestry is export of Mu
  where GDataInputStream | BufferedInputStreamAncestry;

class GIO::DataInputStream is GIO::BufferedInputStream {
  also does GIO::Roles::Seekable;

  has GDataInputStream $!dis is implementor;

  submethod BUILD (:$data-stream) {
    given $data-stream {
      when DataInputStreamAncestry {
        my $to-parent;

        $!dis = do {
          when GDataInputStream {
            $to-parent = cast(GBufferedInputStream, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GDataInputStream, $_);
          }
        }
        self.setBufferedInputStream($to-parent);
      }

      when GIO::DataInputStream {
      }

      default {
      }
    }
  }

  method GTK::Compat::Types::GDataInputStream
    is also<GDataInputStream>
  { $!dis }

  # Prevent descent to base new if signature match.
  proto method new (|)
  { * }

  multi method new (GDataInputStream $data-stream) {
    self.bless( :$data-stream );
  }
  multi method new (GInputStream() $base) {
    self.bless( data-stream => g_data_input_stream_new($base) );
  }

  method byte_order is rw is also<byte-order> {
    Proxy.new(
      FETCH => sub ($) {
        GDataStreamByteOrderEnum( g_data_input_stream_get_byte_order($!dis) );
      },
      STORE => sub ($, Int() $order is copy) {
        my GDataStreamByteOrderEnum $o = $order;

        g_data_input_stream_set_byte_order($!dis, $o);
      }
    );
  }

  method newline_type is rw is also<newline-type> {
    Proxy.new(
      FETCH => sub ($) {
        GDataStreamNewlineTypeEnum(
          g_data_input_stream_get_newline_type($!dis)
        );
      },
      STORE => sub ($, Int() $type is copy) {
        my GDataStreamNewlineType $t = $type;

        g_data_input_stream_set_newline_type($!dis, $t);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_data_input_stream_get_type, $n, $t );
  }

  method read_byte (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-byte>
  {
    clear_error;
    my $rv = g_data_input_stream_read_byte($!dis, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method read_int16 (
    GCancellable() $cancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-int16>
  {
    clear_error;
    my $rv = g_data_input_stream_read_int16($!dis, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method read_int32 (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-int32>
  {
    clear_error;
    my $rv = g_data_input_stream_read_int32($!dis, $cancellable, $error);
    set_error($error);
    $rv ;
  }

  method read_int64 (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-int64>
  {
    clear_error;
    my $rv = g_data_input_stream_read_int64($!dis, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method read_line (|)
      is also<read-line>
  { * }

  multi method read_line (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($, $cancellable, $error, :$all);
  }
  multi method read_line (
    $length is rw,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = g_data_input_stream_read_line($!dis, $l, $cancellable, $error);
    set_error($error);
    $length = $l;

    $all ?? $rv !! ($rv, $length);
  }

  method read_line_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<read-line-async>
  {
    my gint $i = $io_priority;

    g_data_input_stream_read_line_async(
      $!dis,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method read_line_finish (|)
      is also<read-line-finish>
  { * }

  multi method read_line_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($result, $, $error);
  }
  multi method read_line_finish (
    GAsyncResult() $result,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = g_data_input_stream_read_line_finish($!dis, $result, $l, $error);
    set_error($error);
    $length = $l;

    $all ?? $rv !! ($rv, $length);
  }

  proto method read_line_finish_utf8 (|)
      is also<read-line-finish-utf8>
  { * }

  multi method read_line_finish_utf8 (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($result, $, $error, :$all);
  }
  multi method read_line_finish_utf8 (
    GAsyncResult() $result,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = g_data_input_stream_read_line_finish_utf8($!dis, $result, $length, $error);
    set_error($error);
    $length = $l;

    $all ?? $rv !! ($rv, $length);
  }

  proto method read_line_utf8 (|)
      is also<read-line-utf8>
  { * }

  multi method read_line_utf8 (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($cancellable, $, $error, :$all);
  }
  multi method read_line_utf8 (
    $length is rw,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False;
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = g_data_input_stream_read_line_utf8(
      $!dis,
      $l,
      $cancellable,
      $error
    );
    set_error($error);
    $length = $l;

    $all ?? $rv !! ($rv, $length);
  }

  method read_uint16 (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-uint16>
  {
    clear_error;
    my $rv = g_data_input_stream_read_uint16($!dis, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method read_uint32 (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-uint32>
  {
    clear_error;
    my $rv = g_data_input_stream_read_uint32($!dis, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method read_uint64 (
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<read-uint64>
  {
    clear_error;
    my $rv = g_data_input_stream_read_uint64($!dis, $cancellable, $error);
    set_error($error);
    $rv;
  }

  proto method read_upto (|)
      is also<read-upto>
  { * }

  multi method read_upto (
    Str() $stop_chars,
    Int() $stop_chars_len,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($stop_chars, $stop_chars_len, $, $cancellable, $error, :$all);
  }
  multi method read_upto (
    Str() $stop_chars,
    Int() $stop_chars_len,
    $length,
    GCancellable() $cancellable = GCancellable,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gssize $stl = $stop_chars_len;
    my gsize $l = 0;

    clear_error;
    my $rv = g_data_input_stream_read_upto(
      $!dis,
      $stop_chars,
      $stl,
      $l,
      $cancellable,
      $error
    );
    set_error($error);
    $length = $l;

    $all ?? $rv !! ($rv, $length);
  }

  method read_upto_async (
    Str() $stop_chars,
    Int() $stop_chars_len,
    Int() $io_priority,
    GCancellable $cancellable,
    GAsyncReadyCallback $callback,
    gpointer $user_data = gerror
  )
    is also<read-upto-async>
  {
    my gssize $stl = $stop_chars_len;
    my gint $i = $io_priority,

    g_data_input_stream_read_upto_async(
      $!dis,
      $stop_chars,
      $stl,
      $i,
      $cancellable,
      $callback,
      $user_data
    );
  }

  proto method read_upto_finish (|)
      is also<read-upto-finish>
  { * }

  multi method read_upto_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    samewith($result, $, $error, :$all);
  }
  multi method read_upto_finish (
    GAsyncResult() $result,
    $length is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my gsize $l = 0;

    clear_error;
    my $rv = g_data_input_stream_read_upto_finish($!dis, $result, $l, $error);
    set_error($error);
    $length = $l;

    $all ?? $rv !! ($rv, $length);
  }

}
