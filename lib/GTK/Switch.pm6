use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Switch;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Switch is GTK::Widget {
  has GtkSwitch $!s;

  submethod BUILD(:$switch) {
    given $switch {
      when GtkSwitch | GtkWidget {
        $!s = nativecast(GtkSwitch, $switch);
        self.setWidget($switch);
      }
      when GTK::Switch {
      }
      default {
      }
    }
  }

  method new () {
    my $switch = gtk_switch_new();
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
      STORE => sub ($, $is_active is copy) {
        my uint32 $ia = do given $is_active {
          when Bool     { $_.Int;           }
          when Int      { $_ != 0 ?? 1 !! 0 }
          when gboolean { $_                }
          when Str      { $_.lc.trim eq 'true' ?? 1 !! 0; }
          default {
            die "Invalid type/value ({ $_.^name }) passed when setting GTK::Switch.active";
          }
        }
        gtk_switch_set_active($!s, $ia);
      }
    );
  }

  method state is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_switch_get_state($!s);
      },
      STORE => sub ($, $state is copy) {
        gtk_switch_set_state($!s, $state);
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
