use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Range;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Range is GTK::Widget {
  has GtkRange $!r;

  # Abstract code, so no need for BUILD or new

  method setRange($range) {
    my $to-parent;
    $!r = do given $range {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkRange, $_);
      }
      when GtkRange {
        $to-parent = nativecast(GtkWidget, $_);
        $_;
      }
    }
    self.setWidget($to-parent);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method adjust-bounds {
    self.connect($!r, 'adjust-bounds');
  }

  method change-value {
    self.connect($!r, 'change-value');
  }

  method move-slider {
    self.connect($!r, 'move-slider');
  }

  method value-changed {
    self.connect($!r, 'value-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method adjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        Gtk::Adjustment.new( gtk_range_get_adjustment($!r) );
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_range_set_adjustment($!r, $adjustment);
      }
    );
  }

  method fill_level is rw {
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
        my gboolean $f = self.RESOLVE-BOOL($flippable);
        gtk_range_set_flippable($!r, $f);
      }
    );
  }

  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_inverted($!r);
      },
      STORE => sub ($, $setting is copy) {
        my gboolean $s = self.RESOLVE-BOOL($setting);
        gtk_range_set_inverted($!r, $s);
      }
    );
  }

  method lower_stepper_sensitivity is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityType( gtk_range_get_lower_stepper_sensitivity($!r) );
      },
      STORE => sub ($, Int() $sensitivity is copy) {
        my uint32 $s = self.RESOLVE-UINT($sensitivity);
        gtk_range_set_lower_stepper_sensitivity($!r, $s);
      }
    );
  }

  method min_slider_size
    is DEPRECATED('use CSS min-height/min-width')
    is rw
  {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_min_slider_size($!r);
      },
      STORE => sub ($, Int() $min_size is copy) {
        my gint $ms = self.RESOLVE-INT($min_size);
        gtk_range_set_min_slider_size($!r, $ms);
      }
    );
  }

  method restrict_to_fill_level is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_restrict_to_fill_level($!r);
      },
      STORE => sub ($, Int() $restrict_to_fill_level is copy) {
        my uint32 $fl = self.RESOLVE-BOOL($restrict_to_fill_level);
        gtk_range_set_restrict_to_fill_level($!r, $fl);
      }
    );
  }

  method round_digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_round_digits($!r);
      },
      STORE => sub ($, Int() $round_digits is copy) {
        my gint $rd = self.RESOLVE-INT($round_digits);
        gtk_range_set_round_digits($!r, $rd);
      }
    );
  }

  method show_fill_level is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_show_fill_level($!r);
      },
      STORE => sub ($, $show_fill_level is copy) {
        my gboolean $sfl = self.RESOLVE-BOOL($show_fill_level);
        gtk_range_set_show_fill_level($!r, $sfl);
      }
    );
  }

  method slider_size_fixed is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_range_get_slider_size_fixed($!r);
      },
      STORE => sub ($, $size_fixed is copy) {
        my gboolean $sf = self.RESOLVE-BOOL($size_fixed);
        gtk_range_set_slider_size_fixed($!r, $sf);
      }
    );
  }

  method upper_stepper_sensitivity is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityType( gtk_range_get_upper_stepper_sensitivity($!r) );
      },
      STORE => sub ($, Int() $sensitivity is copy) {
        my uint32 $s = self.RESOLVE-UINT($sensitivity);
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
  method get_range_rect (GdkRectangle $range_rect) {
    gtk_range_get_range_rect($!r, $range_rect);
  }

  method get_slider_range (Int() $slider_start, Int() $slider_end) {
    my @i = ($slider_start, $slider_end);
    my gint ($s, $e) = self.RESOLVE-INT(@i);
    gtk_range_get_slider_range($!r, $s, $e);
  }

  method get_type {
    gtk_range_get_type();
  }

  method set_increments (Num() $step, Num() $page) {
    my gdouble ($s, $p) = ($step, $page);
    gtk_range_set_increments($!r, $s, $p);
  }

  method set_range (Num() $min, Num() $max) {
    my gdouble ($mn, $mx) = ($min, $max);
    gtk_range_set_range($!r, $mn, $mx);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
