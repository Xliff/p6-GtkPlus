use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Variant;

class GTK::Compat::Variant {
  has GVariant $!v;
  
  submethod BUILD (:$variant) {
    $!v = $variant;
  }
  
  method GTK::Compat::Types::GVariant { $!v }
  
  method new_boolean(
    GTK::Compat::Variant:U:
    Int() $bool
  ) {
    my gboolean $b = resolve-bool($bool);
    self.bless( variant => g_variant_new_boolean($b) );
  }

  method new_byte(
    GTK::Compat::Variant:U:
    Int() $byte
  ) {
    my uint8 $b = resolve-uint8($byte);
    self.bless( variant => g_variant_new_byte($b) );
  }

  method new_bytestring(
    GTK::Compat::Variant:U:
    Str() $bytestring
  ) {
    self.bless( variant => g_variant_new_bytestring($bytestring) );
  }

  method new_dict_entry (
    GTK::Compat::Variant:U:
    GVariant() $key, 
    GVariant() $value
  ) {
    self.bless( variant => g_variant_new_dict_entry($key, $value) );
  }

  method new_double (
    GTK::Compat::Variant:U:
    Num() $double
  ) {
    my gdouble $d = $double;
    self.bless( variant => g_variant_new_double($d) );
  }

  method new_fixed_array (
    GTK::Compat::Variant:U:
    GVariantType $element_type, 
    Pointer $elements,
    Int() $n_elements, 
    Int() $element_size
  ) {
    my uint64 ($ne, $es) = resolve-uint64($n_elements, $element_size);
    self.bless( 
      variant => g_variant_new_fixed_array(
        $element_type, 
        $elements, 
        $ne, 
        $es
      )
    );
  }

  method new_from_bytes (
    GTK::Compat::Variant:U:
    GVariantType $type, 
    GBytes $bytes, 
    Int() $trusted
  ) {
    my gboolean $t = resolve-bool($trusted);
    self.bless( variant => g_variant_new_from_bytes($type, $bytes, $t) );
  }

  method new_from_data (
    GTK::Compat::Variant:U:
    GVariantType $type,
    gconstpointer $data, 
    Int() $size, 
    Int() $trusted, 
    GDestroyNotify $notify = Pointer, 
    gpointer $user_data    = Pointer
  ) {
    my uint64 $s = resolve-uint64($size);
    my gboolean $t = resolve-bool($trusted);
    self.bless( 
      variant => g_variant_new_from_data(
        $type, 
        $data, 
        $s, 
        $t, 
        $notify, 
        $user_data
      )
    );
  }

  method new_handle(
    GTK::Compat::Variant:U:
    Int() $handle
  ) {
    my gint $h = resolve-int($handle);
    self.bless( variant => g_variant_new_handle($h) );
  }

  method new_int16 (
    GTK::Compat::Variant:U:
    Int() $value
  ) {
    my int16 $v = resolve-int16($value);
    self.bless( variant => g_variant_new_int16($value) );
  }

  method new_int32 (
    GTK::Compat::Variant:U:
    int32 $value
  ) {
    my int32 $v = resolve-int32($value);
    self.bless( variant => g_variant_new_int32($value) );
  }

  method new_int64 (
    GTK::Compat::Variant:U:
    int64 $value
  ) {
    my int64 $v = resolve-int64($value);
    self.bless( variant => g_variant_new_int64($value) );
  }

  method new_maybe (
    GTK::Compat::Variant:U:
    GVariantType $type, 
    GVariant() $child
  ) {
    self.bless( variant => g_variant_new_maybe($type, $child) );
  }

  method new_object_path (
    GTK::Compat::Variant:U:
    Str() $value
  ) {
    self.bless( variant => g_variant_new_object_path($value) );
  }

  # method new_parsed_va (va_list $app) {
  #   g_variant_new_parsed_va($!v, $app);
  # }

  method new_signature (
    GTK::Compat::Variant:U:
    Str() $value
  ) {
    self.bless( variant => g_variant_new_signature($value) );
  }

  method new_string (
    GTK::Compat::Variant:U:
    Str() $value
  ) {
    self.bless( variant => g_variant_new_string($value) );
  }

  # Do not know how this will function when g_free is called on $value
  # method new_take_string (
  #   GTK::Compat::Variant:U:
  #   Str() $value
  # ) {
  #   g_variant_new_take_string($!v);
  # }

  method new_uint16 (
    GTK::Compat::Variant:U:
    Int() $value
  ) {
    my uint16 $v = resolve-uint16($value);
    self.bless( variant => g_variant_new_uint16($value) );
  }

  method new_uint32 (
    GTK::Compat::Variant:U:
    Int() $value
  ) {
    my uint32 $v = resolve-uint16($value);
    self.bless( variant => g_variant_new_uint32($value) );
  }

  method new_uint64 (
    GTK::Compat::Variant:U:
    Int() $value
  ) {
    my uint64 $v = resolve-uint64($value);
    self.bless( variant => g_variant_new_uint64($!v) );
  }

  # method new_va (Str() $endptr, va_list $app) {
  #   g_variant_new_va($!v, $endptr, $app);
  # }

  method new_variant (
    GTK::Compat::Variant:U:
    GVariant() $value
  ) {
    self.bless( variant => g_variant_new_variant($value) );
  }

