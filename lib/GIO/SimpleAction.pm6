use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GIO::Raw::SimpleAction;
use GTK::Raw::Utils;

use GIO::Roles::Action;

# Will need ancestry since this could be built from a GAction!!

class GTK::Compat::SimpleAction {
  also does GIO::Roles::Action;

  has GSimpleAction $!sa is implementor;

  submethod BUILD (:$simple-action) {
    $!sa = $simple-action;

    self!roleInit-Object;
  }

  method GTK::Compat::Types::GSimpleAction
    is also<GSimpleAction>
  { $!sa }

  multi method new (GSimpleAction $simple-action) {
    self.bless( :$simple-action );
  }
  multi method new (GVariantType() $parameter_type) {
    my $sa = g_simple_action_new($$parameter_type);

    $sa ?? self.bless( simple-action => $sa) !! Nil;
  }

  method new_stateful (GVariantType() $parameter_type, GVariant() $state)
    is also<new-stateful>
  {
    my $sa = g_simple_action_new_stateful($parameter_type, $state);

    $sa ?? self.bless( action => $sa ) !! Nil;
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
        $gv.boolean = $val;
        self.prop_set('enabled', $gv);
      }
    );
  }

  # CONSTRUCT-ONLY!
  #
  # Type: gchar
  # method name is rw  {
  #   my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('name', $gv)
  #       );
  #       $gv.string;
  #     },
  #     STORE => -> $, Str() $val is copy {
  #       $gv.string = $val;
  #       self.prop_set('name', $gv);
  #     }
  #   );
  # }
  #
  # # Type: GVariantType
  # method parameter-type is rw  {
  #   my GTK::Compat::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('parameter-type', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('parameter-type', $gv);
  #     }
  #   );
  # }

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
      STORE => -> $, GVariant() $val is copy {
        $gv.object = $val;
        self.prop_set('state', $gv);
      }
    );
  }

  # Type: GVariantType
  method state-type is rw  is also<state_type> {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('state-type', $gv)
        );
        GTK::Compat::VariantType.new(
          nativecast(GVariantType, $gv.object )
        )
      },
      STORE => -> $, $val is copy {
        warn "state-type does not allow writing"
      }
    );
  }

  # Is originally:
  # GSimpleAction, GVariant, gpointer --> void
  method activate {
    self.connect-variant($!sa, 'activate');
  }

  # Is originally:
  # GSimpleAction, GVariant, Pointer
  method change-state is also<change_state> {
    self.connect-variant($!sa, 'change-state');
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_simple_action_get_type, $n, $t );
  }

  method set_enabled (Int() $enabled) is also<set-enabled> {
    my gboolean $e = $enabled;

    g_simple_action_set_enabled($!sa, $e);
  }

  method set_state (GVariant() $value) is also<set-state> {
    g_simple_action_set_state($!sa, $value);
  }

  method set_state_hint (GVariant() $state_hint) is also<set-state-hint> {
    g_simple_action_set_state_hint($!sa, $state_hint);
  }

}
