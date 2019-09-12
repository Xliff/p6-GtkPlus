use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GLib::Raw::Checksum;

class GLib::Checksum {
  has GChecksum $!c;

  submethod BUILD (:$checksum) {
    $!c = $checksum;
  }

  method GTK::Compat::Types::GChecksum
  { $!c }

  multi method new (GChecksum $checksum) {
    self.bless( :$checksum );
  }
  multi method new (Int() $checksum_type) {
    my GChecksumType $ct = $checksum_type;

    self.bless( checksum => g_checksum_new($ct) );
  }

  # Class methods
  method compute_checksum_for_bytes (
    GLib::Checksum:U:
    Int() $checksum_type,
    GBytes() $data
  )
    is also<compute-checksum-for-bytes>
  {
    my GChecksumType $ct = $checksum_type;

    g_compute_checksum_for_bytes($!c, $data);
  }

  method compute_checksum_for_data (
    GLib::Checksum:U:
    Int() $checksum_type,
    Str() $data,
    Int() $length
  )
    is also<compute-checksum-for-data>
  {
    my GChecksumType $ct = $checksum_type;
    my gssize $l = $length;

    g_compute_checksum_for_data($!c, $data, $l);
  }

  method compute_checksum_for_string (
    GLib::Checksum:U:
    Int() $checksum_type,
    Str() $str,
    Int() $length
  )
    is also<compute-checksum-for-string>
  {
    my GChecksumType $ct = $checksum_type;
    my gssize $l = $length;

    g_compute_checksum_for_string($!c, $str, $l);
  }

  method type_get_length (Int() $checksum_type) is also<type-get-length> {
    my GChecksumType $ct = $checksum_type;

    g_checksum_type_get_length($ct);
  }

  # Methods
  method copy {
    GLib::Checksum.new( g_checksum_copy($!c) );
  }

  method free {
    g_checksum_free($!c);
  }

  # Could be a role...
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
    my $rv = g_checksum_get_digest($!c, $buffer, $dl);

    $digest_len = $dl;
    $all ?? $rv !! ($rv, $digest_len);
  }

  method get_string is also<get-string> {
    g_checksum_get_string($!c);
  }

  method reset {
    g_checksum_reset($!c);
  }

  method update (Str() $data, Int() $length) {
    my gssize $l = $length;

    g_checksum_update($!c, $data, $l);
  }

}
