use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GIO::Raw::FilterOutputStream;

use GIO::OutputStream;

our subset FilterOutputStreamAncestry is export of Mu
  where GFilterOutputStream | GOutputStream;

class GIO::FilterOutputStream is GIO::OutputStream {
  has GFilterOutputStream $!fis is implementor;

  submethod BUILD (:$filter-stream) {
    given $filter-stream {
      when FilterOutputStreamAncestry {
        self.setFilterOutputStream($filter-stream);
      }

      when GIO::FilterOutputStream {
      }

      default {
      }
    }
  }

  method setFilterOutputStream (FilterOutputStreamAncestry $_) {
    my $to-parent;

    $!fis = do {
      when GFilterOutputStream {
        $to-parent = cast(GOutputStream, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GFilterOutputStream, $_);
      }
    };
    self.setOutputStream($to-parent);
  }

  method GLib::Raw::Types::GFilterOutputStream
    is also<GFilterOutputStream>
  { $!fis }

  proto method new(|)
  { * }

  multi method new (GFilterOutputStream $filter-stream) {
    self.bless( :$filter-stream );
  }

  method close_base_stream is rw is also<close-base-stream> {
    Proxy.new(
      FETCH => sub ($) {
        so g_filter_output_stream_get_close_base_stream($!fis);
      },
      STORE => sub ($, Int() $close_base is copy) {
        my gboolean $c  = $close_base;

        g_filter_output_stream_set_close_base_stream($!fis, $c);
      }
    );
  }


  method get_base_stream (:$raw = False)
    is also<
      get-base-stream
      base_stream
      base-stream
    >
  {
    my $bs = g_filter_output_stream_get_base_stream($!fis);

    $bs ??
      ( $raw ?? $bs !! GIO::OutputStream.new($bs) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_filter_output_stream_get_type, $n, $t );
  }

}
