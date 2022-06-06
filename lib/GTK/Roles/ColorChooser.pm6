use v6.c;

use Method::Also;
use NativeCall;

use GDK::RGBA;

use GTK::Raw::ColorChooser:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Roles::Types:ver<3.0.1146>;
use GTK::Roles::Signals::Generic:ver<3.0.1146>;

role GTK::Roles::ColorChooser:ver<3.0.1146> {
  also does GTK::Roles::Signals::Generic;

  has GtkColorChooser $!cc;

  method roleInit-ColorChooser {
    my \i = findProperImplementor(self.^attributes);

    $!cc = cast( GtkColorChooser, i.get_value(self) );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  method color-activated is also<color_activated> {
    self.connect($!cc, 'color-activated');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method rgba is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $c = GDK::RGBA.new;
        self.get_rgba($c);
        $c;
      },
      STORE => -> $, GDK::RGBA $color {
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
  method add_palette (
    Int() $orientation,
    Int() $colors_per_line,
    Int() $n_colors,
    GDK::RGBA $colors
  )
    is also<add-palette>
  {
    my uint32 $o = $orientation;
    my gint ($cpl, $nc) = ($colors_per_line, $n_colors);

    gtk_color_chooser_add_palette($!cc, $o, $cpl, $nc, $colors);
  }

  method get_rgba (GDK::RGBA $color is rw) is also<get-rgba> {
    gtk_color_chooser_get_rgba($!cc, $color);
    $color;
  }

  method colorchooser_get_type is also<colorchooser-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_color_chooser_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
