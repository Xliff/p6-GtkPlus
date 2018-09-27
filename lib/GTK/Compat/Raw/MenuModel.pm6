use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::MenuModel;

# va_list...
sub g_menu_model_get_item_attribute (
  GMenuModel $model,
  gint $item_index,
  gchar $attribute,
  gchar $format_string,
  CArray[Pointer]
)
  returns gboolean
  is native(gio)
  is export
  { * }
  
sub g_menu_attribute_iter_next (GMenuAttributeIter $iter)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_menu_link_iter_get_name (GMenuLinkIter $iter)
  returns Str
  is native(gio)
  is export
  { * }

sub g_menu_link_iter_get_next (
  GMenuLinkIter $iter,
  gchar $out_link,
  GMenuModel $value
)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_menu_link_iter_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_menu_link_iter_get_value (GMenuLinkIter $iter)
  returns GMenuModel
  is native(gio)
  is export
  { * }

sub g_menu_link_iter_next (GMenuLinkIter $iter)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_menu_model_get_item_attribute_value (
  GMenuModel $model,
  gint $item_index,
  gchar $attribute,
  GVariantType $expected_type
)
  returns GVariant
  is native(gio)
  is export
  { * }

sub g_menu_model_get_item_link (
  GMenuModel $model,
  gint $item_index,
  gchar $link
)
  returns GMenuModel
  is native(gio)
  is export
  { * }

sub g_menu_model_get_n_items (GMenuModel $model)
  returns gint
  is native(gio)
  is export
  { * }

sub g_menu_model_is_mutable (GMenuModel $model)
  returns uint32
  is native(gio)
  is export
  { * }

sub g_menu_model_items_changed (
  GMenuModel $model,
  gint $position,
  gint $removed,
  gint $added
)
  is native(gio)
  is export
  { * }

sub g_menu_model_iterate_item_attributes (
  GMenuModel $model,
  gint $item_index
)
  returns GMenuAttributeIter
  is native(gio)
  is export
  { * }

sub g_menu_model_iterate_item_links (
  GMenuModel $model,
  gint $item_index
)
  returns GMenuLinkIter
  is native(gio)
  is export
  { * }
