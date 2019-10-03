use NativeCall;

use Test;

use GTK::Compat::Types;

use GIO::Raw::BufferedInputStream;
use GIO::Raw::FilterInputStream;
use GIO::Raw::InputStream;
use GIO::Raw::MemoryInputStream;

my $s = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVXYZ';
my $b = $s.encode('ISO-8859-1');

my $base = g_memory_input_stream_new_from_data($b, -1, Pointer);
my $in   = g_buffered_input_stream_new($base);

my $fis = cast(GFilterInputStream, $in);
g_filter_input_stream_set_close_base_stream($fis, 0);

my $ea = gerror;
my $ins = cast(GInputStream, $in);
my $bin = cast(GInputStream, $base);

say g_filter_input_stream_get_close_base_stream($fis);
say g_input_stream_close($ins, GCancellable, $ea);
say g_input_stream_is_closed($bin);
