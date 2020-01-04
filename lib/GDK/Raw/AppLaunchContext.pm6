use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::AppLaunchContext;

sub gdk_app_launch_context_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_app_launch_context_set_desktop (
  GdkAppLaunchContext $context,
  gint $desktop
)
  is native(gdk)
  is export
  { * }

sub gdk_app_launch_context_set_icon (
  GdkAppLaunchContext $context,
  GIcon $icon
)
  is native(gdk)
  is export
  { * }

sub gdk_app_launch_context_set_icon_name (
  GdkAppLaunchContext $context,
  gchar $icon_name
)
  is native(gdk)
  is export
  { * }

sub gdk_app_launch_context_set_screen (
  GdkAppLaunchContext $context,
  GdkScreen $screen
)
  is native(gdk)
  is export
  { * }

sub gdk_app_launch_context_set_timestamp (
  GdkAppLaunchContext $context,
  guint32 $timestamp
)
  is native(gdk)
  is export
  { * }
