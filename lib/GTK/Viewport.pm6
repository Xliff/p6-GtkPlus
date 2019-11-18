use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Viewport;
use GTK::Raw::Types;

use GTK::Roles::Scrollable;

use GTK::Compat::Window;

use GTK::Bin;

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
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when GtkScrollable {
            $!s = $_;                             # GTK::Roles::Scrollable
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkViewport, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkViewport, $_);
          }
        }
        $!s //= nativecast(GtkScrollable, $!v);   # GTK::Roles::Scrollable
        self.setBin($to-parent);
      }
      when GTK::Viewport {
      }
      default {
      }
    }
  }
  
  method GTK::Raw::Types::GtkViewPort is also<ViewPort> { $!v }

  multi method new (ViewPortAncestry $viewport) {
    my $o = self.bless(:$viewport);
    $o.upref;
    $o;
  }
  multi method new (
    GtkAdjustment() $hadjustment,
    GtkAdjustment() $vadjustment
  ) {
    my $viewport = gtk_viewport_new($hadjustment, $vadjustment);
    self.bless(:$viewport);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓

  method shadow_type is rw is also<shadow-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkShadowType( gtk_viewport_get_shadow_type($!v) );
      },
      STORE => sub ($, Int() $type is copy) {
        my $t = self.RESOLVE-UINT($type);
        gtk_viewport_set_shadow_type($!v, $t);
      }
    );
  }

  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_bin_window 
    is also<
      get-bin-window
      bin_window
      bin-window
    > 
  {
    GDK::Compat::Window.new( gtk_viewport_get_bin_window($!v) );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type( &gtk_viewport_get_type, $n, $t );
  }

  method get_view_window 
    is also<
      get-view-window
      view_window
      view-window
    > 
  {
    GDK::Compat::Window.new( gtk_viewport_get_view_window($!v) );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
