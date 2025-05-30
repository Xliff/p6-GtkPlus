use v6.c;

use Method::Also;
use NativeCall;

use GLib::Value;

use GTK::Raw::AccelGroup:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Roles::StaticClass;

use GLib::Roles::Object;

our subset GtkAccelGroupAncestry is export of Mu
  where GtkAccelGroup | GObject;

class GTK::AccelGroup:ver<3.0.1146> {
  also does GLib::Roles::Object;

  has GtkAccelGroup $!ag is implementor;

  submethod BUILD ( :$gtk-accel-group ) {
    self.setGtkAccelGroup($gtk-accel-group) if $gtk-accel-group
  }

  method setGtkAccelGroup (GtkAccelGroupAncestry $_) {
    my $to-parent;

    $!ag = do {
      when GtkAccelGroup {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkAccelGroup, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkAccelGroup
    is also<GtkAccelGroup>
  { $!ag }

  multi method new (
     $gtk-accel-group where * ~~ GtkAccelGroupAncestry,

    :$ref = True
  ) {
    return unless $gtk-accel-group;

    my $o = self.bless( :$gtk-accel-group );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-accel-group = gtk_accel_group_new();

    $gtk-accel-group ?? self.bless(:$gtk-accel-group) !! Nil;
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
      FETCH => sub ($) {
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
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('modifier-mask', $gv)
        );
        GdkModifierTypeEnum( $gv.enum );
      },
      STORE => -> $, $val is copy {
        warn "modifier-mask does not allow writing"
      }
    );
  }

  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method activate (
    GQuark    $accel_quark,
    GObject() $acceleratable,
    Int()     $accel_key,
    Int()     $accel_mods
  ) {
    my guint           $ak = $accel_key;
    my GdkModifierType $am = $accel_mods;

    so gtk_accel_group_activate($!ag, $accel_quark, $acceleratable, $ak, $am);
  }

  multi method connect (
    Int()      $accel_key,
    Int()      $accel_mods,
    Int()      $accel_flags,
    GClosure() $closure
  ) {
    my guint           $ak = $accel_key;
    my guint           $af = $accel_flags; # GtkAccelFlags
    my GdkModifierType $am = $accel_mods;

    gtk_accel_group_connect($!ag, $ak, $am, $af, $closure);
  }

  method connect_by_path (Str() $accel_path, GClosure() $closure)
    is also<connect-by-path>
  {
    gtk_accel_group_connect_by_path($!ag, $accel_path, $closure);
  }

  method disconnect (GClosure() $closure) {
    so gtk_accel_group_disconnect($!ag, $closure);
  }

  method disconnect_key (Int() $accel_key, Int() $accel_mods)
    is also<disconnect-key>
  {
    my guint $ak = $accel_key;
    my GdkModifierType $am = $accel_mods;

    so gtk_accel_group_disconnect_key($!ag, $ak, $am);
  }

  method find (GtkAccelGroupFindFunc $find_func, gpointer $data) {
    gtk_accel_group_find($!ag, $find_func, $data);
  }

  method from_accel_closure (GClosure() $closure)
    is also<from-accel-closure>
  {
    gtk_accel_group_from_accel_closure($closure);
  }

  method get_is_locked is also<get-is-locked> {
    so gtk_accel_group_get_is_locked($!ag);
  }

  method get_modifier_mask is also<get-modifier-mask> {
    GdkModifierTypeEnum( gtk_accel_group_get_modifier_mask($!ag) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_accel_group_get_type, $n, $t );
  }

  method lock {
    gtk_accel_group_lock($!ag);
  }

  # Not found in v3 reference documentation!
  #
  # method query (
  #   guint $accel_key,
  #   GdkModifierType $accel_mods,
  #   guint $n_entries
  # ) {
  #   my guint $ak = $accel_key;
  #   my GdkModifierType $am = $accel_mods;
  #
  #   gtk_accel_group_query($!ag, $accel_key, $accel_mods, $n_entries);
  # }

  method unlock {
    gtk_accel_group_unlock($!ag);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}

class GTK::AccelGroups:ver<3.0.1146> {
  also does GLib::Roles::StaticClass;

  method activate (
    GObject() $object,
    Int() $accel_key,
    Int() $accel_mods
  )
    is also<accel-groups-activate>
  {
    my guint $ak = $accel_key;
    my GdkModifierType $am = $accel_mods;

    gtk_accel_groups_activate($object, $ak, $am);
  }

  method from_object (GObject() $o) is also<from-object> {
    gtk_accel_groups_from_object($o);
  }

}

class GTK::Accelerator:ver<3.0.1146> {
  also does GLib::Roles::StaticClass;

  method get_default_mod_mask is also<get-default-mod-mask> {
    GdkModifierTypeEnum( gtk_accelerator_get_default_mod_mask() );
  }

  method get_label (
    Int() $accelerator_key,
    Int() $accelerator_mods
  )
    is also<get-label>
  {
    my guint           $ak = $accelerator_key;
    my GdkModifierType $am = $accelerator_mods;

    gtk_accelerator_get_label($ak, $am);
  }

  method get_label_with_keycode (
    GdkDisplay() $display,
    Int()        $accelerator_key,
    Int()        $keycode,
    Int()        $accelerator_mods
  )
    is also<get-label-with-keycode>
  {
    my guint           ($ak, $k) = ($accelerator_key, $keycode);
    my GdkModifierType  $am      = $accelerator_mods;

    gtk_accelerator_get_label_with_keycode($display, $ak, $k, $am);
  }

  method name (
    Int() $accel_key,
    Int() $accelerator_mods
  )
    is also<accelerator-name>
  {
    my guint            $ak = $accel_key;
    my GdkModifierType  $am = $accelerator_mods;

    gtk_accelerator_name($ak, $am);
  }

  method name_with_keycode (
    GdkDisplay() $display,
    Int()        $accelerator_key,
    Int()        $keycode,
    Int()        $accelerator_mods
  )
    is also<name-with-keycode>
  {
    my guint ($ak, $k) = ($accelerator_key, $keycode);
    my GdkModifierType $am = $accelerator_mods;

    gtk_accelerator_name_with_keycode($display, $ak, $k, $am);
  }

  multi method parse (Str() $accelerator) {
    samewith($accelerator, $, $);
  }
  multi method parse (
    Str() $accelerator,
          $accelerator_key  is rw,
          $accelerator_mods is rw
  ) {
    my guint           $ak = 0;
    my GdkModifierType $am = 0;

    gtk_accelerator_parse($accelerator, $ak, $am);
    ($accelerator_key, $accelerator_mods) = ($ak, $am);
  }

  proto method parse_with_keycode (|)
    is also<parse-with-keycode>
  { * }

  multi method parse_with_keycode (Str() $accelerator) {
    samewith($accelerator, $, $, $);
  }
  multi method parse_with_keycode (
    Str() $accelerator,
          $accelerator_key   is rw,
          $accelerator_codes is rw,
          $accelerator_mods  is rw
  ) {
    my guint $ak = 0;

    my $ac = CArray[CArray[guint]].new;
    $ac[0] = CArray[guint];
    my GdkModifierType $am = 0;

    gtk_accelerator_parse_with_keycode($accelerator, $ak, $ac, $am);
    ($accelerator_key, $accelerator_codes, $accelerator_mods) = (
      $ak,
      $ac[0] ?? CArrayToArray($ac[0]) !! Nil,
      GdkModifierTypeEnum( $am )
    );
  }

  method set_default_mod_mask (Int() $mod_mask) is also<set-default-mod-mask> {
    my GdkModifierType $m = $mod_mask;

    gtk_accelerator_set_default_mod_mask($m);
  }

  method valid (Int() $keyval, Int() $modifiers) {
    my guint           $k = $keyval;
    my GdkModifierType $m = $modifiers;

    so gtk_accelerator_valid($k, $modifiers);
  }

}
