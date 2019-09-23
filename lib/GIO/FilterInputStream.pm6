use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::FilterInputStream;

use GIO::InputStream;

our subset FilterInputStreamAncestry is export of Mu
  where GFilterInputStream | GInputStream;

class GIO::FilterInputStream is GIO::InputStream {
  has GFilterInputStream $!fis;

  submethod BUILD (:$filter-stream) {
    given $filter-stream {
      when FilterInputStreamAncestry {
        self.setFilterInputStream($filter-stream);
      }

      when GIO::FilterInputStream {
      }

      default {
      }
    }
  }

  method setFilterInputStream (FilterInputStreamAncestry $_) {
    my $to-parent;

    $!fis = do {
      when GFilterInputStream {
        $to-parent = cast(GInputStream, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GFilterInputStream, $_);
      }
    };
    self.setInputStream($to-parent);
  }

  method GTK::Compat::Types::GFilterInputStream
    is also<GFilterInputStream>
  { $!fis }

  proto method new(|)
  { * }

  multi method new (GFilterInputStream $filter-stream) {
    self.bless( :$filter-stream );
  }

  method close_base_stream is rw is also<close-base-stream> {
    Proxy.new(
      FETCH => sub ($) {
        so g_filter_input_stream_get_close_base_stream($!fis);
      },
      STORE => sub ($, Int() $close_base is copy) {
        my gboolean $c  = $close_base;

        g_filter_input_stream_set_close_base_stream($!fis, $c);
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
    my $bs = g_filter_input_stream_get_base_stream($!fis);

    $bs ??
      ( $raw ?? $bs !! GIO::InputStream.new($bs) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_filter_input_stream_get_type, $n, $t );
  }

}
