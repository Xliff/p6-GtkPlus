use v6.c;

use GTK::Compat::Types;

use GTK::Compat::Raw::Notification;

use GTK::Compat::Roles::Object;

class GTK::Compat::Notification {
  also does GTK::Compat::Roles::Object;

  has GNotification $!n;

  submethod BUILD (:$notification) {
    self!setObject($!n = $notification);
  }

  method new(Str() $title) {
    self.bless( notification => g_notification_new($title) );
  }

  method add_button (Str() $label, Str() $detailed_action) {
    g_notification_add_button($!n, $label, $detailed_action);
  }

  method add_button_with_target_value (
    Str() $label,
    Str() $action,
    GVariant() $target
  ) {
    g_notification_add_button_with_target_value(
      $!n,
      $label,
      $action,
      $target
    );
  }

  method get_type {
    state ($n, $t);
    unstable_get_type( self.^name, &g_notification_get_type, $n, $t );
  }

  method set_body (Str() $body) {
    g_notification_set_body($!n, $body);
  }

  method set_default_action (Str() $detailed_action) {
    g_notification_set_default_action($!n, $detailed_action);
  }

  method set_default_action_and_target_value (
    Str() $action,
    GVariant() $target
  ) {
    g_notification_set_default_action_and_target_value(
      $!n,
      $action,
      $target
    );
  }

  method set_icon (GIcon() $icon) {
    g_notification_set_icon($!n, $icon);
  }

  method set_priority (GNotificationPriority $priority) {
    g_notification_set_priority($!n, $priority);
  }

  method set_title (Str() $title) {
    g_notification_set_title($!n, $title);
  }

}
