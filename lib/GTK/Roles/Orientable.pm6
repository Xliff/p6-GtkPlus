use v6.c;

use NativeCall;

use Method::Also;

use GTK::Raw::Orientable;
use GTK::Raw::Types;

use GTK::Roles::Types;

role GTK::Roles::Orientable {
  has GtkOrientable $!or;

  method roleInit-GtkOrientable is also<roleInit_GtkOrientable> {
    return if $!or;

    my \i = findProperImplementor(self.^attributes);
    $!or = cast( GtkOrientable, i.get_value(self) );
  }

  method GIO::Raw::Definitions::GtkOrientable
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
  method gtkorientable_get_type {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gtk_orientable_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
