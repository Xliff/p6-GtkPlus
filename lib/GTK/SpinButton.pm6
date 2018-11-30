use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::SpinButton;
use GTK::Raw::Types;

use GTK::Entry;

use GTK::Roles::Orientable;

use GTK::Roles::Signals::SpinButton;

my subset Ancestry
  where GtkSpinButton | GtkOrientable | GtkEntry  | GtkCellEditable |
        GtkEditable   | GtkBuildable  | GtkWidget;

class GTK::SpinButton is GTK::Entry {
  also does GTK::Roles::Orientable;
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
      when Ancestry {
        $!sp = do {
          when GtkSpinButton {
            $to-parent = nativecast(GtkEntry, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;                                  # GTK::Roles::Orientable
            $to-parent = nativecast(GtkEntry, $_);
            nativecast(GtkSpinButton, $_);
          }
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkSpinButton, $_);
          }
        };
        self.setEntry($_);
      }
      when GTK::SpinButton {
      }
      default {
      }
    }
    $!or //= nativecast(GtkOrientable, $!sp)            # GTK::Roles::Orientable
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sp;
  }

  multi method new (Ancestry $spinbutton) {
    my $o = self.bless(:$spinbutton);
    $o.upref;
    $o;
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

  method new_with_range (Num() $min, Num() $max, Num() $step)
    is also<new-with-range>
  {
    my gdouble ($mn, $mx, $st) = ($min, $max, $step);
    my $spinbutton = gtk_spin_button_new_with_range($mn, $mx, $st);
    self.bless(:$spinbutton);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkSpinButton, GtkScrollType, gpointer --> void
  method change-value is also<change_value> {
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
  method value-changed is also<value_changed> {
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

  method snap_to_ticks is rw is also<snap-to-ticks> {
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

  method update_policy is rw is also<update-policy> {
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

  method get_increments (Num() $step, Num() $page) is also<get-increments> {
    my gdouble ($s, $p) = ($step, $page);
    gtk_spin_button_get_increments($!sp, $s, $p);
  }

  method get_range (Num() $min, Num() $max) is also<get-range> {
    my gdouble ($mn, $mx) = ($min, $max);
    gtk_spin_button_get_range($!sp, $mn, $mx);
  }

  method get_type is also<get-type> {
    gtk_spin_button_get_type();
  }

  method get_value_as_int is also<get-value-as-int> {
    gtk_spin_button_get_value_as_int($!sp);
  }

  method set_increments (Num() $step, Num() $page) is also<set-increments> {
    my gdouble ($s, $p) = ($step, $page);
    gtk_spin_button_set_increments($!sp, $s, $p);
  }

  method set_range (Num() $min, Num() $max) is also<set-range> {
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
