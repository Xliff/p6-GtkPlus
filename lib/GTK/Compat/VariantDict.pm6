use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Variant;

class GTK::Compat::VariantDict {
  has GVariantDict $!vd;
  
  submethod BUILD (:$dict) {
    $!vd = $dict;
  }
  
  method new (GVariant() $value) {
    self.bless( dict => g_variant_dict_new($value) );
  }
  
  method clear {
    g_variant_dict_clear($!vd);
  }

  method contains (Str() $key) {
    g_variant_dict_contains($!vd, $key);
  }

  method end {
    g_variant_dict_end($!vd);
  }

  method init (GVariant $from_asv) {
    g_variant_dict_init($!vd, $from_asv);
  }

  method insert_value (Str() $key, GVariant $value) {
    g_variant_dict_insert_value($!vd, $key, $value);
  }

  method lookup_value (Str() $key, GVariantType $expected_type) {
    g_variant_dict_lookup_value($!vd, $key, $expected_type);
  }

  method ref 
    #is also<upref>
  {
    g_variant_dict_ref($!vd);
  }

  method remove (Str() $key) {
    g_variant_dict_remove($!vd, $key);
  }

  method unref 
    #is also<downref>
  {
    g_variant_dict_unref($!vd);
  }

}
