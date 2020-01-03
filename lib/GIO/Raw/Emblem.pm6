use v6.c;

use NativeCall;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

unit package GIO::Raw::Emblem;

sub g_emblem_get_icon (GEmblem $emblem)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_emblem_get_origin (GEmblem $emblem)
  returns GEmblemOrigin
  is native(gio)
  is export
{ * }

sub g_emblem_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_emblem_new (GIcon $icon)
  returns GEmblem
  is native(gio)
  is export
{ * }

sub g_emblem_new_with_origin (GIcon $icon, GEmblemOrigin $origin)
  returns GEmblem
  is native(gio)
  is export
{ * }
