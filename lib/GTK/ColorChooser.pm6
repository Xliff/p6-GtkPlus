use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ColorChooser;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Box;

class GTK::ColorChooser is GTK::Box {
  has GtkColorChooser $!cc;

  submethod BUILD(:$chooser) {
    given $chooser {
      when GtkColorChooser | GtkWidget {
        $!cc = do {
          when GtkWidget       { nativecast(GtkColorChooser, $chooser);
          when GtkColorChooser { $chooser; }
        };
        self.setBox($chooser);
      }
      when GTK::ColorChooser {
      }
      default {
      }
    }
    self.setType('GTK::ColorChooser');
  }

  method new {
    my $chooser = gtk_color_chooser_widget_new();
    self.bless(:$chooser);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method color-activated {
    self.connect($!cc, 'color-activated');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method use_alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_color_chooser_get_use_alpha($!cc);
      },
      STORE => sub ($, $use_alpha is copy) {
        gtk_color_chooser_set_use_alpha($!cc, $use_alpha);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_palette (
    GtkOrientation $orientation,
    gint $colors_per_line,
    gint $n_colors,
    GdkRGBA $colors
  ) {
    gtk_color_chooser_add_palette($!cc, $orientation, $colors_per_line, $n_colors, $colors);
  }

  method get_rgba (GdkRGBA $color) {
    gtk_color_chooser_get_rgba($!cc, $color);
  }

  method get_type () {
    gtk_color_chooser_get_type();
  }

  method set_rgba (GdkRGBA $color) {
    gtk_color_chooser_set_rgba($!cc, $color);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
