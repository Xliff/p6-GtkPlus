use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

use GTK::Bin;

# This is an interesting one as it is created by GTK::FlowBox automatically.
# It is practically an abstract class, but it is used as an individual object
# by GTK::FlowBox

# One could almost think this could just be a GTK::Bin. The jury is hung, at
# the moment.

class GTK::FlowBoxChild is GTK::Bin {
  has GtkFlowBoxChild $!fbc;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method setFlowBoxChild(GtkFlowBoxChild $child) {
    $!fbc = $child;
    self.setBin($child);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑
}
