use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ScrolledWindow;
use GTK::Raw::Types;

use GTK::Bin;

class GTK::ScrolledWindow is GTK::Bin {
  has GtkScrolledWindow $!sw;

  submethod BUILD(:$scrolled) {
    given $scrolled {
      when GtkScrolledWindow | GtkWidget {
        self.setScrolledWindow($scrolled);
      }
      when GTK::ScrolledWindow {
      }
      default {
      }
    }
    self.setType('GTK::ScrolledWindow');
  }

  method new (Int() $hadjustment, Int() $vadjustment) {
    my @u = ($hadjustment, $vadjustment);
    my uint32 ($ha, $va) = self.RESOLVE-UINT(@a, ::?METHOD);
    my $scrolled = gtk_scrolled_window_new($ha, $va);
    self.blessed(:$scrolled);
  }

  method setScrolledWindow($scrolled) {
    my $to-parent;
    given $scrolled {
      when GtkScrolledWindow | GtkWidget {
        $!sw = do {
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkScrolledWindow, $_);
          }
          when GtkScrolledWindow {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
        }
        self.setParent($to-parent);
      }
    }
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkScrolledWindow, GtkPositionType, gpointer --> void
  method edge-overshot {
    self.connect($!sw, 'edge-overshot');
  }

  # Is originally:
  # GtkScrolledWindow, GtkPositionType, gpointer --> void
  method edge-reached {
    self.connect($!sw, 'edge-reached');
  }

  # Is originally:
  # GtkScrolledWindow, GtkDirectionType, gpointer --> void
  method move-focus-out {
    self.connect($!sw, 'move-focus-out');
  }

  # Is originally:
  # GtkScrolledWindow, GtkScrollType, gboolean, gpointer --> gboolean
  method scroll-child {
    self.connect($!sw, 'scroll-child');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method capture_button_press is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_capture_button_press($!sw);
      },
      STORE => sub ($, Int() $capture_button_press is copy) {
        my gboolean  $cbp = self.RESOLVE-BOOL($capture_button_press, ::?METHOD);
        gtk_scrolled_window_set_capture_button_press($!sw, $cbp);
      }
    );
  }

  method hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_hadjustment($!sw);
      },
      STORE => sub ($, $hadjustment is copy) {
        gtk_scrolled_window_set_hadjustment($!sw, $hadjustment);
      }
    );
  }

  method kinetic_scrolling is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_scrolled_window_get_kinetic_scrolling($!sw) );
      },
      STORE => sub ($, Int() $kinetic_scrolling is copy) {
        my gboolean $ks = self.RESOLVE-BOOL($kinetic_scrolling, ::?METHOD);
        gtk_scrolled_window_set_kinetic_scrolling($!sw, $kinetic_scrolling);
      }
    );
  }

  method max_content_height is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_max_content_height($!sw);
      },
      STORE => sub ($, Int() $height is copy) {
        my $h = self.RESOLVE-INT($height, ::?METHOD);
        gtk_scrolled_window_set_max_content_height($!sw, $height);
      }
    );
  }

  method max_content_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_max_content_width($!sw);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width, ::?METHOD);
        gtk_scrolled_window_set_max_content_width($!sw, $w);
      }
    );
  }

  method min_content_height is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_min_content_height($!sw);
      },
      STORE => sub ($, Int() $height is copy) {
        my gint $h = self.RESOLVE-INT($height, ::?METHOD);
        gtk_scrolled_window_set_min_content_height($!sw, $h);
      }
    );
  }

  method min_content_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_min_content_width($!sw);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width, ::?METHOD);
        gtk_scrolled_window_set_min_content_width($!sw, $w);
      }
    );
  }

  method overlay_scrolling is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_scrolled_window_get_overlay_scrolling($!sw) );
      },
      STORE => sub ($, Int() $overlay_scrolling is copy) {
        my $os = self.RESOLVE-BOOL($overlay_scrolling, ::?METHOD);
        gtk_scrolled_window_set_overlay_scrolling($!sw, $os);
      }
    );
  }

  method propagate_natural_height is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_scrolled_window_get_propagate_natural_height($!sw) );
      },
      STORE => sub ($, Int() $propagate is copy) {
        my gboolean $p = self.RESOLVE-BOOL($propagate, ::?METHOD);
        gtk_scrolled_window_set_propagate_natural_height($!sw, $p);
      }
    );
  }

  method propagate_natural_width is rw {
    Proxy.new(
      FETCH => sub ($) {
        Bool( gtk_scrolled_window_get_propagate_natural_width($!sw) );
      },
      STORE => sub ($, Int() $propagate is copy) {
        my gboolean $p = self.RESOLVE-BOOL($propagate, ::?METHOD);
        gtk_scrolled_window_set_propagate_natural_width($!sw, $p);
      }
    );
  }

  method shadow_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowType( gtk_scrolled_window_get_shadow_type($!sw) );
      },
      STORE => sub ($, $type is copy) {
        my uint32 $t = self.RESOLVE-UINT($type, ::?METHOD);
        gtk_scrolled_window_set_shadow_type($!sw, $t);
      }
    );
  }

  method vadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_vadjustment($!sw);
      },
      STORE => sub ($, Gtkdjustment $vadjustment is copy) {
        gtk_scrolled_window_set_vadjustment($!sw, $vadjustment);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method add_with_viewport (GtkWidget $child) {
    gtk_scrolled_window_add_with_viewport($!sw, $child);
  }
  multi method add_with_viewport (GTK::Widget $child)  {
    samewith($child.widget);
  }

  method get_hscrollbar {
    gtk_scrolled_window_get_hscrollbar($!sw);
  }

  method get_placement {
    gtk_scrolled_window_get_placement($!sw);
  }

  multi method get_policy (
    GtkPolicyType $hscrollbar_policy is rw,
    GtkPolicyType $vscrollbar_policy is rw
  ) {
    my uint32 ($hp, $vp);
    ($hscrollbar_policy, $vscrollbar_policy) = samewith;
  }
  multi method get_policy {
    my uint32 ($hp, $vp);
    gtk_scrolled_window_get_policy($!sw, $hp, $vp);
    ($hp, $vp);
  }

  method get_type {
    gtk_scrolled_window_get_type();
  }

  method get_vscrollbar {
    gtk_scrolled_window_get_vscrollbar($!sw);
  }

  multi method set_policy (Int() $hscrollbar_policy, Int() $vscrollbar_policy) {
    my @u = ($hscrollbar_policy, $vscrollbar_policy);
    my uint32 ($hp, $vp) = self.RESOLVE-UINT(@u, ::?METHOD);
    gtk_scrolled_window_set_policy($!sw, $hp, $vp);
  }

  method unset_placement {
    gtk_scrolled_window_unset_placement($!sw);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
