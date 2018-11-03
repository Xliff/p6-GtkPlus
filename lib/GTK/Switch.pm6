use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Switch;
use GTK::Raw::Types;

use GTK::Widget;

use GTK::Roles::Actionable;

my subset Ancestry where GtkSwitch | GtkActionable | GtkWidget;

class GTK::Switch is GTK::Widget {
  also does GTK::Roles::Actionable;

  has GtkSwitch $!s;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Switch');
    $o;
  }

  submethod BUILD(:$switch) {
    my $to-parent;
    given $switch {
      when Ancestry {
        $!s = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSwitch, $_);
          }
          when GtkActionable {
            $!action = nativecast(GtkActionable, $_);
            $to-parent = nativecast(GtkWidget, $_);
            nativecast(GtkSwitch, $_);                # GTK::Roles::Actionable
          }
          when GtkSwitch {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }
        };
        self.setWidget($to-parent);
      }
      when GTK::Switch {
      }
      default {
      }
    }
    $!action //= nativecast(GtkActionable, $!s);       # GTK::Roles::Actionable
  }

  multi method new {
    my $switch = gtk_switch_new();
    self.bless(:$switch);
  }
  multi method new(GtkWidget $switch) {
    # cw: Check type before-hand?
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
        Bool( gtk_switch_get_active($!s) );
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
      STORE => sub ($, $state is copy) {
        my gboolean $s = self.RESOLVE-BOOL($state);
        gtk_switch_set_state($!s, $s);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gtk_switch_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

