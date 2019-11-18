use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::VariantType;

# OPAQUE STRUCT (BOXED?)

class GTK::Compat::VariantType {
  has GVariantType $!vt is implementor;

  submethod BUILD (:$type) {
    $!vt = $type;
  }

  method GTK::Compat::Types::GVariantType
    # is also<Variant>
  { $!vt }

  multi method new (GVariantType $type) {
    self.bless(:$type);
  }
  multi method new (Str() $type) {
    self.bless( type => g_variant_type_new($type) );
  }

  method new_array (GVariantType() $element) {
    self.bless( type => g_variant_type_new_array($element) );
  }

  method new_dict_entry (GVariantType() $key, GVariantType() $value) {
    self.bless( type => g_variant_type_new_dict_entry($key, $value) );
  }

  method new_tuple (CArray[Pointer[GVariantType]] $items, Int() $length) {
    my gint $l = resolve-int($length);
    self.bless( type => g_variant_type_new_tuple($items, $l) );
  }

  method new_maybe (GVariantType() $element) {
    self.bless( type => g_variant_type_new_maybe($element) );
  }

  method copy {
    self.bless( type => g_variant_type_copy($!vt) );
  }

  method dup_string {
    g_variant_type_dup_string($!vt);
  }

  method element {
    g_variant_type_element($!vt);
  }

  method equal (GVariantType() $type2) {
    so g_variant_type_equal($!vt, $type2);
  }

  method first (GTK::Compat::VariantType:D: ) {
    GTK::Compat::VariantType.new( g_variant_type_first($!vt) );
  }

  method free {
    g_variant_type_free($!vt);
  }

  method get_string_length {
    g_variant_type_get_string_length($!vt);
  }

  multi method hash (GVariantType() $type) {
    g_variant_type_hash($type);
  }
  multi method hash {
    g_variant_type_hash($!vt);
  }

  method is_array {
    so g_variant_type_is_array($!vt);
  }

  method is_basic {
    so g_variant_type_is_basic($!vt);
  }

  method is_container {
    so g_variant_type_is_container($!vt);
  }

  method is_definite {
    so g_variant_type_is_definite($!vt);
  }

  method is_dict_entry {
    so g_variant_type_is_dict_entry($!vt);
  }

  method is_maybe {
    so g_variant_type_is_maybe($!vt);
  }

  method is_subtype_of (GVariantType() $supertype) {
    so g_variant_type_is_subtype_of($!vt, $supertype);
  }

  method is_tuple {
    so g_variant_type_is_tuple($!vt);
  }

  method is_variant {
    so g_variant_type_is_variant($!vt);
  }

  method key (GTK::Compat::VariantType:D: ) {
    GTK::Compat::VariantType.new( type => g_variant_type_key($!vt) );
  }

  method n_items {
    g_variant_type_n_items($!vt);
  }

  method next (GTK::Compat::VariantType:D: ) {
    GTK::Compat::VariantType.new( type => g_variant_type_next($!vt) );
  }

  method peek_string {
    g_variant_type_peek_string($!vt);
  }

  # ???
  #
  # method string_get_depth_ {
  #   g_variant_type_string_get_depth_($!vt);
  # }

  method string_is_valid (Str() $type) {
    so g_variant_type_string_is_valid($type);
  }

  method string_scan (
    Str() $string,
    Str() $limit,
    CArray[Str] $endptr = CArray[Str].new
  ) {
    my $rc = g_variant_type_string_scan($string, $limit, $endptr);
    $endptr[0] if $rc && $endptr.defined;
  }

  method value (GTK::Compat::VariantType:D: ) {
    GTK::Compat::VariantType.new( type => g_variant_type_value($!vt) );
  }

}

multi sub infix:<eqv> (GVariantType $a, GVariantType $b) {
  g_variant_type_equal($a, $b);
}
multi sub infix:<eqv> (
  GTK::Compat::VariantType $a,
  GTK::Compat::VariantType $b
) {
  $a.equal($b);
}
