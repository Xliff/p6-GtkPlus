use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Raw::IsType;

use GTK::Compat::Types;
use GLib::Value;

use GTK::Raw::Subs;

role GTK::Roles::Properties {
  has GObject $!prop;

  method GTK::Compat::Types::GObject
    is also<GObject>
  { $!prop }

  # Superior to !setObject
  method roleInit-Object
    is also<
      roleInit_Object
      roleInit_Properties
      roleInit-Properties
    >
  {
    $!prop = cast( GObject, self.^attributes(:local)[0].get_value(self) );
  }

  # Deprecated.
  method !setObject($obj) {
    $!prop = nativecast(GObject, $obj);
  }

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
        .gvalue();
      }
    });
  }

  method is_type(GObjectOrPointer $t) {
    is_type($t, self);
  }

  method prop_set(Str() $name, GValue() $value) is also<prop-set> {
    self.set_prop($name, $value);
  }

  proto method set_prop (|)
    is also<set-prop>
  { * }

  multi method set_prop(Str() $name, GValue() $value) {
    samewith( [$name], [$value] );
  }
  multi method set_prop(@names, @values) {
    my @n = self!checkNames(@names);
    my @v = self!checkValues(@values);

    die 'Mismatched number of names and values when setting GObject properties.'
      unless +@n == +@v;

    my CArray[Str] $n = CArray[Str].new;
    my $i = 0;
    $n[$i++] = $_ for @n;
    # my CArray[GValue] $v = CArray[GValue].new;
    # $i = 0;
    # $v[$i++] = $_ for @v;

    # $i = 0;
    # for ^$v.elems {
    #   say "V{$i}: { $v[$i++] }";
    # }

    # say "P: {$!prop}";
    # say $n.^name;
    # $i = 0;
    # say "N{$i}: { $n[$i++] }" for $n;

    # -XXX- NOT a general purpose fix, but will work for now.
    my guint $ne = $n.elems;
    die "Cannot set properties with #elems == { $ne }" unless $ne > 0;
    g_object_setv( $!prop, $ne, $n, @v[0].p );
  }

  method prop_get(Str() $name, GValue() $value) is also<prop-get> {
    self.get_prop($name, $value.g_type);
  }

  proto method get_prop (|)
    is also<get-prop>
  { * }

  multi method get_prop(Str() $name, Int() $type) {
    my @v = ( GLib::Value.new($type).gvalue );
    samewith( [$name], @v );
    @v[0];
  }
  multi method get_prop(Str() $name, GValue() $value is rw) {
    my @v = ($value);
    samewith( [$name], @v );
    $value = @v[0];
  }
  multi method get_prop(@names, @values) {
    my @n = self!checkNames(@names);
    my @v = self!checkValues(@values);

    die 'Mismatched number of names and values when setting GObject properties.'
      unless +@n == +@v;

    my CArray[Str] $n = CArray[Str].new;
    my $i = 0;
    $n[$i++] = $_ for @n;
    # my CArray[GValue] $v = CArray[GValue].new;
    # $i = 0;
    # $v[$i++] = $_ for @v;

    # -XXX- NOT a general purpose fix, but will work for now.
    my $ne = $n.elems;
    die "Cannot get properties with #elems == { $ne }" unless $ne > 0;
    g_object_getv( $!prop, $ne, $n, @v[0].p );

    # @values = ();
    # @values.push( GLib::Value.new($v[$_]) ) for (^$v.elems);

    # Be perlish with the return. -- Maybe do @values[$_].value
    %(do for (^@names.elems) {
      @names[$_] => @values[$_];
    });
  }

  method prop_get_int(Str() $name) is also<prop-get-int> {
    my $a = g_object_get_int($!prop.p, $name);
    $a[0];
  }

  method prop_set_int (Str() $name, Int() $value) is also<prop-set-int> {
    g_object_set_int($!prop.p, $name, $value, Str);
  }

  method prop_get_uint(Str() $name) {
    my $a = g_object_get_uint($!prop.p, $name);
    $a[0];
  }

  method prop_set_uint (Str() $name, Int() $value) is also<prop-set-uint> {
    g_object_set_uint($!prop.p, $name, $value, Str);
  }

  # Should be in its own role that is common to both ::Compat::Roles::Object
  # and this one.
  method ref   is also<upref>   {   g_object_ref($!prop); self; }
  method unref is also<downref> { g_object_unref($!prop)        }

}
