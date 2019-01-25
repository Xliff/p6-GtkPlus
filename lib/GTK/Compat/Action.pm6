use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Action;

class GTK::Compat::Action {
  has GAction $!a;

  submethod BUILD (:$action) {
    $!a = $action;
  }

  method new (GAction $action) {
    self.bless(:$action);
  }

  method activate (GVariant $parameter) {
    g_action_activate($!a, $parameter);
  }

  method change_state (GVariant $value) {
    g_action_change_state($!a, $value);
  }

  method get_enabled {
    g_action_get_enabled($!a);
  }

  method get_name {
    g_action_get_name($!a);
  }

  method get_parameter_type {
    g_action_get_parameter_type($!a);
  }

  method get_state {
    g_action_get_state($!a);
  }

  method get_state_hint {
    g_action_get_state_hint($!a);
  }

  method get_state_type {
    g_action_get_state_type($!a);
  }

  method get_type {
    g_action_get_type();
  }

  method name_is_valid(Str() $action_name) {
    so g_action_name_is_valid($action_name);
  }

  method parse_detailed_name (
    Str() $detailed_name,
    Str() $action_name,
    GVariant $target_value,
    CArray[Pointer[GError]] $error = gerror
  ) {
    $ERROR = Nil;
    my $rc = so g_action_parse_detailed_name(
      $detailed_name, $action_name, $target_value, $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method print_detailed_name (Str() $action_name, GVariant $target_value) {
    g_action_print_detailed_name($action_name, $target_value);
  }

}
