use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::FilenameCompleter;

sub g_filename_completer_get_completion_suffix (
  GFilenameCompleter $completer,
  Str $initial_text
)
  returns Str
  is native(gio)
  is export
{ * }

sub g_filename_completer_get_completions (
  GFilenameCompleter $completer,
  Str $initial_text
)
  returns CArray[Str]
  is native(gio)
  is export
{ * }

sub g_filename_completer_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_filename_completer_new ()
  returns GFilenameCompleter
  is native(gio)
  is export
{ * }

sub g_filename_completer_set_dirs_only (
  GFilenameCompleter $completer,
  gboolean $dirs_only
)
  is native(gio)
  is export
{ * }
