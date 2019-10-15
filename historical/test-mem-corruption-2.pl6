use v6.c;

use NativeCall;

#use GTK::Compat::Types;

class GSeekable          is repr<CPointer> { }
class GInputStream       is repr<CPointer> { }
class GMemoryInputStream is repr<CPointer> { }
class GDataInputStream   is repr<CPointer> { }

constant gsize     := uint64;
constant guint     := uint32;
constant GSeekType := guint;

constant gio        = 'gio-2.0',v0;

our enum GSeekTypeEnum is export <
  G_SEEK_CUR
  G_SEEK_SET
  G_SEEK_END
>;

class GError is repr<CStruct> {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $.message;
}

my $data = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVXYZ';

sub result-cb ($, $r, $) {
  CATCH { default { .message.say } }

  $result = GIO::Task.new($r).ref;
}

for ^100 {
  my $base = g_memory_input_stream_new();
  my $in   = g_data_input_stream_new-sized($base, 5);

  is g_buffered_input_stream_read_byte($in), $_.ord, "Char is {$_}"
    for <a b c>;

  for <7 k 10 v 20 Q>.rotor(2) -> ($s, $l) {
    is g_input_stream_skip_async (in, $s, G_PRIORITY_DEFAULT), $s, 'Skip OK';
    is  $in.read-byte, $l.ord,  "Next byte read was a '{$l}'";
    nok $ERROR,                 'No read error occurred.';
  }

}

sub g_data_input_stream_read_line (
  GDataInputStream $stream,
  gsize $length is rw,
  Pointer $cancellable,
  CArray[Pointer[GError]] $error
)
  returns str
  is native(gio)
  is export
{ * }

sub g_data_input_stream_new (GInputStream $base_stream)
  returns GDataInputStream
  is native(gio)
  is export
{ * }

sub g_seekable_seek (
  GSeekable $seekable,
  uint64 $offset,
  GSeekType $type,
  Pointer $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_new ()
  returns GMemoryInputStream
  is native(gio)
  is export
{ * }

sub g_memory_input_stream_add_data (
  GMemoryInputStream $stream,
  Blob $data,
  int64 $len,
  Pointer $destroy
)
  is native(gio)
  is export
{ * }
