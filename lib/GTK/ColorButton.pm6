use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ColorButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::ColorButton is GTK::Button {
  has GtkColorButton $!cb;

  submethod BUILD(:$button) {
    given $button {
      when GtkColorButton | GtkWidget {
        $!tb = do {
          when GtkWidget      { nativecast(GtkColorButton, $button); }
          when GtkColorButton { $button; }
        };
        self.setButton($button);
      }
      when GTK::Button {
      }
      default {
      }
    }
    self.setType('GTK::ColorButton');
  }

  method new {
    my $button = gtk_color_button_new();
    self.bless(:$button);
  }

  method new_with_color (GdkColor $color) {
    my $button = gtk_color_button_new_with_color($color);
    self.bless(:$button);
  }

  method new_with_rgba (GdkRGBA $color) {
    my $button = gtk_color_button_new_with_rgba($color);
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method color-set {
    self.connect($!cb, 'color-set');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_button_get_alpha($!cb);
      },
      STORE => sub ($, $alpha is copy) {
        gtk_color_button_set_alpha($!cb, $alpha);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_button_get_title($!cb);
      },
      STORE => sub ($, $title is copy) {
        gtk_color_button_set_title($!cb, $title);
      }
    );
  }

  method use_alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_button_get_use_alpha($!cb);
      },
      STORE => sub ($, $use_alpha is copy) {
        gtk_color_button_set_use_alpha($!cb, $use_alpha);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_color (GdkColor $color) {
    gtk_color_button_get_color($!cb, $color);
  }

  method get_rgba (GdkRGBA $rgba) {
    gtk_color_button_get_rgba($!cb, $rgba);
  }

  method get_type {
    gtk_color_button_get_type();
  }

  method set_color (GdkColor $color) {
    gtk_color_button_set_color($!cb, $color);
  }

  method set_rgba (GdkRGBA $rgba) {
    gtk_color_button_set_rgba($!cb, $rgba);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
