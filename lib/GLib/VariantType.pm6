use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

use GLib::Raw::VariantType;

# OPAQUE STRUCT (BOXED?)

class GLib::VariantType {
  has GVariantType $!vt is implementor;

  submethod BUILD (:$type) {
    $!vt = $type;
  }

  method GTK::Compat::Types::GVariantType
    is also<GVariantType>
  { $!vt }

  multi method new (GVariantType $type) {
    self.bless(:$type);
  }
  multi method new (Str() $type) {
    my $t = g_variant_type_new($type);

    $t ?? self.bless( type => $t ) !! Nil;
  }

  multi method new (
    GVariantType() $element,
    :$array is required
  ) {
    self.new_array($element);
  }
  method new_array (GVariantType() $element) is also<new-array> {
    my $t = g_variant_type_new_array($element);

    $t ?? self.bless( type => $t ) !! Nil;
  }

  multi method new (
    GVariantType() $key,
    GVariantType() $value,
    :dict_entry(:dict-entry(:$entry)) is required
  ) {
    self.new_dict_entry($key, $value);
  }
  method new_dict_entry (GVariantType() $key, GVariantType() $value)
    is also<new-dict-entry>
  {
    my $t = g_variant_type_new_dict_entry($key, $value);

    $t ?? self.bless( type => $t ) !! Nil;
  }

  # yyy- Multi to take @!
  multi method new (
    CArray[Pointer[GVariantType]] $items,
    Int() $length,
    :$tuple is required
  ) {
    self.new_tuple($items, $length);
  }
  # yyy- Multi to take @!
  method new_tuple (CArray[Pointer[GVariantType]] $items, Int() $length)
    is also<new-tuple>
  {
    my gint $l = resolve-int($length);
    my $t = g_variant_type_new_tuple($items, $l);

    $t ?? self.bless( type => $t ) !! Nil;
  }

  multi method new (
    GVariantType() $element,
    :$maybe is required
  ) {
    self.new_maybe($element);
  }
  method new_maybe (GVariantType() $element) is also<new-maybe> {
    my $t = g_variant_type_new_maybe($element);

    $t ?? self.bless( type => $t ) !! Nil;
  }

  method copy {
    my $t = g_variant_type_copy($!vt);

    $t ?? self.bless( type => $t ) !! Nil;
  }

  method dup_string is also<dup-string> {
    g_variant_type_dup_string($!vt);
  }

  method element {
    g_variant_type_element($!vt);
  }

  method equal (GVariantType() $type2) {
    so g_variant_type_equal($!vt, $type2);
  }

  method first (GLib::VariantType:D: :$raw = False ) {
    my $vt = g_variant_type_first($!vt);

    $vt ??
      ( $raw ?? $vt !! GLib::VariantType.new($vt) )
      !!
      Nil;
  }

  method free {
    g_variant_type_free($!vt);
  }

  method get_string_length is also<get-string-length> {
    g_variant_type_get_string_length($!vt);
  }

  multi method hash (GVariantType() $type) {
    g_variant_type_hash($type);
  }
  multi method hash {
    g_variant_type_hash($!vt);
  }

  method is_array
    is also<
      is-array
      array
    >
  {
    so g_variant_type_is_array($!vt);
  }

  method is_basic
    is also<
      is-basic
      basic
    >
  {
    so g_variant_type_is_basic($!vt);
  }

  method is_container
    is also<
      is-container
      container
    >
  {
    so g_variant_type_is_container($!vt);
  }

  method is_definite
    is also<
      is-definite
      definite
    >
  {
    so g_variant_type_is_definite($!vt);
  }

  method is_dict_entry
    is also<
      is-dict-entry
      dict_entry
      dict-entry
    >
  {
    so g_variant_type_is_dict_entry($!vt);
  }

  method is_maybe
    is also<
      is-maybe
      maybe
    >
  {
    so g_variant_type_is_maybe($!vt);
  }

  method is_subtype_of (GVariantType() $supertype) is also<is-subtype-of> {
    so g_variant_type_is_subtype_of($!vt, $supertype);
  }

  method is_tuple
    is also<
      is-tuple
      tuple
    >
  {
    so g_variant_type_is_tuple($!vt);
  }

  method is_variant
    is also<
      is-variant
      variant
    >
  {
    so g_variant_type_is_variant($!vt);
  }

  method key (GLib::VariantType:D: :$raw = False) {
    my $t = g_variant_type_key($!vt);

    $t ??
      ( $raw ?? $t !! GLib::VariantType.new( type => $t ) )
      !!
      Nil;
  }

  method n_items
    is also<
      n-items
      elems
    >
  {
    g_variant_type_n_items($!vt);
  }

  method next (GLib::VariantType:D: :$raw = False) {
    my $t = g_variant_type_next($!vt);

    $t ??
      ( $raw ?? $t !! GLib::VariantType.new( type => $t ) )
      !!
      Nil;
  }

  method peek_string is also<peek-string> {
    g_variant_type_peek_string($!vt);
  }

  # ???
  #
  # method string_get_depth_ {
  #   g_variant_type_string_get_depth_($!vt);
  # }

  method string_is_valid (Str() $type) is also<string-is-valid> {
    so g_variant_type_string_is_valid($type);
  }

  method string_scan (
    Str() $string,
    Str() $limit,
    CArray[Str] $endptr = CArray[Str].new
  )
    is also<string-scan>
  {
    my $rc = g_variant_type_string_scan($string, $limit, $endptr);

    $endptr[0] if $rc && $endptr.defined;
  }

  method value (GLib::VariantType:D: :$raw = False) {
    my $t = g_variant_type_value($!vt);

    $t ??
      ( $raw ?? $t !! GLib::VariantType.new( type => $t ) )
      !!
      Nil;
  }

}

multi sub infix:<eqv> (GVariantType $a, GVariantType $b) {
  g_variant_type_equal($a, $b);
}
multi sub infix:<eqv> (
  GLib::VariantType $a,
  GLib::VariantType $b
) {
  $a.equal($b);
}
