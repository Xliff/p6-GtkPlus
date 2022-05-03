use v6.c;

use NativeCall;

use Method::Also;

use GLib::Raw::Traits;
use GTK::Raw::Orientable:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::Object;

role GTK::Roles::Orientable:ver<3.0.1146> {
  has GtkOrientable $!or;

  method roleInit-GtkOrientable is also<roleInit_GtkOrientable> {
    return if $!or;

    my \i = findProperImplementor(self.^attributes);
    $!or = cast( GtkOrientable, i.get_value(self) );
  }

  method GTK::Raw::Definitions::GtkOrientable
    is also<GtkOrientable>
  { $!or }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkOrientationEnum( gtk_orientable_get_orientation($!or) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = $orientation;

        gtk_orientable_set_orientation($!or, $o);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_gtkorientable_type is static {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gtk_orientable_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

our subset GtkOrientableAncestry is export of Mu
  where GtkOrientable | GObject;

class GTK::Orientable {
  also does GLib::Roles::Object;
  also does GTK::Roles::Orientable;

  submethod BUILD ( :$gtk-orientable ) {
    self.setGtkOrientable($gtk-orientable);
  }

  method setGtkOrientable (GtkOrientableAncestry $_) {
    my $to-parent;

    $!or = do {
      when GtkOrientable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkOrientable, $_);
      }
    }
    self!setObject($to-parent);
  }

  method new (GtkOrientableAncestry $gtk-orientable, :$ref = True) {
    return Nil unless $gtk-orientable;

    my $o = self.bless( :$gtk-orientable );
    $o.ref if $ref;
    $o;
  }

  method get_type is static {
    self.get_gtkorientable_type
  }
}
