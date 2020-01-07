use v6.c;

use NativeCall;


use GTK::Raw::Actionable;
use GTK::Raw::Types;

role GTK::Roles::Actionable {
  has GtkActionable $!action;

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method action_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_actionable_get_action_name($!action);
      },
      STORE => sub ($, Str() $action_name is copy) {
        gtk_actionable_set_action_name($!action, $action_name);
      }
    );
  }

  # Alias back to action_target_value
  method action_target is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_actionable_get_action_target_value($!action);
      },
      STORE => sub ($, GVariant() $target_value is copy) {
        gtk_actionable_set_action_target_value($!action, $target_value);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_actionable_type {
    state ($n, $t);
    
    GTK::Widget.unstable_get_type( &gtk_actionable_get_type, $n, $t );
  }

  method set_detailed_action_name (Str() $detailed_action_name) {
    gtk_actionable_set_detailed_action_name($!action, $detailed_action_name);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
