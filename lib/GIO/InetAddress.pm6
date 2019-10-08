use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::InetAddress;

use GTK::Compat::Roles::Object;

class GIO::InetAddress {
  also does GTK::Compat::Roles::Object;

  has GInetAddress $!ia;

  submethod BUILD (:$address) {
    $!ia = $address;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GInetAddress
    is also<GInetAddress>
  { $!ia }

  multi method new (GInetAddress $address) {
    self.bless( :$address );
  }

  # my $ia = GIO::InetAddress.new(:any, $family)
  multi method new (Int() $family, :$any is required) {
    GIO::InetAddress.new_any($family);
  }
  method new_any (Int() $family) is also<new-any> {
    my GSocketFamily $f = $family;
    my $a = g_inet_address_new_any($f);

    $a ?? self.bless( address => $a ) !! Nil;
  }

  # my $ia = GIO::InetAddress.new(:bytes, $bytes, $family)

  proto method new(|) { * }

  multi method new ($b, Int() $family, :$bytes is required) {
    GIO::InetAddress.new_from_bytes($b, $family);
  }
  multi method new_from_bytes (@bytes, Int() $family) {
    my $ca = CArray[uint8].new;
    $ca[$_] = @bytes[$_] for ^@bytes.elems;
    samewith($ca, $family);
  }
  multi method new_from_bytes (Buf $bytes, Int() $family) {
    my $ca = CArray[uint8].new;
    $ca[$_] = $bytes[$_] for ^$bytes.elems;
    samewith($ca, $family);
  }
  multi method new_from_bytes (CArray[uint8] $bytes, Int() $family)
    is also<new-from-bytes>
  {
    my GSocketFamily $f = $family;
    my $a = g_inet_address_new_from_bytes($bytes, $f);

    $a ?? self.bless( address => $a ) !! Nil;
  }

  # my $ia = GIO::InetAddress.new(:string, $string)
  multi method new (Str() $s, :$string is required) {
    GIO::InetAddress.new_from_string($s);
  }
  method new_from_string (Str() $string) is also<new-from-string> {
    my $a = g_inet_address_new_from_string($string);

    $a ?? self.bless( address => $a ) !! Nil;
  }

  # my $ia = GIO::InetAddress.new(:loopback, $family)
  multi method new (Int() $family, :$loopback is required) {
    GIO::InetAddress.new_loopback($family);
  }
  method new_loopback (Int() $family) is also<new-loopback> {
    my GSocketFamily $f = $family;
    my $a = g_inet_address_new_loopback($f);

    $a ?? self.bless( address => $a ) !! Nil;
  }

  # Static alternatives could be useful, here.
  method equal (GInetAddress() $other_address) {
    so g_inet_address_equal($!ia, $other_address);
  }

  method get_family
    is also<
      get-family
      family
    >
  {
    GSocketFamilyEnum( g_inet_address_get_family($!ia) );
  }

  # Consideration for review:
  # Given that we do NOT need the property code, there is argument that
  # the get_is_* methods can also drop the "is" portion.

  method get_is_any
    is also<
      get-is-any
      is_any
      is-any
    >
  {
    so g_inet_address_get_is_any($!ia);
  }

  method get_is_link_local
    is also<
      get-is-link-local
      is_link_local
      is-link-local
    >
  {
    so g_inet_address_get_is_link_local($!ia);
  }

  method get_is_loopback
    is also<
      get-is-loopback
      is_loopback
      is-loopback
    >
  {
    so g_inet_address_get_is_loopback($!ia);
  }

  method get_is_mc_global
    is also<
      get-is-mc-global
      is_mc_global
      is-mc-global
    >
  {
    so g_inet_address_get_is_mc_global($!ia);
  }

  method get_is_mc_link_local
    is also<
      get-is-mc-link-local
      is_mc_link_local
      is-mc-link-local
    >
  {
    so g_inet_address_get_is_mc_link_local($!ia);
  }

  method get_is_mc_node_local
    is also<
      get-is-mc-node-local
      is_mc_node_local
      is-mc-node-local
    >
  {
    so g_inet_address_get_is_mc_node_local($!ia);
  }

  method get_is_mc_org_local
    is also<
      get-is-mc-org-local
      is_mc_org_local
      is-mc-org-local
    >
  {
    so g_inet_address_get_is_mc_org_local($!ia);
  }

  method get_is_mc_site_local
    is also<
      get-is-mc-site-local
      is_mc_site_local
      is-mc-site-local
    >
  {
    so g_inet_address_get_is_mc_site_local($!ia);
  }

  method get_is_multicast
    is also<
      get-is-multicast
      is_multicast
      is-multicast
    >
  {
    so g_inet_address_get_is_multicast($!ia);
  }

  method get_is_site_local
    is also<
      get-is-site-local
      is_site_local
      is-site-local
    >
  {
    so g_inet_address_get_is_site_local($!ia);
  }

  method get_native_size
    is also<
      get-native-size
      native_size
      native-size
    >
  {
    g_inet_address_get_native_size($!ia);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_inet_address_get_type, $n, $t );
  }

  # Default set to true for use in .new(..., :bytes)
  method to_bytes (:$buf = True) is also<to-bytes> {
    my @bytes;
    my $bytes = g_inet_address_to_bytes($!ia);
    @bytes[$_] = $bytes[$_] for ^self.native_size;
    return unless $buf;

    Buf.new(@bytes);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    g_inet_address_to_string($!ia);
  }

}
