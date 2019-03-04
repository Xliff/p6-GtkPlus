use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::X11_Types;

package GTK::Compat::Raw::X11_Display {
  
  # From x11/gdkx11window.h
  sub gdk_x11_window_foreign_new_for_display (
    GdkDisplay $display, 
    X11Window $X11Window
  )
    returns GdkWindow
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_error_trap_pop_ignored (GdkDisplay $display)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_error_trap_push (GdkDisplay $display)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_lookup_xdisplay (X11Display $xdisplay)
    returns GdkDisplay
    is native(gdk)
    is export
    { * }

  sub gdk_x11_register_standard_event_type (
    GdkDisplay $display, 
    gint $event_base, 
    gint $n_events
  )
    is native(gdk)
    is export
    { * }

  sub gdk_x11_set_sm_client_id (Str $sm_client_id)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_get_type ()
    returns GType
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_get_user_time (GdkDisplay $display)
    returns guint32
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_get_xdisplay (GdkDisplay $display)
    returns X11Display
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_grab (GdkDisplay $display)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_set_cursor_theme (
    GdkDisplay $display, 
    Str $theme, 
    gint $size
  )
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_set_window_scale (GdkDisplay $display, gint $scale)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_ungrab (GdkDisplay $display)
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_get_startup_notification_id (GdkDisplay $display)
    returns Str
    is native(gdk)
    is export
    { * }

  sub gdk_x11_display_set_startup_notification_id (
    GdkDisplay $display, 
    Str $startup_id
  )
    is native(gdk)
    is export
    { * }
    
  }
