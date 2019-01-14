use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Toolbar;
use GTK::Raw::Types;

use GTK::Roles::Orientable;
use GTK::Roles::ToolShell;

use GTK::Container;

my subset Ancestry
  where GtkToolbar | GtkToolShell | GtkContainer | GtkOrientable |
        GtkBuilder | GtkWidget;

class GTK::Toolbar is GTK::Container {
  also does GTK::Roles::Orientable;
  also does GTK::Roles::ToolShell;

  has GtkToolbar $!tb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::Toolbar');
    $o;
  }

  submethod BUILD(:$toolbar) {
    my $to-parent;
    given $toolbar {
      when Ancestry {
        $!tb = do {
          when GtkToolbar {
            $to-parent = nativecast(GtkContainer, $_);
            $_;
          }
          when GtkOrientable {
            $!or = $_;
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkToolbar, $_);
          }
          when GtkToolShell {
            $!shell = $_;
            $to-parent = nativecast(GtkContainer, $_);
            nativecast(GtkToolbar, $_);
          }
          default {
            $to-parent = $_;
            nativecast(GtkToolbar, $_);
          }
        }
        $!or //= nativecast(GtkOrientable, $toolbar);   # GTK::Roles::Orientable
        $!shell //= nativecast(GtkToolShell, $toolbar); # GTK::Roles::ToolShell
        self.setContainer($to-parent);
      }
      when GTK::Toolbar {
      }
      default {
      }
    }
  }

  multi method new (Ancestry $toolbar) {
    my $o = self.bless(:$toolbar);
    $o.upref;
    $o;
  }
  multi method new {
    my $toolbar = gtk_toolbar_new();
    self.bless(:$toolbar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkToolbar, gboolean, gpointer --> gboolean
  method focus-home-or-end is also<focus_home_or_end> {
    self.connect-uint-rbool($!tb, 'focus-home-or-end');
  }

  # Is originally:
  # GtkToolbar, GtkOrientation, gpointer --> void
  method orientation-changed is also<orientation_changed> {
    self.connect-uint($!tb, 'orientation-changed');
  }

  # Is originally:
  # GtkToolbar, gint, gint, gint, gpointer --> gboolean
  method popup-context-menu is also<popup_context_menu> {
    self.connect-context-menu($!tb);
  }

  # Is originally:
  # GtkToolbar, GtkToolbarStyle, gpointer --> void
  method style-changed is also<style_changed> {
    self.connect-uint($!tb, 'style-changed');
  }
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method show_arrow is rw is also<show-arrow> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_toolbar_get_show_arrow($!tb);
      },
      STORE => sub ($, Int() $show_arrow is copy) {
        my gboolean $sa = self.RESOLVE-BOOL($show_arrow);
        gtk_toolbar_set_show_arrow($!tb, $show_arrow);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_drop_index (Int() $x is rw, Int() $y is rw)
    is also<get-drop-index>
  {
    my @u = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-UINT(@u);
    my $rc = gtk_toolbar_get_drop_index($!tb, $xx, $yy);
    ($x, $y) = ($xx, $yy);
    $rc;
  }
  # Add a no-arg multi

  method get_icon_size is also<get-icon-size> {
    GtkIconSize( gtk_toolbar_get_icon_size($!tb) );
  }

  multi method get_item_index (GtkToolItem() $item) is also<get-item-index> {
    gtk_toolbar_get_item_index($!tb, $item);
  }

  method get_n_items is also<get-n-items> {
    gtk_toolbar_get_n_items($!tb);
  }

  method get_nth_item (Int $n) is also<get-nth-item> {
    my gint $nn = self.RESOLVE-INT($n);
    gtk_toolbar_get_nth_item($!tb, $nn);
  }

  method get_relief_style is also<get-relief-style> {
    GtkReliefStyle( gtk_toolbar_get_relief_style($!tb) );
  }

  method get_style is also<get-style> {
    GtkToolbarStyle( gtk_toolbar_get_style($!tb) );
  }

  method get_type is also<get-type> {
    gtk_toolbar_get_type();
  }

  method insert (GtkToolItem() $item, Int $pos = -1) {
    my uint32 $p = self.RESOLVE-UINT($pos);
    gtk_toolbar_insert($!tb, $item, $p);
  }

  method set_drop_highlight_item (GtkToolItem() $tool_item, Int() $index)
    is also<set-drop-highlight-item>
  {
    my uint32 $i = self.RESOLVE-UINT($index);
    gtk_toolbar_set_drop_highlight_item($!tb, $tool_item, $i);
  }

  method unset_icon_size is also<unset-icon-size> {
    gtk_toolbar_unset_icon_size($!tb);
  }

  method unset_style is also<unset-style> {
    gtk_toolbar_unset_style($!tb);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

  method child-set(GtkWidget() $c, *@propval) {
    my @notfound;
    @notfound = gather for @propval -> $p, $v {
      given $p {
        when 'expand'     |
             'homogenous' { self.child-set-bool($c, $p, $v)  }

        default           { take $p; take $v;                }
      }
    }
    nextwith($c, @notfound) if +@notfound;
  }
}
