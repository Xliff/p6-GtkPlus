use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::FontButton;
use GTK::Raw::Types;

use GTK::Button;

class GTK::FontButton is GTK::Button {
  has GtkFontButton $!fb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::FontButton');
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when GtkFontButton | GtkWidget {
        $!fb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkFontButton, $_);
          }
          when GtkFontButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
        };
        self.setButton($to-parent);
      }
      when GTK::Button {
      }
      default {
      }
    }
  }

  multi method new {
    my $button = gtk_font_button_new();
    self.bless(:$button);
  }
  multi method new (GtkWidget $button) {
    self.bless(:$button);
  }

  method new_with_font (Str $font) {
    my $button = gtk_font_button_new_with_font($font);
    self.bless(:$button);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkFontButton, gpointer --> void
  method font-set {
    self.connect($!fb, 'font-set');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method font_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_font_name($!fb);
      },
      STORE => sub ($, Str() $fontname is copy) {
        gtk_font_button_set_font_name($!fb, $fontname);
      }
    );
  }

  method show_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_show_size($!fb);
      },
      STORE => sub ($, Int() $show_size is copy) {
        my gboolean $ss = self.RESOLVE-BOOL($show_size);
        gtk_font_button_set_show_size($!fb, $ss);
      }
    );
  }

  method show_style is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_show_style($!fb);
      },
      STORE => sub ($, Int() $show_style is copy) {
        my gboolean $ss = self.RESOLVE-BOOL($show_style);
        gtk_font_button_set_show_style($!fb, $ss);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_font_button_get_title($!fb);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_font_button_set_title($!fb, $title);
      }
    );
  }

  method use_font is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_use_font($!fb);
      },
      STORE => sub ($, Int() $use_font is copy) {
        my gboolean $uf = self.RESOLVE-BOOL($use_font);
        gtk_font_button_set_use_font($!fb, $uf);
      }
    );
  }

  method use_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_font_button_get_use_size($!fb);
      },
      STORE => sub ($, Int() $use_size is copy) {
        my gboolean $us = self.RESOLVE-BOOL($use_size);
        gtk_font_button_set_use_size($!fb, $us);
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
