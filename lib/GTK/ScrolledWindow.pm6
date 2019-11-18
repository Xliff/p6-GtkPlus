use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::ScrolledWindow;
use GTK::Raw::Types;

use GTK::Adjustment;
use GTK::Bin;

use GTK::Roles::Signals::ScrolledWindow;

use GTK::Scrollbar;

our subset ScrolledWindowAncestry is export
  where GtkScrolledWindow | BinAncestry;

class GTK::ScrolledWindow is GTK::Bin {
  also does GTK::Roles::Signals::ScrolledWindow;

  has GtkScrolledWindow $!sw is implementor;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$scrolled) {
    given $scrolled {
      when ScrolledWindowAncestry {
        self.setScrolledWindow($scrolled);
      }
      when GTK::ScrolledWindow {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sw;
  }
  
  method GTK::Raw::Types::GtkScrolledWindow is also<ScrolledWindow> { $!sw }

  method setScrolledWindow($scrolled) {
    my $to-parent;
    $!sw = do given $scrolled {
      when GtkScrolledWindow {
        $to-parent = nativecast(GtkBin, $_);
        $_;
      }
      default {
        $to-parent = $_;
        nativecast(GtkScrolledWindow, $_);
      }
    }
    self.setBin($to-parent);
  }

  multi method new (ScrolledWindowAncestry $scrolled) {
    my $o = self.bless(:$scrolled);
    $o.upref;
    $o;
  }
  multi method new (
    GtkAdjustment() $hadjustment = GtkAdjustment,
    GtkAdjustment() $vadjustment = GtkAdjustment
  ) {
    my $scrolled = gtk_scrolled_window_new($hadjustment, $vadjustment);
    self.bless(:$scrolled);
  }

  # Convenience
  method new_with_policy(
    Int() $hpolicy,
    Int() $vpolicy,
    GtkAdjustment() $hadjustment = GtkAdjustment,
    GtkAdjustment() $vadjustment = GtkAdjustment
  )
    is also<new-with-policy>
  {
    my $o = GTK::ScrolledWindow.new($hadjustment, $vadjustment);
    $o.set_policy($hpolicy, $vpolicy);
    $o;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkScrolledWindow, GtkPositionType, gpointer --> void
  method edge-overshot is also<edge_overshot> {
    self.connect-uint($!sw, 'edge-overshot');
  }

  # Is originally:
  # GtkScrolledWindow, GtkPositionType, gpointer --> void
  method edge-reached is also<edge_reached> {
    self.connect-uint($!sw, 'edge-reached');
  }

  # Is originally:
  # GtkScrolledWindow, GtkDirectionType, gpointer --> void
  method move-focus-out is also<move_focus_out> {
    self.connect-uint($!sw, 'move-focus-out');
  }

  # Is originally:
  # GtkScrolledWindow, GtkScrollType, gboolean, gpointer --> gboolean
  method scroll-child is also<scroll_child> {
    self.connect-scroll-child($!sw, 'scroll-child');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method capture_button_press is rw is also<capture-button-press> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scrolled_window_get_capture_button_press($!sw);
      },
      STORE => sub ($, Int() $capture_button_press is copy) {
        my gboolean  $cbp = self.RESOLVE-BOOL($capture_button_press);
        gtk_scrolled_window_set_capture_button_press($!sw, $cbp);
      }
    );
  }

  method hadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new(
          gtk_scrolled_window_get_hadjustment($!sw)
        );
      },
      STORE => sub ($, GtkAdjustment() $hadjustment is copy) {
        gtk_scrolled_window_set_hadjustment($!sw, $hadjustment);
      }
    );
  }

  method adjustment is rw {
    Proxy.new(
      FETCH => -> $ {
        (self.hadjustment, self.vadjustment);
      },
      STORE => -> $, *@a {
        die q:to/D/.chomp unless @a.grep({ $_.^can('Int').elems }).elems == 2;
Argument to .adjustment must be a list of 2 integer-resolvable values
D

        (self.hadjustment, self.vadjustment) = @a.map( *.Int );
      }
    );
  }

  method kinetic_scrolling is rw is also<kinetic-scrolling> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scrolled_window_get_kinetic_scrolling($!sw);
      },
      STORE => sub ($, Int() $kinetic_scrolling is copy) {
        my gboolean $ks = self.RESOLVE-BOOL($kinetic_scrolling);
        gtk_scrolled_window_set_kinetic_scrolling($!sw, $ks);
      }
    );
  }

  method max_content_height is rw is also<max-content-height> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_max_content_height($!sw);
      },
      STORE => sub ($, Int() $height is copy) {
        my $h = self.RESOLVE-INT($height);
        gtk_scrolled_window_set_max_content_height($!sw, $height);
      }
    );
  }

  method max_content_width is rw is also<max-content-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_max_content_width($!sw);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width);
        gtk_scrolled_window_set_max_content_width($!sw, $w);
      }
    );
  }

  method min_content_height is rw is also<min-content-height> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_min_content_height($!sw);
      },
      STORE => sub ($, Int() $height is copy) {
        my gint $h = self.RESOLVE-INT($height);
        gtk_scrolled_window_set_min_content_height($!sw, $h);
      }
    );
  }

  method min_content_width is rw is also<min-content-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_scrolled_window_get_min_content_width($!sw);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width);
        gtk_scrolled_window_set_min_content_width($!sw, $w);
      }
    );
  }

  method overlay_scrolling is rw is also<overlay-scrolling> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scrolled_window_get_overlay_scrolling($!sw);
      },
      STORE => sub ($, Int() $overlay_scrolling is copy) {
        my $os = self.RESOLVE-BOOL($overlay_scrolling);
        gtk_scrolled_window_set_overlay_scrolling($!sw, $os);
      }
    );
  }

  method propagate_natural_height is rw is also<propagate-natural-height> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scrolled_window_get_propagate_natural_height($!sw);
      },
      STORE => sub ($, Int() $propagate is copy) {
        my gboolean $p = self.RESOLVE-BOOL($propagate);
        gtk_scrolled_window_set_propagate_natural_height($!sw, $p);
      }
    );
  }

  method propagate_natural_width is rw is also<propagate-natural-width> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_scrolled_window_get_propagate_natural_width($!sw);
      },
      STORE => sub ($, Int() $propagate is copy) {
        my gboolean $p = self.RESOLVE-BOOL($propagate);
        gtk_scrolled_window_set_propagate_natural_width($!sw, $p);
      }
    );
  }

  method shadow_type is rw is also<shadow-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowType( gtk_scrolled_window_get_shadow_type($!sw) );
      },
      STORE => sub ($, Int() $type is copy) {
        my uint32 $t = self.RESOLVE-UINT($type);
        gtk_scrolled_window_set_shadow_type($!sw, $t);
      }
    );
  }

  method vadjustment is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Adjustment.new(
          gtk_scrolled_window_get_vadjustment($!sw)
        );
      },
      STORE => sub ($, GtkAdjustment() $vadjustment is copy) {
        gtk_scrolled_window_set_vadjustment($!sw, $vadjustment);
      }
    );
  }
  
  # method policy is rw to call set_policy and get_policy?
  
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_with_viewport (GtkWidget() $child)
    is also<add-with-viewport>
  {
    gtk_scrolled_window_add_with_viewport($!sw, $child);
  }

  # Mechanism to return plain GtkWidget?
  method get_hscrollbar 
    is also<
      get-hscrollbar
      hscrollbar
    > 
  {
    GTK::Scrollbar.new( gtk_scrolled_window_get_hscrollbar($!sw) );
  }

  method get_placement 
    is also<
      get-placement
      placement
    > 
  {
    GtkCornerType( gtk_scrolled_window_get_placement($!sw) );
  }
  
  proto method get_policy (|)
    is also<get-policy>
  { * }
  
  # Only no-arg methods get to have an alias without the get[-_] prefix.
  multi method get_policy is also<policy> {
    my ($hp, $vp);
    samewith($hp, $vp);
    ($hp, $vp);
  }
  multi method get_policy (
    Int() $hscrollbar_policy is rw,     # GtkPolicyType
    Int() $vscrollbar_policy is rw      # GtkPolicyType
  ) {
    my @u = ($hscrollbar_policy, $vscrollbar_policy);
    my uint32 ($hp, $vp) = self.RESOLVE-UINT(@u);
    my $rc = gtk_scrolled_window_get_policy($!sw, $hp, $vp);
    ($hscrollbar_policy, $vscrollbar_policy) = ($hp, $vp);
    $rc;
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_scrolled_window_get_type, $n, $t );
  }

  # Mechanism to return plain GtkWidget?
  method get_vscrollbar 
    is also<
      get-vscrollbar
      vscrollbar
    > 
  {
    GTK::Scrollbar.new( gtk_scrolled_window_get_vscrollbar($!sw) );
  }

  method set_policy (Int() $hscrollbar_policy, Int() $vscrollbar_policy)
    is also<set-policy>
  {
    my @u = ($hscrollbar_policy, $vscrollbar_policy);
    my uint32 ($hp, $vp) = self.RESOLVE-UINT(@u);
    gtk_scrolled_window_set_policy($!sw, $hp, $vp);
  }

  method unset_placement is also<unset-placement> {
    gtk_scrolled_window_unset_placement($!sw);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
