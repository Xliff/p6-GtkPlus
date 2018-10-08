use v6.c;

use NativeCall;

use GTK::Compat::Types;

role GTK::Roles::Properties {
  has GObject $!prop;

  method !checkNames(@names) {
    gather {
      for @names {
        if $_ ~~ Str {
          .take;
        } else {
          unless .^can('Str').elems {
            die "$_ value cannot be coerced to string.";
          }
          take .Str;
        }
      }
    }
  }

  method !checkValues(@values) {
    gather {
      for @values {
        if $_ ~~ GValue {
          .take;
          unless .^can('GValue').elems {
            die "$_ value cannot be coerced to GValue";
          }
          take .GValue;
        }
      }
    }
  }

  method set_prop(@names, @values) {
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

  method get_prop(@names, @values) {
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
    @values.push($v[$_]) for (^$v.elems);

    # Be perlish with the return.
    %(
      gather {
        for (^@names.elems) {
          take @names[$_] => @values[$_];
        }
      }
    );
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