  method parse (
    GTK::Compat::Variant:U:
    GVariantType $type,
    Str() $text, 
    Str() $limit, 
    Str() $endptr, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    $ERROR = Nil;
    my $rc = g_variant_parse($type, $text, $limit, $endptr, $error);
    $ERROR = $error with $error[0];
    $ERROR.defined ?? Nil !! self.bless( variant => $rc );
  }
  
  method byteswap {
    g_variant_byteswap($!v);
  }
  
  method check_format_string (Str() $format_string, Int() $copy_only) {
    my gboolean $co = resolve-bool($copy_only);
    g_variant_check_format_string($!v, $format_string, $co);
  }
  
  # Uses GVariantClass, so not in-scope.
  # method classify {
  #   g_variant_classify($!v);
  # }

  method compare (GVariant() $two) {
    g_variant_compare($!v, $two);
  }

  method dup_bytestring (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_dup_bytestring($!v, $l);
  }

  method dup_bytestring_array (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_dup_bytestring_array($!v, $l);
  }

  method dup_objv (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_dup_objv($!v, $l);
  }

  method dup_string (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_dup_string($!v, $l);
  }

  method dup_strv (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_dup_strv($!v, $l);
  }

  method equal (GVariant() $two) {
    g_variant_equal($!v, $two);
  }

  method get_boolean {
    so g_variant_get_boolean($!v);
  }

  method get_byte {
    g_variant_get_byte($!v);
  }

  method get_bytestring {
    g_variant_get_bytestring($!v);
  }

  method get_bytestring_array (gsize $length) {
    g_variant_get_bytestring_array($!v, $length);
  }

  method get_child_value (gsize $index_) {
    g_variant_get_child_value($!v, $index_);
  }

  method get_data {
    g_variant_get_data($!v);
  }

  method get_data_as_bytes {
    g_variant_get_data_as_bytes($!v);
  }

  method get_double {
    g_variant_get_double($!v);
  }

  method get_fixed_array (Int() $n_elements, Int() $element_size) {
    my uint64 ($ne, $es) = resolve-uint64($n_elements, $element_size);
    g_variant_get_fixed_array($!v, $ne, $es);
  }

  method get_handle {
    g_variant_get_handle($!v);
  }

  method get_int16 {
    g_variant_get_int16($!v);
  }

  method get_int32 {
    g_variant_get_int32($!v);
  }

  method get_int64 {
    g_variant_get_int64($!v);
  }

  method get_maybe {
    g_variant_get_maybe($!v);
  }

  method get_normal_form {
    g_variant_get_normal_form($!v);
  }

  method get_objv (gsize $length) {
    g_variant_get_objv($!v, $length);
  }

  method get_size {
    g_variant_get_size($!v);
  }

  method get_string (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_get_string($!v, $l);
  }

  method get_strv (Int() $length) {
    my uint64 $l = resolve-uint64($length);
    g_variant_get_strv($!v, $l);
  }

  # This is GLib, not GLib descendant, so it means what you'd think it means!
  method get_type {
    g_variant_get_type($!v);
  }

  method get_type_string {
    g_variant_get_type_string($!v);
  }

  method get_uint16 {
    g_variant_get_uint16($!v);
  }

  method get_uint32 {
    g_variant_get_uint32($!v);
  }

  method get_uint64 {
    g_variant_get_uint64($!v);
  }

  # method get_va (Str() $format_string, Str() $endptr, va_list $app) {
  #   g_variant_get_va($!v, $format_string, $endptr, $app);
  # }

  method get_variant {
    GTK::Compat::Variant.new( g_variant_get_variant($!v) );
  }

  method hash {
    g_variant_hash($!v);
  }

  method is_container {
    so g_variant_is_container($!v);
  }

  method is_floating {
    so g_variant_is_floating($!v);
  }

  method is_normal_form {
    so g_variant_is_normal_form($!v);
  }

  method is_object_path (
    GTK::Compat::Variant:U:
    Str() $path
  ) {
    so g_variant_is_object_path($path);
  }

  method is_of_type (GVariantType $type) {
    so g_variant_is_of_type($!v, $type);
  }

  method is_signature (
    GTK::Compat::Variant:U:
    Str() $signature
  ) {
    so g_variant_is_signature($signature);
  }

  method lookup_value (Str() $key, GVariantType $expected_type) {
    g_variant_lookup_value($!v, $key, $expected_type);
  }

  method n_children {
    g_variant_n_children($!v);
  }

  method parse_error_print_context (
    GTK::Compat::Variant:U:
    GError $error, 
    Str() $source_str
  ) {
    g_variant_parse_error_print_context($error, $source_str);
  }

  # Singleton.
  method parse_error_quark {
    g_variant_parse_error_quark();
  }

  method print (gboolean $type_annotate) {
    g_variant_print($!v, $type_annotate);
  }

  method print_string (GString $string, gboolean $type_annotate) {
    g_variant_print_string($!v, $string, $type_annotate);
  }

  method ref 
    #is also<upref>
  {
    g_variant_ref($!v);
  }

  method ref_sink {
    g_variant_ref_sink($!v);
  }

  method store (gpointer $data) {
    g_variant_store($!v, $data);
  }

  method take_ref {
    g_variant_take_ref($!v);
  }

  method unref 
    #is also<downref>
  {
    g_variant_unref($!v);
  }
  
}
  
