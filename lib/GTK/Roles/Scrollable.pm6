use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Scrollable;
use GTK::Raw::Types;

use GTK::Roles::Signals;

role GTK::Roles::Scrollable {
  also does GTK::Roles::Signals;

  has GtkScrollable $!s;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrollable_get_hadjustment($!s);
      },
      STORE => sub ($, $hadjustment is copy) {
        gtk_scrollable_set_hadjustment($!s, $hadjustment);
      }
    );
  }

  method hscroll_policy is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrollable_get_hscroll_policy($!s);
      },
      STORE => sub ($, $policy is copy) {
        gtk_scrollable_set_hscroll_policy($!s, $policy);
      }
    );
  }

  method vadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrollable_get_vadjustment($!s);
      },
      STORE => sub ($, $vadjustment is copy) {
        gtk_scrollable_set_vadjustment($!s, $vadjustment);
      }
    );
  }

  method vscroll_policy is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrollable_get_vscroll_policy($!s);
      },
      STORE => sub ($, $policy is copy) {
        gtk_scrollable_set_vscroll_policy($!s, $policy);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_border (GtkBorder $border) {
    gtk_scrollable_get_border($!s, $border);
  }

  method get_type {
    gtk_scrollable_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
