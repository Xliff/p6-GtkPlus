use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::DesktopAppInfo;

sub g_desktop_app_info_get_action_name (
  GDesktopAppInfo $info,
  Str $action_name
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_boolean (GDesktopAppInfo $info, Str $key)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_categories (GDesktopAppInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_filename (GDesktopAppInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_generic_name (GDesktopAppInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_implementations (Str $interface)
  returns GList
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_is_hidden (GDesktopAppInfo $info)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_locale_string (GDesktopAppInfo $info, Str $key)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_nodisplay (GDesktopAppInfo $info)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_show_in (GDesktopAppInfo $info, Str $desktop_env)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_startup_wm_class (GDesktopAppInfo $info)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_string (GDesktopAppInfo $info, Str $key)
  returns Str
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_string_list (
  GDesktopAppInfo $info,
  Str $key,
  gsize $length
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_has_key (GDesktopAppInfo $info, Str $key)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_launch_action (
  GDesktopAppInfo $info,
  Str $action_name,
  GAppLaunchContext $launch_context
)
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_launch_uris_as_manager (
  GDesktopAppInfo $appinfo,
  GList $uris,
  GAppLaunchContext $launch_context,
  GSpawnFlags $spawn_flags,
  GSpawnChildSetupFunc $user_setup,
  gpointer $user_setup_data,
  &pid_callback (GDesktopAppInfo, GPid, gpointer),
  gpointer $pid_callback_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_launch_uris_as_manager_with_fds (
  GDesktopAppInfo $appinfo,
  GList $uris,
  GAppLaunchContext $launch_context,
  GSpawnFlags $spawn_flags,
  GSpawnChildSetupFunc $user_setup,
  gpointer $user_setup_data,
  &pid_callback (GDesktopAppInfo, GPid, gpointer),
  gpointer $pid_callback_data,
  gint $stdin_fd,
  gint $stdout_fd,
  gint $stderr_fd,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_lookup_get_default_for_uri_scheme (
  GDesktopAppInfoLookup $lookup,
  Str $uri_scheme
)
  returns GAppInfo
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_lookup_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_new (Str $desktop_id)
  returns GDesktopAppInfo
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_new_from_filename (Str $filename)
  returns GDesktopAppInfo
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_new_from_keyfile (GKeyFile $key_file)
  returns GDesktopAppInfo
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_search (Str $search_string)
  returns CArray[CArray[Str]]
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_set_desktop_env (Str $desktop_env)
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_list_actions (GDesktopAppInfo $info)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_desktop_app_info_get_keywords (GDesktopAppInfo $info)
  returns CArray[Str]
  is native(gio)
  is export
{ * }
