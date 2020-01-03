use v6.c;

use Method::Also;

use GLib::Raw::Types;

use GIO::Raw::BufferedOutputStream;

use GIO::FilterOutputStream;

use GLib::Roles::Object;
use GIO::Roles::Seekable;

our subset BufferedOutputStreamAncestry is export of Mu
  where GBufferedOutputStream | GSeekable | FilterOutputStreamAncestry;

class GIO::BufferedOutputStream is GIO::FilterOutputStream {
  also does GIO::Roles::Seekable;

  has GBufferedOutputStream $!bos is implementor;

  submethod BUILD (:$buffered-stream) {
    given $buffered-stream {
      when BufferedOutputStreamAncestry {
        self.setBufferedOutputStream($_);
      }

      when GIO::BufferedOutputStream {
      }

      default {
      }
    }
  }

  method setBufferedOutputStream (BufferedOutputStreamAncestry $_) {
    my $to-parent;

    $!bos = do {
      when GBufferedOutputStream {
        $to-parent = cast(GFilterOutputStream, $_);
        $_;
      }

      when GSeekable {
        $to-parent = cast(GFilterOutputStream, $_);
        $!s = $_;
        cast(GBufferedOutputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GBufferedOutputStream, $_);
      }
    }
    self.roleInit-Seekable unless $!s;
    self.setFilterOutputStream($to-parent);
  }

  method GLib::Raw::Types::GBufferedOutputStream
    is also<GBufferedOutputStream>
  { $!bos }

  proto method new (|)
  { * }

  multi method new (BufferedOutputStreamAncestry $buffered-stream) {
    self.bless( :$buffered-stream );
  }
  multi method new (GIO::OutputStream $base) {
    self.bless(
      buffered-stream => g_buffered_output_stream_new($base.GOutputStream)
    );
  }

  method new_sized (GOutputStream() $base, Int() $size) is also<new-sized> {
    my gsize $s = $size;

    self.bless(
      buffered-stream => g_buffered_output_stream_new_sized($base, $s)
    );
  }

  method auto_grow is rw is also<auto-grow> {
    Proxy.new(
      FETCH => sub ($) {
        so g_buffered_output_stream_get_auto_grow($!bos);
      },
      STORE => sub ($, Int() $auto_grow is copy) {
        my gboolean $a = $auto_grow;

        g_buffered_output_stream_set_auto_grow($!bos, $a);
      }
    );
  }

  method buffer_size is rw is also<buffer-size> {
    Proxy.new(
      FETCH => sub ($) {
        g_buffered_output_stream_get_buffer_size($!bos);
      },
      STORE => sub ($, Int() $size is copy) {
        my gsize $s = $size;

        g_buffered_output_stream_set_buffer_size($!bos, $s);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_buffered_output_stream_get_type, $n, $t );
  }

}
