use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::Seekable;

sub g_seekable_can_seek (GSeekable $seekable)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_seekable_can_truncate (GSeekable $seekable)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_seekable_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_seekable_seek (
  GSeekable $seekable,
  goffset $offset,
  GSeekType $type,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }

sub g_seekable_tell (GSeekable $seekable)
  returns goffset
  is native(gio)
  is export
{ * }

sub g_seekable_truncate (
  GSeekable $seekable,
  goffset $offset,
  GCancellable $cancellable,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gio)
  is export
{ * }
