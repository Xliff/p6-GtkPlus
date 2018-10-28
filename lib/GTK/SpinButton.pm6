use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SpinButton;
use GTK::Raw::Types;

use GTK::Entry;

use GTK::Roles::Editable;
use GTK::Roles::Signals::SpinButton;

class GTK::SpinButton is GTK::Entry {
  also does GTK::Roles::Editable;
  also does GTK::Roles::Signals::SpinButton;

  has GtkSpinButton $!sp;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::SpinButton');
    $o;
  }

  submethod BUILD(:$spinbutton) {
    my $to-parent;
    given $spinbutton {
      when GtkSpinButton | GtkWidget {
        $!sp = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSpinButton, $_);
          }
          when GtkSpinButton {
            $to-parent = nativecast(GtkEntry, $_);
            $_;
          }
        };
        self.setEntry($_);
      }
      when GTK::SpinButton {
      }
      default {
      }
    }
    # For GTK::Roles::Editable
    $!er = nativecast(GtkEditable, $!sp);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sp;
  }

  multi method new (GtkWidget $spinbutton) {
    self.bless(:$spinbutton);
  }
  multi method new (
    GtkAdjustment() $adjustment,
    Num() $climb_rate,
    Int() $digits
  ) {
    my gdouble $cr = $climb_rate;
    my guint $d = self.RESOLVE-UINT($digits);
    my $spinbutton = gtk_spin_button_new($adjustment, $cr, $d);
    self.bless(:$spinbutton);
  }

  method new_with_range (Num() $min, Num() $max, Num() $step) {
    my gdouble ($mn, $mx, $st) = ($min, $max, $step);
    my $spinbutton = gtk_spin_button_new_with_range($mn, $mx, $st);
    self.bless(:$spinbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkSpinButton, GtkScrollType, gpointer --> void
  method change-value {
    self.connect-guint($!sp, 'change-value');
  }

  # Is originally:
  # GtkSpinButton, gdouble is rw, gpointer --> gint
  # NOTE: !!!
  # Really is CArray[num64]. Assigning to anything BUT the first element
  # will result in a crash.
  method input {
    self.connect-input($!sp);
  }

  # Is originally:
  # GtkSpinButton, gpointer --> void (Corrected)
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
        GTK::Adjustment.new( gtk_spin_button_get_adjustment($!sp) );
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_spin_button_set_adjustment($!sp, $adjustment);
      }
    );
  }

  method digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_digits($!sp);
      },
      STORE => sub ($, Int() $digits is copy) {
        my gint $d = self.RESOLVE-INT($digits);
        gtk_spin_button_set_digits($!sp, $d);
      }
    );
  }

  method numeric is rw {
    Proxy.new(
      FETCH => sub ($) {
        # Previously using Bool() for this, so() is more efficient.
        so gtk_spin_button_get_numeric($!sp);
      },
      STORE => sub ($, Int() $numeric is copy) {
        my gboolean $n = self.RESOLVE-BOOL($numeric);
        gtk_spin_button_set_numeric($!sp, $n);
      }
    );
  }

  method snap_to_ticks is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_spin_button_get_snap_to_ticks($!sp);
      },
      STORE => sub ($, $snap_to_ticks is copy) {
        my gboolean $s = self.RESOLVE-BOOL($snap_to_ticks);
        gtk_spin_button_set_snap_to_ticks($!sp, $s);
      }
    );
  }

  method update_policy is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSpinButtonUpdatePolicy( gtk_spin_button_get_update_policy($!sp) );
      },
      STORE => sub ($, Int() $policy is copy) {
        my gboolean $p = self.RESOLVE-UINT($policy);
        gtk_spin_button_set_update_policy($!sp, $p);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_spin_button_get_value($!sp);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_spin_button_set_value($!sp, $v);
      }
    );
  }

  method wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_spin_button_get_wrap($!sp);
      },
      STORE => sub ($, Int() $wrap is copy) {
        my gboolean $w = self.RESOLVE-BOOL($wrap);
        gtk_spin_button_set_wrap($!sp, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method configure (
    GtkAdjustment() $adjustment,
    Int() $climb_rate,
    Int() $digits
  ) {
    my guint $d = self.RESOLVE-UINT($digits);
    my gdouble $cr = $climb_rate;
    gtk_spin_button_configure($!sp, $adjustment, $cr, $d);
  }

  method get_increments (Num() $step, Num() $page) {
    my gdouble ($s, $p) = ($step, $page);
    gtk_spin_button_get_increments($!sp, $s, $p);
  }

  method get_range (Num() $min, Num() $max) {
    my gdouble ($mn, $mx) = ($min, $max);
    gtk_spin_button_get_range($!sp, $mn, $mx);
  }

  method get_type {
    gtk_spin_button_get_type();
  }

  method get_value_as_int {
    gtk_spin_button_get_value_as_int($!sp);
  }

  method set_increments (Num() $step, Num() $page) {
    my gdouble ($s, $p) = ($step, $page);
    gtk_spin_button_set_increments($!sp, $s, $p);
  }

  method set_range (Num() $min, Num() $max) {
    my gdouble ($mn, $mx) = ($min, $max);
    gtk_spin_button_set_range($!sp, $mn, $mx);
  }

  method spin (Int() $direction, Num() $increment) {
    my uint32 $d = self.RESOLVE-UINT($direction);
    my gdouble $i = $increment;
    gtk_spin_button_spin($!sp, $d, $i);
  }

  method update {
    gtk_spin_button_update($!sp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
