use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Types:ver<3.0.1146>;
use GTK::Raw::ScaleButton:ver<3.0.1146>;

use GTK::Adjustment:ver<3.0.1146>;
use GTK::Button:ver<3.0.1146>;

use GTK::Roles::Orientable:ver<3.0.1146>;

our subset ScaleButtonAncestry is export
  where GtkScaleButton | GtkOrientable | ButtonAncestry;

class GTK::ScaleButton:ver<3.0.1146> is GTK::Button {
  also does GTK::Roles::Orientable;

  has GtkScaleButton $!sb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$scale-button) {
    self.setScaleButton($scale-button) if $scale-button;
  }

  method GTK::Raw::Definitions::GtkScaleButton
    is also<
      ScaleButton
      GtkScaleButton
    >
  { $!sb }

  method setScaleButton(ScaleButtonAncestry $scale-button) {
    my $to-parent;
    $!sb = do given $scale-button {
      when GtkScaleButton {
        $to-parent = cast(GtkButton, $_);
        $_;
      }
      when GtkOrientable {
        $!or = $_;
        $to-parent = cast(GtkButton, $_);   # GTK:::Roles::Orientable
        cast(GtkScaleButton, $_);
      }
      default {
        $to-parent = $_;
        cast(GtkScaleButton, $_);
      }
    };
    self.setButton($to-parent);
    $!or //= cast(GtkOrientable, $!sb);     # GTK::Roles::Orientable
  }

  multi method new (ScaleButtonAncestry $scale-button, :$ref = True) {
    return Nil unless $scale-button;

    my $o = self.bless(:$scale-button);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int() $size,
    Num() $min,
    Num() $max,
    Num() $step,
    Str @icons
  ) {
    my uint32 $s = $size;
    my gdouble ($mn, $mx, $st) = ($min, $max, $step);
    my $i = resolve-gstrv( |@icons );
    my $scale-button = gtk_scale_button_new($s, $mn, $mx, $st, $i);

    $scale-button ?? self.bless(:$scale-button) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkScaleButton, gpointer --> void
  method popdown {
    self.connect($!sb, 'popdown');
  }

  # Is originally:
  # GtkScaleButton, gpointer --> void
  method popup {
    self.connect($!sb, 'popup');
  }

  # Is originally:
  # GtkScaleButton, gdouble, gpointer --> void
  method value-changed is also<value_changed> {
    self.connect-double($!sb, 'value-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method adjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_scale_button_get_adjustment($!sb);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAdjustment() $adjustment is copy) {
        gtk_scale_button_set_adjustment($!sb, $adjustment);
      }
    );
  }

  method value is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scale_button_get_value($!sb);
      },
      STORE => sub ($, Num() $value is copy) {
        my gdouble $v = $value;

        gtk_scale_button_set_value($!sb, $v);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_minus_button (:$raw = False, :$widget = False)
    is also<get-minus-button>
  {
    my $w = gtk_scale_button_get_minus_button($!sb);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_plus_button (:$raw = False, :$widget = False)
    is also<get-plus-button>
  {
    my $w = gtk_scale_button_get_plus_button($!sb);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_popup is also<get-popup> {
    gtk_scale_button_get_popup($!sb);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_scale_button_get_type, $n, $t );
  }

  proto method set_icons (|)
    is also<set-icons>
  { * }

  multi method set_icons (@icons) {
    samewith( ArrayToCArray(Str, @icons) );
  }
  multi method set_icons (CArray[Str] $icons)  {
    gtk_scale_button_set_icons($!sb, $icons);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
