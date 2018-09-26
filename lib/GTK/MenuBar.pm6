use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuBar;
use GTK::Raw::Types;

use GTK::MenuShell;

class GTK::MenuBar is GTK::MenuShell {
  has GtkMenuBar $!mb;

  method bless(*%attrinit) {
    use nqp;
    my $o = nqp::create(self).BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuBar');
    $o;
  }

  submethod BUILD(:$menubar) {
    given $menubar {
      my $to-parent;
      when GtkMenuBar | GtkMenuShell | GtkWidget {
        $!mb = do {
          when GtkMenuShell | GtkWidget  {
            $to-parent = $_;
            nativecast(GtkMenuBar, $_);
          }
          when GtkMenuBar {
            $to-parent = nativecast(GtkMenuShell, $_);
            $_;
          }
        }
        self.setMenuShell($to-parent);
      }
      when GTK::MenuBar {
      }
      default {
      }
    }
  }

  method new {
    my $menubar = gtk_menu_bar_new();
    self.bless(:$menubar);
  }
  multi method new ($menubar) {
    self.bless(:$menubar);
  }

  method new_from_model (GMenuModel $model) {
    my $menubar = gtk_menu_bar_new_from_model($model);
    self.bless(:$menubar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method child_pack_direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPackDirection( gtk_menu_bar_get_child_pack_direction($!mb) );
      },
      STORE => sub ($, Int() $child_pack_dir is copy) {
        my $cpd = self.RESOLVE-UINT($child_pack_dir);
        gtk_menu_bar_set_child_pack_direction($!mb, $cpd);
      }
    );
  }

  method pack_direction is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkPackDirection( gtk_menu_bar_get_pack_direction($!mb) );
      },
      STORE => sub ($, Int() $pack_dir is copy) {
        my uint32 $pd = self.RESOLVE-UINT($pack_dir);
        gtk_menu_bar_set_pack_direction($!mb, $pd);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type {
    gtk_menu_bar_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
