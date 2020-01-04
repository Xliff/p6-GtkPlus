use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types;
use GDK::Raw::Keymap;

use GLib::Roles::TypedBuffer;

class GDK::Keymap {
  has GdkKeymap $!km is implementor;

  submethod BUILD(:$keymap) {
    $!km = $keymap;
  }

  method GDK::Raw::Definitions::GdkKeymap
    is also<GdkKeymap>
  { $!km }

  multi method new (GdkDisplay() $display) {
    GDK::Keymap.get_for_display($display);
  }
  multi method new {
    GDK::Keymap.get_for_display(GdkDisplay);
  }

  method get_for_display(GdkDisplay() $display is copy)
    is also<get-for-display>
  {
    $display //= GDK::Display.get_default;
    my $keymap = gdk_keymap_get_for_display($display);
    $keymap ?? self.bless(:$keymap) !! Nil;
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓

  # $state is in/out so no need for a multi.
  method add_virtual_modifiers ($state is rw) {
    die '$state is invalid!' unless $state.^can('Int').elems;

    my guint $s = $state;

    gdk_keymap_add_virtual_modifiers($!km, $s);
    $state = $s;
  }

  method unicode_to_keyval (Int() $unichar)
    is also<unicode-to-keyval>
  {
    my guint $u = $unichar;

    gdk_unicode_to_keyval($u);
  }

  method get_caps_lock_state is also<get-caps-lock-state> {
    so gdk_keymap_get_caps_lock_state($!km);
  }

  method get_direction is also<get-direction> {
    PangoDirectionEnum( gdk_keymap_get_direction($!km) );
  }

  proto method get_entries_for_keycode (|c)
    is also<get-entries-for-keycode>
  { * }

  multi method get_entries_for_keycode (
    Int() $hardware_keycode,
    :$raw = False
  ) {
    my guint ($h, $n) = ($hardware_keycode, 0);
    my $keys = CArray[Pointer].new;
    my $kvals = CArray[CArray[guint]].new;
    $keys[0] = Pointer;
    $kvals[0] = CArray[gint];

    samewith($h, $keys, $kvals, $n, :$raw);
  }
  multi method get_entries_for_keycode (
    Int() $hardware_keycode,
    CArray[Pointer[GdkKeymapKey]] $keys,
    CArray[guint] $keyvals,
    $n_entries is rw,
    :$raw = False
  ) {
    my guint $hk = $hardware_keycode;
    my gint $ne = $n_entries;
    my $rc = gdk_keymap_get_entries_for_keycode(
      $!km, $hk, $keys, $keyvals, $ne
    );
    $n_entries = $ne;
    $keys = do if $keys[0] {
      my $k = GLib::Roles::TypedBuffer[GdkKeymapKey].new($keys[0]);
      $k.setSize($n);
      $k.Array;
    } else {
      Nil;
    }

    (
      $rc,
      $keys,
      $kvals[0] ?? CArrayToArray($kvals[0]) !! Nil
    );
  }

  proto method get_entries_for_keyval (|)
    is also<get-entries-for-keyval>
    { * }

  multi method get_entries_for_keyval (
    Int() $keyval,
  ) {
    my @keys;
    my $keys = CArray[Pointer[GdkKeymapKey]].new;
    $keys[0] = Pointer[GdkKeymapKey];
    samewith($keyval, $keys, $);
  }
  multi method get_entries_for_keyval (
    Int() $keyval,
    CArray[Pointer[GdkKeymapKey]] $keys,
    $n_keys is rw
  ) {
    my guint $kv = $keyval;
    my gint $nk = 0;
    my $rc = gdk_keymap_get_entries_for_keyval($!km, $kv, $keys, $nk);

    $n_keys = $nk
    $keys = do if $keys[0] {
      my $k = GLib::Roles::TypedBuffer[GdkKeymapKey].new($keys[0]);
      $k.setSize($nk);
      $k.Array;
    } else {
      Nil;
    }

    ($rc, $keys, $n_keys);
  }

  method get_modifier_mask (Int() $intent) is also<get-modifier-mask> {
    my guint $i = $intent;

    GdkModfierMaskEnum( gdk_keymap_get_modifier_mask($!km, $i) );
  }

  method get_modifier_state is also<get-modifier-state> {
    gdk_keymap_get_modifier_state($!km);
  }

  method get_num_lock_state is also<get-num-lock-state> {
    so gdk_keymap_get_num_lock_state($!km);
  }

  method get_scroll_lock_state is also<get-scroll-lock-state> {
    so gdk_keymap_get_scroll_lock_state($!km);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_keymap_get_type, $n, $t );
  }

