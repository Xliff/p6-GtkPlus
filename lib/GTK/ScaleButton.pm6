use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ScaleButton;

use GTK::Button;

class GTK::ScaleButton is GTK::Button {
  has GtkScaleButton $!sb;

  submethod BUILD(:$button) {
    given $button {
      when GtkScaleButton | GtkWidget {
        $!sb = do when {
          GtkWidget      { nativecast(GtkScaleButton, $button); }
          GtkScaleButton { $button; }
        };
        self.setScaleButton($button);
      }
      when GTK::ScaleButton {
      }
      default {
      }
    }
    self.setType('GTK::ScaleButton');
  }

  method new (gdouble $min, gdouble $max, gdouble $step, gchar $icons) {
    $button - gtk_scale_button_new($min, $max, $step, $icons);
    self.bless(:$button);
  }

  method setScaleButton($button) {
    $!sb = nativecast(GtkScaleButton, $button);
    self.setButton($button);
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
        GtkAdjustment( gtk_scale_button_get_adjustment($!sb) );
      },
      STORE => sub ($, $adjustment is copy) {
        my uint32 $a = do given $adjustment {
          when GtkAdjustment { $_.Int;           }
          when Int           { $_ +& 0xffff;     }
          when IntStr        { $_.Int +& 0xffff; }
          when uint32        { $_;               }
          default {
            die "Invalid type ({ $_.^name }) detected when attempting to set GTK::ScaleButton.adjustment.";
          }
        }
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
  method get_minus_button () {
    gtk_scale_button_get_minus_button($!sb);
  }

  method get_plus_button () {
    gtk_scale_button_get_plus_button($!sb);
  }

  method get_popup () {
    gtk_scale_button_get_popup($!sb);
  }

  method get_type () {
    gtk_scale_button_get_type();
  }

  method set_icons (gchar $icons) {
    gtk_scale_button_set_icons($!sb, $icons);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
