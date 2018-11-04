use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;

role GTK::Roles::Properties {
  has GObject $!prop;

  method !checkNames(@names) {
    @names.map({
      if $_ ~~ Str {
        $_;
      } else {
        unless .^can('Str').elems {
          die "$_ value cannot be coerced to string.";
        }
        .Str;
      }
    });
  }

  method !checkValues(@values) {
    @values.map({
      if $_ ~~ GValue {
        $_;
      } else {
        unless .^can('GValue').elems {
          die "$_ value cannot be coerced to GValue";
        }
        .'GTK::Compat::Types::GValue'();
      }
    });
  }

  proto method set_prop(|) is also<prop_set> { * }

  multi method set_prop(Str() $name, GValue() $value) {
    samewith( $name.Array, ($value) );
  }
  multi method set_prop(@names, @values) {
    my @n = self!checkNames(@names);
    my @v = self!checkValues(@values);

    die 'Mismatched number of names and values when setting GObject properties.'
      unless +@n == +@v;

    my CArray[Str] $n = CArray[Str].new;
    $n[$++] = $_ for @n;
    my CArray[GValue] $v = CArray[GValue].new;
    $v[$++] = $_ for @v;

    g_object_setv($!prop, $n.elems, $n, $v);
  }

  proto method get_prop(|) is also<prop_get> { * }

  multi method get_prop(Str() $name, GValue() $value is rw) {
    my @v = ($value);
    samewith( $name.Array, @v );
    $value = @v[0];
  }
  multi method get_prop(@names, @values) {
    my @n = self!checkNames(@names);
    my @v = self!checkValues(@values);

    die 'Mismatched number of names and values when setting GObject properties.'
      unless +@n == +@v;

    my CArray[Str] $n = CArray[Str].new;
    $n[$++] = $_ for @n;
    my CArray[GValue] $v = CArray[GValue].new;
    $v[$++] = $_ for @v;

    g_object_getv($!prop, $n.elems, $n, $v);

    @values = ();
    @values.push( GTK::Compat::Value.new($v[$_]) ) for (^$v.elems);

    # Be perlish with the return.
    %(do for (^@names.elems) {
      @names[$_] => @values[$_];
    });
  }

}

sub g_object_setv (
  GObject $object,
  guint $n_properties,
  CArray[Str] $names,
  CArray[GValue] $values
)
  is native(gobject)
  { * }

sub g_object_getv (
  GObject $object,
  guint $n_properties,
  CArray[Str] $names,
  CArray[GValue] $values
)
  is native(gobject)
  { * }
