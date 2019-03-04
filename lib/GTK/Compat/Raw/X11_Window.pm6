use v6.c;

use GTK::Compat::Types;

unit package GTK::Compat::Raw::X11_Window;

our class X11Window is repr<CPointer> is export also does GTK::Roles::Pointer;

sub gdk_x11_window_foreign_new_for_display (
  GdkDisplay $display, 
  X11Window $X11Window
)
  returns GdkWindow
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_get_desktop (GdkWindow $X11Window)
  returns guint32
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_get_xid (GdkWindow $X11Window)
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

sub gdk_x11_window_move_to_current_desktop (GdkWindow $X11Window)
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_move_to_desktop (GdkWindow $X11Window, guint32 $desktop)
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_set_frame_sync_enabled (
  GdkWindow $X11Window, 
  gboolean $frame_sync_enabled
)
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_set_hide_titlebar_when_maximized (
  GdkWindow $X11Window, 
  gboolean $hide_titlebar_when_maximized
)
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_set_theme_variant (GdkWindow $X11Window, Str $variant)
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_set_user_time (GdkWindow $X11Window, guint32 $timestamp)
  is native(gdk)
  is export
  { * }

sub gdk_x11_window_set_utf8_property (
  GdkWindow $X11Window, 
  Str $name, 
  Str $value
)
  is native(gdk)
  is export
  { * }
