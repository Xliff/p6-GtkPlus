use v6.c;

use Method::Also;
use NativeCall;


use GTK::Raw::Switch;
use GTK::Raw::Types;

use GTK::Widget;

use GTK::Roles::Actionable;

our subset SwitchAncestry is export 
  where GtkSwitch | GtkActionable | WidgetAncestry;

class GTK::Switch is GTK::Widget {
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
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
          when GtkActionable {
            $!action = nativecast(GtkActionable, $_);
            $to-parent = nativecast(GtkWidget, $_);
            nativecast(GtkSwitch, $_);                # GTK::Roles::Actionable
          }
          default {
            $to-parent = $_;
            nativecast(GtkSwitch, $_);
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Switch {
      }
      default {
      }
    }
    $!action //= nativecast(GtkActionable, $!s);      # GTK::Roles::Actionable
  }
  
  method GTK::Raw::Types::GtkSwitch is also<Switch> { $!s }

  multi method new(SwitchAncestry $switch) {
    my $o = self.bless(:$switch);
    $o.upref;
    $o;
  }
  multi method new {
    my $switch = gtk_switch_new();
    self.bless(:$switch);
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
        my gboolean $ia = self.RESOLVE-BOOL($is_active);
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
        my gboolean $s = self.RESOLVE-BOOL($state);
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
