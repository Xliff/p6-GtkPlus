use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::Notification;

sub g_notification_add_button (
  GNotification $notification,
  Str $label,
  Str $detailed_action
)
  is native(gio)
  is export
  { * }

sub g_notification_add_button_with_target_value (
  GNotification $notification,
  Str $label,
  Str $action,
  GVariant $target
)
  is native(gio)
  is export
  { * }

sub g_notification_get_type ()
  returns GType
  is native(gio)
  is export
  { * }

sub g_notification_new (Str $title)
  returns GNotification
  is native(gio)
  is export
  { * }

sub g_notification_set_body (GNotification $notification, Str $body)
  is native(gio)
  is export
  { * }

sub g_notification_set_default_action (
  GNotification $notification,
  Str $detailed_action
)
  is native(gio)
  is export
  { * }

sub g_notification_set_default_action_and_target_value (
  GNotification $notification,
  Str $action,
  GVariant $target
)
  is native(gio)
  is export
  { * }

sub g_notification_set_icon (GNotification $notification, GIcon $icon)
  is native(gio)
  is export
  { * }

sub g_notification_set_priority (
  GNotification $notification,
  uint32 $proiroty                    # GNotificationPriority $priority
)
  is native(gio)
  is export
  { * }

sub g_notification_set_title (GNotification $notification, Str $title)
  is native(gio)
  is export
  { * }
