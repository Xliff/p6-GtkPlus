use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::AppLaunchContext;

use GLib::Value;
use GDK::Display;

use GLib::Roles::Properties;

class GDK::AppLaunchContext {
  also does GLib::Roles::Properties;

  has GdkAppLaunchContext $!alc is implementor;

  submethod BUILD(:$context) {
    $!prop = nativecast(GObject, $!alc = $context);
  }

  multi method new (GdkAppLaunchContext $context) {
    $context ?? self.bless(:$context) !! Nil;
  }
  multi method new {
    my $context = GDK::Display.get_default.get_app_launch_context;

    $context ?? self.bless(:$context) !! Nil;
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
        GDK::Display.new( nativecast(GdkDisplay, $gv.object) );
      },
      STORE => -> $, $val is copy {
        warn 'GDK::AppLaunchContext.display is create-only';
      }
    );
  }
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method get_type is also<get-type> {
    unstable_get_type( self.^name, &gdk_app_launch_context_get_type, $n, $t );
  }

  method set_desktop (Int() $desktop) is also<set-desktop> {
    my gint $d = $desktop;

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
    my guint $t = $timestamp;

    gdk_app_launch_context_set_timestamp($!alc, $t);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
