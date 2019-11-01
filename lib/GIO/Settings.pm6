use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GTK::Raw::Utils;

use GIO::Raw::Settings;

use GTK::Roles::Properties;

use GIO::Roles::Signals::Settings;

class GIO::Settings {
  also does GTK::Roles::Properties;
  also does GIO::Roles::Signals::Settings;

  has GSettings $!s;

  submethod BUILD (:$settings) {
    $!s = $settings;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GSettings
  { $!s }

  multi method new (GSettings $settings, :$ref = True) {
    my $o = self.bless( :$settings );
    $o.upref if $ref;
    $o;
  }

  multi method new (Str() $schema_id) {
    my $s = g_settings_new($schema_id);

    $s ?? self.bless( settings => $s ) !! Nil;
  }

  multi method new (
    Str() $schema_id,
    GSettingsBackend() $backend,
    Str() $path,
    :$full is required
  ) {
    self.new_full($schema_id, $backend, $path);
  }
  method new_full (
    Str() $schema_id,
    GSettingsBackend() $backend,
    Str() $path
  ) {
    my $s = g_settings_new_full($schema_id, $backend, $path);

    $s ?? self.bless( settings => $s ) !! Nil;
  }

  multi method new (
    Str() $schema_id,
    GSettingsBackend() $settings_backend,
    :$backend is required
  ) {
    self.new_with_backend($schema_id, $settings_backend);
  }
  method new_with_backend (Str() $schema_id, GSettingsBackend() $backend) {
    my $s = g_settings_new_with_backend($schema_id, $backend);

    $s ?? self.bless( settings => $s ) !! Nil;
  }

  multi method new (
    Str() $schema_id,
    GSettingsBackend() $backend,
    Str() $path,
    :backend_path(:$backend-path)
  ) {
    self.new_with_backend_and_path($schema_id, $backend, $path);
  }
  method new_with_backend_and_path (
    Str() $schema_id,
    GSettingsBackend() $backend,
    Str() $path
  ) {
    my $s = g_settings_new_with_backend_and_path(
      $schema_id,
      $backend,
      $path
    );

    $s ?? self.bless( settings => $s ) !! Nil;
  }

  method new_with_path (Str() $schema_id, Str() $path) {
    my $s = g_settings_new_with_path($schema_id, $path);

    $s ?? self.bless( settings => $s ) !! Nil;
  }

  # Type: GSettingsBackend
  method backend (:$raw = False) is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('backend', $gv)
        );
        return Nil unless $gv.object;

