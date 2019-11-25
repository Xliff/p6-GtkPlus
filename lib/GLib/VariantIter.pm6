use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::Variant;

class GLib::VariantIter {
  has GVariantIter $!vi is implementor;

  submethod BUILD (:$iter) {
    $!vi = $iter;
  }

  method GTK::Compat::Types::GVariantIter
    is also<VariantIter>
    { $!vi }

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

  method n_children is also<n-children> {
    g_variant_iter_n_children($!vi);
  }

  method next_value is also<next-value> {
    g_variant_iter_next_value($!vi);
  }

}
