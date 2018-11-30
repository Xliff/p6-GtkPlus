use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::MenuBar;
use GTK::Raw::Types;

use GTK::MenuShell;

my subset Ancestry
  where GtkMenuBar | GtkMenuShell | GtkContainer | GtkBuilder | GtkWidget;

class GTK::MenuBar is GTK::MenuShell {
  has GtkMenuBar $!mb;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType('GTK::MenuBar');
    $o;
  }

  submethod BUILD(:$menubar, :@items) {
    given $menubar {
      my $to-parent;
      when Ancestry {
        $!mb = do {
          when GtkMenuBar {
            $to-parent = nativecast(GtkMenuShell, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkMenuBar, $_);
          }
        }
        self.setMenuShell($to-parent);
      }
      when GTK::MenuBar {
      }
      default {
      }
    }

    # Cannot be done until after self.setMenuShell()
    with @items {
      die 'All items in @append must be GTK::MenuItems or GtkMenuItem references.'
        unless @items.all ~~ (GTK::MenuItem, GtkMenuItem).any;
      self.append-widgets($_) for @items;
    }
  }

  multi method new (Ancestry $menubar) {
    my $o = self.bless(:$menubar);
    $o.upref;
    $o;
  }
  multi method new {
    my $menubar = gtk_menu_bar_new();
    self.bless(:$menubar);
  }
  multi method new (*@items) {
    my $menubar = gtk_menu_bar_new();
    self.bless(:$menubar, :@items);
  }

  method new_from_model (GMenuModel $model) is also<new-from-model> {
    my $menubar = gtk_menu_bar_new_from_model($model);
    self.bless(:$menubar);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method child_pack_direction is rw is also<child-pack-direction> {
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

  method pack_direction is rw is also<pack-direction> {
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
  method get_type is also<get-type> {
    gtk_menu_bar_get_type();
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
