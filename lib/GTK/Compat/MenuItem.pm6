use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Menu;

use GTK::Compat::Variant;

class GTK::Compat::MenuItem {
  has GMenuItem $!mitem is implementor;

  submethod BUILD(:$item) {
    $!mitem = $item
  }

  method GTK::Compat::Types::GMenuItem
    is also<
      GMenuItem
      MenuItem
    >
  { $!mitem }

  multi method new (GMenuItem $item) {
    self.bless(:$item);
  }
  multi method new (Str() $label, Str() $detailed_action) {
    my $item = g_menu_item_new($label, $detailed_action);
    self.bless(:$item);
  }

  method new_from_model (GMenuModel() $model, Int() $item_index)
    is also<new-from-model>
  {
    my gint $ii = self.RESOLVE-INT($item_index);
    my $item = g_menu_item_new_from_model($model, $ii);
    self.bless(:$item);
  }

  method new_section (Str() $label, GMenuModel() $section)
    is also<new-section>
  {
    self.bless( item => g_menu_item_new_section($label, $section) );
  }

  method new_submenu (Str() $label, GMenuModel() $submenu)
    is also<new-submenu>
  {
    self.bless( item => g_menu_item_new_submenu($label, $submenu) );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_attribute_value (
    Str() $attribute,
    GVariantType $expected_type
  )
    is also<get-attribute-value>
  {
    GTK::Compat::Variant.new(
      g_menu_item_get_attribute_value($!mitem, $attribute, $expected_type),
      :!ref
    );
  }

  method get_link (Str() $link) is also<get-link> {
    GTK::Compat::MenuModel.new(
      g_menu_item_get_link($!mitem, $link)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &g_menu_item_get_type, $n, $t );
  }

  method set_action_and_target_value (
    Str() $action,
    GVariant() $target_value
  )
    is also<set-action-and-target-value>
  {
    g_menu_item_set_action_and_target_value($!mitem, $action, $target_value);
  }

  method set_attribute_value (Str() $attribute, GVariant() $value)
    is also<set-attribute-value>
  {
    g_menu_item_set_attribute_value($!mitem, $attribute, $value);
  }

  method set_detailed_action (Str() $detailed_action)
    is also<set-detailed-action>
  {
    g_menu_item_set_detailed_action($!mitem, $detailed_action);
  }

  method set_icon (GIcon() $icon) is also<set-icon> {
    g_menu_item_set_icon($!mitem, $icon);
  }

  method set_label (Str() $label) is also<set-label> {
    g_menu_item_set_label($!mitem, $label);
  }

  method set_link (Str() $link, GMenuModel() $model) is also<set-link> {
    g_menu_item_set_link($!mitem, $link, $model);
  }

  method set_section (GMenuModel() $section) is also<set-section> {
    g_menu_item_set_section($!mitem, $section);
  }

  method set_submenu (GMenuModel() $submenu) is also<set-submenu> {
    g_menu_item_set_submenu($!mitem, $submenu);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
