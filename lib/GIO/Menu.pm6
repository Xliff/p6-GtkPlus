use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GIO::Raw::Menu;

use GIO::MenuModel;

my subset GIOMenuAncestry is export of Mu
  where GMenu | GMenuModel;

class GIO::Menu is GIO::MenuModel {
  has GMenu $!menu;

  method GTK::Compat::Types::GMenu
    is also<GMenu>
  { $!menu }

  submethod BUILD(:$menu) {
    given $menu {
      when GIOMenuAncestry {
        my $to-parent;
        $!menu = do {
          when GMenu {
            $to-parent = cast(GMenuModel, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GMenu, $_);
          }
        }
        self.setMenuModel($to-parent);
      }

      when GIO::Menu {
      }

      default {
      }
    }
  }

  multi method new {
    my $m = g_menu_new();

    $m ?? self.bless( menu => $m ) !! Nil;
  }
  multi method new (GMenuModel $menu) {
    self.bless( :$menu );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append (Str() $label, Str() $detailed_action) {
    g_menu_append($!menu, $label, $detailed_action);
  }

  method append_item (GMenuItem() $item) is also<append-item> {
    g_menu_append_item($!menu, $item);
  }

  method append_section (Str() $label, GMenuModel() $section)
    is also<append-section>
  {
    g_menu_append_section($!menu, $label, $section);
  }

  method append_submenu (Str() $label, GMenuModel() $submenu)
    is also<append-submenu>
  {
    g_menu_append_submenu($!menu, $label, $submenu);
  }

  method freeze {
    g_menu_freeze($!menu);
  }

  method insert (Int() $position, Str() $label, Str() $detailed_action) {
    my gint $p = $position;

    g_menu_insert($!menu, $p, $label, $detailed_action);
  }

  method insert_item (Int() $position, GMenuItem() $item)
    is also<insert-item>
  {
    my gint $p = $position;

    g_menu_insert_item($!menu, $p, $item);
  }

  method insert_section (
    Int() $position,
    Str() $label,
    GMenuModel() $section
  )
    is also<insert-section>
  {
    my gint $p = $position;

    g_menu_insert_section($!menu, $p, $label, $section);
  }

  method insert_submenu (
    Int() $position,
    Str() $label,
    GMenuModel() $submenu
  )
    is also<insert-submenu>
  {
    my gint $p = $position;

    g_menu_insert_submenu($!menu, $p, $label, $submenu);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
