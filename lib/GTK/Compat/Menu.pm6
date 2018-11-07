use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Menu;

use GTK::Roles::Types;

my subset Ancestry where GMenu | GMenuModel;

class GTK::Compat::Menu is GTK::Compat::MenuModel {
  also does GTK::Roles::Types;

  has GMenu $!menu

  submethod BUILD(:$menu) {
    $!menu = $menu
    self.setMenuModel($menu);
  }

  method new {
    my $menu = g_menu_new();
    self.bless(:$menu);
  }
  method new (GMenuModel() $menu) {
    self.build(:$menu);
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

  method append_item (GMenuItem() $item) {
    g_menu_append_item($!menu, $item);
  }

  method append_section (Str() $label, GMenuModel() $section) {
    g_menu_append_section($!menu, $label, $section);
  }

  method append_submenu (Str() $label, GMenuModel() $submenu) {
    g_menu_append_submenu($!menu, $label, $submenu);
  }

  method freeze {
    g_menu_freeze($!menu);
  }

  method insert (Int() $position, Str() $label, Str() $detailed_action) {
    my gint $p = self.RESOLVE-INT($position);
    g_menu_insert($!menu, $p, $label, $detailed_action);
  }

  method insert_item (gint $position, GMenuItem() $item) {
    my gint $p = self.RESOLVE-INT($position);
    g_menu_insert_item($!menu, $p, $item);
  }

  method insert_section (
    Int() $position,
    Str() $label,
    GMenuModel() $section)
  {
    my gint $p = self.RESOLVE-INT($position);
    g_menu_insert_section($!menu, $p, $label, $section);
  }

  method insert_submenu (
    Int() $position,
    Str() $label,
    GMenuModel() $submenu
  ) {
    my gint $p = self.RESOLVE-INT($position);
    g_menu_insert_submenu($!menu, $p, $label, $submenu);
  }

  method item_get_attribute_value (
    Str() $attribute,
    GVariantType $expected_type
  ) {
    g_menu_item_get_attribute_value($!menu, $attribute, $expected_type);
  }

  method item_get_link (Str() $link) {
    g_menu_item_get_link($!menu, $link);
  }

  method item_get_type {
    g_menu_item_get_type();
  }

  method item_new (Str() $detailed_action) {
    g_menu_item_new($!menu, $detailed_action);
  }

  method item_new_from_model (gint $item_index) {
    g_menu_item_new_from_model($!menu, $item_index);
  }

  method item_new_section (GMenuModel() $section) {
    g_menu_item_new_section($!menu, $section);
  }

  method item_new_submenu (GMenuModel() $submenu) {
    g_menu_item_new_submenu($!menu, $submenu);
  }

  method item_set_action_and_target_value (
    Str() $action,
    GVariant $target_value
  ) {
    g_menu_item_set_action_and_target_value($!menu, $action, $target_value);
  }

  method item_set_attribute_value (Str() $attribute, GVariant $value) {
    g_menu_item_set_attribute_value($!menu, $attribute, $value);
  }

  method item_set_detailed_action (Str() $detailed_action) {
    g_menu_item_set_detailed_action($!menu, $detailed_action);
  }

  method item_set_icon (GIcon() $icon) {
    g_menu_item_set_icon($!menu, $icon);
  }

  method item_set_label (Str() $label) {
    g_menu_item_set_label($!menu, $label);
  }

  method item_set_link (Str() $link, GMenuModel() $model) {
    g_menu_item_set_link($!menu, $link, $model);
  }

  method item_set_section (GMenuModel() $section) {
    g_menu_item_set_section($!menu, $section);
  }

  method item_set_submenu (GMenuModel() $submenu) {
    g_menu_item_set_submenu($!menu, $submenu);
  }

  # ↑↑↑↑ METHODS ↑↑↑↑

}
