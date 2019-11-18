use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GLib::Raw::HMAC;

class GLib::HMAC {
  has GHmac $!h is implementor;

  submethod BUILD (:$hmac) {
    $!h = $hmac;
  }

  method GTK::Compat::Types::GHmac
  { $!h }

  multi method new (GHmac $hmac) {
    self.bless( :$hmac );
  }
  multi method new (Int() $digest_type, Str() $key, Int() $key_len) {
    my GChecksumType $dt = $digest_type;
    my gsize $kl = $key_len;

    self.bless( hmac => g_hmac_new($dt, $key, $kl) );
  }

  # Class Methods
  method compute_hmac_for_bytes (
    GLib::HMAC:U:
    Int() $digest_type,
    GBytes() $key,
    GBytes() $data
  )
    is also<compute-hmac-for-bytes>
  {
    my GChecksumType $dt = $digest_type;

    g_compute_hmac_for_bytes($dt, $key, $data);
  }

  method compute_hmac_for_data (
    GLib::HMAC:U:
    Int() $digest_type,
    Str() $key,
    Int() $key_len,
    Str() $data,
    Int() $length
  )
    is also<compute-hmac-for-data>
  {
    my GChecksumType $dt = $digest_type;
    my gsize ($kl, $l) = ($key_len, $length);

    g_compute_hmac_for_data($!h, $key, $kl, $data, $l);
  }

  method compute_hmac_for_string (
    GLib::HMAC:U:
    Int() $digest_type,
    Str() $key,
    Int() $key_len,
    Str() $str,
    Int() $length
  )
    is also<compute-hmac-for-string>
  {
    my GChecksumType $dt = $digest_type;
    my gsize ($kl, $l) = ($key_len, $length);

    g_compute_hmac_for_string($!h, $key, $kl, $str, $l);
  }

  proto method get_digest (|)
      is also<get-digest>
  { * }

  multi method get_digest (@buffer, :$all = False) {
    my $ca = CArray[uint8].new;
    my $idx = 0;

    for @buffer {
      die '@buffer cannot take a non integer value'
        unless $_ ~~ (Int, IntStr).any;
      die '@buffer cannot take a non 8-bit value.' unless $_ <= 255;
      $ca[$idx++] = $_
    }
    samewith($ca, :$all);
  }
  multi method get_digest (Str() $buffer, :$all = False) {
    samewith($buffer.encode, :$all);
  }
  multi method get_digest (Buf $buffer, :$all = False) {
    my $ca = CArray[uint8].new;
    my $idx = 0;

    $ca[$idx++] = $_ for $buffer.list;
    samewith($ca, :$all);
  }
  multi method get_digest (CArray[uint8] $buffer, :$all = False) {
    samewith($buffer, $, :$all);
  }
  multi method get_digest (
    CArray[uint8] $buffer,
    $digest_len is rw,
    :$all = False
  ) {
    my gsize $dl = 0;
    my $rv = g_hmac_get_digest($!h, $buffer, $dl);

    $digest_len = $dl;
    $all ?? $rv !! ($rv, $digest_len);
  }

  # Methods
  method copy {
    GLib::HMAC.new( g_hmac_copy($!h) );
  }

  method get_string is also<get-string> {
    g_hmac_get_string($!h);
  }

  method ref {
    g_hmac_ref($!h);
    self;
  }

  method unref {
    g_hmac_unref($!h);
  }

  method update (Str() $data, Int() $length) {
    my gsize $l = $length;

    g_hmac_update($!h, $data, $l);
  }

}