        my $rv = cast(GSettingsBackend, $gv.object);
        $rv = GIO::SettingsBackend.new($rv) unless $raw;
        $rv;
      },
      STORE => -> $,  $val is copy {
        warn "{ &?ROUTINE.name } can not be modified after creation!"
          if $DEBUG;
      }
    );
  }

  # Type: gboolean
  method delay-apply is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('delay-apply', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'delay-apply does not allow writing' if $DEBUG;
      }
    );
  }

  # Type: gboolean
  method has-unapplied is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('has-unapplied', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-unapplied does not allow writing' if $DEBUG;
      }
    );
  }

  # Type: gchar
  method path is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('path', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn "{ &?ROUTINE.name } can not be modified after creation!"
          if $DEBUG;
      }
    );
  }

  # Type: gchar
  method schema-id is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('schema-id', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn "{ &?ROUTINE.name } can not be modified after creation!"
          if $DEBUG;
      }
    );
  }

  # Type: GSettingsSchema
  method settings-schema (:$raw = False) is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('settings-schema', $gv)
        );
        return Nil unless $gv.object;

        my $rv = cast(GSettingsSchema, $gv.object);
        $rv = GIO::Settings::Schema.new($rv) unless $raw;
        $rv;
      },
      STORE => -> $, GSettingsSchema() $val is copy {
        warn "{ &?ROUTINE.name } can not be modified after creation!"
          if $DEBUG;
      }
    );
  }

  # Is originally:
  # GSettings, gpointer, gint, gpointer --> gboolean
  method change-event {
    self.connect-change-event($!s, 'change-event');
  }

  # Is originally:
  # GSettings, gchar, gpointer --> void
  method changed {
    self.connect-string($!s, 'changed');
  }

  # Is originally:
  # GSettings, guint, gpointer --> gboolean
  method writable-change-event {
    self.connect-int($!s, 'writeable-change-event');
  }

  # Is originally:
  # GSettings, gchar, gpointer --> void
  method writable-changed {
    self.connect-string($!s, 'writable-changed');
  }


  method apply {
    g_settings_apply($!s);
  }

  method bind (
    Str() $key,
    GObject() $object,
    Str() $property,
    Int() $flags
  ) {
    my GSettingsBindFlags $f = $flags;

    g_settings_bind($!s, $key, $object, $property, $f);
  }

  method bind_with_mapping (
    Str() $key,
    GObject() $object,
    Str() $property,
    Int() $flags,
    GSettingsBindGetMapping $get_mapping,
    GSettingsBindSetMapping $set_mapping,
    gpointer $user_data     = gpointer,
    GDestroyNotify $destroy = gpointer
  ) {
    my GSettingsBindFlags $f = $flags;

    g_settings_bind_with_mapping(
      $!s,
      $key,
      $object,
      $property,
      $flags,
      $get_mapping,
      $set_mapping,
      $user_data,
      $destroy
    );
  }

  method bind_writable (
    Str $key,
    GObject() $object,
    Str $property,
    Int() $inverted
  ) {
    my gboolean $i = $inverted;

    g_settings_bind_writable($!s, $key, $object, $property, $inverted);
  }

  method create_action (Str() $key) {
    g_settings_create_action($!s, $key);
  }

  method delay {
    g_settings_delay($!s);
  }

  method get_boolean (Str() $key) {
    so g_settings_get_boolean($!s, $key);
  }

  method get_child (Str() $name, :$raw = False) {
    my $s = g_settings_get_child($!s, $name);

    $s ??
      ( $raw ?? $s !! GIO::Settings.new($s) )
      !!
      Nil;
  }

  method get_default_value (Str() $key) {
    g_settings_get_default_value($!s, $key);
  }

  method get_double (Str() $key) {
    g_settings_get_double($!s, $key);
  }

  method get_enum (Str() $key) {
    g_settings_get_enum($!s, $key);
  }

  method get_flags (Str() $key) {
    g_settings_get_flags($!s, $key);
  }

  method get_has_unapplied {
    so g_settings_get_has_unapplied($!s);
  }

  method get_int (Str() $key) {
    g_settings_get_int($!s, $key);
  }

  method get_int64 (Str() $key) {
    g_settings_get_int64($!s, $key);
  }

  method get_mapped (
    Str() $key,
    GSettingsGetMapping $mapping,
    gpointer $user_data = gpointer
  ) {
    g_settings_get_mapped($!s, $key, $mapping, $user_data);
  }

  method get_string (Str() $key) {
    g_settings_get_string($!s, $key);
  }

  method get_strv (Str() $key) {
    g_settings_get_strv($!s, $key);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &g_settings_get_type, $n, $t );
  }

  method get_uint (Str() $key) {
    g_settings_get_uint($!s, $key);
  }

  method get_uint64 (Str() $key) {
    g_settings_get_uint64($!s, $key);
  }

  method get_user_value (Str() $key) {
    g_settings_get_user_value($!s, $key);
  }

  method get_value (Str() $key, :$raw = False) {
    my $v = g_settings_get_value($!s, $key);

    $v ??
      ( $raw ?? $v !! GTK::Compat::Variant.new($v) )
      !!
      Nil;
  }

  method is_writable (Str() $name) {
    so g_settings_is_writable($!s, $name);
  }

  method list_children {
    CStringArrayToArray( g_settings_list_children($!s) );
  }

  method reset (Str() $key) {
    g_settings_reset($!s, $key);
  }

  method revert {
    g_settings_revert($!s);
  }

  method set_boolean (Str() $key, Int() $value) {
    my gboolean $v = $value;

    so g_settings_set_boolean($!s, $key, $v);
  }

  method set_double (Str() $key, Num() $value) {
    my gdouble $v = $value;

    so g_settings_set_double($!s, $key, $v);
  }

  method set_enum (Str() $key, Int() $value) {
    my gint $v = $value;

    so g_settings_set_enum($!s, $key, $v);
  }

  method set_flags (Str() $key, Int() $value) {
    my gint $v = $value;

    so g_settings_set_flags($!s, $key, $v);
  }

  proto method set_strv (|)
  { * }

  multi method set_strv(
    Str() $key,
    @value
  ) {
    samewith( $key, resolve-gstrv(@value) );
  }
  multi method set_strv (
    Str()       $key,
    CArray[Str] $value
  ) {
    so g_settings_set_strv($!s, $key, $value)
  }

  method set_int (Str() $key, Int() $value) {
    my gint $v = $value;

    so g_settings_set_int($!s, $key, $v);
  }

  method set_int64 (Str() $key, Int() $value) {
    my gint64 $v = $value;

    so g_settings_set_int64($!s, $key, $v);
  }

  method set_string (Str() $key, Str() $value) {
    so g_settings_set_string($!s, $key, $value);
  }

  method set_uint (Str() $key, Int() $value) {
    my guint $v = $value;

    so g_settings_set_uint($!s, $key, $v);
  }

  method set_uint64 (Str() $key, Int() $value) {
    my guint64 $v = $value;

    so g_settings_set_uint64($!s, $key, $v);
  }

  method set_value (Str() $key, GVariant() $value) {
    so g_settings_set_value($!s, $key, $value);
  }

  method sync {
    g_settings_sync();
  }

  method unbind (
    GIO::Settings:U:
    GObject() $object,
    Str() $property
  ) {
    g_settings_unbind($object, $property);
  }

}
