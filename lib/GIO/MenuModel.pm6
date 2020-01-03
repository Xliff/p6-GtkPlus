use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Types;

use GIO::Raw::MenuModel;

use GIO::MenuAttributeIter;
use GIO::MenuLinkIter;

use GLib::Roles::Object;
use GIO::Roles::Signals::MenuModel;

sub EXPORT {
  %(
    GIO::MenuAttributeIter::,
    GIO::MenuLinkIter::,
  );
}

class GIO::MenuModel {
  also does GLib::Roles::Object;
  also does GIO::Roles::Signals::MenuModel;

  has GMenuModel $!mm is implementor;

  submethod BUILD(:$model) {
    self.setModel($model) if $model;
  }

  submethod DESTROY {
    self.disconnect-all(%_) for %!signals-mm;
  }

  method setMenuModel(GMenuModel $model) {
    $!mm = $model;

    self.roleInit-Object;
  }

  method new (GMenuModel $model) {
    self.bless( :$model );
  }

  method GLib::Raw::Types::GMenuModel
    is also<GMenuModel>
  { $!mm }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GMenuModel, gint, gint, gint, gpointer
  method items-changed is also<items_changed> {
    self.connect-items-changed($!mm);
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
    my gint $ii = $item_index;

    g_menu_model_get_item_attribute_value(
      $!mm,
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
    my gint $ii = $item_index;

    g_menu_model_get_item_link($!mm, $ii, $link);
  }

  method get_n_items
    is also<
      get-n-items
      elems
    >
  {
    g_menu_model_get_n_items($!mm);
  }

  method is_mutable is also<is-mutable> {
    g_menu_model_is_mutable($!mm);
  }

  method emit_items_changed (
    Int() $position,
    Int() $removed,
    Int() $added
  )
    is also<emit-items-changed>
  {
    my @i = ($position, $removed, $added);
    my gint ($p, $r, $a) = @i;

    g_menu_model_items_changed($!mm, $position, $removed, $added);
  }

  method iterate_item_attributes (Int() $item_index, :$raw = False)
    is also<iterate-item-attributes>
  {
    my gint $ii = $item_index;
    my $mai = g_menu_model_iterate_item_attributes($!mm, $ii);

    $mai ??
      ( $raw ?? $mai !! GIO::MenuAttributeIter.new($mai) )
      !!
      Nil;
  }

  method iterate_item_links (Int() $item_index, :$raw = False)
    is also<iterate-item-links>
  {
    my gint $ii = $item_index;
    my $mli = g_menu_model_iterate_item_links($!mm, $ii);

    $mli ??
      ( $raw ?? $mli !! GTK::Compat::MenuLinkIter.new($mli) )
      !!
      Nil;
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
