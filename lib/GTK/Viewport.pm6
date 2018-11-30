use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Viewport;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Scrollable;

my subset Ancestry
  where GtkViewport | GtkScrollable | GtkContainer | GtkBuilder | GtkWidget;

class GTK::Viewport is GTK::Bin {
  also does GTK::Roles::Scrollable;

  has GtkViewport $!v;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Viewport');
    $o;
  }

  submethod BUILD(:$viewport) {
    my $to-parent;
    given $viewport {
      when Ancestry {
        $!v = do {
          when GtkViewport {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          when GtkScrollable {
            $!s = $_;                         # GTK::Roles::Scrollable
            $to-parent = nativecast(GtkBin, $_);
            nativecast(GtkViewport, $_);
          }
          when GtkWidget {
            $to-parent = $_;
            nativecast(GtkViewport, $_);
          }
        }
        self.setBin($to-parent);
      }
      when GTK::Viewport {
      }
      default {
      }
    }
    $!s //= nativecast(GtkScrollable, $!v)    # GTK::Roles::Scrollable
  }

  multi method new (Ancestry $viewport) {
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
  method get_bin_window is also<get-bin-window> {
    gtk_viewport_get_bin_window($!v);
  }

  method get_type is also<get-type> {
    gtk_viewport_get_type();
  }

  method get_view_window is also<get-view-window> {
    gtk_viewport_get_view_window($!v);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
