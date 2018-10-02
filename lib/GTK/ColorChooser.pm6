use v6.c;

use NativeCall;

use GTK::Compat::RGBA;
use GTK::Compat::Types;

use GTK::Raw::ColorChooser;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GTK::Box;

use GTK::Roles::ColorChooser;

class GTK::ColorChooser is GTK::Box {
  also does GTK::Roles::ColorChooser;

  # Attribute provided by GTK::Roles::ColorChooser

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ColorChooser');
    $o;
  }

  submethod BUILD(:$chooser) {
    my $to-parent;
    given $chooser {
      when GtkColorChooser | GtkWidget {
        $!cc = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkColorChooser, $_);
          }
          when GtkColorChooser {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
        };
        self.setBox($to-parent);
      }
      when GTK::ColorChooser {
      }
      default {
      }
    }
  }

  multi method new {
    my $chooser = gtk_color_chooser_widget_new();
    self.bless(:$chooser);
  }
  multi method new (GtkWidget $chooser) {
    self.bless(:$chooser);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # All signals implemented by GTK::Role::ColorChooser

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # All attributes immplemented by GTK::Role::ColorChooser

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_palette (
    Int() $orientation,
    Int() $colors_per_line,
    Int() $n_colors,
    GTK::Compat::RGBA $colors
  ) {
    my uint32 $o = self.RESOLVE-UINT($orientation);
    my @i = ($colors_per_line, $n_colors);
    my gint ($cpl, $nc) = self.RESOLVE-INT(@i);
    gtk_color_chooser_add_palette($!cc, $o, $cpl, $nc, $colors);
  }

  method get_type {
    gtk_color_chooser_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
