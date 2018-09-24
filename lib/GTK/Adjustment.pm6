use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Adjustment;
use GTK::Raw::Types;

class GTK::Adjustment {
  has GtkAdjustment $!a;

  submethod BUILD(GtkAdjustment :$adjustment) {
    $!a = $adjustment;
  }

  method new (
    Num() $lower,
    Num() $upper,
    Num() $step_increment,
    Num() $page_increment,
    Num() $page_size
  ) {
    my gdouble ($l, $u, $si, $pi, $ps) = (
      $lower, $upper, $step_increment, $page_increment, $page_size
    );
    my $adjustment = gtk_adjustment_new($!a, $l, $u, $si, $pi, $ps);
    self.bless($adjustment);
  }

  method GTK::Raw::Types::GtkAdjustment {
    $!a;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAdjustment, gpointer --> void
  method changed {
    self.connect($!a, 'changed');
  }

  # Is originally:
  # GtkAdjustment, gpointer --> void
  method value-changed {
    self.connect($!a, 'value-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method lower is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_lower($!a);
      },
      STORE => sub ($, Num() $lower is copy) {
        my gdouble $l = $lower;
        gtk_adjustment_set_lower($!a, $l);
      }
    );
  }

  method page_increment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_page_increment($!a);
      },
      STORE => sub ($, Num() $page_increment is copy) {
        my gdouble $pi = $page_increment;
        gtk_adjustment_set_page_increment($!a, $pi);
      }
    );
  }

  method page_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_page_size($!a);
      },
      STORE => sub ($, Num() $page_size is copy) {
        my gdouble $ps = $page_size;
        gtk_adjustment_set_page_size($!a, $ps);
      }
    );
  }

  method step_increment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_step_increment($!a);
      },
      STORE => sub ($, Num() $step_increment is copy) {
        my gdouble $si = $step_increment;
        gtk_adjustment_set_step_increment($!a, $si);
      }
    );
  }

  method upper is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_upper($!a);
      },
      STORE => sub ($, Num() $upper is copy) {
        my gdouble $u = $upper;
        gtk_adjustment_set_upper($!a, $u);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_value($!a);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_adjustment_set_value($!a, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  # method changed {
  #   gtk_adjustment_changed($!a);
  # }

  method clamp_page (Num() $lower, Num() $upper) {
    my gdouble ($l, $u) = ($lower, $upper);
    gtk_adjustment_clamp_page($!a, $l, $u);
  }

  method configure (
    Num() $value,
    Num() $lower,
    Num() $upper,
    Num() $step_increment,
    Num() $page_increment,
    Num() $page_size
  ) {
    my gdouble ($v, $l, $u, $si, $pi, $ps) = (
      $value, $lower, $upper, $step_increment, $page_increment, $page_size
    );
    gtk_adjustment_configure($!a, $v, $l, $u, $si, $pi, $ps);
  }

  method get_minimum_increment {
    gtk_adjustment_get_minimum_increment($!a);
  }

  method get_type {
    gtk_adjustment_get_type();
  }

  # method value_changed () {
  #   gtk_adjustment_value_changed($!a);
  # }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
