use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Overlay;
use GTK::Raw::Types;

use GTK::Bin;

use GTK::Roles::Signals::Overlay;

my subset Ancestry where GtkOverlay | GtkBin | GtkContainer | GtkBuildable |
                         GtkWidget;

class GTK::Overlay is GTK::Bin {
  also does GTK::Roles::Signals::Overlay;

  has GtkOverlay $!o;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Overlay');
    $o;
  }

  submethod BUILD(:$overlay) {
    my $to-parent;
    given $overlay {
      when Ancestry {
        $!o = do {
          when GtkOverlay  {
            $to-parent = nativecast(GtkBin, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkOverlay, $_);
          }
        }
        self.setBin($to-parent);
      }
      when GTK::Overlay {
      }
      default {
      }
    }
  }

  submethod DESTROY {
    self.disconnect-all($_) for %!signals-o;
  }

  multi method new (Ancestry $overlay) {
    my $o = self.bless(:$overlay);
    $o.upref;
    $o;
  }
  multi method new {
    my $overlay = gtk_overlay_new();
    self.bless(:$overlay);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkOverlay, GtkWidget, GdkRectangle, gpointer --> gboolean
  method get-child-position is also<get_child_position> {
    self.connect-widget-rect($!o, 'get-child-position');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method passthrough
    is rw
    is also<
      pass-through
      pass_through
    >
  {
    Proxy.new(
      FETCH => -> $ {
        self.get_overlay_passthrough;
      },
      STORE => -> $, *@list {
        die "GTK::Overlay.passthrough only takes a list of 2 elements."
          unless @list.elems == 2;
        self.set_overlay_passthrough( |@list );
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_overlay (GtkWidget() $widget) is also<add-overlay> {
    gtk_overlay_add_overlay($!o, $widget);
  }

  method get_overlay_pass_through (GtkWidget() $widget)
    is also<
      get-overlay-pass-through
      get_overlay_passthrough
      get-overlay-passthrough
    >
  {
    gtk_overlay_get_overlay_pass_through($!o, $widget);
  }

  method get_type is also<get-type> {
    gtk_overlay_get_type();
  }

  method reorder_overlay (GtkWidget() $child, Int() $position)
    is also<reorder-overlay>
  {
    my gint $p = self.RESOLVE-INT($position);
    gtk_overlay_reorder_overlay($!o, $child, $p);
  }

  method set_overlay_pass_through (
    GtkWidget() $widget,
    Int() $pass_through
  )
    is also<
      set-overlay-pass-through
      set_overlay_passthrough
      set-overlay-passthrough
    >
  {
    my gboolean $pt = self.RESOLVE-BOOL($pass_through);
    gtk_overlay_set_overlay_pass_through($!o, $widget, $pt);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'index'        { self.child-set-int($c, $p, $v)  }
        when 'pass-through' { self.child-set-bool($c, $p, $v) }

        default             { take $p; take $v;               }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
