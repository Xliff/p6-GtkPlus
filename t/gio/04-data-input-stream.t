use v6.c;

use NativeCall;

use Test;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::DataInputStream;
use GIO::MemoryInputStream;

sub swap-endian ($bits, $i, :$signed = False) {
  my $b = Buf.new;
  my $s = $signed ?? '' !! 'u';

  $b."write-{$s}int{$bits}"(0, $i);
  $b."read-{$s}int{$bits}"(0, BigEndian);
}

sub swap-endian16 ($i, :$signed = False) {
  swap-endian(16, $i, :$signed);
}
sub swap-endian32 ($i, :$signed = False) {
  swap-endian(32, $i, :$signed);
}
sub swap-endian64 ($i, $signed = False) {
  swap-endian(64, $i, :$signed);
}

sub test-basic {
  my $base = GIO::MemoryInputStream.new;
  my $in   = GIO::DataInputStream.new($base);

  is  $in.byte-order, G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN,
      'Byte order is Big Endian';

  $in.byte-order = G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN;
  is  $in.byte-order, G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN,
      'Byte order is Little Endian, after byte-order reset';

  is  $in.newline-type, G_DATA_STREAM_NEWLINE_TYPE_LF,
      'Newline type is LF.';

  $in.newline-type = G_DATA_STREAM_NEWLINE_TYPE_CR_LF;
  is  $in.newline-type, G_DATA_STREAM_NEWLINE_TYPE_CR_LF,
      'Newline type is CRLF.';
}

sub test-seek-to-start ($s) {
  is  $s.seek(0, G_SEEK_SET), True, 'Can seek to start of stream.';
  nok $ERROR,                       'No error reported during seek';
}

sub test-read-lines ($nl is copy) {
  my @lines = 'some text' xx 4;
  my @ends = ( "\n", "\r", "\r\n", "\n" );

  my $base   = GIO::MemoryInputStream.new;
  my $stream = GIO::DataInputStream.new($base);

  ok  $base,    'Base input stream is defined';
  ok  $stream,  'Data input stream is defined';

  $stream.byte-order = G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN;
  is  $stream.byte-order, G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN,
      'Data input stream can be set to Big Endian byte order';

  $stream.byte-order = G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN;
  is  $stream.byte-order, G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN,
      'Data input stream can be set to Little Endian byte order';

  $nl = GDataStreamNewlineTypeEnum($nl);
  $stream.newline-type = $nl;
  is  $stream.newline-type, $nl,
      "Data input stream can be set to the {$nl} newline type";

  $base.add-data($_, enc => 'ISO-8859-1') for @lines »~« @ends;

  test-seek-to-start($base);

  my ($data, $line) = ('', 0);
  repeat {
    $data = $stream.read-line;

    if $data {
      is  $data, @lines[$line],   "Line {$line++} matches expected data";
      nok $ERROR,                 'No error detected during read';
    }
    exit if $line > 5;
  } while $data;

  is  $line, +@lines,             'All lines were read';
}

sub test-read-lines-LF-valid-utf8 {
  my $base   = GIO::MemoryInputStream.new;
  my $stream = GIO::DataInputStream.new($base);

  $base.add-data("foo\nthis is valid UTF-8 ☺!\nbar\n");

  my $lines = 0;
  loop {
    my $line = $stream.read-line-utf8;
    nok   $ERROR,     'No error detected during read';

    last unless $line;
    $lines++
  }

  is      $lines, 3,  'Correct number of valid UTF8 lines read';
}

test-basic;
test-read-lines(.value) for GDataStreamNewlineTypeEnum.enums.sort( *.key );
test-read-lines-LF-valid-utf8;
