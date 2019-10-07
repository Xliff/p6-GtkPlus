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

my $data = ('a'..'z').join('') ~ ('A'..'Z').join('');

for ^100 {
  my $base = g_memory_input_stream_new();
  my $in   = g_data_input_stream_new($base);

  g_memory_input_stream_add_data(
    $base,
    $data.encode,
    -1,
    Pointer
  );

  my guint $len = 0;
  my $error = CArray[GError].new;
  $error[0] = GError;

  g_seekable_seek(
    nativecast(GSeekable, $in),
    0,
    G_SEEK_SET,
    Pointer,
    $error
  );
  my $s = g_data_input_stream_read_line($in, $len, Pointer, $error);
  $s.say;
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
