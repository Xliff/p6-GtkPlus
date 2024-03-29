use v6.c;

use NativeCall;

use GTK::Raw::Scrollable:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::Adjustment:ver<3.0.1146>;

role GTK::Roles::Scrollable:ver<3.0.1146> {
  has GtkScrollable $!s;

  method roleInit-GtkScrollable {
    return if $!s;

    my \i = findProperImplementor(self.^attributes);
    $!s   = cast( GtkScrollable, i.get_value(self) )
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method hadjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_scrollable_get_hadjustment($!s);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
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
        my uint32 $p = $policy;

        gtk_scrollable_set_hscroll_policy($!s, $p);
      }
    );
  }

  method vadjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_scrollable_get_vadjustment($!s);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
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
        my guint32 $p = $policy;

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
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_scrollable_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
