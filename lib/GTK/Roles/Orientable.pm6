use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Orientable;
use GTK::Raw::Types;

use GTK::Roles::Types

class GTK::Roles::Orientable {
  also does GTK::Roles::Types;

  has GtkOrientable $!c;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkOrientation( gtk_orientable_get_orientation($!or) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        my guint $o = self.RESOLVE-UINT($orientation);
        gtk_orientable_set_orientation($!or, $o);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_role_type {
    gtk_orientable_get_type($!or);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
