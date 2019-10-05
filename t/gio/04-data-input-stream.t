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
  $b."read-{$s}int{$bits}"(
    0,
    $*KERNEL.endian == BigEndian ?? LittleEndian !! BigEndian
  );
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

  # Convert parameter back to enum.
  $nl = GDataStreamNewlineTypeEnum($nl);
  $stream.newline-type = $nl;
  is  $stream.newline-type, $nl,
      "Data input stream can be set to the {$nl} newline type";

  $base.add-data($_, enc => 'ISO-8859-1')
    for @lines »~« @ends[$nl] xx +@lines;

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

sub test-read-lines-LF-utf8 (:$valid, :$invalid) {
  die ':valid OR :invalid MUST be specified' unless $valid ^^ $invalid;

  my $VALID  = $valid.defined;
  my $base   = GIO::MemoryInputStream.new;
  my $stream = GIO::DataInputStream.new($base);

  $stream.newline-type = G_DATA_STREAM_NEWLINE_TYPE_LF;

  if $VALID {
    $base.add-data("foo\nthis is valid UTF-8 ☺!\nbar\n");
  } else {
    $base.add-data(
      "foo\nthis is not valid UTF-8 \xE5 =(\nbar\n",
      enc => 'ISO-8859-1'
    );
  }

  my $lines = 0;
  loop {
    my $line = $stream.read-line-utf8;

    if $VALID {
      nok       $ERROR,     'No error detected during read';
    } else {
      if $lines {
        ok    $ERROR,       "Error detected when reading line {$lines}";
        last;
      } else {
        nok   $ERROR,       'No error detected during read';
      }
    }

    last unless $line;
    $lines++
  }

  is      $lines, $VALID ?? 3 !! 1,
          "Correct number of { $VALID ?? '' !! 'in' }valid UTF8 lines read";
}

sub test-read-sep(:$upto, :$until) {
  die ':upto OR :until MUST be specified' unless $upto ^^ $until;

  my $REPEATS             = 10;
  my $DATA_STRING         = $until ??
                              ' part1 # part2 $ part3 % part4 ^'
                              !!
                              " part1 # part2 \$ part3 \x0 part4 ^";
  my $DATA_PART_LEN       = 7;
  my $DATA_SEP            = $until ??
                              '#$%^'
                              !!
                              "#\$\x0^";
  my $DATA_SEP_LEN        = 4;
  my $DATA_PARTS_NUM      = $DATA_SEP_LEN * $REPEATS;

  my $base   = GIO::MemoryInputStream.new;
  my $stream = GIO::DataInputStream.new($base);

  diag $DATA_STRING;
  diag $DATA_SEP;

  $base.add-data(
    $DATA_STRING,
    $until ?? -1 !! 32,
    enc => 'ISO-8859-1'
  ) for ^$REPEATS;

  my ($line, $data) = (0);
  repeat {
    $data = $until ??
      $stream.read-until($DATA_SEP)
      !!
      $stream.read-upto($DATA_SEP, $DATA_SEP_LEN);

    if $data {
      my $u = $until ?? 'until' !! 'upto';

      is  $data.chars, $DATA_PART_LEN,
          "Data part of read-{$u} string is the proper length";

      nok $ERROR,
          "No error occurred during read-{$u}";

      if $upto {
        my $sc = $stream.read-byte;

        ok  $DATA_SEP.contains($sc.chr), 'Read byte is in stop char list';
        nok $ERROR,                      'No error detected reading stop char';
      }

      $line++;
    }
  } while $data;

  nok $ERROR,                 'No error detected';

  is  $line, $DATA_PARTS_NUM, 'All data parts read successfully';
}

enum TestDataType <
  TEST_DATA_BYTE
  TEST_DATA_INT16
  TEST_DATA_UINT16
  TEST_DATA_INT32
  TEST_DATA_UINT32
  TEST_DATA_INT64
  TEST_DATA_UINT64
>;

sub test-data-array ($stream, $base, $buf, $len, $data-type, $byte-order) {

  my $native = $*KERNEL.endian == BigEndian ??
    G_DATA_STREAM_BYTE_ORDER_BIG_ENDIAN    !!
    G_DATA_STREAM_BYTE_ORDER_LITTLE_ENDIAN;

  my $swap = [&&](
    $byte-order != G_DATA_STREAM_BYTE_ORDER_HOST_ENDIAN,
    $byte-order != $native
  );

  test-seek-to-start($base);

  my ($pos, $data) = (0);
  my ($type, $un) = ( $data-type.Str.lc.split('_')[* - 1], 0 );
  my $size = do {
    if $type ~~ /(u)?\w+(\d+)$/ {
      $un = $0.defined;
      $1.Int;
    } else {
      1;
    }
  };

  repeat {
    $data = $stream."read-{$type}"();
    $data = swap-endian($size, $data, signed => $un) if $swap && $size > 1;

    unless $ERROR {
      is  $data, $buf."read-{$type}"($pos, BigEndian),
          "Normalized integer from read-{$type} matches data from buffer";
    }

    $pos  += $size.log(2) + 1;
  } while $data;

  nok $ERROR,               'No error occured during read operation'
    if $pos < $len + 1;

  is  $pos - $size, $len,   'Position in buffer is properly set';
}

plan 320;

test-basic;
test-read-lines(.value) for GDataStreamNewlineTypeEnum.enums.sort( *.key );
test-read-lines-LF-utf8( :valid   );
test-read-lines-LF-utf8( :invalid );
test-read-sep( :until );
test-read-sep( :upto  );
