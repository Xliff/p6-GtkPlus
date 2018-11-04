use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ColorChooser;
use GTK::Raw::Types;

use GTK::Roles::Types;
use GTK::Roles::Signals::Generic;

role GTK::Roles::ColorChooser {
  also does GTK::Roles::Signals::Generic;
  
  has GtkColorChooser $!cc;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method color-activated is also<color_activated> {
    self.connect($!cc, 'color-activated');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method rgba is rw {
    Proxy.new(
      FETCH => -> $ {
        my $c = GTK::Compat::RGBA.new;
        self.get_rgba($c);
        $c;
      },
      STORE => -> $, GTK::Compat::RGBA $color {
        gtk_color_chooser_set_rgba($!cc, $color);
      }
    );
  }

  method use_alpha is rw is also<use-alpha> {
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
  method get_rgba (GTK::Compat::RGBA $color is rw) is also<get-rgba> {
    gtk_color_chooser_get_rgba($!cc, $color);
    $color;
  }

  method get_colorchooser_type is also<get-colorchooser-type> {
    warn 'There is no role type for GTK::Roles::ColorChooser';
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

