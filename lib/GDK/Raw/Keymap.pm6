use v6.c;

use NativeCall;

use GDK::Raw::Types;

unit package GDK::Raw::Keymap;

sub gdk_keymap_add_virtual_modifiers (
  GdkKeymap $keymap,
  guint $state                        # GdkModifierType $state
)
  is native(gdk)
  is export
  { * }

sub gdk_keyval_convert_case (guint $symbol, guint $lower, guint $upper)
  is native(gdk)
  is export
  { * }

sub gdk_keyval_from_name (gchar $keyval_name)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_keyval_is_lower (guint $keyval)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keyval_is_upper (guint $keyval)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keyval_name (guint $keyval)
  returns Str
  is native(gdk)
  is export
  { * }

sub gdk_keyval_to_lower (guint $keyval)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_keyval_to_unicode (guint $keyval)
  returns guint32
  is native(gdk)
  is export
  { * }

sub gdk_keyval_to_upper (guint $keyval)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_unicode_to_keyval (guint32 $wc)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_caps_lock_state (GdkKeymap $keymap)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_direction (GdkKeymap $keymap)
  returns uint32 # PangoDirection
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_entries_for_keycode (
  GdkKeymap $keymap,
  guint $hardware_keycode,
  CArray[Pointer[GdkKeymapKey]] $keys,
  CArray[guint] $keyvals,
  gint $n_entries is rw
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_entries_for_keyval (
  GdkKeymap $keymap,
  guint $keyval,
  CArray[Pointer[GdkKeymapKey]] $keys,
  gint $n_keys is rw
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_for_display (GdkDisplay $display)
  returns GdkKeymap
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_modifier_mask (
  GdkKeymap $keymap,
  uint32 $intent                        # GdkModifierIntent $intent
)
  returns uint32 # GdkModifierType
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_modifier_state (GdkKeymap $keymap)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_num_lock_state (GdkKeymap $keymap)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_scroll_lock_state (GdkKeymap $keymap)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_get_type ()
  returns GType
  is native(gdk)
  is export
  { * }

sub gdk_keymap_have_bidi_layouts (GdkKeymap $keymap)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_lookup_key (GdkKeymap $keymap, GdkKeymapKey $key)
  returns guint
  is native(gdk)
  is export
  { * }

sub gdk_keymap_map_virtual_modifiers (
  GdkKeymap $keymap,
  uint32 $state                         # GdkModifierType $state
)
  returns uint32
  is native(gdk)
  is export
  { * }

sub gdk_keymap_translate_keyboard_state (
  GdkKeymap $keymap,
  guint $hardware_keycode,
  uint32 $state,                        # GdkModifierType $state,
  gint $group,
  guint $keyval,
  gint $effective_group,
  gint $level,
  uint32 $consumed_modifiers            # GdkModifierType $consumed_modifiers
)
  returns uint32
  is native(gdk)
  is export
  { * }
