use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::Keymap;

use GTK::Roles::Types;

class GTK::Compat::Keymap {
  also does GTK::Roles::Types;

  has GdkKeymap $!km;

  submethod BUILD(:$keymap) {
    $!km = $keymap;
  }

  multi method new (GdkDisplay $display) {
    GTK::Compat::Keymap.get_for_display($display);
  }
  multi method new {
    GTK::Compat::Keymap.get_for_display(GdkDisplay);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method add_virtual_modifiers (Int() $state is rw)
    is also<add-virtual-modifiers>
  {
    my guint $s = self.RESOLVE-UINT($state);
    gdk_keymap_add_virtual_modifiers($!km, $s);
    $state = $s;
    Nil;
  }

  method unicode_to_keyval (Int() $unichar)
    is also<unicode-to-keyval>
  {
    my guint $u = self.RESOLVE-UINT($unichar);
    gdk_unicode_to_keyval($u);
  }

  method get_caps_lock_state is also<get-caps-lock-state> {
    gdk_keymap_get_caps_lock_state($!km);
  }

  method get_direction is also<get-direction> {
    gdk_keymap_get_direction($!km);
  }

  proto method get_entries_for_keycode (|c)
    is also<get-entries-for-keycode>
    { * }

  multi method get_entries_for_keycode (
    Int() $hardware_keycode,
    Int() $n_entries is rw
  ) {
    my $keys = CArray[Pointer[GdkKeymap]].new;
    my $kvals = CArray[gint].new;
    my $rc = samewith($hardware_keycode, $keys, $kvals, $n_entries);
    my (@keys, @keyvals);
    @keys.push($keys[$_]) for ^$n_entries;
    @keyvals.push($kvals[$_].deref) for ^$n_entries;
    ($rc, @keys, @keyvals);
  }
  multi method get_entries_for_keycode (
    Int() $hardware_keycode,
    CArray[Pointer[GdkKeymapKey]] $keys,
    CArray[guint] $keyvals,
    Int() $n_entries is rw
  ) {
    my guint $hk = self.RESOLVE-UINT($hardware_keycode);
    my gint $ne = self.RESOLVE-INT($n_entries);
    my $rc = gdk_keymap_get_entries_for_keycode(
      $!km, $hk, $keys, $keyvals, $ne
    );
    $n_entries = $ne;
    $rc;
  }

  proto method get_entries_for_keyval (|)
    is also<get-entries-for-keyval>
    { * }

  multi method get_entries_for_keyval (
    Int() $keyval,
    Int() $n_keys is rw
  ) {
    my @keys;
    my $keys = CArray[Pointer[GdkKeymapKey]].new;
    my $rc = samewith($keyval, $keys, $n_keys);
    @keys.push($keys[$_].deref) for ^$n_keys;
    ($rc, @keys);
  }
  multi method get_entries_for_keyval (
    Int() $keyval,
    CArray[Pointer[GdkKeymapKey]] $keys,
    Int() $n_keys is rw
  ) {
    my guint $kv = self.RESOLVE-UINT($keyval);
    my gint $nk = self.RESOLVE-INT($n_keys);
    my $rc = gdk_keymap_get_entries_for_keyval($!km, $kv, $keys, $nk);
    $n_keys = $nk;
    $rc;
  }

  method get_for_display(GdkDisplay() $display is copy)
    is also<get-for-display>
  {
    $display //= GTK::Compat::Display.get_default;
    my $keymap = gdk_keymap_get_for_display($display);
    self.bless(:$keymap);
  }

  method get_modifier_mask (Int() $intent) is also<get-modifier-mask> {
    my guint $i = self.RESOLVE-INT($intent);
    gdk_keymap_get_modifier_mask($!km, $i);
  }

  method get_modifier_state is also<get-modifier-state> {
    gdk_keymap_get_modifier_state($!km);
  }

  method get_num_lock_state is also<get-num-lock-state> {
    gdk_keymap_get_num_lock_state($!km);
  }

  method get_scroll_lock_state is also<get-scroll-lock-state> {
    gdk_keymap_get_scroll_lock_state($!km);
  }

  method get_type is also<get-type> {
    gdk_keymap_get_type();
  }

  method have_bidi_layouts is also<have-bidi-layouts> {
    gdk_keymap_have_bidi_layouts($!km);
  }

  method keyval_convert_case (Int() $symbol, Int() $lower, Int() $upper)
    is also<keyval-convert-case>
  {
    my guint ($s, $l, $u) = self.RESOLVE-UINT($symbol, $lower, $upper);
    gdk_keyval_convert_case($s, $l, $u);
  }

  method keyval_from_name(Str() $keyval_name)
    is also<keyval-from-name>
  {
    gdk_keyval_from_name($keyval_name);
  }

  method keyval_is_lower(Int() $keyval)
    is also<keyval-is-lower>
  {
    my guint $k = self.RESOLVE-UINT($keyval);
    gdk_keyval_is_lower($k);
  }

  method keyval_is_upper (Int() $keyval) is also<keyval-is-upper> {
    my guint $k = self.RESOLVE-UINT($keyval);
    gdk_keyval_is_upper($k);
  }

  method keyval_name (Int() $keyval) is also<keyval-name> {
    my guint $k = self.RESOLVE-UINT($keyval);
    gdk_keyval_name($k);
  }

  method keyval_to_lower (Int() $keyval) is also<keyval-to-lower> {
    my guint $k = self.RESOLVE-UINT($keyval);
    gdk_keyval_to_lower($k);
  }

  method keyval_to_unicode (Int() $keyval) is also<keyval-to-unicode> {
    my guint $k = self.RESOLVE-UINT($keyval);
    gdk_keyval_to_unicode($k);
  }

  method keyval_to_upper (Int() $keyval) is also<keyval-to-upper> {
    my guint $k = self.RESOLVE-UINT($keyval);
    gdk_keyval_to_upper($k);
  }

  method lookup_key (GdkKeymapKey $key) is also<lookup-key> {
    gdk_keymap_lookup_key($!km, $key);
  }

  method map_virtual_modifiers (Int() $state)
    is also<map-virtual-modifiers>
  {
    my gint $s = self.RESOLVE-UINT($state);
    gdk_keymap_map_virtual_modifiers($!km, $s);
  }

  method translate_keyboard_state (
    Int() $hardware_keycode,
    Int() $state,                   # GdkModifierType $state,
    Int() $group,
    Int() $keyval,
    Int() $effective_group,
    Int() $level,
    Int() $consumed                 # GdkModifierType $consumed_modifiers
  )
    is also<translate-keyboard-state>
  {
    my @i = ($group, $effective_group, $level);
    my gint ($g, $eg, $l) = self.RESOLVE-INT(@i);
    my @u = ($hardware_keycode, $state, $keyval, $consumed);
    my guint ($hk, $s, $kv, $cm) = self.RESOLVE-UINT(@u);
    gdk_keymap_translate_keyboard_state($!km, $hk, $s, $g, $kv, $eg, $l, $cm);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
