use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scale;
use GTK::Raw::Types;

use GTK::Range;

class GTK::Scale is GTK::Range {
  has GtkScale $!s;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Scale');
    $o;
  }

  submethod BUILD(:$scale) {
    my $to-parent;
    given $scale {
      when GtkScale | GtkWidget {
        $!s = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkScale, $_);
          }
          when GtkScale  {
            $to-parent = nativecast(GtkRange, $_);
            $_;
          }
        };
        self.setRange($to-parent);
      }
      when GTK::Scale {
      }
      default {
      }
    }
  }

  multi method new (
    GtkAdjustment() $adj,
    :$horizontal = False,
    :$vertical = False
  ) {
    die 'You must specify only $horizontal or $vertical when creating a GTK::Scale'
      unless $horizontal ^^ $vertical;

    my uint32 $or = do {
      when $horizontal { GTK_ORIENTATION_HORIZONTAL.Int; }
      when $vertical   { GTK_ORIENTATION_VERTICAL.Int;   }
    };
    my $scale = gtk_scale_new($or, $adj);
    self.bless(:$scale);
  }
  multi method new (GtkWidget $scale) {
    self.bless(:$scale);
  }
  multi method new (
    Int() $orientation,           # GtkOrientation $orientation,
    GtkAdjustment() $adjustment
  ) {
    my uint32 $o = self.RESOLVE-UINT($orientation);
    my $scale = gtk_scale_new($o, $adjustment);
    self.bless(:$scale);
  }

  method new-hscale(GtkAdjustment() $adj) {
    my $scale = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, $adj);
    self.bless(:$scale);
  }

  method new-vscale(GtkAdjustment() $adj) {
    my $scale = gtk_scale_new(GTK_ORIENTATION_VERTICAL, $adj);
    self.bless(:$scale);
  }

  method new_with_range (
    Int() $orientation,           # GtkOrientation $orientation,
    Num() $min,
    Num() $max,
    Num() $step
  ) {
    my uint32 $o = self.RESOLVE-UINT($orientation);
    my num64 ($mn, $mx, $st) = ($min, $max, $step);
    my $scale = gtk_scale_new_with_range($o, $mn, $mx, $st);
    self.bless(:$scale);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method format-value {
    self.connect_handler($!s, 'format-value');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scale_get_digits($!s);
      },
      STORE => sub ($, Int() $digits is copy) {
        my gint $d = self.RESOLVE-INT($digits);
        gtk_scale_set_digits($!s, $d);
      }
    );
  }

  method draw_value is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scale_get_draw_value($!s);
      },
      STORE => sub ($, Int() $draw_value is copy) {
        my gboolean $dv = self.RESOLVE-BOOL($draw_value);
        gtk_scale_set_draw_value($!s, $draw_value);
      }
    );
  }

  method has_origin is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scale_get_has_origin($!s);
      },
      STORE => sub ($, Int() $has_origin is copy) {
        my gboolean $ho = self.RESOLVE-BOOL($has_origin);
        gtk_scale_set_has_origin($!s, $ho);
      }
    );
  }

  method value_pos is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionType( gtk_scale_get_value_pos($!s) );
      },
      STORE => sub ($, Int() $pos is copy) {
        my uint32 $p = self.RESOVLE-UINT($pos);
        gtk_scale_set_value_pos($!s, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_mark (
    Num() $value,
    Int() $position,
    gchar $markup
  ) {
    my uint32 $p = self.RESOLVE-UINT($position);
    my num64 $v = $value;
    gtk_scale_add_mark($!s, $v, $p, $markup);
  }

  method clear_marks {
    gtk_scale_clear_marks($!s);
  }

  method get_layout {
    gtk_scale_get_layout($!s);
  }

  method get_layout_offsets (Int $x, Int $y) {
    my gint $_x = $x;
    my gint $_y = $y;
    gtk_scale_get_layout_offsets($!s, $_x, $_y);
  }

  method get_type {
    gtk_scale_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
