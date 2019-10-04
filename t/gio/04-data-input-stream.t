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

test-basic;
