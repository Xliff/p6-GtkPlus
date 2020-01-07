use v6.c;

use NativeCall;


use GTK::Raw::Scrollable;
use GTK::Raw::Types;
use GTK::Raw::Utils;

use GTK::Adjustment;

role GTK::Roles::Scrollable {
  has GtkScrollable $!s;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new( gtk_scrollable_get_hadjustment($!s) );
      },
      STORE => sub ($, GtkAdjustment() $hadjustment is copy) {
        gtk_scrollable_set_hadjustment($!s, $hadjustment);
      }
    );
  }

  method hscroll_policy is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkScrollablePolicyEnum( gtk_scrollable_get_hscroll_policy($!s) );
      },
      STORE => sub ($, Int() $policy is copy) {
        my uint32 $p = resolve-uint($policy);
        gtk_scrollable_set_hscroll_policy($!s, $p);
      }
    );
  }

  method vadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new( gtk_scrollable_get_vadjustment($!s) );
      },
      STORE => sub ($, GtkAdjustment() $vadjustment is copy) {
        gtk_scrollable_set_vadjustment($!s, $vadjustment);
      }
    );
  }

  method vscroll_policy is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkScrollablePolicyEnum( gtk_scrollable_get_vscroll_policy($!s) );
      },
      STORE => sub ($, Int() $policy is copy) {
        my guint32 $p = resolve-uint($policy);
        gtk_scrollable_set_vscroll_policy($!s, $p);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_border (GtkBorder $border) {
    gtk_scrollable_get_border($!s, $border);
  }

  method get_scrollable_type {
    gtk_scrollable_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
