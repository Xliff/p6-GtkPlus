use NativeCall;

unit package toolbar_example;

sub gdk_window_unfullscreen(GdkWindow $window)
  is export
  is native(gdk)
  { * }

sub gdk_window_fullscreen(GdkWindow $window)
  is export
  is native(gdk)
  { * }

sub gdk_screen_get_default()
  returns GdkScreen
  is export
  is native('gdk-3')
  { * }

sub gdk_screen_get_width(GdkScreen)
  returns gint
  is export
  is native(gdk)
  { * }

sub gdk_screen_get_height(GdkScreen)
  returns gint
  is export
  is native(gdk)
  { * }
