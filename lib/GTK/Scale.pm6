use v6.c;

use Method::Also;

use GTK::Raw::Scale:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Signals::Scale:ver<3.0.1146>;

use Pango::Layout;

use GTK::Range:ver<3.0.1146>;

our subset ScaleAncestry is export
  where GtkScale | RangeAncestry;

our constant GtkScaleAncestry is export = ScaleAncestry;

class GTK::Scale:ver<3.0.1146> is GTK::Range {
  also does GTK::Roles::Signals::Scale;

  has GtkScale $!s is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$scale) {
    self.setGtkScale($scale) if $scale;
  }

  method setGtkScale (GtkScaleAncestry $_) {
    my $to-parent;

    $!s = do {
      when GtkScale {
        $to-parent = cast(GtkRange, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkScale, $_);
      }
    };
    self.setGtkRange($to-parent);
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-scale;
  }

  method GTK::Raw::Definitions::GtkScale
    is also<
      Scale
      GtkScale
    >
  { $!s }

  multi method new (ScaleAncestry $scale, :$ref = True) {
    return Nil unless $scale;

    my $o = self.bless(:$scale);
    $o.ref if $ref;
    $o;
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

    $scale ?? self.bless(:$scale) !! Nil;
  }
  multi method new (
    Int() $orientation,           # GtkOrientation $orientation,
    GtkAdjustment() $adjustment
  ) {
    my uint32 $o = $orientation;
    my $scale = gtk_scale_new($o, $adjustment);

    $scale ?? self.bless(:$scale) !! Nil;
  }

  method new-hscale(GtkAdjustment() $adj = GtkAdjustment)
    is also<new_hscale>
  {
    my $scale = gtk_scale_new(GTK_ORIENTATION_HORIZONTAL, $adj);

    $scale ?? self.bless(:$scale) !! Nil;
  }

  method new-vscale(GtkAdjustment() $adj = GtkAdjustment)
    is also<new_vscale>
  {
    my $scale = gtk_scale_new(GTK_ORIENTATION_VERTICAL, $adj);

    $scale ?? self.bless(:$scale) !! Nil;
  }

  proto method new_with_range (|)
    is also<new-with-range>
  { * }

  multi method new_with_range (
    Num() $min,
    Num() $max,
    Num() $step,
    :h(:$horizontal),
    :v(:$vertical)
  ) {
    die 'Must give either :horizontal or :vertical!'
      unless $horizontal || $vertical;
    die 'Cannot use new_with_range, with both $horizontal and $verical defined!'
      if $horizontal.defined && $vertical.defined;
    my uint32 $o = do {
      if $horizontal.defined {
        $horizontal ?? GTK_ORIENTATION_HORIZONTAL.Int !!
                       GTK_ORIENTATION_VERTICAL.Int;
      } elsif $vertical.defined {
        $vertical ?? GTK_ORIENTATION_VERTICAL.Int !!
                     GTK_ORIENTATION_HORIZONTAL.Int;
      }
    };
    samewith($o, $min, $max, $step);
  }
  multi method new_with_range (
    Int() $orientation,           # GtkOrientation $orientation,
    Num() $min,
    Num() $max,
    Num() $step
  ) {
    my uint32 $o = $orientation;
    my num64 ($mn, $mx, $st) = ($min, $max, $step);
    my $scale = gtk_scale_new_with_range($o, $mn, $mx, $st);

    $scale ?? self.bless(:$scale) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkScale, gdouble, gpointer --> Str
  method format-value is also<format_value> {
    self.connect-format-value($!s);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method digits is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scale_get_digits($!s);
      },
      STORE => sub ($, Int() $digits is copy) {
        my gint $d = $digits;

        gtk_scale_set_digits($!s, $d);
      }
    );
  }

  method draw_value is rw is also<draw-value> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scale_get_draw_value($!s);
      },
      STORE => sub ($, Int() $draw_value is copy) {
        my gboolean $dv = $draw_value.so.Int;

        gtk_scale_set_draw_value($!s, $draw_value);
      }
    );
  }

  method has_origin is rw is also<has-origin> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scale_get_has_origin($!s);
      },
      STORE => sub ($, Int() $has_origin is copy) {
        my gboolean $ho = $has_origin.so.Int;

        gtk_scale_set_has_origin($!s, $ho);
      }
    );
  }

  method value_pos is rw is also<value-pos> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPositionTypeEnum( gtk_scale_get_value_pos($!s) );
      },
      STORE => sub ($, Int() $pos is copy) {
        my uint32 $p = $pos;

        gtk_scale_set_value_pos($!s, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_mark (
    Num() $value,
    Int() $position,
    Str() $markup
  )
    is also<add-mark>
  {
    my uint32 $p = $position;
    my num64 $v = $value;

    gtk_scale_add_mark($!s, $v, $p, $markup);
  }

  method clear_marks is also<clear-marks> {
    gtk_scale_clear_marks($!s);
  }

  method get_layout (:$raw = False)
    is also<
      get-layout
      layout
    >
  {
    my $l = gtk_scale_get_layout($!s);

    $l ??
      ( $raw ?? $l !! Pango::Layout.new($l) )
      !!
      Nil;
  }

  method get_layout_offsets (Int() $x, Int() $y)
    is also<get-layout-offsets>
  {
    my gint $_x = $x;
    my gint $_y = $y;

    gtk_scale_get_layout_offsets($!s, $_x, $_y);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_scale_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
