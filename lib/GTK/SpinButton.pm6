use v6.c;

use Method::Also;

use GTK::Raw::SpinButton:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Adjustment:ver<3.0.1146>;
use GTK::Entry:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

use GTK::Roles::Signals::SpinButton:ver<3.0.1146>;

our subset GtkSpinButtonAncestry of Mu
  where GtkSpinButton | GtkOrientable | GtkEntry  | GtkCellEditable |
        GtkEditable   | GtkBuildable  | GtkWidget;

class GTK::SpinButton:ver<3.0.1146> is GTK::Entry {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Signals::SpinButton;

  has GtkSpinButton $!sp is implementor;

  submethod BUILD (:$spinbutton) {
    self.setGtkSpinButton($spinbutton) if $spinbutton;
  }

  method setGtkSpinButton (GtkSpinButtonAncestry $_) {
    my $to-parent;

    $!sp = do {
      when GtkSpinButton {
        $to-parent = cast(GtkEntry, $_);
        $_;
      }
      when GtkOrientable {
        $!or = $_;                                  # GTK::Roles::Orientable
        $to-parent = cast(GtkEntry, $_);
        cast(GtkSpinButton, $_);
      }
      when GtkWidget {
        $to-parent = $_;
        cast(GtkSpinButton, $_);
      }
    }
    self.setEntry($to-parent);
    self.roleInit-GtkOrientable;
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sp;
  }

  multi method new (GtkSpinButtonAncestry $spinbutton) {
    return Nil unless $spinbutton;

    my $o = self.bless(:$spinbutton);
    $o.ref;
    $o;
  }
  multi method new (
    GtkAdjustment() $adjustment,
    Num()           $climb_rate,
    Int()           $digits
  ) {
    my gdouble $cr = $climb_rate;
    my guint   $d  = $digits;

    my $spinbutton = gtk_spin_button_new($adjustment, $cr, $d);

    $spinbutton ?? self.bless(:$spinbutton) !! Nil;
  }

  proto method new_with_range (|)
    is also<new-with-range>
  { * }

  multi method new_with_range (Range() $range, :$step = 1) {
    my ($min, $max) = ( .min, .max ) given $range;
    $min .= succ if $range.excludes-min;
    $max .= pred if $range.excludes-max;
    return Nil if $min > $max;
    
    samewith( $min, $max, $step ) given $range;
  }
  multi method new_with_range (Num() $min, Num() $max, Num() $step) {
    my gdouble ($mn, $mx, $st) = ($min, $max, $step);

    my $spinbutton = gtk_spin_button_new_with_range($mn, $mx, $st);

    $spinbutton ?? self.bless(:$spinbutton) !! Nil;
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
  method adjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_spin_button_get_adjustment($!sp);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
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
        my gint $d = $digits;

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
        my gboolean $n = $numeric.so.Int;

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
        my gboolean $s = $snap_to_ticks.so.Int;

        gtk_spin_button_set_snap_to_ticks($!sp, $s);
      }
    );
  }

  method update_policy is rw is also<update-policy> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSpinButtonUpdatePolicyEnum(
          gtk_spin_button_get_update_policy($!sp)
        );
      },
      STORE => sub ($, Int() $policy is copy) {
        my GtkSpinButtonUpdatePolicy $p = $policy;

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
        my gboolean $w = $wrap.so.Int;

        gtk_spin_button_set_wrap($!sp, $w);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method configure (
    GtkAdjustment() $adjustment,
    Num()           $climb_rate,
    Int()           $digits
  ) {
    my guint   $d  = $digits;
    my gdouble $cr = $climb_rate;

    gtk_spin_button_configure($!sp, $adjustment, $cr, $d);
  }

  proto method get_increments (|)
    is also<get-increments>
  { * }

  multi method get_increments is also<increments> {
    samewith($, $);
  }
  multi method get_increments ($step is rw, $page is rw)  {
    my gdouble ($s, $p) = 0x0 xx 2;

    gtk_spin_button_get_increments($!sp, $s, $p);
    ($step, $page) = ($s, $p);
  }

  proto method get_range (|)
    is also<get-range>
    is DEPRECATED<.adjustment>
  {  }

  multi method get_range {
    my ($n, $x);

    samewith($n, $x);
  }
  multi method get_range ($min is rw, $max is rw) {
    my gdouble ($mn, $mx) = 0e0 xx 2;

    gtk_spin_button_get_range($!sp, $mn, $mx);
    ($min, $max) = ($mn, $mx);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_spin_button_get_type, $n, $t );
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
    my uint32  $d = $direction;
    my gdouble $i = $increment;

    gtk_spin_button_spin($!sp, $d, $i);
  }

  method update {
    gtk_spin_button_update($!sp);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
