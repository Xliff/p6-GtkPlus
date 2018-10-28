use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Orientable;
use GTK::Raw::Types;

use GTK::Roles::Types;

role GTK::Roles::Orientable {
  has GtkOrientable $!or;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method orientation is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkOrientation( gtk_orientable_get_orientation($!or) );
      },
      STORE => sub ($, Int() $orientation is copy) {
        # YYY - GTK::ROLES::TYPES CONFLICT - YYY
        # Another reason to move these to subs or macros is the fact that
        # indescriminant use in roles will cause conflicts, when they SHOULDN'T
        #my guint $o = self.RESOLVE-UINT($orientation);
        my guint $o = $orientation +& 0xffff;
        gtk_orientable_set_orientation($!or, $o);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_orientable_type {
    gtk_orientable_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
