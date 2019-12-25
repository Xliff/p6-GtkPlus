use v6.c;

use Method::Also;
use NativeCall;

use GLib::Value;
use GTK::Compat::Types;
use GTK::Compat::Raw::AppLaunchContext;

use GTK::Compat::Display;

use GTK::Roles::Properties;
use GTK::Roles::Types;

class GTK::Compat::AppLaunchContext {
  also does GTK::Roles::Types;
  also does GTK::Roles::Properties;

  has GdkAppLaunchContext $!alc is implementor;

  submethod BUILD(:$context) {
    $!prop = nativecast(GObject, $!alc = $context);
  }

  method new {
    self.bless(
      context => GTK::Compat::Display.get_default.get_app_launch_context
    );
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # Type: GdkDisplay
method display is rw  {
  my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('display', $gv)
        );
        GTK::Compat::Display.new( nativecast(GdkDisplay, $gv.object) );
      },
      STORE => -> $, $val is copy {
        warn "GTK::Compat::AppLaunchContext.display is create-only";
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    gdk_app_launch_context_get_type();
  }

  method set_desktop (Int() $desktop) is also<set-desktop> {
    my gint $d = self.RESOLVE-INT($desktop);
    gdk_app_launch_context_set_desktop($!alc, $d);
  }

  method set_icon (GIcon $icon) is also<set-icon> {
    gdk_app_launch_context_set_icon($!alc, $icon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gdk_app_launch_context_set_icon_name($!alc, $icon_name);
  }

  method set_screen (GdkScreen() $screen) is also<set-screen> {
    gdk_app_launch_context_set_screen($!alc, $screen);
  }

  method set_timestamp (Int() $timestamp) is also<set-timestamp> {
    my guint $t = self.RESOLVE-UINT($timestamp);
    gdk_app_launch_context_set_timestamp($!alc, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
