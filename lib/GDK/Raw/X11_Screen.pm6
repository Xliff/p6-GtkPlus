use v6.c;

use NativeCall;

use GDK::Raw::Types;
use GDK::X11_Types;

unit package GDK::Raw::X11_Screen;

sub gdk_x11_get_default_screen ()
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_current_desktop (GdkScreen $screen)
  returns guint32
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_monitor_output (GdkScreen $screen, gint $monitor_num)
  returns XID
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_number_of_desktops (GdkScreen $screen)
  returns guint32
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_screen_number (GdkScreen $screen)
  returns gint
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_window_manager_name (GdkScreen $screen)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_get_xscreen (GdkScreen $screen)
  returns X11Screen
  is native(gdk)
  is export
  { * }

sub gdk_x11_screen_supports_net_wm_hint (GdkScreen $screen, GdkAtom $property)
  returns uint32
  is native(gdk)
  is export
  { * }
