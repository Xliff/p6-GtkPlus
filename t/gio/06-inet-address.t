use v6.c;

use Test;

use GTK::Compat::Types;

use GIO::InetAddress;
use GIO::InetAddressMask;
use GIO::InetSocketAddress;

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

sub test-any {
  for GSocketFamilyEnum
        .enums
        .pairs
        .grep( *.key.contains('IPV') )
        .sort( *.key )
  {
    my $f = GSocketFamilyEnum( .value );
    my $s = $f == G_SOCKET_FAMILY_IPV4 ?? 4 !! 16;
    my $a = GIO::InetAddress.new($f, :any);

    ok  $a.is-any,                'InetAddress is ANY';
    is  $a.family,       $f,      "InetAddress belongs to { $f }";
    is  $a.native-size,  $s,      "InetAddress native size is { $s }";

    nok $a.is-loopback,           'InetAddress is NOT a loopback';
    nok $a.is-link-local,         'InetAddress is NOT link local';
    nok $a.is-site-local,         'InetAddress is NOT site local';
    nok $a.is-multicast,          'InetAddress is NOT a multicast addr';
    nok $a.is-mc-global,          'InetAddress is NOT MC Global';
    nok $a.is-mc-link-local,      'InetAddress is NOT MC Link Local';
    nok $a.is-mc-node-local,      'InetAddress is NOT MC Node Local';
    nok $a.is-mc-org-local,       'InetAddress is NOT MC Org Local';
    nok $a.is-mc-site-local,      'InetAddress is NOT MC Site Local';
  }
}

sub test-loopback {
  my $a1 = GIO::InetAddress.new('::1', :string);

  is  $a1.family, G_SOCKET_FAMILY_IPV6,   '::1 Address family is IPv6';
  ok  $a1.is-loopback,                    '::1 recognized as a loopback addr';

  my $a2 = GIO::InetAddress.new('127.0.0.1', :string);

  is  $a2.family, G_SOCKET_FAMILY_IPV4,   '127.0.0.1 Address family is IPv4';
  ok  $a2.is-loopback,                    '127.0.0.1 recognized as a loopback addr';
}

sub test-bytes {
  my ($a1, $a2) =
    ('192.168.0.100', '192.168.0.101')».&{ GIO::InetAddress.new($_, :string) };
  my $a3 = GIO::InetAddress.new(
    $a1.to-bytes,
    G_SOCKET_FAMILY_IPV4,
    :bytes
  );

  nok $a1.equal($a2), 'Address1 does NOT equal Address2';
  ok  $a1.equal($a3), 'Address1 equals Address3';
}

sub test-attributes {
  my $addr = 'ff85::';
  my $a = GIO::InetAddress.new($addr, :string);
  my $pre = "'{$addr}'";

  is  $a.family, G_SOCKET_FAMILY_IPV6,  "$pre belongs to the IPv family";
  nok $a.is-any,                        "$pre is NOT an ANY";
  nok $a.is-loopback,                   "$pre is NOT a loopback";
  nok $a.is_link_local,                 "$pre is NOT link local";
  nok $a.is_site_local,                 "$pre is NOT site local";
  ok  $a.is_multicast,                  "$pre is multicast";
  nok $a.is_mc_global,                  "$pre is NOT multicast global";
  nok $a.is_mc_link_local,              "$pre is NOT multicast link local";
  nok $a.is_mc_node_local,              "$pre is NOT multicast node local";
  nok $a.is_mc_org_local,               "$pre is NOT muilticast org local";
  ok  $a.is_mc_site_local,              "$pre is multicast site local";
}

sub test-socket-address {
  my $addr  = '::ffff:125.1.15.5';
  my $port  = 308;
  my $a     = GIO::InetAddress.new($addr, :string);
  my $sa    = GIO::InetSocketAddress.new($a, $port);

  ok  $a.equal($sa.address(:raw)),
      'Address object and address from Socket object are equal';

  is  $sa.port, $port,    "Socket address is set to port {$port}";
  nok $sa.flowinfo,       'Socket flowinfo is not set';
  nok $sa.scope-id,       'Socket scope-id is not set';

  $sa = GIO::InetSocketAddress.new(
    GIO::InetAddress.new('::1', :string),
    $port,
    10,
    25
  );

  my $fam = G_SOCKET_FAMILY_IPV6;
  is  $sa.family,   $fam,     "Socket address belongs to family {$fam}";
  is  $sa.port,     $port,    "Socket address is set to port {$port}";
  is  $sa.flowinfo, 10,       'Socket address flowinfo is set correctly';
  is  $sa.scope-id, 25,       'Socket address scope-ids is set correctly';
}

sub test-socket-address-to-string {
  my @tests = (
    [ '123.1.123.1',         80, '123.1.123.1:80' ],
    [ 'fe80::80',            80, '[fe80::80]:80'  ],
    [ 'fe80::80',             0, 'fe80::80'       ],
    [ '::1',      (123, 10, 25), '[::1%25]:123'   ]
  );

  for @tests {
    my $ia =  GIO::InetAddress.new(.[0], :string);
    my $sa =  [.1] ~~ Array ??
      GIO::InetSocketAddress.new( $ia, |.[1] ) !!
      GIO::InetSocketAddress.new( $ia,  .[1] );

    my $ln = ++$;
    is ~$sa, .[2], "Stringified inetsocketaddr object {$ln} equals '{.[2]}'";
  }
}

sub test-mask-parse {
  my @tests = (
    [ '10.0.0.0/8',    0 ],
    [ 'fe80::/10',     0 ],
    [ '::',            0 ],
    [ ':/abc',         G_IO_ERROR_INVALID_ARGUMENT ],
    [ '127.0.0.1/128', G_IO_ERROR_INVALID_ARGUMENT ],
  );

  for @tests {
    my $m = GIO::InetAddressMask.new_from_string( .[0] );

    if .[1] {
      ok  [&&](
        $ERROR,
        #$ERROR.domain == $G_IO_ERROR,
        $ERROR.code == .[1]
      ),           "inetaddrmask object creation from '{.[0]}' failed";
      nok $m,      'inetaddrmask object is undefined';
    } else {
      nok $ERROR,  "inetaddrmask object successfully created from '{.[0]}'";
      ok  $m,      'inetaddrmask object is defined';
    }
  }
}

plan 79;

test-parse;
test-any;
test-loopback;
test-bytes;
test-attributes;
test-socket-address;
test-socket-address-to-string;
test-mask-parse;
