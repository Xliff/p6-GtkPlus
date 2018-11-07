use v6.c;

use NativeCall;

use gio::Compat::Types;
use gio::Raw::Types;

unit package gio::Compat::Raw::Menu;

sub g_menu_append (GMenu $menu, gchar $label, gchar $detailed_action)
  is native(gio)
  is export
  { * }

sub g_menu_append_item (GMenu $menu, GMenuItem $item)
  is native(gio)
  is export
  { * }

sub g_menu_append_section (GMenu $menu, gchar $label, GMenuModel $section)
  is native(gio)
  is export
  { * }

sub g_menu_append_submenu (GMenu $menu, gchar $label, GMenuModel $submenu)
  is native(gio)
  is export
  { * }

sub g_menu_freeze (GMenu $menu)
  is native(gio)
  is export
  { * }

sub g_menu_insert (
  GMenu $menu,
  gint $position,
  gchar $label,
  gchar $detailed_action
)
  is native(gio)
  is export
  { * }

sub g_menu_insert_item (GMenu $menu, gint $position, GMenuItem $item)
  is native(gio)
  is export
  { * }

sub g_menu_insert_section (
  GMenu $menu,
  gint $position,
  gchar $label,
  GMenuModel $section
)
  is native(gio)
  is export
  { * }

sub g_menu_insert_submenu (
  GMenu $menu,
  gint $position,
  gchar $label,
  GMenuModel $submenu
)
  is native(gio)
  is export
  { * }

sub g_menu_item_get_attribute_value (
  GMenuItem $menu_item,
  gchar $attribute,
  GVariantType $expected_type
)
  returns GVariant
  is native(gio)
  is export
  { * }

sub g_menu_item_get_link (GMenuItem $menu_item, gchar $link)
  returns GMenuModel
  is native(gio)
  is export
  { * }

sub g_menu_item_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_menu_item_new (gchar $label, gchar $detailed_action)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_new_from_model (GMenuModel $model, gint $item_index)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_new_section (gchar $label, GMenuModel $section)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_new_submenu (gchar $label, GMenuModel $submenu)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_set_action_and_target_value (
  GMenuItem $menu_item,
  gchar $action,
  GVariant $target_value
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_attribute_value (
  GMenuItem $menu_item,
  gchar $attribute,
  GVariant $value
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_detailed_action (
  GMenuItem $menu_item,
  gchar $detailed_action
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_icon (GMenuItem $menu_item, GIcon $icon)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_label (GMenuItem $menu_item, gchar $label)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_link (
  GMenuItem $menu_item,
  gchar $link,
  GMenuModel $model
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_section (GMenuItem $menu_item, GMenuModel $section)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_submenu (GMenuItem $menu_item, GMenuModel $submenu)
  is native(gio)
  is export
  { * }

sub g_menu_new ()
  returns GMenu
  is native(gio)
  is export
  { * }

sub g_menu_prepend (GMenu $menu, gchar $label, gchar $detailed_action)
  is native(gio)
  is export
  { * }

sub g_menu_prepend_item (GMenu $menu, GMenuItem $item)
  is native(gio)
  is export
  { * }

sub g_menu_prepend_section (GMenu $menu, gchar $label, GMenuModel $section)
  is native(gio)
  is export
  { * }

sub g_menu_prepend_submenu (GMenu $menu, gchar $label, GMenuModel $submenu)
  is native(gio)
  is export
  { * }

sub g_menu_remove (GMenu $menu, gint $position)
  is native(gio)
  is export
  { * }

sub g_menu_remove_all (GMenu $menu)
  is native(gio)
  is export
  { * }
