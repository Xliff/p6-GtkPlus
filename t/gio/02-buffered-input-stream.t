use v6.c;

use Test;

use GIO::InputStream;
use GIO::MemoryInputStream;
use GIO::BufferedInputStream;

sub test-peek {
  my $data = 'abcdefghijk';
  my $base = GIO::MemoryInputStream.new-from-data( $data.encode('ISO-8859-1') );
  my $in   = GIO::BufferedInputStream.new-sized($base, 64);

  $in.fill(5);

  is  $in.available, 5,
      '5 Bytes read into buffer after call to .fill(5)';

  $in.fill(-1);

  is  $in.available, $data.chars,
      'All of $data available in buffer after call to .fill(-1)';

  {
    my $buf  = Buf.allocate(64);
    my $peek = $in.peek($buf, 2, 3);

    is  $peek, 3,
        "Number of bytes peek'ed is 3";
    is  $buf.decode, 'cde',
        'Result of peek has "cde" in $buf';
  }

  {
    my $buf  = Buf.allocate(64);
    my $peek = $in.peek($buf, 9, 5);

    is  $peek, 2,
        "Number of bytes peek'ed is 2";
    is  $buf.decode, 'jk',
        'Result of peek has "jk" in $buf';
  }

  {
    my $buf  = Buf.allocate(64);
    my $peek = $in.peek($buf, 75, 3);

    is  $peek, 0,
        "Number of bytes peek'ed is 0 (outside range of \$data)";
  }

  #.unref for $in, $base
}

test-peek;
