use v6.c;

use NativeCall;
use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::InetAddressMask;

use GIO::InetAddress;

use GTK::Compat::Roles::Object;

class GIO::InetAddressMask {
  also does GTK::Compat::Roles::Object;

  has GInetAddressMask $!iam;

  submethod BUILD (:$mask) {
    $!iam = $mask;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GInetAddressMask
    is also<GInetAddressMask>
  { $!iam }

  multi method new (GInetAddressMask $mask) {
    self.bless( :$mask );
  }
  multi method new (
    GInetAddress() $addr,
    guint $length,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = g_inet_address_mask_new($addr, $length, $error);
    set_error($error);
    self.bless( mask => $rv ) if $rv;
  }

  multi method new(
    Str() $mask_string,
    CArray[Pointer[GError]] $error = gerror,
    :$string is required
  ) {
    GIO::InetAddressMask.new_from_string($mask_string, $error);
  }
  method new_from_string (
    Str() $mask_string,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-string>
  {
    clear_error;
    my $rv = g_inet_address_mask_new_from_string($mask_string, $error);
    set_error($error);
    self.bless( mask => $rv ) if $rv;
  }

  method equal (GInetAddressMask() $mask2) {
    so g_inet_address_mask_equal($!iam, $mask2);
  }

  method get_address (:$raw = False)
    is also<
      get-address
      address
    >
  {
    my $a = g_inet_address_mask_get_address($!iam);
    $raw ?? $a !! GIO::InetAddress.new($a);
  }

  method get_family
    is also<
      get-family
      family
    >
  {
    GSocketFamilyEnum( g_inet_address_mask_get_family($!iam) );
  }

  method get_length
    is also<
      get-length
      length
    >
  {
    g_inet_address_mask_get_length($!iam);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_inet_address_mask_get_type, $n, $t );
  }

  method matches (GInetAddress() $address) {
    so g_inet_address_mask_matches($!iam, $address);
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    g_inet_address_mask_to_string($!iam);
  }

}
