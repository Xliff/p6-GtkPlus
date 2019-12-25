use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;

use GLib::Value;
use GIO::Roles::Action;

class GIO::PropertyAction {
  also does GIO::Roles::Action;

  has GPropertyAction $!pa is implementor;

  submethod BUILD (:$action) {
    $!pa = $action;

    self.roleInit-Object;
    self!roleInit-Action;
  }

  method GTK::Compat::Types::GPropertyAction
    is also<GPropertyAction>
  { $!pa }

  proto method new (|)
  { * }

  multi method new (
    Str() $name,
    Str $property_name,
    GObject() $object = GObject
  ) {
    samewith($name, $object, $property_name);
  }
  multi method new (Str() $name, GObject() $object, Str() $property_name) {
    my $a = g_property_action_new($name, $object, $property_name);

    $a ?? self.bless( action => $a ) !! Nil;
  }

  # Type: gboolean
  method enabled is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
  method invert-boolean is rw is also<invert_boolean> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        warn 'object does not allow reading'
      },
      STORE => -> $, GObject() $val is copy {
        $gv.object = $val;
        self.prop_set('object', $gv);
      }
    );
  }

  # Type: GVariantType
  method parameter-type (:$raw = False) is rw is also<parameter_type> {
    my GLib::Value $gv .= new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('parameter-type', $gv)
        );

        do if $gv.pointer {
          my $vt = cast(GVariantType, $gv.pointer);
          $raw ?? $vt !! GLib::VariantType.new($vt);
        } else {
          Nil;
        }
      },
      STORE => -> $,  $val is copy {
        warn 'parameter-type does not allow writing';
      }
    );
  }

  # Type: gchar
  method property-name is rw  is also<property_name> {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        warn 'property-name does not allow reading'
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('property-name', $gv);
      }
    );
  }

  # Type: GVariant
  method state (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('state', $gv)
        );

        do if $gv.object {
          my $v = cast(GVariant, $gv.object);
          $raw ?? $v !! $GLib::Variant.new($v, :!ref);
        } else {
          Nil;
        }
      },
      STORE => -> $,  $val is copy {
        warn 'state does not allow writing'
      }
    );
  }

  # Type: GVariantType
  method state-type (:$raw = False) is rw  is also<state_type> {
    my GLib::Value $gv .= new( G_TYPE_BOXED );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('state-type', $gv)
        );
        do if $gv.pointer {
          my $vt = cast(GVariantType, $gv.pointer);
          $raw ?? $vt !! GLib::VariantType.new($vt);
        } else {
          Nil;
        }
      },
      STORE => -> $, $val is copy {
        warn 'state-type does not allow writing';
      }
    );
  }

  method get_type is also<get-type> {
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
