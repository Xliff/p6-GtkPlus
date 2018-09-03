use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SpinButton;
use GTK::Raw::Types;

use GTK::Entry;

class GTK::SpinButton is GTK::Entry {
  has Gtk $!sp;

  submethod BUILD(:$spinbutton) {
    given $spinbutton {
      when GtkSpinButton | GtkWidget {
        $!sp = do {
          when GtkWidget     { nativecast(GtkSpinButton, $_); }
          when GtkSpinButton { $spinbutton; }
        };
        self.setParent($_);
      }
      when GTK::SpinButton {
      }
      default {
      }
    }
    self.setType('GTK::SpinButton');
  }

  method new (Num() $climb_rate, Int() $digits) {
    my $spinbutton = gtk_spin_button_new($climb_rate, $digits);
    self.bless(:$spinbutton);
  }

  method new_with_range (Num() $max, Num() $step) {
    my $spinbutton = gtk_spin_button_new_with_range($max, $step);
    self.bless(:$spinbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkSpinButton, GtkScrollType, gpointer --> void
  method change-value {
    self.connect($!sp, 'change-value');
  }

  # Is originally:
  # GtkSpinButton, gpointer, gpointer --> gint
  method input {
    self.connect($!sp, 'input');
  }

  # Is originally:
  # int, int --> gboolean
  method output {
    self.connect($!sp, 'output');
  }

  # Is originally:
  # GtkSpinButton, gpointer --> void
  method value-changed {
    self.connect($!sp, 'value-changed');
  }

  # Is originally:
  # GtkSpinButton, gpointer --> void
  method wrapped {
    self.connect($!sp, 'wrapped');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method adjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_adjustment($!sp);
      },
      STORE => sub ($, $adjustment is copy) {
        gtk_spin_button_set_adjustment($!sp, $adjustment);
      }
    );
  }

  method digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_digits($!sp);
      },
      STORE => sub ($, $digits is copy) {
        gtk_spin_button_set_digits($!sp, $digits);
      }
    );
  }

  method numeric is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_numeric($!sp);
      },
      STORE => sub ($, $numeric is copy) {
        gtk_spin_button_set_numeric($!sp, $numeric);
      }
    );
  }

  method snap_to_ticks is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_snap_to_ticks($!sp);
      },
      STORE => sub ($, $snap_to_ticks is copy) {
        gtk_spin_button_set_snap_to_ticks($!sp, $snap_to_ticks);
      }
    );
  }

  method update_policy is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_update_policy($!sp);
      },
      STORE => sub ($, $policy is copy) {
        gtk_spin_button_set_update_policy($!sp, $policy);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_value($!sp);
      },
      STORE => sub ($, $value is copy) {
        gtk_spin_button_set_value($!sp, $value);
      }
    );
  }

  method wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_wrap($!sp);
      },
      STORE => sub ($, $wrap is copy) {
        gtk_spin_button_set_wrap($!sp, $wrap);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method configure (GtkAdjustment $adjustment, gdouble $climb_rate, guint $digits) {
    gtk_spin_button_configure($!sp, $adjustment, $climb_rate, $digits);
  }

  method get_increments (gdouble $step, gdouble $page) {
    gtk_spin_button_get_increments($!sp, $step, $page);
  }

  method get_range (gdouble $min, gdouble $max) {
    gtk_spin_button_get_range($!sp, $min, $max);
  }

  method get_type {
    gtk_spin_button_get_type();
  }

  method get_value_as_int {
    gtk_spin_button_get_value_as_int($!sp);
  }

  method set_increments (gdouble $step, gdouble $page) {
    gtk_spin_button_set_increments($!sp, $step, $page);
  }

  method set_range (gdouble $min, gdouble $max) {
    gtk_spin_button_set_range($!sp, $min, $max);
  }

  method spin (GtkSpinType $direction, gdouble $increment) {
    gtk_spin_button_spin($!sp, $direction, $increment);
  }

  method update {
    gtk_spin_button_update($!sp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
