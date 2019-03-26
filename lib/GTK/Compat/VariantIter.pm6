use v6.c;

use GTK::Compat::Types;
use GTK::Compat::Raw::Variant;

class GTK::Compat::VariantIter {
  has GVariantIter $!vi;
  
  submethod BUILD (:$iter) {
    $!vi = $iter;
  }
  
  method new (GVariant() $value) {
    self.bless( iter => g_variant_iter_new($value) );
  }

  method copy {
    g_variant_iter_copy($!vi);
  }

  method free {
    g_variant_iter_free($!vi);
  }

  method init (GVariant() $value) {
    g_variant_iter_init($!vi, $value);
  }

  method n_children {
    g_variant_iter_n_children($!vi);
  }

  method next_value {
    g_variant_iter_next_value($!vi);
  }

}
