use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Compat::Raw::Settings;

use GTK::Compat::Roles::Object;
use GTK::Compat::Roles::Signals::Settings;

class GTK::Compat::Settings {
  also does GTK::Compat::Roles::Object;
  also does GTK::Compat::Roles::Signals::Settings;
  
  has GSettings $!s;
  
  submethod BUILD (:$settings) {
    self!setObject($!s = $settings);
  }
  
  method GTK::Compat::Types::GSettings 
    #is also<settings> 
    { $!s }
  
  # cw: Consider making new multi's for all new_ alternatives across the 
  #     project. It's a lot of work, but fits with the OO approach.
  multi method new (
    GSettingsSchema $schema, 
    GSettingsBackend $backend, 
    Str() $path
  ) {
    self.new_full($schema, $backend, $path);
  }
  multi method new (GSettingsBackend $backend, Str $path) {
    self.new_with_backend_and_path($backend, $path);
  }
  multi method new (GSettingsBackend $backend) {
    self.new_with_backend($backend);
  }
  multi method new (Str $schema_id) {
    self.bless( settings => g_settings_new($schema_id) );
  }
  multi new(:$path, :$schema) {
    with ($path, $schema).all {
      die qq:to/DIE/.chomp 
        Please do not specify both \$path and \$schema when calling{
        } GTK::Compat::Settings.new()
        DIE
    }
    do {  
      when $schema.defined { GTK::Compat::Settings.new($schema) }
      when $path.defined   { GTK::Compat::Settings.new_with_path($path) }
    }
  }
      
  method new_full (
    GSettingsSchema() $schema, 
    GSettingsBackend() $backend, 
    Str() $path
  ) {
    g_settings_new_full($schema, $backend, $path);
  }

  method new_with_backend (GSettingsBackend() $backend) {
    g_settings_new_with_backend($backend);
  }

  method new_with_backend_and_path (
    GSettingsBackend() $backend, 
    Str() $path
  ) {
    g_settings_new_with_backend_and_path($backend, $path);
  }

  method new_with_path (Str() $path) {
    g_settings_new_with_path($path);
  }
  
  # Is originally:
  # GSettings, gpointer, gint, gpointer --> gboolean
  method change-event {
    self.connect-change-event($!s);
  }

  # Is originally:
  # GSettings, gchar, gpointer --> void
  method changed {
    self.connect-string($!s, 'changed');
  }

  # Is originally:
  # GSettings, guint, gpointer --> gboolean
  method writable-change-event {
    self.connect-uint-rbool($!s);
  }

  # Is originally:
  # GSettings, gchar, gpointer --> void
  method writable-changed {
    self.connect-string($!s);
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
    my guint $f = resolve-uint($flags);
    g_settings_bind($!s, $key, $object, $property, $f);
  }

  method bind_with_mapping (
    Str() $key, 
    GObject() $object, 
    Str() $property, 
    Int() $flags, 
    GSettingsBindGetMapping $get_mapping = Pointer, 
    GSettingsBindSetMapping $set_mapping = Pointer, 
    gpointer $user_data                  = Pointer, 
    GDestroyNotify $destroy              = Pointer
  ) {
    my guint $f = resolve-uint($flags);
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
    Str() $key, 
    GObject() $object, 
    Str() $property, 
    Int() $inverted
  ) {
    my gboolean $i = resolve-bool($inverted);
    g_settings_bind_writable($!s, $key, $object, $property, $i);
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
    gpointer $user_data
  ) {
    g_settings_get_mapped($!s, $key, $mapping, $user_data);
  }
  
  method get_range (Str() $key) {
    g_settings_get_range($key);
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

  method set_int (Str() $key, gint $value) {
    g_settings_set_int($!s, $key, $value);
  }

  method set_int64 (Str() $key, gint64 $value) {
    g_settings_set_int64($!s, $key, $value);
  }
  
  multi method set_strv (Str $key, @value) {
    die '@value must be an array of Str objects!' unless @value.all ~~ Str;
    my CArray[Str] $v = resolve-gstrv(@value);
    samewith($key, $v);
  }
  multi method set_strv (Str $key, CArray[Str] $value) {
    g_settings_set_strv($!, $key, $value);
  }

  method set_string (Str() $key, Str() $value) {
    g_settings_set_string($!s, $key, $value);
  }

  method set_uint (Str() $key, guint $value) {
    g_settings_set_uint($!s, $key, $value);
  }

  method set_uint64 (Str() $key, guint64 $value) {
    g_settings_set_uint64($!s, $key, $value);
  }

  method set_value (Str() $key, GVariant $value) {
    g_settings_set_value($!s, $key, $value);
  }

  method sync {
    g_settings_sync();
  }

  method unbind ($object, Str() $property) {
    die '$object parameter must be a CPointer or CStruct REPR!'
      unless $object.REPR eq <CString CPointer>.any;
      
    g_settings_unbind( 
      nativecast(Pointer, $object), 
      $property 
    );
  }

}
