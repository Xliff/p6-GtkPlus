use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ScaleButton;

use GTK::Button;

class GTK::ScaleButton is GTK::Button {
  has GtkScaleButton $!sb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ScaleButton');
    $o;
  }

  submethod BUILD(:$button) {
    given $button {
      when GtkScaleButton | GtkWidget {
        self.setScaleButton($button);
      }
      when GTK::ScaleButton {
      }
      default {
      }
    }
  }

  method new (
    Int() $size,
    Num() $min,
    Num() $max,
    Num() $step,
    Str @icons
  ) {
    my uint32 $s = self.RESOLVE-UINT($size);
    my gdouble ($mn, $mx, $s, $i) = ($min, $max, $step);
    my GStrV $i = self.RESOLVE-GSTRV(@icons);
    $button = gtk_scale_button_new($s, $min, $max, $step, $i);
    self.bless(:$button);
  }

  method setScaleButton($button) {
    my $to-parent;
    $!sb = do given $button {
      when GtkWidget {
        $to-parent = $_;
        nativecast(GtkScaleButton, $_);
      }
      when GtkScaleButton {
        $to-parent = nativecast(GtkButton, $_);
        $_;
      }
    };
    self.setButton($to-parent);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method popdown {
    self.connect($!sb, 'popdown');
  }

  method popup {
    self.connect($!sb, 'popup');
  }

  method value-changed {
    self.connect($!sb. 'value-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method adjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkAdjustment.new(
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
      STORE => sub ($, $value is copy) {
        gtk_scale_button_set_value($!sb, $value);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_minus_button {
    gtk_scale_button_get_minus_button($!sb);
  }

  method get_plus_button {
    gtk_scale_button_get_plus_button($!sb);
  }

  method get_popup {
    gtk_scale_button_get_popup($!sb);
  }

  method get_type {
    gtk_scale_button_get_type();
  }

  method set_icons (gchar $icons) {
    gtk_scale_button_set_icons($!sb, $icons);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
