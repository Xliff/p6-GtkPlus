use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::X11_Types;
use GTK::Roles::Pointers;

package GTK::Compat::Raw::X11_Window {

  sub gdk_x11_window_get_desktop (GdkWindow $window)
    returns guint32
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_get_type ()
    returns GType
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_get_xid (GdkWindow $window)
    returns X11Window
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_lookup_for_display (
    GdkDisplay $display, 
    X11Window $X11Window
  )
    returns GdkWindow
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_move_to_current_desktop (GdkWindow $window)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_move_to_desktop (GdkWindow $window, guint32 $desktop)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_set_frame_sync_enabled (
    GdkWindow $window, 
    gboolean $frame_sync_enabled
  )
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_set_hide_titlebar_when_maximized (
    GdkWindow $window, 
    gboolean $hide_titlebar_when_maximized
  )
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_set_theme_variant (GdkWindow $window, Str $variant)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_set_user_time (GdkWindow $window, guint32 $timestamp)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_window_set_utf8_property (
    GdkWindow $window, 
    Str $name, 
    Str $value
  )
    is native(gdk)
    is export
    { * }
    
  sub gdk_x11_get_server_time (GdkWindow $window)
    is native(gdk)
    is export
    { * }
    
 }
