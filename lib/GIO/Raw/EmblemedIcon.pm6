use v6.c;

use NativeCall;

use GLib::Raw::Types;

unit package GIO::Raw::EmblemedIcon;

sub g_emblemed_icon_add_emblem (GEmblemedIcon $emblemed, GEmblem $emblem)
  is native(gio)
  is export
{ * }

sub g_emblemed_icon_clear_emblems (GEmblemedIcon $emblemed)
  is native(gio)
  is export
{ * }

sub g_emblemed_icon_get_emblems (GEmblemedIcon $emblemed)
  returns GList
  is native(gio)
  is export
{ * }

sub g_emblemed_icon_get_icon (GEmblemedIcon $emblemed)
  returns GIcon
  is native(gio)
  is export
{ * }

sub g_emblemed_icon_get_type ()
  returns GType
  is native(gio)
  is export
{ * }

sub g_emblemed_icon_new (GIcon $icon, GEmblem $emblem)
  returns GEmblemedIcon
  is native(gio)
  is export
{ * }
