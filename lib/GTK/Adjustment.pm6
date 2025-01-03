use v6.c;

use Method::Also;

use GTK::Raw::Adjustment:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::Object;

our subset GtkAdjustmentAncestry is export of Mu
  where GtkAdjustment | GObject;

class GTK::Adjustment:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkAdjustment $!adj is implementor;

  submethod BUILD ( :$adjustment ) {
    self.setGtkAdjustment($adjustment) if $adjustment;
  }

  method setGtkAdjustment (GtkAdjustmentAncestry $_) {
    my $to-parent;

    $!adj = do {
      when GtkAdjustment {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAdjustment, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkAdjustment
    is also<
      Adjustment
      GtkAdjustment
    >
  { $!adj }

  multi method new (GtkAdjustmentAncestry $adjustment, :$ref = True) {
    return Nil unless $adjustment;

    my $o = self.bless( :$adjustment );
    $o.ref if $ref;
    $o;
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

    $adjustment ?? self.bless(:$adjustment) !! Nil;
  }
  multi method new (
    # cw: Use arbitrary defaults.
    Num() :v(:$value)                           = 0,
    Num() :l(:min(:$lower))                     = 0,
    Num() :u(:max(:$upper))                     = 100,
    Num() :s(:step-increment(:$step_increment)) = 1,
    Num() :p(:page-increment(:$page_increment)) = 10,
    Num() :size(:page-size(:$page_size))        = 10
  ) {
    samewith(
      $value,
      $lower,
      $upper,
      $step_increment,
      $page_increment,
      $page_size
    );
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

  # cw: Deprecated in 3.18
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
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_adjustment_get_type, $n, $t );
  }

  # cw: Deprecated in 3.18
  # method value_changed () {
  #   gtk_adjustment_value_changed($!adj);
  # }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
