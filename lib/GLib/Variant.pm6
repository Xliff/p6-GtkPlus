use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;

use GLib::Raw::Variant;

class GLib::Variant {
  has GVariant $!v is implementor;

  submethod BUILD (:$variant) {
    $!v = $variant;
  }

  submethod DESTROY {
    self.downref;
  }

  method GTK::Compat::Types::GVariant
    is also<GVariant>
  { $!v }

  multi method new (GVariant $variant, :$ref = True) {
    my $o = self.bless( :$variant );
    $o.upref if $ref;
    $o;
  }

  multi method new (
    GLib::Variant:U:
    Int() $bool,
    :bool(:$boolean) is required
  ) {
    self.new_boolean($bool);
  }
  method new_boolean(
    GLib::Variant:U:
    Int() $bool
  )
    is also<new-boolean>
  {
    my gboolean $b = $bool;
    my $v = g_variant_new_boolean($b);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $byte_val,
    :$byte is required
  ) {
    self.new_byte($byte_val);
  }
  method new_byte(
    GLib::Variant:U:
    Int() $byte
  )
    is also<new-byte>
  {
    my uint8 $b = $byte;
    my $v = g_variant_new_byte($b);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Str() $bytestring_val,
    :$bytestring is required
  ) {
    self.new_bytestring($bytestring_val);
  }
  method new_bytestring(
    GLib::Variant:U:
    Str() $bytestring
  )
    is also<new-bytestring>
  {
    my $v = g_variant_new_bytestring($bytestring);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    GVariant() $key,
    GVariant() $value,
    :entry(:dict_entry(:$dict-entry)) is required
  ) {
    self.new_dict_entry($key, $value);
  }
  method new_dict_entry (
    GLib::Variant:U:
    GVariant() $key,
    GVariant() $value
  )
    is also<new-dict-entry>
  {
    my $v = g_variant_new_dict_entry($key, $value);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Num() $double_val,
    :$double is required
  ) {
    self.new_double($double_val);
  }
  method new_double (
    GLib::Variant:U:
    Num() $double
  )
    is also<new-double>
  {
    my gdouble $d = $double;
    my $v = g_variant_new_double($d);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    GVariantType $element_type,
    Pointer $elements,
    Int() $n_elements,
    Int() $element_size,
    :fixed_array(:fixed-array(:$array)) is required
  ) {
    self.new_fixed_array($element_type, $elements, $n_elements, $element_size);
  }
  method new_fixed_array (
    GLib::Variant:U:
    GVariantType $element_type,
    Pointer $elements,
    Int() $n_elements,
    Int() $element_size
  )
    is also<new-fixed-array>
  {
    my uint64 ($ne, $es) = resolve-uint64($n_elements, $element_size);
    my $v = g_variant_new_fixed_array(
      $element_type,
      $elements,
      $ne,
      $es
    );

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    GVariantType $type,
    GBytes $bytes_val,
    Int() $trusted,
    :$bytes is required
  ) {
    self.new_from_bytes($type, $bytes_val, $trusted);
  }
  method new_from_bytes (
    GLib::Variant:U:
    GVariantType $type,
    GBytes $bytes,
    Int() $trusted
  )
    is also<new-from-bytes>
  {
    my gboolean $t = $trusted;
    my $v = g_variant_new_from_bytes($type, $bytes, $t);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    GVariantType $type,
    gconstpointer $data_val,
    Int() $size,
    Int() $trusted,
    GDestroyNotify $notify = Pointer,
    gpointer $user_data    = Pointer,
    :$data is required
  ) {
    self.new_from_data($type, $data_val, $size, $trusted, $notify, $user_data);
  }
  method new_from_data (
    GLib::Variant:U:
    GVariantType $type,
    gconstpointer $data,
    Int() $size,
    Int() $trusted,
    GDestroyNotify $notify = Pointer,
    gpointer $user_data    = Pointer
  )
    is also<new-from-data>
  {
    my uint64 $s = $size;
    my gboolean $t = $trusted;
    my $v = g_variant_new_from_data(
      $type,
      $data,
      $s,
      $t,
      $notify,
      $user_data
    );

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $handle_int,
    :$handle is required
  ) {
    self.new_handle($handle_int);
  }
  method new_handle(
    GLib::Variant:U:
    Int() $handle
  )
    is also<new-handle>
  {
    my gint $h = $handle;
    my $v = g_variant_new_handle($h);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $value,
    :$int16 is required
  ) {
    self.new_int16($value);
  }
  method new_int16 (
    GLib::Variant:U:
    Int() $value
  )
    is also<new-int16>
  {
    my int16 $val = $value;
    my $v = g_variant_new_int16($val);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $value,
    :$int32 is required
  ) {
    self.new_int32($value);
  }
  method new_int32 (
    GLib::Variant:U:
    Int() $value
  )
    is also<new-int32>
  {
    my int32 $val = $value;
    my $v = g_variant_new_int32($val);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $value,
    :$int64 is required
  ) {
    self.new_int64($value);
  }
  method new_int64 (
    GLib::Variant:U:
    Int() $value
  )
    is also<new-int64>
  {
    my int64 $val = $value;
    my $v = g_variant_new_int64($val);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    GVariantType() $type,
    GVariant() $child,
    :$maybe is required
  ) {
    self.new_maybe($type, $child);
  }
  method new_maybe (
    GLib::Variant:U:
    GVariantType $type,
    GVariant() $child
  )
    is also<new-maybe>
  {
    my $v = g_variant_new_maybe($type, $child);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Str() $value,
    :object_path(:object-path(:obj_path(:obj-path(:$path)))) is required
  ) {
    self.new_object_path($value);
  }
  method new_object_path (
    GLib::Variant:U:
    Str() $value
  )
    is also<new-object-path>
  {
    my $v = g_variant_new_object_path($value);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  # method new_parsed_va (va_list $app) {
  #   g_variant_new_parsed_va($!v, $app);
  # }

  multi method new (
    GLib::Variant:U:
    Str() $value,
    :$signature is required
  ) {
    self.new_signature($value);
  }
  method new_signature (
    GLib::Variant:U:
    Str() $value
  )
    is also<new-signature>
  {
    my $v = g_variant_new_signature($value);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Str() $value,
    :$string is required
  ) {
    self.new_string($value);
  }
  method new_string (
    GLib::Variant:U:
    Str() $value
  )
    is also<new-string>
  {
    my $v = g_variant_new_string($value);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  # Do not know how this will function when GLib::Memory.free is called on
  # $value
  #
  # method new_take_string (
  #   GLib::Variant:U:
  #   Str() $value
  # ) {
  #   g_variant_new_take_string($!v);
  # }

  multi method new (
    GLib::Variant:U:
    Int() $value,
    :$uint16 is required
  ) {
    self.new_uint16($value);
  }
  method new_uint16 (
    GLib::Variant:U:
    Int() $value
  )
    is also<new-uint16>
  {
    my uint16 $val = $value;
    my $v = g_variant_new_uint16($val);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $value,
    :$uint32 is required
  ) {
    self.new_uint32($value);
  }
  method new_uint32 (
    GLib::Variant:U:
    Int() $value
  )
    is also<new-uint32>
  {
    my uint32 $val = $value;
    my $v = g_variant_new_uint32($val);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  multi method new (
    GLib::Variant:U:
    Int() $value,
    :$uint64 is required
  ) {
    self.new_uint64($value);
  }
  method new_uint64 (
    GLib::Variant:U:
    Int() $value
  )
    is also<new-uint64>
  {
    my uint64 $val = $value;
    my $v = g_variant_new_uint64($val);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  # method new_va (Str() $endptr, va_list $app) {
  #   g_variant_new_va($!v, $endptr, $app);
  # }

  multi method new (
    GLib::Variant:U:
    GVariant() $value,
    :$variant is required
  ) {
    self.new_variant($value);
  }
  method new_variant (
    GLib::Variant:U:
    GVariant() $value
  )
    is also<new-variant>
  {
    my $v = g_variant_new_variant($value);

    $v ?? self.bless( variant => $v ) !! Nil;
  }

  method parse (
    GLib::Variant:U:
    GVariantType $type,
    Str() $text,
    Str() $limit,
    Str() $endptr,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rc = g_variant_parse($type, $text, $limit, $endptr, $error);
    set_error($error);
    $rc ?? self.bless( variant => $rc ) !! Nil;
  }

  method byteswap {
    g_variant_byteswap($!v);
  }

  method check_format_string (Str() $format_string, Int() $copy_only)
    is also<check-format-string>
  {
    my gboolean $co = $copy_only;

    g_variant_check_format_string($!v, $format_string, $co);
  }

  # Uses GVariantClass, so not in-scope.
  # method classify {
  #   g_variant_classify($!v);
  # }

  method compare (GVariant() $two) {
    g_variant_compare($!v, $two);
  }

  method dup_bytestring (Int() $length) is also<dup-bytestring> {
    my uint64 $l = $length;

    g_variant_dup_bytestring($!v, $l);
  }

  method dup_bytestring_array (Int() $length) is also<dup-bytestring-array> {
    my uint64 $l = $length;

    g_variant_dup_bytestring_array($!v, $l);
  }

  method dup_objv (Int() $length) is also<dup-objv> {
    my uint64 $l = $length;

    g_variant_dup_objv($!v, $l);
  }

  method dup_string (Int() $length) is also<dup-string> {
    my uint64 $l = $length;

    g_variant_dup_string($!v, $l);
  }

  method dup_strv (Int() $length) is also<dup-strv> {
    my uint64 $l = $length;

    g_variant_dup_strv($!v, $l);
  }

  method equal (GVariant() $two) {
    g_variant_equal($!v, $two);
  }

  method get_boolean
    is also<
      get-boolean
      boolean
    >
  {
    so g_variant_get_boolean($!v);
  }

  method get_byte
    is also<
      get-byte
      byte
    >
  {
    g_variant_get_byte($!v);
  }

  method get_bytestring
    is also<
      get-bytestring
      bytestring
    >
  {
    g_variant_get_bytestring($!v);
  }

  method get_bytestring_array (Int() $length) is also<get-bytestring-array> {
    my gsize $l = $length;

    g_variant_get_bytestring_array($!v, $length);
  }

  method get_child_value (Int() $index) is also<get-child-value> {
    my gsize $i = $index;

    g_variant_get_child_value($!v, $i);
  }

  method get_data
    is also<
      get-data
      data
    >
  {
    g_variant_get_data($!v);
  }

  method get_data_as_bytes
    is also<
      get-data-as-bytes
      data_as_bytes
      data-as-bytes
    >
  {
    g_variant_get_data_as_bytes($!v);
  }

  method get_double
    is also<
      get-double
      double
    >
  {
    g_variant_get_double($!v);
  }

  method get_fixed_array (Int() $n_elements, Int() $element_size)
    is also<get-fixed-array>
  {
    my uint64 ($ne, $es) = resolve-uint64($n_elements, $element_size);

    g_variant_get_fixed_array($!v, $ne, $es);
  }

  method get_handle
    is also<
      get-handle
      handle
    >
  {
    g_variant_get_handle($!v);
  }

  method get_int16
    is also<
      get-int16
      int16
    >
  {
    g_variant_get_int16($!v);
  }

  method get_int32
    is also<
      get-int32
      int32
    >
  {
    g_variant_get_int32($!v);
  }

  method get_int64
    is also<
      get-int64
      int64
    >
  {
    g_variant_get_int64($!v);
  }

  method get_maybe
    is also<
      get-maybe
      maybe
    >
  {
    g_variant_get_maybe($!v);
  }

  method get_normal_form
    is also<
      get-normal-form
      normal_form
      normal-form
    >
  {
    g_variant_get_normal_form($!v);
  }

  method get_objv (Int() $length) is also<get-objv> {
    my gsize $l = $length;

    g_variant_get_objv($!v, $length);
  }

  method get_size
    is also<
      get-size
      size
    >
  {
    g_variant_get_size($!v);
  }

  method get_string (Int() $length)
    is also<
      get-string
      string
    >
  {
    my uint64 $l = $length;

    g_variant_get_string($!v, $l);
  }

  method get_strv (Int() $length) is also<get-strv> {
    my uint64 $l = $length;

    CStringArrayToArray( g_variant_get_strv($!v, $l) );
  }

  # This is GLib, not a GLib descendant, so it means what you'd think it means!
  # That is: no unstable_get_type needed, here!
  method get_type
    is also<
      get-type
      type
    >
  {
    GTypeEnum( g_variant_get_type($!v) );
  }

  method get_type_string
    is also<
      get-type-string
      type_string
      type-string
    >
  {
    g_variant_get_type_string($!v);
  }

  method get_uint16
    is also<
      get-uint16
      uint16
    >
  {
    g_variant_get_uint16($!v);
  }

  method get_uint32
    is also<
      get-uint32
      uint32
    >
  {
    g_variant_get_uint32($!v);
  }

  method get_uint64
    is also<
      get-uint64
      uint64
    >
  {
    g_variant_get_uint64($!v);
  }

  # method get_va (Str() $format_string, Str() $endptr, va_list $app) {
  #   g_variant_get_va($!v, $format_string, $endptr, $app);
  # }

  method get_variant (:$raw = False)
    is also<
      get-variant
      variant
    >
  {
    my $v = g_variant_get_variant($!v);

    $v ??
      ( $raw ?? $v !! GLib::Variant.new($v, :!ref) )
      !!
      Nil;
  }

  method hash {
    g_variant_hash($!v);
  }

  method is_container
    is also<
      is-container
      container
    >
  {
    so g_variant_is_container($!v);
  }

  method is_floating
    is also<
      is-floating
      floating
    >
  {
    so g_variant_is_floating($!v);
  }

  # Shorter aliases go in favor of the get_* form
  method is_normal_form is also<is-normal-form>
  {
    so g_variant_is_normal_form($!v);
  }

  method is_object_path (
    GLib::Variant:U:
    Str() $path
  )
    is also<is-object-path>
  {
    so g_variant_is_object_path($path);
  }

  method is_of_type (GVariantType $type) is also<is-of-type> {
    so g_variant_is_of_type($!v, $type);
  }

  method is_signature (
    GLib::Variant:U:
    Str() $signature
  )
    is also<is-signature>
  {
    so g_variant_is_signature($signature);
  }

  method lookup_value (Str() $key, GVariantType $expected_type)
    is also<lookup-value>
  {
    g_variant_lookup_value($!v, $key, $expected_type);
  }

  method n_children
    is also<
      n-children
      elems
    >
  {
    g_variant_n_children($!v);
  }

  method parse_error_print_context (
    GLib::Variant:U:
    GError() $error,
    Str() $source_str
  )
    is also<parse-error-print-context>
  {
    g_variant_parse_error_print_context($error, $source_str);
  }

  # Singleton.
  method parse_error_quark is also<parse-error-quark> {
    g_variant_parse_error_quark();
  }

  method print (Int() $type_annotate) {
    my gboolean $t = $type_annotate;

    g_variant_print($!v, $t);
  }

  method print_string (GString $string, Int() $type_annotate)
    is also<print-string>
  {
    my gboolean $t = $type_annotate;

    g_variant_print_string($!v, $string, $t);
  }

  method ref is also<upref> {
    g_variant_ref($!v);
    self;
  }

  method ref_sink is also<ref-sink> {
    g_variant_ref_sink($!v);
    self;
  }

  method store (gpointer $data) {
    g_variant_store($!v, $data);
  }

  method take_ref is also<take-ref> {
    g_variant_take_ref($!v);
  }

  method unref is also<downref> {
    g_variant_unref($!v);
  }

}
