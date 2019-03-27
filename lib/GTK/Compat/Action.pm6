use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Action;

use GTK::Compat::Roles::Object;

class GTK::Compat::Action {
  also does GTK::Compat::Roles::Object;
  
  has GAction $!a;

  submethod BUILD (:$action) {
    self!setObject($!a = $action);
  }
  
  method GTK::Compat::Types::GAction 
    is also<Action>
    { $!a }

  method new (GAction $action) {
    self.bless(:$action);
  }

  method activate (GVariant() $parameter) {
    g_action_activate($!a, $parameter);
  }

  method change_state (GVariant() $value) is also<change-state> {
    g_action_change_state($!a, $value);
  }

  method get_enabled is also<get-enabled> {
    g_action_get_enabled($!a);
  }

  method get_name is also<get-name> {
    g_action_get_name($!a);
  }

  method get_parameter_type is also<get-parameter-type> {
    g_action_get_parameter_type($!a);
  }

  method get_state is also<get-state> {
    g_action_get_state($!a);
  }

  method get_state_hint is also<get-state-hint> {
    g_action_get_state_hint($!a);
  }

  method get_state_type is also<get-state-type> {
    g_action_get_state_type($!a);
  }

  method get_type is also<get-type> {
    g_action_get_type();
  }

  method name_is_valid(Str() $action_name) is also<name-is-valid> {
    so g_action_name_is_valid($action_name);
  }

  proto method parse_detailed_name (|)
    is also<parse-detailed-name> 
    { * }
    
  multi method parse_detailed_name (
    Str() $detailed_name,
    Str() $action_name,
    GVariant $target_value,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    $ERROR = Nil;
    my $rc = so g_action_parse_detailed_name(
      $detailed_name, $action_name, $target_value, $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }
  multi method print_detailed_name (
    Str() $action_name, 
    GVariant() $target_value
  ) {
    g_action_print_detailed_name($action_name, $target_value);
  }

}
