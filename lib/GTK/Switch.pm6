use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Switch;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Switch is GTK::Widget {
  has GtkSwitch $!s;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Switch');
    $o;
  }

  submethod BUILD(:$switch) {
    my $to-parent;
    given $switch {
      when GtkSwitch | GtkWidget {
        $!s = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSwitch, $switch);
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
  method activate {
    self.connect($!s, 'activate');
  }

  method state-set {
    self.connect($!s, 'state-set');
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
  method get_type {
    gtk_switch_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
