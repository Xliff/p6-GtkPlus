use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scale;
use GTK::Raw::Types;

use GTK::Range;

class GTK::Scale is GTK::Range {
  has GtkScale $!s;

  submethod BUILD(:$scale) {
    given $scale {
      when GtkScale | GtkWidget {
        $!s = nativecast(GtkScale, $scale);
        self.setRange($scale);
      }
      when GTK::Scale {
      }
      default {
      }
    }
  }

  multi method new (GtkAdjustment $adj, :$horizontal, :$vertical) {
    die 'You must specify only $horizontal or $vertical when creating a GTK::Scale'
      unless $horizontal.defined ^^ $vertical.defined;

    my $or = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL; }
      when $vertical   { GTK_ORIENTATION_VERTICAL;   }
    };
    my $scale = gtk_scale_new($or, $adj);
    self.bless(:$scale);
  }
  multi method new (GtkOrientation $orientation, GtkAdjustment $adjustment) {
    my $scale = gtk_scale_new($orientation, $adjustment);
    self.bless(:$scale);
  }

  method new-hscale(GtkAdjustment $adj) {
    my $scale = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, $adj);
    self.bless(:$scale);
  }

  method new-vscale(GtkAdjustment $adj) {
    my $scale = gtk_scale_new(GTK_ORIENTATION_VERTICAL, $adj);
    self.bless(:$scale);
  }

  multi method new_with_range (GtkOrientation $o, gdouble $min, gdouble $max, gdouble $step) {
    my $scale = gtk_scale_new_with_range($o, $min, $max, $step);
    self.bless(:$scale);
  }
  multi method new_with_range (
    gdouble $min,
    gdouble $max,
    gdouble $step,
    :$horizontal,
    :$vertical
  ) {
    die 'You must specify only $horizontal or $vertical when creating a GTK::Scale'
      unless $horizontal.defined ^^ $vertical.defined;

    my $or = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL; }
      when $vertical   { GTK_ORIENTATION_VERTICAL;   }
    };
    my $scale = gtk_scale_new_with_range($or, $min, $max, $step);
    self.bless(:$scale);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method format-value {
    self.connect($!s, 'format-value');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scale_get_digits($!s);
      },
      STORE => sub ($, $digits is copy) {
        gtk_scale_set_digits($!s, $digits);
      }
    );
  }

  method draw_value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scale_get_draw_value($!s);
      },
      STORE => sub ($, $draw_value is copy) {
        gtk_scale_set_draw_value($!s, $draw_value);
      }
    );
  }

  method has_origin is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scale_get_has_origin($!s);
      },
      STORE => sub ($, $has_origin is copy) {
        gtk_scale_set_has_origin($!s, $has_origin);
      }
    );
  }

  method value_pos is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionType( gtk_scale_get_value_pos($!s) );
      },
      STORE => sub ($, $pos is copy) {
        my $p = do given $pos {
          when GtkPositionType { $_.Int;      }
          when Int             { $_ +&0xffff; }
          when uint32          { $_;          }
        }
        gtk_scale_set_value_pos($!s, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_mark (gdouble $value, GtkPositionType $position, gchar $markup) {
    gtk_scale_add_mark($!s, $value, $position, $markup);
  }
  multi method add_mark (gdouble $value, GtkPositionType $position, gchar $markup)  {
    samewith($value, $position, $markup);
  }

  method clear_marks () {
    gtk_scale_clear_marks($!s);
  }

  method get_layout () {
    gtk_scale_get_layout($!s);
  }

  method get_layout_offsets (gint $x, gint $y) {
    gtk_scale_get_layout_offsets($!s, $x, $y);
  }

  method get_type () {
    gtk_scale_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
