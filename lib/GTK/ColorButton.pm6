use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;
use GTK::Raw::ColorButton;
use GTK::Raw::ColorChooser;
use GTK::Raw::Types;

use GTK::Button;

class GTK::ColorButton is GTK::Button {
  has GtkColorButton $!cb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ColorButton');
    $o;
  }

  submethod BUILD(:$button) {
    my $to-parent;
    given $button {
      when GtkColorButton | GtkWidget {
        $!cb = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkColorButton, $_);
          }
          when GtkColorButton {
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
    my $button = gtk_color_button_new();
    self.bless(:$button);
  }
  multi method new (GtkWidget $button) {
    self.bless(:$button);
  }

  method new_with_color (GdkColor $color) is DEPRECATED {
    my $button = gtk_color_button_new_with_color($color);
    self.bless(:$button);
  }

  method new_with_rgba (GTK::Compat::RGBA $color) {
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
      STORE => sub ($, Int() $alpha is copy) {
        my guint $a = self.RESOLVE-UINT($alpha);
        gtk_color_button_set_alpha($!cb, $a);
      }
    );
  }

  method rgba is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $rgba = GTK::Compat::RGBA.new;
        my GtkColorChooser $cc = nativecast(GtkColorChooser, $!cb);
        gtk_color_chooser_get_rgba($cc, $rgba);
        $rgba;
      },
      STORE => sub ($, GTK::Compat::RGBA $rgba is copy) {
        my GtkColorChooser $cc = nativecast(GtkColorChooser, $!cb);
        gtk_color_chooser_set_rgba($cc, $rgba);
      }
    );
  }

  method title is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_button_get_title($!cb);
      },
      STORE => sub ($, Str() $title is copy) {
        gtk_color_button_set_title($!cb, $title);
      }
    );
  }

  method use_alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_color_button_get_use_alpha($!cb);
      },
      STORE => sub ($, Int() $use_alpha is copy) {
        my gboolean $ua = self.RESOLVE-BOOL($use_alpha);
        gtk_color_button_set_use_alpha($!cb, $ua);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_color (GdkColor $color) is DEPRECATED {
    gtk_color_button_get_color($!cb, $color);
  }

  method get_type {
    gtk_color_button_get_type();
  }

  method set_color (GdkColor $color) is DEPRECATED {
    gtk_color_button_set_color($!cb, $color);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
