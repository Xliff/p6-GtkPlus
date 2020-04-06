use v6.c;

use Method::Also;

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
      when ScrolledWindowAncestry { self.setScrolledWindow($scrolled) }
      when GTK::ScrolledWindow    { }
      default                     { }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-sw;
  }

  method GTK::Raw::Definitions::GtkScrolledWindow
    is also<
      ScrolledWindow
      GtkScrolledWindow
    >
  { $!sw }

  method setScrolledWindow($scrolled) {
    my $to-parent;
    $!sw = do given $scrolled {
      when GtkScrolledWindow {
        $to-parent = cast(GtkBin, $_);
        $_;
      }
      default {
        $to-parent = $_;
        cast(GtkScrolledWindow, $_);
      }
    }
    self.setBin($to-parent);
  }

  multi method new (ScrolledWindowAncestry $scrolled, :$ref = True) {
    return Nil unless $scrolled;

    my $o = self.bless(:$scrolled);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkAdjustment() $hadjustment = GtkAdjustment,
    GtkAdjustment() $vadjustment = GtkAdjustment
  ) {
    my $scrolled = gtk_scrolled_window_new($hadjustment, $vadjustment);

    $scrolled ?? self.bless(:$scrolled) !! Nil;
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

    return Nil unless $o;

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
        my gboolean  $cbp = $capture_button_press.so.Int;

        gtk_scrolled_window_set_capture_button_press($!sw, $cbp);
      }
    );
  }

  method hadjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_scrolled_window_get_hadjustment($!sw);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAdjustment() $hadjustment is copy) {
        gtk_scrolled_window_set_hadjustment($!sw, $hadjustment);
      }
    );
  }

  method adjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        ( self.hadjustment(:$raw) , self.vadjustment(:$raw) );
      },
      STORE => -> $, *@a {
        my $c = @a.grep({ .^can('GtkAdjustment').elems }).elems == 2;
        die qq:to/D/.chomp unless @a.all ~~ GtkAdjustment || $c;
          Argument to .adjustment must be a list of 2 {''
          }GtkAdjustment-compatible values
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
        my gboolean $ks = $kinetic_scrolling.so.Int;

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
        my $h = $height;

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
        my gint $w = $width;

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
        my gint $h = $height;

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
        my gint $w = $width;

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
        my gboolean $os = $overlay_scrolling.so.Int;

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
        my gboolean $p = $propagate.so.Int;

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
        my gboolean $p = $propagate.so.Int;

        gtk_scrolled_window_set_propagate_natural_width($!sw, $p);
      }
    );
  }

  method shadow_type is rw is also<shadow-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowTypeEnum( gtk_scrolled_window_get_shadow_type($!sw) );
      },
      STORE => sub ($, Int() $type is copy) {
        my uint32 $t = $type;

        gtk_scrolled_window_set_shadow_type($!sw, $t);
      }
    );
  }

  method vadjustment (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $a = gtk_scrolled_window_get_vadjustment($!sw);

        $a ??
          ( $raw ?? $a !! GTK::Adjustment.new($a) )
          !!
          Nil;
      },
      STORE => sub ($, GtkAdjustment() $vadjustment is copy) {
        gtk_scrolled_window_set_vadjustment($!sw, $vadjustment);
      }
    );
  }

  # method policy is rw to call set_policy and get_policy?

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  # Mechanism to return plain GtkWidget?
  method get_hscrollbar (:$raw = False, :$widget = False)
    is also<
      get-hscrollbar
      hscrollbar
    >
  {
    my $w = gtk_scrolled_window_get_hscrollbar($!sw);

    self.ReturnWidget($w, $raw, $widget);
  }

  method get_placement
    is also<
      get-placement
      placement
    >
  {
    GtkCornerTypeEnum( gtk_scrolled_window_get_placement($!sw) );
  }

  proto method get_policy (|)
    is also<get-policy>
  { * }

  # Only no-arg methods get to have an alias without the get[-_] prefix.
  multi method get_policy is also<policy> {
    my @r = samewith($, $, :all);

    @r[0] ?? @r[1..*] !! Nil;
  }
  multi method get_policy (
    $hscrollbar_policy is rw,      # GtkPolicyType
    $vscrollbar_policy is rw,      # GtkPolicyType
    :$all = False
  ) {
    my uint32 ($hp, $vp) = 0 xx 2;
    my $rc = gtk_scrolled_window_get_policy($!sw, $hp, $vp);

    ($hscrollbar_policy, $vscrollbar_policy) = ($hp, $vp);
    $all.not ?? $rc !! ($rc, $hscrollbar_policy, $vscrollbar_policy);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_scrolled_window_get_type, $n, $t );
  }

  # Mechanism to return plain GtkWidget?
  method get_vscrollbar (:$raw = False, :$widget = False)
    is also<
      get-vscrollbar
      vscrollbar
    >
  {
    my $w = gtk_scrolled_window_get_vscrollbar($!sw);

    self.ReturnWidget($w, $raw, $widget);
  }

  method set_policy (Int() $hscrollbar_policy, Int() $vscrollbar_policy)
    is also<set-policy>
  {
    my uint32 ($hp, $vp) = ($hscrollbar_policy, $vscrollbar_policy);

    gtk_scrolled_window_set_policy($!sw, $hp, $vp);
  }

  method unset_placement is also<unset-placement> {
    gtk_scrolled_window_unset_placement($!sw);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
