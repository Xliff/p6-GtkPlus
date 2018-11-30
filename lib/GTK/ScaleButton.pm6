use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ScaleButton;

use GTK::Button;

use GTK::Roles::Orientable;

my subset Ancestry
  where GtkScaleButton | GtkOrientable | GtkButton | GtkActionable | GtkBin |
        GtkContainer   | GtkBuilder    | GtkWidget;

class GTK::ScaleButton is GTK::Button {
  also does GTK::Roles::Orientable;

  has GtkScaleButton $!sb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ScaleButton');
    $o;
  }

  submethod BUILD(:$button) {
    given $button {
      when Ancestry {
        self.setScaleButton($button);
      }
      when GTK::ScaleButton {
      }
      default {
      }
    }
  }

  method setScaleButton($button) {
    my $to-parent;
    $!sb = do given $button {
      when GtkScaleButton {
        $to-parent = nativecast(GtkButton, $_);
        $_;
      }
      when GtkOrientable {
        $!or = $_;
        $to-parent = nativecast(GtkButton, $_);
        nativecast(GtkScaleButton, $_);
      }
      default {
        $to-parent = $_;
        nativecast(GtkScaleButton, $_);
      }
    };
    self.setButton($to-parent);
    $!or //= nativecast(GtkOrientable, $!sb);     # GTK::Roles::Orientable
  }

  multi method new (Ancestry $button) {
    my $o = self.bless(:$button);
    $o.upref;
    $o;
  }
  multi method new (
    Int() $size,
    Num() $min,
    Num() $max,
    Num() $step,
    Str @icons
  ) {
    my uint32 $s = self.RESOLVE-UINT($size);
    my gdouble ($mn, $mx, $st) = ($min, $max, $step);
    my GStrv $i = self.RESOLVE-GSTRV(@icons);
    my $button = gtk_scale_button_new($s, $mn, $mx, $st, $i);
    self.bless(:$button);
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
  method adjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new(
          gtk_scale_button_get_adjustment($!sb)
        );
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
  method get_minus_button is also<get-minus-button> {
    gtk_scale_button_get_minus_button($!sb);
  }

  method get_plus_button is also<get-plus-button> {
    gtk_scale_button_get_plus_button($!sb);
  }

  method get_popup is also<get-popup> {
    gtk_scale_button_get_popup($!sb);
  }

  method get_type is also<get-type> {
    gtk_scale_button_get_type();
  }

  method set_icons (gchar $icons) is also<set-icons> {
    gtk_scale_button_set_icons($!sb, $icons);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
