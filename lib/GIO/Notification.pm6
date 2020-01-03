use v6.c;

use Method::Also;

use GLib::Raw::Types;

use GIO::Raw::Notification;

use GLib::Roles::Object;

class GIO::Notification {
  also does GLib::Roles::Object;

  has GNotification $!n is implementor;

  submethod BUILD (:$notification) {
    $!n = $notification;

    self.roleInit-Object;
  }

  method GLib::Raw::Types::GNotification
    is also<GNotification>
  { $!n }

  multi method new (GNotification $notification) {
    self.bless( :$notification );
  }
  multi method new(Str() $title) {
    my $n = g_notification_new($title);

    self.bless( notification => $n );
  }

  method add_button (Str() $label, Str() $detailed_action)
    is also<add-button>
  {
    g_notification_add_button($!n, $label, $detailed_action);
  }

  method add_button_with_target_value (
    Str() $label,
    Str() $action,
    GVariant() $target
  )
    is also<add-button-with-target-value>
  {
    g_notification_add_button_with_target_value(
      $!n,
      $label,
      $action,
      $target
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_notification_get_type, $n, $t );
  }

  method set_body (Str() $body) is also<set-body> {
    g_notification_set_body($!n, $body);
  }

  method set_default_action (Str() $detailed_action)
    is also<set-default-action>
  {
    g_notification_set_default_action($!n, $detailed_action);
  }

  method set_default_action_and_target_value (
    Str() $action,
    GVariant() $target
  )
    is also<set-default-action-and-target-value>
  {
    g_notification_set_default_action_and_target_value(
      $!n,
      $action,
      $target
    );
  }

  method set_icon (GIcon() $icon) is also<set-icon> {
    g_notification_set_icon($!n, $icon);
  }

  method set_priority (Int() $priority) is also<set-priority> {
    my GNotificationPriority $p = $priority;

    g_notification_set_priority($!n, $p);
  }

  method set_title (Str() $title) is also<set-title> {
    g_notification_set_title($!n, $title);
  }

}
