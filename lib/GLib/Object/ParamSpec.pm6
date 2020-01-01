use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GLib::Raw::Subs;

use GLib::Object::Raw::ParamSpec;

use GLib::Value;

class GLib::Object::ParamSpec {
  has GParamSpec $!ps;

  submethod BUILD (:$spec) {
    $!ps = $spec;
  }

  method GTK::Compat::Types::GParamSpec
  { $!ps }

  method new (GParamSpec $spec, :$ref = True) {
    return Nil unless $spec;

    my $o = self.bless( :$spec );
    $o.ref if $ref;
    $o
  }

  method new_boolean (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $default_value,
    Int() $flags
  ) {
    my gboolean $d = $default_value;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_boolean($name, $nick, $blurb, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_boxed (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $boxed_type,
    Int() $flags
  ) {
    my GType $b = $boxed_type;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_boxed($name, $nick, $blurb, $b, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_char (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my gint8 ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_char($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_double (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Num() $minimum,
    Num() $maximum,
    Num() $default_value,
    Int() $flags
  ) {
    my GParamFlags $f = $flags;
    my gdouble ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my $spec = g_param_spec_double($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_enum (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $enum_type,
    Int() $default_value,
    Int() $flags
  ) {
    my GType $e = $enum_type;
    my gint $d = $default_value;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_enum($name, $nick, $blurb, $e, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_flags (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $flags_type,
    Int() $default_value,
    Int() $flags
  ) {
    my GType $ft = $flags_type;
    my guint $d = $default_value;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_flags($name, $nick, $blurb, $ft, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_float (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Num() $minimum,
    Num() $maximum,
    Num() $default_value,
    Int() $flags
  ) {
    my gfloat ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_float($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_gtype (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $is_a_type,
    Int() $flags
  ) {
    my GType $i = $is_a_type;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_gtype($name, $nick, $blurb, $i, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_int (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my gint ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_int($name, $nick, $blurb, $mn, $mx, $d, $flags);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_int64 (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my gint64 ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_int64($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_long (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my glong ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_long($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_object (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $object_type,
    Int() $flags
  ) {
    my GType $o = $object_type;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_object($name, $nick, $blurb, $object_type, $flags);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_override (Str() $name, Int() $overridden) {
    my GParamSpec $o = $overridden;
    my $spec = g_param_spec_override($name, $overridden);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_param (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $param_type,
    Int() $flags
  ) {
    my GParamFlags $f = $flags;
    my GType $p = $param_type,
    my $spec = g_param_spec_param($name, $nick, $blurb, $p, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_pointer (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $flags
  ) {
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_pointer($name, $nick, $blurb, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_string (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Str() $default_value,
    Int() $flags
  ) {
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_string($name, $nick, $blurb, $default_value, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_uchar (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my guint8 ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_uchar($name, $nick, $blurb, $mn, $mx, $d, $flags);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_uint (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my guint ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_uint($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_uint64 (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my guint64 ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_uint64($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_ulong (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $minimum,
    Int() $maximum,
    Int() $default_value,
    Int() $flags
  ) {
    my gulong ($mn, $mx, $d) = ($minimum, $maximum, $default_value);
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_ulong($name, $nick, $blurb, $mn, $mx, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_unichar (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $default_value,
    Int() $flags
  ) {
    my gunichar $d = $default_value;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_unichar($name, $nick, $blurb, $d, $f);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_value_array (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    GParamSpec() $element_spec,
    Int() $flags
  ) {
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_value_array(
      $name,
      $nick,
      $blurb,
      $element_spec,
      $f
    );

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_variant (
    Str() $name,
    Str() $nick,
    Str() $blurb,
    Int() $type,
    GVariant() $default_value,
    Int() $flags
  ) {
    my GVariantType $t = $type;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_variant(
      $name,
      $nick,
      $blurb,
      $t,
      $default_value,
      $f
    );

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method get_blurb {
    g_param_spec_get_blurb($!ps);
  }

  method get_default_value {
    my $v = g_param_spec_get_default_value($!ps);

    $v ?? GLib::Value.new($v, :!ref) !! Nil
  }

  method get_name {
    g_param_spec_get_name($!ps);
  }

  method get_name_quark {
    g_param_spec_get_name_quark($!ps);
  }

  method get_nick {
    g_param_spec_get_nick($!ps);
  }

  method get_qdata (GQuark $quark) {
    g_param_spec_get_qdata($!ps, $quark);
  }

  method get_redirect_target {
    my $p = g_param_spec_get_redirect_target($!ps);

    $p ?? GLib::Object::ParamSpec.new($p, :!ref) !! Nil;
  }

  method internal (Str() $name, Str() $nick, Str() $blurb, Int() $flags) {
    my GParamFlags $f = $flags;

    g_param_spec_internal($!ps, $name, $nick, $blurb, $f);
  }

  method ref {
    g_param_spec_ref($!ps);
    self;
  }

  method ref_sink {
    g_param_spec_ref_sink($!ps);
    self;
  }

  method set_qdata (GQuark $quark, gpointer $data) {
    g_param_spec_set_qdata($!ps, $quark, $data);
  }

  method set_qdata_full (
    GQuark $quark,
    gpointer $data,
    GDestroyNotify $destroy = gpointer
  ) {
    g_param_spec_set_qdata_full($!ps, $quark, $data, $destroy);
  }

  method sink {
    g_param_spec_sink($!ps);
  }

  method steal_qdata (GQuark $quark) {
    g_param_spec_steal_qdata($!ps, $quark);
  }

  method unref {
    g_param_spec_unref($!ps);
  }

  method type_register_static (
    GLib::Object::ParamSpec:U:
    Str() $name,
    GParamSpecTypeInfo $pspec_info
  ) {
    my $t = g_param_type_register_static($name, $pspec_info);

    # INFO -- The PROPER way to handle GTypeEnum as a return value.
    my $ret = GTypeEnum($t);
    $ret.so ?? $ret !! $t
  }

  method values_cmp (GValue() $value1, GValue() $value2) {
    so g_param_values_cmp($!ps, $value1, $value2);
  }

  method value_convert (
    GValue() $src_value,
    GValue() $dest_value,
    Int() $strict_validation
  ) {
    my gboolean $s = (so $strict_validation).Int;

    so g_param_value_convert($!ps, $src_value, $dest_value, $s);
  }

  method value_defaults (GValue() $value) {
    so g_param_value_defaults($!ps, $value);
  }

  method value_set_default (GValue() $value) {
    g_param_value_set_default($!ps, $value);
  }

  method value_validate (GValue() $value) {
    so g_param_value_validate($!ps, $value);
  }

}


class GLib::Object::ParamSpec::Pool {
  has GParamSpecPool $!psp;

  submethod BUILD (:$pool) {
    $!psp = $pool;
  }

  method GTK::Compat::Types::GParamSpecPool
  { $!psp }

  multi method new (GParamSpecPool $pool, :$ref = True) {
    return Nil unless $pool;

    my $o = self.bless(:$pool);
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $type_prefixing) {
    my gboolean $t = (so $type_prefixing).Int;
    my $pool = g_param_spec_pool_new($t);

    $pool ?? self.bless(:$pool) !! Nil;
  }

  method insert (GParamSpec() $pspec, Int() $owner_type) {
    my GType $o = $owner_type;

    g_param_spec_pool_insert($!psp, $pspec, $o);
  }

  multi method list (Int() $owner_type, :$all = True, :$raw = False) {
    samewith($owner_type, $, :$all, :$raw);
  }
  multi method list (
    Int() $owner_type,
    $n_pspecs_p is rw,
    :$all = False,
    :$raw = False
  ) {
    my GType $o = $owner_type;
    my guint $n = 0;

    my $la = g_param_spec_pool_list($!psp, $owner_type, $n);
    $la = CArrayToArray($la) unless $raw;
    $n_pspecs_p = $n;
    $all.not ?? $la !! ($la, $n_pspecs_p);
  }

  method list_owned (Int() $owner_type, :$glist = False, :$raw = False) {
    my GType $o = $owner_type;
    my $pl = g_param_spec_pool_list_owned($!psp, $owner_type);

    return Nil unless $pl;
    return $pl if     $glist;

    $pl = GTK::Compat::List.new($pl)
      but GLib::Roles::ListData[GParamSpec];

    $raw ??
      $pl.Array
      !!
      $pl.Array.map({ GLib::Object::ParamSpec.new($_, :!ref) })

  }

  method lookup (Str() $param_name, Int() $owner_type, Int() $walk_ancestors) {
    my GType $o = $owner_type;
    my gboolean $w = $walk_ancestors;
    my $p = g_param_spec_pool_lookup($!psp, $param_name, $o, $w);

    $p ?? GLib::Object::ParamSpec.new($p, :!ref) !! Nil;
  }

  method remove (GParamSpec() $pspec) {
    g_param_spec_pool_remove($!psp, $pspec);
  }

}
