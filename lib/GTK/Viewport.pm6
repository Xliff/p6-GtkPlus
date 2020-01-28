use v6.c;

use Method::Also;

use GTK::Raw::Types;
use GTK::Raw::Viewport;

use GDK::Window;
use GTK::Bin;

use GTK::Roles::Scrollable;

our subset ViewPortAncestry is export
  where GtkViewport | GtkScrollable | BinAncestry;

class GTK::Viewport is GTK::Bin {
  also does GTK::Roles::Scrollable;

  has GtkViewport $!v is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType($o.^name);
    $o;
  }

  submethod BUILD(:$viewport) {
    my $to-parent;
    given $viewport {
      when ViewPortAncestry {
        $!v = do {
          when GtkViewport {
            $to-parent = cast(GtkBin, $_);
            $_;
          }
          when GtkScrollable {
            $!s = $_;                             # GTK::Roles::Scrollable
            $to-parent = cast(GtkBin, $_);
            cast(GtkViewport, $_);
          }
          default {
            $to-parent = $_;
            cast(GtkViewport, $_);
          }
        }
        $!s //= cast(GtkScrollable, $!v);   # GTK::Roles::Scrollable
        self.setBin($to-parent);
      }
      when GTK::Viewport {
      }
      default {
      }
    }
  }

  method GTK::Raw::Definitions::GtkViewPort
    is also<
      ViewPort
      GtkViewPort
    >
  { $!v }

  multi method new (ViewPortAncestry $viewport, :$ref = True) {
    return Nil unless $viewport;

    my $o = self.bless(:$viewport);
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GtkAdjustment() $hadjustment = GtkAdjustment,
    GtkAdjustment() $vadjustment = GtkAdjustment
  ) {
    my $viewport = gtk_viewport_new($hadjustment, $vadjustment);

    $viewport ?? self.bless(:$viewport) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  method shadow_type is rw is also<shadow-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowTypeEnum( gtk_viewport_get_shadow_type($!v) );
      },
      STORE => sub ($, Int() $type is copy) {
        my $t = $type;

        gtk_viewport_set_shadow_type($!v, $t);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_bin_window (:$raw = False)
    is also<
      get-bin-window
      bin_window
      bin-window
    >
  {
    my $win = gtk_viewport_get_bin_window($!v);

    $win ??
      ( $raw ?? $win !! GDK::Window.new($win) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_viewport_get_type, $n, $t );
  }

  method get_view_window (:$raw = False)
    is also<
      get-view-window
      view_window
      view-window
    >
  {
    my $win = gtk_viewport_get_view_window($!v);

    $win ??
      ( $raw ?? $win !! GDK::Window.new($win) )
      !!
      Nil;
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
