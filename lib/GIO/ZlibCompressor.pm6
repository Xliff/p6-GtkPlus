use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GTK::Roles::Properties;
use GIO::Roles::Converter;

class GIO::ZlibCompressor {
  also does GTK::Roles::Properties;
  also does GIO::Roles::Converter;

  has GZlibCompressor $!zc is implementor;

  submethod BUILD (:$compressor) {
    $!zc = $compressor;

    self.roleInit-Object;
    self.roleInit-Converter;
  }

  method GTK::Compat::Types::GZlibCompressor
    is also<GZlibCompressor>
  { $!zc }

  method new (Int() $level) {
    my gint $l = $level;

    self.bless( compressor => g_zlib_compressor_new($!zc, $l) );
  }

  method file_info is rw is also<file-info> {
    Proxy.new(
      FETCH => sub ($) {
        g_zlib_compressor_get_file_info($!zc);
      },
      STORE => sub ($, $file_info is copy) {
        g_zlib_compressor_set_file_info($!zc, $file_info);
      }
    );
  }

  # Type: GZlibCompressorFormat
  method format is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('format', $gv)
        );
        GZlibCompressorFormatEnum( $gv.uint )
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('format', $gv);
      }
    );
  }

  # Type: gint
  method level is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('level', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('level', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_zlib_compressor_get_type, $n, $t );
  }

}


sub g_zlib_compressor_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_zlib_compressor_new (GZlibCompressorFormat $format, gint $level)
  returns GZlibCompressor
  is native(gio)
  is export
{ * }

sub g_zlib_compressor_get_file_info (GZlibCompressor $compressor)
  returns GFileInfo
  is native(gio)
  is export
{ * }

sub g_zlib_compressor_set_file_info (
  GZlibCompressor $compressor,
  GFileInfo $file_info
)
  is native(gio)
  is export
{ * }
