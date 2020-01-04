use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::DisplayManager;

sub gdk_display_manager_get ()
  returns GdkDisplayManager
  is native(gdk)
  is export
  { * }

sub gdk_display_manager_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_display_manager_list_displays (GdkDisplayManager $manager)
  returns GSList
  is native(gdk)
  is export
  { * }

sub gdk_display_manager_open_display (GdkDisplayManager $manager, gchar $name)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_display_manager_get_default_display (GdkDisplayManager $manager)
  returns GdkDisplay
  is native(gdk)
  is export
  { * }

sub gdk_display_manager_set_default_display (
  GdkDisplayManager $manager,
  GdkDisplay $display
)
  is native(gdk)
  is export
  { * }
