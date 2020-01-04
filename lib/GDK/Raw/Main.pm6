use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::Main;

sub gdk_add_option_entries_libgtk_only (GOptionGroup $group)
  is native(gdk)
  is export
{ * }

sub gdk_disable_multidevice ()
  is native(gdk)
  is export
{ * }

sub gdk_get_display_arg_name ()
  returns Str
  is native(gdk)
  is export
{ * }

sub gdk_get_program_class ()
  returns Str
  is native(gdk)
  is export
{ * }

sub gdk_init (gint $argc, CArray[Str] $argv)
  is native(gdk)
  is export
{ * }

sub gdk_init_check (gint $argc, CArray[Str] $argv)
  returns uint32
  is native(gdk)
  is export
{ * }

sub gdk_notify_startup_complete ()
  is native(gdk)
  is export
{ * }

sub gdk_notify_startup_complete_with_id (Str $startup_id)
  is native(gdk)
  is export
{ * }

sub gdk_parse_args (gint $argc, Str $argv)
  is native(gdk)
  is export
{ * }

sub gdk_pre_parse_libgtk_only ()
  is native(gdk)
  is export
{ * }

sub gdk_screen_height ()
  returns gint
  is native(gdk)
  is export
{ * }

sub gdk_screen_height_mm ()
  returns gint
  is native(gdk)
  is export
{ * }

sub gdk_screen_width ()
  returns gint
  is native(gdk)
  is export
{ * }

sub gdk_screen_width_mm ()
  returns gint
  is native(gdk)
  is export
{ * }

sub gdk_set_allowed_backends (Str $backends)
  is native(gdk)
  is export
{ * }

sub gdk_set_program_class (Str $program_class)
  is native(gdk)
  is export
{ * }
