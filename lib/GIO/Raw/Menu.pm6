use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Menu;

sub g_menu_append (GMenu $menu, Str $label, Str $detailed_action)
  is native(gio)
  is export
  { * }

sub g_menu_append_item (GMenu $menu, GMenuItem $item)
  is native(gio)
  is export
  { * }

sub g_menu_append_section (GMenu $menu, Str $label, GMenuModel $section)
  is native(gio)
  is export
  { * }

sub g_menu_append_submenu (GMenu $menu, Str $label, GMenuModel $submenu)
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
  Str $label,
  Str $detailed_action
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
  Str $label,
  GMenuModel $section
)
  is native(gio)
  is export
  { * }

sub g_menu_insert_submenu (
  GMenu $menu,
  gint $position,
  Str $label,
  GMenuModel $submenu
)
  is native(gio)
  is export
  { * }

sub g_menu_item_get_attribute_value (
  GMenuItem $menu_item,
  Str $attribute,
  uint32 $expected_type       # GVariantType $expected_type
)
  returns GVariant
  is native(gio)
  is export
  { * }

sub g_menu_item_get_link (GMenuItem $menu_item, Str $link)
  returns GMenuModel
  is native(gio)
  is export
  { * }

sub g_menu_item_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_menu_item_new (Str $label, Str $detailed_action)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_new_from_model (GMenuModel $model, gint $item_index)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_new_section (Str $label, GMenuModel $section)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_new_submenu (Str $label, GMenuModel $submenu)
  returns GMenuItem
  is native(gio)
  is export
  { * }

sub g_menu_item_set_action_and_target_value (
  GMenuItem $menu_item,
  Str $action,
  GVariant $target_value
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_attribute_value (
  GMenuItem $menu_item,
  Str $attribute,
  GVariant $value
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_detailed_action (
  GMenuItem $menu_item,
  Str $detailed_action
)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_icon (GMenuItem $menu_item, GIcon $icon)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_label (GMenuItem $menu_item, Str $label)
  is native(gio)
  is export
  { * }

sub g_menu_item_set_link (
  GMenuItem $menu_item,
  Str $link,
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

sub g_menu_prepend (GMenu $menu, Str $label, Str $detailed_action)
  is native(gio)
  is export
  { * }

sub g_menu_prepend_item (GMenu $menu, GMenuItem $item)
  is native(gio)
  is export
  { * }

sub g_menu_prepend_section (GMenu $menu, Str $label, GMenuModel $section)
  is native(gio)
  is export
  { * }

sub g_menu_prepend_submenu (GMenu $menu, Str $label, GMenuModel $submenu)
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
