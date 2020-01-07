use v6.c;

use Method::Also;
use NativeCall;

use GDK::RGBA;


use GTK::Raw::ColorChooser;
use GTK::Raw::Label;
use GTK::Raw::Types;

use GLib::Value;
use GTK::Box;

use GTK::Roles::ColorChooser;

our subset ColorChooserAncestry is export
  where GtkColorChooser | BoxAncestry;

class GTK::ColorChooser is GTK::Box {
  also does GTK::Roles::ColorChooser;

  # Note that the attribute for the widget is also the attribute provided
  # by the role. This is a special case.

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::ColorChooser');
    $o;
  }

  submethod BUILD(:$chooser) {
    my $to-parent;
    given $chooser {
      when ColorChooserAncestry {
        $!cc = do {
          when GtkColorChooser {
            $to-parent = nativecast(GtkBox, $_);
            $_;
          }
          when BoxAncestry {
            $to-parent = $_;
            nativecast(GtkColorChooser, $_);
          }
        };
        self.setBox($to-parent);
      }
      when GTK::ColorChooser {
      }
      default {
        # DO NOT throw an exception here.
      }
    }
  }

  multi method new (ColorChooserAncestry $chooser) {
    my $o = self.bless(:$chooser);
    $o.upref;
    $o;
  }
  multi method new {
    my $chooser = gtk_color_chooser_widget_new();
    self.bless(:$chooser);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # All signals implemented by GTK::Role::ColorChooser

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # Type: gboolean

  method show-editor is rw {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('show-editor', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = self.RESOLVE-BOOL($val);
        self.prop_set('show-editor', $gv);
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  # All attributes immplemented by GTK::Role::ColorChooser

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
    my uint32 $o = self.RESOLVE-UINT($orientation);
    my @i = ($colors_per_line, $n_colors);
    my gint ($cpl, $nc) = self.RESOLVE-INT(@i);
    gtk_color_chooser_add_palette($!cc, $o, $cpl, $nc, $colors);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_color_chooser_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
