use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Range;
use GTK::Raw::Types;

use GTK::Widget;

class GTK::Range is GTK::Widget {
  has GtkRange $!r;

  # Abstract code, so no need for BUILD or new

  method setRange(:$range) {
    $!r = nativecast(GtkRange, $range);
    self.setWidget($range);
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
        gtk_range_get_adjustment($!r);
      },
      STORE => sub ($, $adjustment is copy) {
        gtk_range_set_adjustment($!r, $adjustment);
      }
    );
  }

  method fill_level is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_fill_level($!r);
      },
      STORE => sub ($, $fill_level is copy) {
        gtk_range_set_fill_level($!r, $fill_level);
      }
    );
  }

  method flippable is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_flippable($!r);
      },
      STORE => sub ($, $flippable is copy) {
        gtk_range_set_flippable($!r, $flippable);
      }
    );
  }

  method inverted is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_inverted($!r);
      },
      STORE => sub ($, $setting is copy) {
        gtk_range_set_inverted($!r, $setting);
      }
    );
  }

  method lower_stepper_sensitivity is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityType( gtk_range_get_lower_stepper_sensitivity($!r) );
      },
      STORE => sub ($, $sensitivity is copy) {
        my $s = do given $sensitivity {
          when GtkSensitivityType { $_.Int; }
          when Int | uint32       { $_;     }
          default {
            die "Wrong type used ({ $_.^name }) when setting GTK::Range.lower_stepper_sensitivity.";
          }
        }
        gtk_range_set_lower_stepper_sensitivity($!r, $s);
      }
    );
  }

  method min_slider_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_min_slider_size($!r);
      },
      STORE => sub ($, $min_size is copy) {
        gtk_range_set_min_slider_size($!r, $min_size);
      }
    );
  }

  method restrict_to_fill_level is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_restrict_to_fill_level($!r);
      },
      STORE => sub ($, $restrict_to_fill_level is copy) {
        gtk_range_set_restrict_to_fill_level($!r, $restrict_to_fill_level);
      }
    );
  }

  method round_digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_round_digits($!r);
      },
      STORE => sub ($, $round_digits is copy) {
        gtk_range_set_round_digits($!r, $round_digits);
      }
    );
  }

  method show_fill_level is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_show_fill_level($!r);
      },
      STORE => sub ($, $show_fill_level is copy) {
        gtk_range_set_show_fill_level($!r, $show_fill_level);
      }
    );
  }

  method slider_size_fixed is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_slider_size_fixed($!r);
      },
      STORE => sub ($, $size_fixed is copy) {
        gtk_range_set_slider_size_fixed($!r, $size_fixed);
      }
    );
  }

  method upper_stepper_sensitivity is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSensitivityType( gtk_range_get_upper_stepper_sensitivity($!r) );
      },
      STORE => sub ($, $sensitivity is copy) {
        my $s = do given $sensitivity {
          when GtkSensitivityType { $_.Int; }
          when Int | uint32       { $_;     }
          default {
            die "Wrong type used ({ $_.^name }) when setting GTK::Range.upper_stepper_sensitivity.";
          }
        }
        gtk_range_set_upper_stepper_sensitivity($!r, $s);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_range_get_value($!r);
      },
      STORE => sub ($, $value is copy) {
        gtk_range_set_value($!r, $value);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_range_rect (GdkRectangle $range_rect) {
    gtk_range_get_range_rect($!r, $range_rect);
  }

  method get_slider_range (gint $slider_start, gint $slider_end) {
    gtk_range_get_slider_range($!r, $slider_start, $slider_end);
  }

  method get_type () {
    gtk_range_get_type();
  }

  method set_increments (gdouble $step, gdouble $page) {
    gtk_range_set_increments($!r, $step, $page);
  }

  method set_range (gdouble $min, gdouble $max) {
    gtk_range_set_range($!r, $min, $max);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
