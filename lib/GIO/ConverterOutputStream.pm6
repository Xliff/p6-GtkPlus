use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GIO::FilterOutputStream;

use GIO::Roles::Converter;
use GIO::Roles::PollableOutputStream;

our subset ConverterOutputStreamAncestry is export of Mu
  where GConverterOutputStream     | GPollableOutputStream |
        FilterOutputStreamAncestry;

class GIO::ConverterOutputStream is GIO::FilterOutputStream {
  also does GIO::Roles::Converter;
  also does GIO::Roles::PollableOutputStream;

  has GConverterOutputStream $!cos;

  submethod BUILD (:$convert-stream) {
    given $convert-stream {
      when ConverterOutputStreamAncestry {
        self.setConverterOutputStream($convert-stream);
      }

      when GIO::ConverterOutputStream {
      }

      default {
      }
    }
  }

  method setConverterOutputStream(ConverterOutputStreamAncestry $_) {
    my $to-parent;

    $!cos = do {
      when GConverterOutputStream {
        $to-parent = cast(GFilterOutputStream, $_);
        $_
      }

      when GPollableOutputStream {
        $to-parent = cast(GFilterOutputStream, $_);
        $!pos = $_;
        cast(GConverterOutputStream, $_);
      }

      default {
        $to-parent = $_;
        cast(GConverterOutputStream, $_);
      }
    }
    self.roleInit-PollableOutputStream unless $!pos;
    self.setFilterOutputStream($to-parent);
  }

  method GTK::Compat::Types::GConverterOutputStream
    is also<GConverterOutputStream>
  { $!cos }

  proto method new (|)
  { * }

  multi method new (ConverterOutputStreamAncestry $convert-stream) {
    self.bless( :$convert-stream );
  }
  multi method new (GOutputStream() $base, GConverter() $converter) {
    self.bless(
      convert-stream => g_converter_output_stream_new($base, $converter)
    );
  }

  method get_converter (:$raw = False) is also<get-converter> {
    my $c = g_converter_output_stream_get_converter($!cos);

    $c ??
      ( $raw ?? $c !! GIO::Roles::Converter.new-converter-obj($c) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name; &g_converter_output_stream_get_type, $n, $t );
  }

}

sub g_converter_output_stream_get_converter (
  GConverterOutputStream $converter_stream
)
  returns GConverter
  is native(gio)
  is export
{ * }

sub g_converter_output_stream_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_converter_output_stream_new (
  GOutputStream $base_stream,
  GConverter $converter
)
  returns GConverterOutputStream
  is native(gio)
  is export
{ * }
