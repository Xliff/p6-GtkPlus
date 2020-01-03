use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GTK::Compat::Raw::AppInfo;

sub g_app_info_add_supports_type (
  GAppInfo $appinfo,
  gchar $content_type,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_can_delete (GAppInfo $appinfo)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_can_remove_supports_type (GAppInfo $appinfo)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_create_from_commandline (
  gchar $commandline,
  gchar $application_name,
  uint32 $flags,                # GAppInfoCreateFlags $flags,
  GError $error is rw
)
  returns GAppInfo
  is native(gtk)
  is export
  { * }

sub g_app_info_delete (GAppInfo $appinfo)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_dup (GAppInfo $appinfo)
  returns GAppInfo
  is native(gtk)
  is export
  { * }

sub g_app_info_equal (GAppInfo $appinfo1, GAppInfo $appinfo2)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_get_display (
  GAppLaunchContext $context,
  GAppInfo $info,
  GList $files
)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_get_environment (GAppLaunchContext $context)
  returns CArray[Str]
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_get_startup_notify_id (
  GAppLaunchContext $context,
  GAppInfo $info,
  GList $files
)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_launch_failed (
  GAppLaunchContext $context,
  gchar $startup_notify_id
)
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_new ()
  returns GAppLaunchContext
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_setenv (
  GAppLaunchContext $context,
  gchar $variable,
  gchar $value
)
  is native(gtk)
  is export
  { * }

sub g_app_launch_context_unsetenv (
  GAppLaunchContext $context,
  gchar $variable
)
  is native(gtk)
  is export
  { * }

sub g_app_info_get_all ()
  returns GList
  is native(gtk)
  is export
  { * }

sub g_app_info_get_all_for_type (gchar $content_type)
  returns GList
  is native(gtk)
  is export
  { * }

sub g_app_info_get_commandline (GAppInfo $appinfo)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_info_get_default_for_type (
  gchar $content_type,
  gboolean $must_support_uris
)
  returns GAppInfo
  is native(gtk)
  is export
  { * }

sub g_app_info_get_default_for_uri_scheme (gchar $uri_scheme)
  returns GAppInfo
  is native(gtk)
  is export
  { * }

sub g_app_info_get_description (GAppInfo $appinfo)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_info_get_display_name (GAppInfo $appinfo)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_info_get_executable (GAppInfo $appinfo)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_info_get_fallback_for_type (gchar $content_type)
  returns GList
  is native(gtk)
  is export
  { * }

sub g_app_info_get_icon (GAppInfo $appinfo)
  returns GIcon
  is native(gtk)
  is export
  { * }

sub g_app_info_get_id (GAppInfo $appinfo)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_info_get_name (GAppInfo $appinfo)
  returns gchar
  is native(gtk)
  is export
  { * }

sub g_app_info_get_recommended_for_type (gchar $content_type)
  returns GList
  is native(gtk)
  is export
  { * }

sub g_app_info_get_supported_types (GAppInfo $appinfo)
  returns CArray[gchar]
  is native(gtk)
  is export
  { * }

sub g_app_info_launch (
  GAppInfo $appinfo,
  GList $files,
  GAppLaunchContext $context,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_launch_default_for_uri (
  gchar $uri,
  GAppLaunchContext $context,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_launch_default_for_uri_async (
  gchar $uri,
  GAppLaunchContext $context,
  GCancellable $cancellable,
  GAsyncReadyCallback $callback,
  gpointer $user_data
)
  is native(gtk)
  is export
  { * }

sub g_app_info_launch_default_for_uri_finish (
  GAsyncResult $result,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_launch_uris (
  GAppInfo $appinfo,
  GList $uris,
  GAppLaunchContext $context,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_monitor_get ()
  returns GAppInfoMonitor
  is native(gtk)
  is export
  { * }

sub g_app_info_monitor_get_type ()
  returns GType
  is native(gtk)
  is export
  { * }

sub g_app_info_remove_supports_type (
  GAppInfo $appinfo,
  gchar $content_type,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_reset_type_associations (gchar $content_type)
  is native(gtk)
  is export
  { * }

sub g_app_info_set_as_default_for_extension (
  GAppInfo $appinfo,
  gchar $extension,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_set_as_default_for_type (
  GAppInfo $appinfo,
  gchar $content_type,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_set_as_last_used_for_type (
  GAppInfo $appinfo,
  gchar $content_type,
  GError $error is rw
)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_should_show (GAppInfo $appinfo)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_supports_files (GAppInfo $appinfo)
  returns uint32
  is native(gtk)
  is export
  { * }

sub g_app_info_supports_uris (GAppInfo $appinfo)
  returns uint32
  is native(gtk)
  is export
  { * }
