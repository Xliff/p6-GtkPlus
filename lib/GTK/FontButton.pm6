use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FontButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::FontButton is GTK::Button {
  has Gtk $!cb;

  submethod BUILD(:$button) {
    given $button {
      when GtkColorButton | GtkWidget {
        $!tb = nativecast(GtkFontButton, $button);
        self.setButton($button);
      }
      when GTK::Button {
      }
      default {
      }
    }
  }

  method new {
    my $button = gtk_font_button_new($!fb);
    self.bless(:$button);
  }

  method new_with_font (Str $font) {
    my $button = gtk_font_button_new_with_font($font);
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method font-set {
    self.connect($!cb, 'font-set');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_font_name($!fb);
      },
      STORE => sub ($, $fontname is copy) {
        gtk_font_button_set_font_name($!fb, $fontname);
      }
    );
  }

  method show_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_show_size($!fb);
      },
      STORE => sub ($, $show_size is copy) {
        gtk_font_button_set_show_size($!fb, $show_size);
      }
    );
  }

  method show_style is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_show_style($!fb);
      },
      STORE => sub ($, $show_style is copy) {
        gtk_font_button_set_show_style($!fb, $show_style);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_title($!fb);
      },
      STORE => sub ($, $title is copy) {
        gtk_font_button_set_title($!fb, $title);
      }
    );
  }

  method use_font is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_use_font($!fb);
      },
      STORE => sub ($, $use_font is copy) {
        gtk_font_button_set_use_font($!fb, $use_font);
      }
    );
  }

  method use_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_use_size($!fb);
      },
      STORE => sub ($, $use_size is copy) {
        gtk_font_button_set_use_size($!fb, $use_size);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_font_button_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
