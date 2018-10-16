use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Actionable;
use GTK::Raw::Types;

role GTK::Roles::Actionable {
  has GtkActionable $!a;

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  method action_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_actionable_get_action_name($!a);
      },
      STORE => sub ($, Str() $action_name is copy) {
        gtk_actionable_set_action_name($!a, $action_name);
      }
    );
  }

  # Alias back to action_target_value
  method action_target is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_actionable_get_action_target_value($!a);
      },
      STORE => sub ($, GVariant() $target_value is copy) {
        gtk_actionable_set_action_target_value($!a, $target_value);
      }
    );
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_actionable_type {
    gtk_actionable_get_type();
  }

  method set_detailed_action_name (Str() $detailed_action_name) {
    gtk_actionable_set_detailed_action_name($!a, $detailed_action_name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
