use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Compat::Roles::Action;

class GTK::Compat::PropertyAction {
  also does GTK::Compat::Roles::Action;

  has GPropertyAction $!pa;

  submethod BUILD (:$action) {
    self!setObject($!pa = $action);
    $!a = cast(GAction, $!pa);            # GTK::Compat::Roles::Action
  }

  method GTK::Compat::Types::GPropertyAction
    # is also<PropertyAction>
  { $!pa }

  proto method new (|) { * }

  multi method new (Str() $name, GObject() $object, Str $property_name) {
    samewith($name, $property_name, $object);
  }
  multi method new (
    Str() $name,
    Str $property_name,
    GObject() $object = GObject
  ) {
    self.bless(
      action => g_property_action_new($name, $object, $property_name)
    );
  }

  # Type: gboolean
  method enabled is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('enabled', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn "enabled does not allow writing"
      }
    );
  }

  # Type: gboolean
  method invert-boolean is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('invert-boolean', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('invert-boolean', $gv);
      }
    );
  }

  # Type: gchar
  method name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: GObject
  method object is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        warn "object does not allow reading"
      },
      STORE => -> $, GObject() $val is copy {
        $gv.object = $val;
        self.prop_set('object', $gv);
      }
    );
  }

  # Type: GVariantType
  method parameter-type is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('parameter-type', $gv)
        );
        GTK::Compat::VariantType.new(
          nativecast(GVariantType, $gv.pointer)
        );
      },
      STORE => -> $,  $val is copy {
        warn "parameter-type does not allow writing"
      }
    );
  }

  # Type: gchar
  method property-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        warn "property-name does not allow reading"
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('property-name', $gv);
      }
    );
  }

  # Type: GVariant
  method state is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('state', $gv)
        );
        GTK::Compat::Variant.new(
          nativecast(GVariant, $gv.object), :!ref
        );
      },
      STORE => -> $,  $val is copy {
        warn "state does not allow writing"
      }
    );
  }

  # Type: GVariantType
  method state-type is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('state-type', $gv)
        );
        GTK::Compat::VariantType.new(
          nativecast(GVariantType, $gv.pointer )
        );
      },
      STORE => -> $, $val is copy {
        warn "state-type does not allow writing"
      }
    );
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &g_property_action_get_type, $n, $t );
  }

}

sub g_property_action_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_property_action_new (Str $name, gpointer $object, Str $property_name)
  returns GPropertyAction
  is native(gio)
  is export
  { * }
