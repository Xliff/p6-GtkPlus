use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::AppInfo;

class GTK::Compat::LaunchContext {
  has GLaunchContext $!lc;

  submethod BUILD(:$context) {
    $!lc = $context
  }

  multi method new {
    my $context = g_app_launch_context_new($!lc);
    self.bless(:$context);
  }
  multi method new(GLaunchContext $context) {
    self.bless(:$context);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally
  # GAppLaunchContext, gchar, gpointer
  method launch-failed {
    self.connect($!lc, 'launch-failed');
  }

  method launched {
    self.connect($!lc, 'launched');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  method get_display (GAppInfo() $info, GList() $files) {
    g_app_launch_context_get_display($!lc, $info, $files);
  }

  method get_environment {
    g_app_launch_context_get_environment($!lc);
  }

  method get_startup_notify_id (GAppInfo() $info, GList() $files) {
    g_app_launch_context_get_startup_notify_id($!lc, $info, $files);
  }

  method launch_failed (Str() $startup_notify_id) {
    g_app_launch_context_launch_failed($!lc, $startup_notify_id);
  }

  method setenv (Str() $variable, Str() $value) {
    g_app_launch_context_setenv($!lc, $variable, $value);
  }

  method unsetenv (Str() $variable) {
    g_app_launch_context_unsetenv($!lc, $variable);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
