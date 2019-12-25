use v6.c;

use Method::Also;
use NativeCall;

use GLib::Value;
use GTK::Compat::Types;
use GTK::Raw::AccelGroup;
use GTK::Raw::Types;

use GTK::Roles::Types;

class GTK::AccelGroup {
  has GtkAccelGroup $!ag is implementor;

  submethod BUILD(:$group) {
    $!ag = $group;
  }

  method new {
    my $group = gtk_accel_group_new();
    self.bless(:$group);
  }


  # ↓↓↓↓ SIGNALS ↓↓↓↓

  # Is originally:
  # GtkAccelGroup, GObject, guint, GdkModifierType, gpointer --> gboolean
  method accel-activate is also<accel_activate> {
    self.connect($!ag, 'accel-activate');
  }

  # Is originally:
  # GtkAccelGroup, guint, GdkModifierType, GClosure, gpointer --> void
  method accel-changed is also<accel_changed> {
    self.connect($!ag, 'accel-changed');
  }

  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓

  # Type: gboolean
  method is-locked is rw is also<is_locked> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('is-locked', $gv)
         );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn "is-locked does not allow writing"
      }
    );
  }

  # Type: GdkModifierType
  method modifier-mask is rw is also<modifier_mask> {
    my GLib::Value $gv .= new( G_TYPE_ENUM );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('modifier-mask', $gv)
        );
        GdkModifierType( $gv.enum );
      },
      STORE => -> $, $val is copy {
        warn "modifier-mask does not allow writing"
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ STATIC METHODS ↓↓↓↓
  method accelerator_get_default_mod_mask
    is also<accelerator-get-default-mod-mask>
  {
    gtk_accelerator_get_default_mod_mask();
  }

  method accelerator_get_label (GdkModifierType $accelerator_mods)
    is also<accelerator-get-label>
  {
    gtk_accelerator_get_label($!ag, $accelerator_mods);
  }

  method acceelerator_get_label_with_keycode (
    GdkDisplay $display,
    guint $accelerator_key,
    guint $keycode,
    GdkModifierType $accelerator_mods
  )
    is also<acceelerator-get-label-with-keycode>
  {
    gtk_accelerator_get_label_with_keycode(
      $display,
      $accelerator_key,
      $keycode,
      $accelerator_mods
    );
  }

  method accelerator_name (
    guint $accel_key,
    GdkModifierType $accelerator_mods
  ) is also<accelerator-name> {
    gtk_accelerator_name($accel_key, $accelerator_mods);
  }

  method accelerator_name_with_keycode (
    GdkDisplay $display,
    guint $accelerator_key,
    guint $keycode,
    GdkModifierType $accelerator_mods
  )
    is also<accelerator-name-with-keycode>
  {
    gtk_accelerator_name_with_keycode(
      $display,
      $accelerator_key,
      $keycode,
      $accelerator_mods
    );
  }

  method accelerator_parse (
    Str() $accelerator,
    guint $accelerator_key,
    GdkModifierType $accelerator_mods
  )
    is also<accelerator-parse>
  {
    gtk_accelerator_parse(
      $accelerator,
      $accelerator_key,
      $accelerator_mods
    );
  }

  method accelerator_parse_with_keycode (
    Str() $accelerator,
    guint $accelerator_key,
    guint $accelerator_codes,
    GdkModifierType $accelerator_mods
  )
    is also<accelerator-parse-with-keycode>
  {
    gtk_accelerator_parse_with_keycode(
      $accelerator,
      $accelerator_key,
      $accelerator_codes,
      $accelerator_mods
    );
  }

  method accelerator_set_default_mod_mask
    is also<accelerator-set-default-mod-mask>
  {
    gtk_accelerator_set_default_mod_mask($!ag);
  }

  method accelerator_valid (GdkModifierType $modifiers)
    is also<accelerator-valid>
  {
    gtk_accelerator_valid($!ag, $modifiers);
  }
  # ↑↑↑↑ STATIC METHODS ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate (
    GQuark $accel_quark,
    GObject $acceleratable,
    guint $accel_key,
    GdkModifierType $accel_mods
  ) {
    gtk_accel_group_activate(
      $!ag,
      $accel_quark,
      $acceleratable,
      $accel_key,
      $accel_mods
    );
  }

  method connect (
    guint $accel_key,
    GdkModifierType $accel_mods,
    GtkAccelFlags $accel_flags,
    GClosure $closure
  ) {
    gtk_accel_group_connect(
      $!ag,
      $accel_key,
      $accel_mods,
      $accel_flags,
      $closure
    );
  }

  method connect_by_path (gchar $accel_path, GClosure $closure)
    is also<connect-by-path>
  {
    gtk_accel_group_connect_by_path($!ag, $accel_path, $closure);
  }

  method disconnect (GClosure $closure) {
    gtk_accel_group_disconnect($!ag, $closure);
  }

  method disconnect_key (guint $accel_key, GdkModifierType $accel_mods)
    is also<disconnect-key>
  {
    gtk_accel_group_disconnect_key($!ag, $accel_key, $accel_mods);
  }

  method find (GtkAccelGroupFindFunc $find_func, gpointer $data) {
    gtk_accel_group_find($!ag, $find_func, $data);
  }

  method from_accel_closure (GClosure $closure)
    is also<from-accel-closure>
  {
    gtk_accel_group_from_accel_closure($closure);
  }

  method get_is_locked is also<get-is-locked> {
    gtk_accel_group_get_is_locked($!ag);
  }

  method get_modifier_mask is also<get-modifier-mask> {
    gtk_accel_group_get_modifier_mask($!ag);
  }

  method get_type is also<get-type> {
    gtk_accel_group_get_type();
  }

  method accel_groups_activate (
    GObject $object,
    guint $accel_key,
    GdkModifierType $accel_mods
  )
    is also<accel-groups-activate>
  {
    gtk_accel_groups_activate($object, $accel_key, $accel_mods);
  }

  method groups_from_object (GObject $o) is also<groups-from-object> {
    gtk_accel_groups_from_object($o);
  }

  method lock {
    gtk_accel_group_lock($!ag);
  }

  method query (
    guint $accel_key,
    GdkModifierType $accel_mods,
    guint $n_entries
  ) {
    gtk_accel_group_query($!ag, $accel_key, $accel_mods, $n_entries);
  }

  method unlock {
    gtk_accel_group_unlock($!ag);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
