use v6.c;

use Method::Also;

use GTK::Raw::Range:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Adjustment:ver<3.0.1146>;
use GTK::Widget:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;
use GTK::Roles::Signals::Range:ver<3.0.1146>;

our subset RangeAncestry is export
  where GtkRange | GtkOrientable | GtkWidgetAncestry;

our constant GtkRangeAncestry is export = RangeAncestry;

class GTK::Range:ver<3.0.1146> is GTK::Widget {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::Signals::Range;

  has GtkRange $!r is implementor;

  submethod BUILD(:$range) {
    given $range {
      when RangeAncestry { self.setRange($range) }
      default            { }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-r;
  }

  method GTK::Raw::Definitions::GtkRange is also<Range> { $!r }

  method setRange(RangeAncestry $range) is also<setGtkRange> {
    my $to-parent;
    $!r = do given $range {
      when GtkRange {
        $to-parent = cast(GtkWidget, $_);
        $_;
      }
      when GtkOrientable {
        $!or = $_;                                  # GTK::Roles::Orientable
        $to-parent = cast(GtkWidget, $_);
        cast(GtkRange, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkRange, $_);
      }
    }
    self.setWidget($to-parent);
    $!or //= cast(GtkOrientable, $!r);        # GTK::Roles::Orientable
  }

  # This is an abstract class, but can have instances of it's descendants
  method new (GtkRangeAncestry $range) {
    return unless $range;
    my $o = self.bless(:$range);
    $o.upref;
    $o;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:

  # GtkRange, gdouble, gpointer --> void
  method adjust-bounds is also<adjust_bounds> {
    self.connect-double($!r, 'adjust-bounds');
  }

  # Is originally:
  # GtkRange, GtkScrollType, gdouble, gpointer --> gboolean
  method change-value is also<change_value> {
    self.connect($!r, 'change-value');
  }

  # Is originally:
  # GtkRange, GtkScrollType, gpointer --> void
  method move-slider is also<move_slider> {
    self.connect-uint($!r, 'move-slider');
  }

  # Is originally:
  # GtkRange, gpointer --> void
  method value-changed is also<value_changed> {
    self.connect($!r, 'value-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method adjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_range_get_adjustment($!r);
        $a.defined ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_range_set_adjustment($!r, $adjustment);
      }
    );
  }

  method fill_level is rw is also<fill-level> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_fill_level($!r);
      },
      STORE => sub ($, Num() $fill_level is copy) {
        my gdouble $fl = $fill_level;
        gtk_range_set_fill_level($!r, $fl);
      }
    );
  }

  method flippable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_flippable($!r);
      },
      STORE => sub ($, $flippable is copy) {
        my gboolean $f = $flippable;
        gtk_range_set_flippable($!r, $f);
      }
    );
  }

  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_inverted($!r);
      },
      STORE => sub ($, Int() $setting is copy) {
        my gboolean $s = $setting;
        gtk_range_set_inverted($!r, $s);
      }
    );
  }

  method lower_stepper_sensitivity
    is rw
    is also<lower-stepper-sensitivity>
  {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityTypeEnum( gtk_range_get_lower_stepper_sensitivity($!r) );
      },
      STORE => sub ($, Int() $sensitivity is copy) {
        my uint32 $s = $sensitivity;
        gtk_range_set_lower_stepper_sensitivity($!r, $s);
      }
    );
  }

  method min_slider_size
    is DEPRECATED('use CSS min-height/min-width')
    is rw
    is also<min-slider-size>
  {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_min_slider_size($!r);
      },
      STORE => sub ($, Int() $min_size is copy) {
        my gint $ms = $min_size;
        gtk_range_set_min_slider_size($!r, $ms);
      }
    );
  }

  method restrict_to_fill_level is rw is also<restrict-to-fill-level> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_restrict_to_fill_level($!r);
      },
      STORE => sub ($, Int() $restrict_to_fill_level is copy) {
        my uint32 $fl = $restrict_to_fill_level;
        gtk_range_set_restrict_to_fill_level($!r, $fl);
      }
    );
  }

  method round_digits is rw is also<round-digits> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_round_digits($!r);
      },
      STORE => sub ($, Int() $round_digits is copy) {
        my gint $rd = $round_digits;
        gtk_range_set_round_digits($!r, $rd);
      }
    );
  }

  method show_fill_level is rw is also<show-fill-level> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_show_fill_level($!r);
      },
      STORE => sub ($, Int() $show_fill_level is copy) {
        my gboolean $sfl = $show_fill_level;
        gtk_range_set_show_fill_level($!r, $sfl);
      }
    );
  }

  method slider_size_fixed is rw is also<slider-size-fixed> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_slider_size_fixed($!r);
      },
      STORE => sub ($, Int() $size_fixed is copy) {
        my gboolean $sf = $size_fixed;
        gtk_range_set_slider_size_fixed($!r, $sf);
      }
    );
  }

  method upper_stepper_sensitivity is rw is also<upper-stepper-sensitivity> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityTypeEnum( gtk_range_get_upper_stepper_sensitivity($!r) );
      },
      STORE => sub ($, Int() $sensitivity is copy) {
        my uint32 $s = $sensitivity;
        gtk_range_set_upper_stepper_sensitivity($!r, $s);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_value($!r);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;
        gtk_range_set_value($!r, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_range_rect (GdkRectangle $range_rect)
    is also<get-range-rect>
  {
    gtk_range_get_range_rect($!r, $range_rect);
  }

  method get_slider_range (Int() $slider_start, Int() $slider_end)
    is also<get-slider-range>
  {
    my @i = ($slider_start, $slider_end);
    my gint ($s, $e) = @i;
    gtk_range_get_slider_range($!r, $s, $e);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_range_get_type, $n, $t );
  }

  method set_increments (Num() $step, Num() $page)
    is also<set-increments>
  {
    my gdouble ($s, $p) = ($step, $page);
    gtk_range_set_increments($!r, $s, $p);
  }

  method set_range (Num() $min, Num() $max) is also<set-range> {
    my gdouble ($mn, $mx) = ($min, $max);
    gtk_range_set_range($!r, $mn, $mx);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
