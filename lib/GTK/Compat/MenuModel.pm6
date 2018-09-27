use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::MenuModel;

use GTK::Roles::Types;

class GTK::Compat::MenuModel {
  also does GTK::Roles::Types;

  has GMenuModel $!m;

  submethod BUILD(:$model) {
    $!m = $model;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GMenuModel, gint, gint, gint, gpointer
  method items-changed {
    self.connect('items-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method g_menu_attribute_iter_next {
    g_menu_attribute_iter_next($!m);
  }

  method g_menu_link_iter_get_name {
    g_menu_link_iter_get_name($!m);
  }

  method g_menu_link_iter_get_next (
    Str() $out_link,
    GMenuModel $value
  ) {
    g_menu_link_iter_get_next($!m, $out_link, $value);
  }

  method g_menu_link_iter_get_type {
    g_menu_link_iter_get_type($!m);
  }

  method g_menu_link_iter_get_value {
    g_menu_link_iter_get_value($!m);
  }

  method g_menu_link_iter_next {
    g_menu_link_iter_next($!m);
  }

  method get_item_attribute_value (
    Int() $item_index,
    Str() $attribute,
    GVariantType $expected_type
  ) {
    my gint $ii = self.RESOLVE-INT($item_index);
    g_menu_model_get_item_attribute_value(
      $!m, $ii, $attribute, $expected_type
    );
  }

  method get_item_link (
    Int() $item_index,
    Str() $link
  ) {
    my gint $ii = self.RESOLVE-INT($item_index);
    g_menu_model_get_item_link($!m, $ii, $link);
  }

  method get_n_items {
    g_menu_model_get_n_items($!m);
  }

  method is_mutable {
    g_menu_model_is_mutable($!m);
  }

  method items_changed (
    Int() $position,
    Int() $removed,
    Int() $added
  ) {
    my @i = ($position, $removed, $added);
    my gint ($p, $r, $a) = self.RESOLVE-INT(@i);
    g_menu_model_items_changed($!m, $position, $removed, $added);
  }

  method iterate_item_attributes (Int() $item_index) {
    my gint $ii = self.RESOLVE-INT($item_index);
    g_menu_model_iterate_item_attributes($!m, $ii);
  }

  method iterate_item_links (Int() $item_index) {
    my gint $ii = self.RESOLVE-INT($item_index);
    g_menu_model_iterate_item_links($!m, $iii);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
