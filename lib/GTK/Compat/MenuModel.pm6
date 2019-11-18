use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::MenuAttributeIter;
use GTK::Compat::MenuLinkIter;
use GTK::Compat::Types;
use GTK::Compat::Raw::MenuModel;

use GTK::Roles::Types;
use GTK::Compat::Roles::Object;
use GTK::Compat::Roles::Signals;

sub EXPORT {
  %(
    GTK::Compat::MenuAttributeIter::,
    GTK::Compat::MenuLinkIter::,
  );
}

class GTK::Compat::MenuModel {
  also does GTK::Roles::Types;
  also does GTK::Compat::Roles::Object;
  also does GTK::Compat::Roles::Signals;

  has GMenuModel $!m is implementor;

  submethod BUILD(:$model) {
    self!setObject($!m = $model) if $model.defined;
  }

  submethod DESTROY {
    self.disconnect-all(%_) for %!signals-compat;
  }

  method setMenuModel(GMenuModel $model) {
    $!m = $model;
  }

  method new (GMenuModel $model) {
    self.bless(:$model);
  }

  method GTK::Compat::Types::GMenuModel
    is also<GMenuModel>
  { $!m }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GMenuModel, gint, gint, gint, gpointer
  method items-changed is also<items_changed> {
    self.connect-items-changed($!m);
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_item_attribute_value (
    Int() $item_index,
    Str() $attribute,
    GVariantType $expected_type
  )
    is also<get-item-attribute-value>
  {
    my gint $ii = self.RESOLVE-INT($item_index);
    g_menu_model_get_item_attribute_value(
      $!m,
      $ii,
      $attribute,
      $expected_type
    );
  }

  method get_item_link (
    Int() $item_index,
    Str() $link
  )
    is also<get-item-link>
  {
    my gint $ii = self.RESOLVE-INT($item_index);
    g_menu_model_get_item_link($!m, $ii, $link);
  }

  method get_n_items is also<get-n-items> {
    g_menu_model_get_n_items($!m);
  }

  method is_mutable is also<is-mutable> {
    g_menu_model_is_mutable($!m);
  }

  method emit_items_changed (
    Int() $position,
    Int() $removed,
    Int() $added
  )
    is also<emit-items-changed>
  {
    my @i = ($position, $removed, $added);
    my gint ($p, $r, $a) = self.RESOLVE-INT(@i);
    g_menu_model_items_changed($!m, $position, $removed, $added);
  }

  method iterate_item_attributes (Int() $item_index)
    is also<iterate-item-attributes>
  {
    my gint $ii = self.RESOLVE-INT($item_index);
    GTK::Compat::MenuAttributeIter.new(
      g_menu_model_iterate_item_attributes($!m, $ii);
    );
  }

  method iterate_item_links (Int() $item_index)
    is also<iterate-item-links>
  {
    my gint $ii = self.RESOLVE-INT($item_index);
    GTK::Compat::MenuLinkIter.new(
      g_menu_model_iterate_item_links($!m, $ii);
    );
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
