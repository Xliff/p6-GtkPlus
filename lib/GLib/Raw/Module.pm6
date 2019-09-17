use v6.c;

use NativeCall;

use GTK::Compat::Types;

unit package GLib::Raw::Module;

sub g_module_build_path (Str $directory, Str $module_name)
  returns Str
  is native(glib)
  is export
{ * }

sub g_module_close (GModule $module)
  returns uint32
  is native(glib)
  is export
{ * }

sub g_module_error ()
  returns Str
  is native(glib)
  is export
{ * }

sub g_module_make_resident (GModule $module)
  is native(glib)
  is export
{ * }

sub g_module_name (GModule $module)
  returns Str
  is native(glib)
  is export
{ * }

sub g_module_open (Str $file_name, GModuleFlags $flags)
  returns GModule
  is native(glib)
  is export
{ * }

sub g_module_supported ()
  returns uint32
  is native(glib)
  is export
{ * }

sub g_module_symbol (GModule $module, Str $symbol_name, gpointer $symbol)
  returns uint32
  is native(glib)
  is export
{ * }
