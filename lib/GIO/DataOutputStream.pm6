use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::DataOutputStream;

use GIO::FilterOutputStream;

our subset DataOutputStreamAncestry is export of Mu
  where GDataOutputStream | FilterOutputStreamAncestry;

class GIO::DataOutputStream is GIO::FilterOutputStream {
  has GDataOutputStream $!dos is implementor;

  submethod BUILD (:$data-stream) {
    given $data-stream {
      when DataOutputStreamAncestry {
        my $to-parent;

        $!dos = do {
          when GDataOutputStream {
            $to-parent = cast(GFilterOutputStream, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GDataOutputStream, $_);
          }
        }
        self.setFilterOutputStream($to-parent);
      }
    }
  }

  method GTK::Compat::Types::GDataOutputStream
    is also<GDataOutputStream>
  { $!dos }

  multi method new (GDataOutputStream $data-stream) {
    self.bless( :$data-stream );
  }
  multi method new (GOutputStream() $base) {
    my $d = g_data_output_stream_new($base);

    $d ?? self.bless( data-stream => $d ) !! Nil;
  }

  method byte_order is rw is also<byte-order> {
    Proxy.new(
      FETCH => sub ($) {
        GDataStreamByteOrderEnum( g_data_output_stream_get_byte_order($!dos) );
      },
      STORE => sub ($, Int() $order is copy) {
        my GDataStreamByteOrder $o = $order;

        g_data_output_stream_set_byte_order($!dos, $o);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_data_output_stream_get_type, $n, $t );
  }

  method put_byte (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-byte>
  {
    my guint8 $d = $data;

    clear_error;
    my $rv = so g_data_output_stream_put_byte($!dos, $d, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method put_int16 (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-int16>
  {
    my gint16 $d = $data;

    clear_error;
    my $rv = so g_data_output_stream_put_int16($!dos, $d, $cancellable, $error);
    set_error($error);
    $rv;
  }

  method put_int32 (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-int32>
  {
    my gint32 $d = $data;

    clear_error;
    my $rv = so g_data_output_stream_put_int32(
      $!dos,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method put_int64 (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-int64>
  {
    my gint64 $d = $data;

    clear_error;
    my $rv = so g_data_output_stream_put_int64(
      $!dos,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method put_string (
    Str() $str,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-string>
  {
    clear_error;
    my $rv = so g_data_output_stream_put_string(
      $!dos,
      $str,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method put_uint16 (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-uint16>
  {
    my guint16 $d = $data;

    clear_error;
    my $rv = so  g_data_output_stream_put_uint16(
      $!dos,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method put_uint32 (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-uint32>
  {
    my guint32 $d = $data;

    clear_error;
    my $rv = so g_data_output_stream_put_uint32(
      $!dos,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

  method put_uint64 (
    Int() $data,
    GCancellable() $cancellable    = GCancellable,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<put-uint64>
  {
    my guint64 $d = $data;

    clear_error;
    my $rv = so g_data_output_stream_put_uint64(
      $!dos,
      $d,
      $cancellable,
      $error
    );
    set_error($error);
    $rv;
  }

}
