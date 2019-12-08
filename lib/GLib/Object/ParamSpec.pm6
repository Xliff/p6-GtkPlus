use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GLib::Object::Raw::ParamSpec;

class GLib::Object::ParamSpec {
  has GParamSpec $name;

  submethod BUILD (:$spec) {
    $name = $spec;
  }

  method new_boolean (
    Str() $name,
    Str() $nick,,
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
    Str() $nick,,
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
    Str() $nick,,
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
    Str() $nick,,
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
    Str() $nick,,
    Str() $blurb,
    Int() $enum_type,
    Int() $default_value,
    Int() $flags
  ) {
    my GType $e = $enum_type;
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
    my GType $e = $enum_type;
    my guint $d = $default_value;
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_flags($name, $nick, $blurb, $f, $d, $f);

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
    my GType $o = $object_type
    my GParamFlags $f = $flags;
    my $spec = g_param_spec_object($name, $nick, $blurb, $object_type, $flags);

    $spec ?? self.bless( :$spec ) !! Nil;
  }

  method new_override (Int() $overridden) {
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
    g_param_spec_uchar($name, $nick, $blurb, $mn, $mx, $d, $flags);

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

}
