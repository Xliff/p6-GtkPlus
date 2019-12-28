use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Adjustment;
use GTK::Raw::Types;

use GLib::Roles::Object;

class GTK::Adjustment {
  also does GLib::Roles::Object;
  
  has GtkAdjustment $!adj is implementor;

  submethod BUILD(GtkAdjustment :$adjustment) {
    self!setObject($!adj = $adjustment);
  }

  method GTK::Raw::Types::GtkAdjustment 
    is also<Adjustment>
    { $!adj }

  multi method new (GtkAdjustment $adjustment) {
    self.bless(:$adjustment);
  }
  multi method new (
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
    my $adjustment = gtk_adjustment_new($v, $l, $u, $si, $pi, $ps);
    self.bless(:$adjustment);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAdjustment, gpointer --> void
  method changed {
    self.connect($!adj, 'changed');
  }

  # Is originally:
  # GtkAdjustment, gpointer --> void
  method value-changed is also<value_changed> {
    self.connect($!adj, 'value-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method lower is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_lower($!adj);
      },
      STORE => sub ($, Num() $lower is copy) {
        my gdouble $l = $lower;
        gtk_adjustment_set_lower($!adj, $l);
      }
    );
  }

  method page_increment is rw is also<page-increment> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_page_increment($!adj);
      },
      STORE => sub ($, Num() $page_increment is copy) {
        my gdouble $pi = $page_increment;
        gtk_adjustment_set_page_increment($!adj, $pi);
      }
    );
  }

  method page_size is rw is also<page-size> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_page_size($!adj);
      },
      STORE => sub ($, Num() $page_size is copy) {
        my gdouble $ps = $page_size;
        gtk_adjustment_set_page_size($!adj, $ps);
      }
    );
  }

  method step_increment is rw is also<step-increment> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_step_increment($!adj);
      },
      STORE => sub ($, Num() $step_increment is copy) {
        my gdouble $si = $step_increment;
        gtk_adjustment_set_step_increment($!adj, $si);
      }
    );
  }

  method upper is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_upper($!adj);
      },
      STORE => sub ($, Num() $upper is copy) {
        my gdouble $u = $upper;
        gtk_adjustment_set_upper($!adj, $u);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_adjustment_get_value($!adj);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_adjustment_set_value($!adj, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  # method changed {
  #   gtk_adjustment_changed($!adj);
  # }

  method clamp_page (Num() $lower, Num() $upper) is also<clamp-page> {
    my gdouble ($l, $u) = ($lower, $upper);
    gtk_adjustment_clamp_page($!adj, $l, $u);
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
    gtk_adjustment_configure($!adj, $v, $l, $u, $si, $pi, $ps);
  }

  method get_minimum_increment is also<get-minimum-increment> {
    gtk_adjustment_get_minimum_increment($!adj);
  }

  method get_type is also<get-type> {
    gtk_adjustment_get_type();
  }

  # method value_changed () {
  #   gtk_adjustment_value_changed($!adj);
  # }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