  method have_bidi_layouts is also<have-bidi-layouts> {
    so gdk_keymap_have_bidi_layouts($!km);
  }

  proto method keyval_convert_case (|)
    is also<keyval-convert-case>
  { * }

  multi method keyval_convert_case(Int() $symbol) {
    samewith($symbol, $, $);
  }
  multi method keyval_convert_case (
    Int() $symbol,
    $lower is rw,
    $upper is rw
  ) {
    my guint ($s, $l, $u) = ($symbol, 0, 0);

    gdk_keyval_convert_case($s, $l, $u);
    ($lower, $upper) = ($l, $u);
  }

  method keyval_from_name(Str() $keyval_name)
    is also<keyval-from-name>
  {
    gdk_keyval_from_name($keyval_name);
  }

  method keyval_is_lower(Int() $keyval)
    is also<keyval-is-lower>
  {
    my guint $k = $keyval;

    so gdk_keyval_is_lower($k);
  }

  method keyval_is_upper (Int() $keyval) is also<keyval-is-upper> {
    my guint $k = $keyval;

    so gdk_keyval_is_upper($k);
  }

  method keyval_name (Int() $keyval) is also<keyval-name> {
    my guint $k = $keyval;

    gdk_keyval_name($k);
  }

  method keyval_to_lower (Int() $keyval) is also<keyval-to-lower> {
    my guint $k = $keyval;

    gdk_keyval_to_lower($k);
  }

  method keyval_to_unicode (Int() $keyval) is also<keyval-to-unicode> {
    my guint $k = $keyval;
    gdk_keyval_to_unicode($k);
  }

  method keyval_to_upper (Int() $keyval) is also<keyval-to-upper> {
    my guint $k = $keyval;

    gdk_keyval_to_upper($k);
  }

  method lookup_key (GdkKeymapKey $key) is also<lookup-key> {
    gdk_keymap_lookup_key($!km, $key);
  }

  method map_virtual_modifiers (Int() $state)
    is also<map-virtual-modifiers>
  {
    my gint $s = $state;

    gdk_keymap_map_virtual_modifiers($!km, $s);
  }

  proto method translate_keyboard_state (|)
    is also<translate-keyboard-state>
  { * }

  multi method translate_keyboard_state (
    Int() $hardware_keycode,
    Int() $state,                   # GdkModifierType $state,
    Int() $group
  ) {
    samewith($hardware_keycode, $state, $group, $, $, $, $);
  }
  multi method translate_keyboard_state (
    Int() $hardware_keycode,
    Int() $state,                   # GdkModifierType $state,
    Int() $group,
    $keyval          is rw,
    $effective_group is rw,
    $level           is rw,
    $consumed        is rw          # GdkModifierType $consumed_modifiers
  ) {
    my gint ($g, $eg, $l) = ($group, 0, 0);
    my guint ($hk, $s, $kv, $cm) = ($hardware_keycode, $state, 0, 0);

    gdk_keymap_translate_keyboard_state($!km, $hk, $s, $g, $kv, $eg, $l, $cm);
    ($keyval, $effective_group, $level, $consumed_modifiers) =
      ($kv, $eg, $l, $cm);

    ($rc, $keyval, $effective_group, $level, $consumed_modifiers);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
