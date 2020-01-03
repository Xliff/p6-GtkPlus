use v6.c;

use Method::Also;

use GLib::Raw::Types;

use GIO::Raw::ListModel;

use GLib::Roles::Object;
use GIO::Roles::Signals::ListModel;

role GIO::Roles::ListModel {
  also does GIO::Roles::Signals::ListModel;

  has GListModel $!lm;

  submethod BUILD (:$model) {
    $!lm = $model;
  }

  method roleInit-ListModel {
    my \i = findProperImplementor(self.^attributes);

    $!lm = cast( GListModel, i.get_value(self) );
  }

  method GLib::Raw::Types::GListModel
    is also<GListModel>
  { $!lm }

  # Consider this approach to initializing a role-based object.
  method new-listmodel-obj (GListModel $model) is also<new_listmodel_obj> {
    my $o = self.bless( :$model ) but GLib::Roles::Object;
    $o.roleInit-Object;
    $o;
  }

  # Is originally:
  # GListModel, guint, guint, guint, gpointer --> void
  method items-changed {
    self.connect-items-changed($!lm);
  }

  method get_item (Int() $position) is also<get-item> {
    my guint $p = $position;

    g_list_model_get_item($!lm, $p);
  }

  method get_item_type is also<get-item-type> {
    GTypeEnum( g_list_model_get_item_type($!lm) );
  }

  method get_n_items
    is also<
      get-n-items
      elems
    >
  {
    g_list_model_get_n_items($!lm);
  }

  method get_object (Int() $position) is also<get-object> {
    my guint $p = $position;

    g_list_model_get_object($!lm, $p);
  }

  method emit_items_changed (
    Int() $position,
    Int() $removed,
    Int() $added
  )
    is also<emit-items-changed>
  {
    my guint ($p, $r, $a) = ($position, $removed, $added);

    g_list_model_items_changed($!lm, $p, $r, $a);
  }

}
