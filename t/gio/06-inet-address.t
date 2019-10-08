use v6.c;

use Test;

use GTK::Compat::Types;

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
  ok $a.is_mc_site_local,               "$pre is multicast site local";
}

plan 57;

test-parse;
test-any;
test-loopback;
test-bytes;
test-attributes;
