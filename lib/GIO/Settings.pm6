use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GIO::Raw::Settings;

use GTK::Roles::Properties;

class GIO::Settings {
  also does GTK::Roles::Properties;

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
    self.new_full($schema, $backend, $path);
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
    GSettingsBackend() $backend,
    :$backend is required
  ) {
    self.new_with_backend($schema_id, $backend);
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
    g_settings_get_boolean($!s, $key);
  }

  method get_child (Str() $name) {
    g_settings_get_child($!s, $name);
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
    g_settings_get_has_unapplied($!s);
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
    g_settings_get_type();
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

  method get_value (Str() $key) {
    g_settings_get_value($!s, $key);
  }

  method is_writable (Str() $name) {
    g_settings_is_writable($!s, $name);
  }

  method list_children {
    g_settings_list_children($!s);
  }

  method reset (Str() $key) {
    g_settings_reset($!s, $key);
  }

  method revert {
    g_settings_revert($!s);
  }

  method set_boolean (Str() $key, gboolean $value) {
    g_settings_set_boolean($!s, $key, $value);
  }

  method set_double (Str() $key, gdouble $value) {
    g_settings_set_double($!s, $key, $value);
  }

  method set_enum (Str() $key, gint $value) {
    g_settings_set_enum($!s, $key, $value);
  }

  method set_flags (Str() $key, guint $value) {
    g_settings_set_flags($!s, $key, $value);
  }

  proto method set_gstrv (|)
  { * }

  multi method set_gstrv(
    Str() $key,
    @value
  ) {
    samewith( $key, resolve-gstrv(@value) );
  }
  multi method set_gstrv (
    Str()       $key,
    CArray[Str] $value
  ) {
    g_settings_set_gstrv($!s, $key, $value)
  }

  method set_int (Str() $key, gint $value) {
    g_settings_set_int($!s, $key, $value);
  }

  method set_int64 (Str() $key, gint64 $value) {
    g_settings_set_int64($!s, $key, $value);
  }

  method set_string (Str() $key, Str $value) {
    g_settings_set_string($!s, $key, $value);
  }

  method set_uint (Str() $key, guint $value) {
    g_settings_set_uint($!s, $key, $value);
  }

  method set_uint64 (Str() $key, guint64 $value) {
    g_settings_set_uint64($!s, $key, $value);
  }

  method set_value (Str() $key, GVariant() $value) {
    g_settings_set_value($!s, $key, $value);
  }

  method sync {
    g_settings_sync($!s);
  }

  method unbind (Str() $property) {
    g_settings_unbind($!s, $property);
  }

}
