use v6.c;

use Test;

use GIO::InetAddress;

sub test-parse {
  my @non-null = <
    0:0:0:0:0:0:0:0
    1:0:0:0:0:0:0:8
    0:0:0:0:0:FFFF:204.152.189.116
    ::1
    ::
    ::FFFF:204.152.189.116
    204.152.189.116
  >;

  my @null = «
    ::1::2
    2001:1:2:3:4:5:6:7]
    [2001:1:2:3:4:5:6:7
    [2001:1:2:3:4:5:6:7]
    [2001:1:2:3:4:5:6:7]:80
    0:1:2:3:4:5:6:7:8:9
    ::FFFFFFF
    204.152.189.116:80
  »;

  for @non-null {
    my $a = GIO::InetAddress.new($_, :string);

    ok ~$a,   "Address {$_} is valid";
  }

  for @null {
    my $a = GIO::InetAddress.new($_, :string);

    nok $a,  "Address {$_} is NOT valid";
  }
}

test-parse;
