use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GIO::FilterInputStream;

use GIO::Roles::Converter;
use GIO::Roles::PollableInputStream;

our subset ConverterInputStreamAncestry is export of Mu
  where GConverterInputStream     | GPollableInputStream |
        FilterInputStreamAncestry;

class GIO::ConverterInputStream is GIO::FilterInputStream {
  also does GIO::Roles::Converter;
  also does GIO::Roles::PollableInputStream;

  has GConverterInputStream $!cis;

  submethod BUILD (:$convert-stream) {
    given $convert-stream {
      when ConverterInputStreamAncestry {
        self.setConverterInputStream($convert-stream);
      }

      when GIO::ConverterInputStream {
      }

      default {
      }
    }
  }

  method setConverterInputStream(ConverterInputStreamAncestry $_) {
    my $to-parent;

    $!cis = do {
      when GConverterInputStream {
        $to-parent = cast(GFilterInputStream, $_);
        $_
      }

      when GPollableInputStream {
        $to-parent = cast(GFilterInputStream, $_);
        $!pis = $_;
        cast(GConverterInputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GConverterInputStream, $_);
      }
    }
    self.roleInit-PollableInputStream unless $!pis;
    self.setFilterInputStream($to-parent);
  }

  method GTK::Compat::Types::GConverterInputStream
    is also<GConverterInputStream>
  { $!cis }

  proto method new (|)
  { * }

  multi method new (ConverterInputStreamAncestry $convert-stream) {
    self.bless( :$convert-stream );
  }
  multi method new (GInputStream() $base, GConverter() $converter) {
    self.bless(
      convert-stream => g_converter_input_stream_new($base, $converter)
    );
  }

  method get_converter (:$raw = False) is also<get-converter> {
    my $c = g_converter_input_stream_get_converter($!cis);

    $c ??
      ( $raw ?? $c !! GIO::Roles::Converter.new-converter-obj($c) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name; &g_converter_input_stream_get_type, $n, $t );
  }

}

sub g_converter_input_stream_get_converter (
  GConverterInputStream $converter_stream
)
  returns GConverter
  is native(gio)
  is export
{ * }

sub g_converter_input_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_converter_input_stream_new (
  GInputStream $base_stream,
  GConverter $converter
)
  returns GConverterInputStream
  is native(gio)
  is export
{ * }
