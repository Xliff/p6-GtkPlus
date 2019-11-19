use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::Menu;

use GTK::Compat::Variant;

use GTK::Compat::Roles::Object;

class GIO::MenuItem {
  has GMenuItem $!mitem is implementor;

  submethod BUILD(:$item) {
    $!mitem = $item;

    self.roleInit-Object;
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

    $item ?? self.bless(:$item) !! Nil;
  }

  method new_from_model (GMenuModel() $model, Int() $item_index)
    is also<new-from-model>
  {
    my gint $ii = $item_index;

    my $item = g_menu_item_new_from_model($model, $ii);

    $item ?? self.bless(:$item) !! Nil;
  }

  method new_section (Str() $label, GMenuModel() $section)
    is also<new-section>
  {
    my $i = g_menu_item_new_section($label, $section);

    $i ?? self.bless( item => $i ) !! Nil;
  }

  method new_submenu (Str() $label, GMenuModel() $submenu)
    is also<new-submenu>
  {
    my $i = g_menu_item_new_submenu($label, $submenu);

    $i ?? self.bless( item => $i) !! Nil;
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
    GVariantType $expected_type,
    :$raw = False
  )
    is also<get-attribute-value>
  {
    my $v = g_menu_item_get_attribute_value(
      $!mitem,
      $attribute,
      $expected_type
    );

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v, :!ref) )
      !!
      Nil;
  }

  method get_link (Str() $link, :$raw = False) is also<get-link> {
    my $mm = g_menu_item_get_link($!mitem, $link);

    $mm ??
      ( $raw ?? $mm !! GTK::Compat::MenuModel.new($mm) )
      !!
      Nil;
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
