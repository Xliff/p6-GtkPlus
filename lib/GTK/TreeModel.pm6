use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeModel;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::TreeModel {
  also does GTK::Roles::Types;

  has GtkTreeModel $!tm;

  submethod BUILD(:$tree) {
    $!tm = $tree;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  # ↑↑↑↑ METHODS ↑↑↑↑

}
