use v6.c;

use Method::Also;

use GTK::Raw::Switch:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Actionable:ver<3.0.1146>;

our subset SwitchAncestry is export
  where GtkSwitch | GtkActionable | GtkWidgetAncestry;

class GTK::Switch:ver<3.0.1146> is GTK::Widget {
  also does GTK::Roles::Actionable;

  has GtkSwitch $!s is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$switch) {
    my $to-parent;
    given $switch {
      when SwitchAncestry {
        $!s = do {
          when GtkSwitch {
            $to-parent = cast(GtkWidget, $_);
            $_;
          }
          when GtkActionable {
            $!action = cast(GtkActionable, $_);
            $to-parent = cast(GtkWidget, $_);
            cast(GtkSwitch, $_);                # GTK::Roles::Actionable
          }
          default {
            $to-parent = $_;
            cast(GtkSwitch, $_);
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Switch {
      }
      default {
      }
    }
    $!action //= cast(GtkActionable, $!s);      # GTK::Roles::Actionable
  }

  method GTK::Raw::Definitions::GtkSwitch
    is also<
      Switch
      GtkSwitch
    >
  { $!s }

  multi method new(SwitchAncestry $switch, :$ref = True) {
    return Nil unless $switch;

    my $o = self.bless(:$switch);
    $o.ref if $switch;
    $o;
  }
  multi method new {
    my $switch = gtk_switch_new();

    $switch ?? self.bless(:$switch) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkSwitch, gpointer --> void
  method activate {
    self.connect($!s, 'activate');
  }

  # Is originally:
  # GtkSwitch, gboolean, gpointer --> gboolean
  method state-set is also<state_set> {
    self.connect-uint-ruint($!s, 'state-set');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method active is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_switch_get_active($!s);
      },
      STORE => sub ($, Int() $is_active is copy) {
        my gboolean $ia = $is_active.so.Int;

        gtk_switch_set_active($!s, $ia);
      }
    );
  }

  method state is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_switch_get_state($!s);
      },
      STORE => sub ($, Int() $state is copy) {
        my gboolean $s = $state.so.Int;

        gtk_switch_set_state($!s, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);
    
    GTK::Widget.unstable_get_type( &gtk_switch_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
