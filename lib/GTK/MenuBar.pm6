use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::MenuBar:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GTK::MenuShell:ver<3.0.1146>;

our subset GtkMenuBarAncestry is export
  where GtkMenuBar | GtkMenuShellAncestry;

class GTK::MenuBar:ver<3.0.1146> is GTK::MenuShell {
  has GtkMenuBar $!mb is implementor;

  submethod BUILD ( :$menubar ) {
    self.setGtkMenuBar($menubar) if $menubar;
  }

  submethod TWEAK ( :@items ) {
    self.append-widgets(|@items) if +@items;
  }

  method setGtkMenuBar (GtkMenuBarAncestry $_) {
    my $to-parent;

    $!mb = do {
      when GtkMenuBar {
        $to-parent = cast(GtkMenuShell, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkMenuBar, $_);
      }
    }
    self.setGtkMenuShell($to-parent);
  }

  method GTK::Raw::Definitions::GtkMenuBar
    is also<
      MenuBar
      GtkMenuBar
    >
  { $!mb }

  multi method new (GtkMenuBarAncestry $menubar, :$ref = True) {
    return Nil unless $menubar;

    my $o = self.bless(:$menubar);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $menubar = gtk_menu_bar_new();

    $menubar ?? self.bless(:$menubar) !! Nil;
  }
  multi method new (*@items) {
    my $menubar = gtk_menu_bar_new();

    $menubar ?? self.bless(:$menubar, :@items) !! Nil;
  }

  method new_from_model (GMenuModel() $model) is also<new-from-model> {
    my $menubar = gtk_menu_bar_new_from_model($model);

    $menubar ?? self.bless(:$menubar) !! Nil;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method child_pack_direction is rw is also<child-pack-direction> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPackDirectionEnum( gtk_menu_bar_get_child_pack_direction($!mb) );
      },
      STORE => sub ($, Int() $child_pack_dir is copy) {
        my GtkPackDirection $cpd = $child_pack_dir;

        gtk_menu_bar_set_child_pack_direction($!mb, $cpd);
      }
    );
  }

  method pack_direction is rw is also<pack-direction> {
    Proxy.new(
      FETCH => sub ($) {
        GtkPackDirectionEnum( gtk_menu_bar_get_pack_direction($!mb) );
      },
      STORE => sub ($, Int() $pack_dir is copy) {
        my uint32 $pd = $pack_dir;

        gtk_menu_bar_set_pack_direction($!mb, $pd);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_menu_bar_get_type, $n, $t );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
