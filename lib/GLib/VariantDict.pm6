use v6.c;

use Method::Also;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GLib::Raw::Variant;

use GLib::Roles::Object;

class GLib::VariantDict {
  also does GLib::Roles::Object;

  has GVariantDict $!vd is implementor;

  submethod BUILD (:$dict) {
    self!setObject($!vd = $dict);
  }

  method GTK::Compat::Types::GVariantDict
    is also<GVariantDict>
  { $!vd }

  method new (GVariant() $value) {
    my $d = g_variant_dict_new($value);

    $d ?? self.bless( dict => $d ) !! Nil
  }

  method clear {
    g_variant_dict_clear($!vd);
  }

  method contains (Str() $key) {
    so g_variant_dict_contains($!vd, $key);
  }

  method end (:$raw = False) {
    my $v = g_variant_dict_end($!vd);

    $v ??
      ( $raw ?? $v !! GLib::Variant.new($v) )
      !!
      Nil;
  }

  method init (GVariant() $from_asv) {
    g_variant_dict_init($!vd, $from_asv);
  }

  method insert_value (Str() $key, GVariant() $value) is also<insert-value> {
    g_variant_dict_insert_value($!vd, $key, $value);
  }

  method lookup_value (
    Str() $key,
    GVariantType() $expected_type,
    :$raw = False
  )
    is also<lookup-value>
  {
    my $v = g_variant_dict_lookup_value($!vd, $key, $expected_type);

    $v ??
      ( $raw ?? $v !! GLib::Variant.new($v) )
      !!
      Nil;
  }

  method ref is also<upref> {
    g_variant_dict_ref($!vd);
    self;
  }

  method remove (Str() $key) {
    g_variant_dict_remove($!vd, $key);
  }

  method unref is also<downref> {
    g_variant_dict_unref($!vd);
  }

}
