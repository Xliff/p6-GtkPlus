use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Raw::KeyFile;

class GTK::Compat::KeyFile  {
  has GKeyFile $!kf is implementor;

  submethod BUILD(:$file) {
    $!kf = $file;
  }

  method new {
    my $file = g_key_file_new();
    self.bless(:$file);
  }

  method GTK::Compat::Types::GKeyFile {
    $!kf;
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  #void      g_key_file_set_string_list (
  #   GKeyFile             *key_file,
  #   const Str()          *group_name,
  #   const Str()          *key,
  #   const Str() * const   list[],
  #   gsize                 length
  # );
  # void      g_key_file_set_locale_string_list (
  #   GKeyFile             *key_file,
  #   const Str()          *group_name,
  #   const Str()          *key,
  #   const Str()          *locale,
  #   const Str() * const   list[],
  #   gsize                 length
  # );
  #void      g_key_file_set_boolean_list       (
  #   GKeyFile             *key_file,
  #   const Str()          *group_name,
  #   const Str()          *key,
  #   gboolean              list[],
  #   gsize                 length
  # );
  # void      g_key_file_set_double_list        (
  #   GKeyFile             *key_file,
  #   const Str()          *group_name,
  #   const Str()          *key,
  #   gdouble               list[],
  #   gsize                 length
  # );
  # void      g_key_file_set_integer_list       (
  #   GKeyFile             *key_file,
  #   const Str()          *group_name,
  #   const Str()          *key,
  #   gint                  list[],
  #   gsize                 length
  # );


  # ↓↓↓↓ METHODS ↓↓↓↓
  method error_quark is also<error-quark> {
    g_key_file_error_quark();
  }

  method free {
    g_key_file_free($!kf);
  }

  method get_boolean (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-boolean>
  {
    g_key_file_get_boolean($!kf, $group_name, $key, $error);
  }

  method get_boolean_list (
    Str() $group_name,
    Str() $key,
    gsize $length,
    GError $error = GError
  )
    is also<get-boolean-list>
  {
    g_key_file_get_boolean_list($!kf, $group_name, $key, $length, $error);
  }

  method get_comment (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-comment>
  {
    g_key_file_get_comment($!kf, $group_name, $key, $error);
  }

  method get_double (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-double>
  {
    g_key_file_get_double($!kf, $group_name, $key, $error);
  }

  method get_double_list (
    Str() $group_name,
    Str() $key,
    gsize $length,
    GError $error = GError
  )
    is also<get-double-list>
  {
    g_key_file_get_double_list($!kf, $group_name, $key, $length, $error);
  }

  method get_groups (gsize $length) is also<get-groups> {
    g_key_file_get_groups($!kf, $length);
  }

  method get_int64 (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-int64>
  {
    g_key_file_get_int64($!kf, $group_name, $key, $error);
  }

  method get_integer (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-integer>
  {
    g_key_file_get_integer($!kf, $group_name, $key, $error);
  }

  method get_integer_list (
    Str() $group_name,
    Str() $key,
    gsize $length,
    GError $error = GError
  )
    is also<get-integer-list>
  {
    g_key_file_get_integer_list($!kf, $group_name, $key, $length, $error);
  }

  method get_keys (
    Str() $group_name,
    gsize $length,
    GError $error = GError
  )
    is also<get-keys>
  {
    g_key_file_get_keys($!kf, $group_name, $length, $error);
  }

  method get_locale_for_key (
    Str() $group_name,
    Str() $key,
    Str() $locale
  )
    is also<get-locale-for-key>
  {
    g_key_file_get_locale_for_key($!kf, $group_name, $key, $locale);
  }

  method get_locale_string (
    Str() $group_name,
    Str() $key,
    Str() $locale,
    GError $error = GError
  )
    is also<get-locale-string>
  {
    g_key_file_get_locale_string($!kf, $group_name, $key, $locale, $error);
  }

  method get_locale_string_list (
    Str() $group_name,
    Str() $key,
    Str() $locale,
    gsize $length,
    GError $error = GError
  )
    is also<get-locale-string-list>
  {
    g_key_file_get_locale_string_list(
      $!kf,
      $group_name,
      $key,
      $locale,
      $length,
      $error
    );
  }

  method get_start_group is also<get-start-group> {
    g_key_file_get_start_group($!kf);
  }

  method get_string (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-string>
  {
    g_key_file_get_string($!kf, $group_name, $key, $error);
  }

  method get_string_list (
    Str() $group_name,
    Str() $key,
    gsize $length,
    GError $error = GError
  )
    is also<get-string-list>
  {
    g_key_file_get_string_list($!kf, $group_name, $key, $length, $error);
  }

  method get_uint64 (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-uint64>
  {
    g_key_file_get_uint64($!kf, $group_name, $key, $error);
  }

  method get_value (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<get-value>
  {
    g_key_file_get_value($!kf, $group_name, $key, $error);
  }

  method has_group (Str() $group_name) is also<has-group> {
    g_key_file_has_group($!kf, $group_name);
  }

  method has_key (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<has-key>
  {
    g_key_file_has_key($!kf, $group_name, $key, $error);
  }

  method load_from_bytes (
    GBytes $bytes,
    GKeyFileFlags $flags,
    GError $error = GError
  )
    is also<load-from-bytes>
  {
    g_key_file_load_from_bytes($!kf, $bytes, $flags, $error);
  }

  method load_from_data (
    Str() $data,
    gsize $length,
    GKeyFileFlags $flags,
    GError $error = GError
  )
    is also<load-from-data>
  {
    g_key_file_load_from_data($!kf, $data, $length, $flags, $error);
  }

  method load_from_data_dirs (
    Str() $file,
    Str() $full_path,
    GKeyFileFlags $flags,
    GError $error = GError
  )
    is also<load-from-data-dirs>
  {
    g_key_file_load_from_data_dirs($!kf, $file, $full_path, $flags, $error);
  }

  method load_from_dirs (
    Str() $file,
    Str() $search_dirs,
    Str() $full_path,
    GKeyFileFlags $flags,
    GError $error = GError
  )
    is also<load-from-dirs>
  {
    g_key_file_load_from_dirs(
      $!kf,
      $file,
      $search_dirs,
      $full_path,
      $flags,
      $error
    );
  }

  method load_from_file (
    Str() $file,
    GKeyFileFlags $flags,
    GError $error = GError
  )
    is also<load-from-file>
  {
    g_key_file_load_from_file($!kf, $file, $flags, $error);
  }

  method ref is also<upref> {
    g_key_file_ref($!kf);
  }

  method remove_comment (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<remove-comment>
  {
    g_key_file_remove_comment($!kf, $group_name, $key, $error);
  }

  method remove_group (
    Str() $group_name,
    GError $error = GError
  )
    is also<remove-group>
  {
    g_key_file_remove_group($!kf, $group_name, $error);
  }

  method remove_key (
    Str() $group_name,
    Str() $key,
    GError $error = GError
  )
    is also<remove-key>
  {
    g_key_file_remove_key($!kf, $group_name, $key, $error);
  }

  method save_to_file (
    Str() $filename,
    GError $error = GError
  )
    is also<save-to-file>
  {
    g_key_file_save_to_file($!kf, $filename, $error);
  }

  method set_boolean (Str() $group_name, Str() $key, gboolean $value)
    is also<set-boolean>
  {
    g_key_file_set_boolean($!kf, $group_name, $key, $value);
  }

  method set_comment (
    Str() $group_name,
    Str() $key,
    Str() $comment,
    GError $error = GError
  )
    is also<set-comment>
  {
    g_key_file_set_comment($!kf, $group_name, $key, $comment, $error);
  }

  method set_double (Str() $group_name, Str() $key, gdouble $value)
    is also<set-double>
  {
    g_key_file_set_double($!kf, $group_name, $key, $value);
  }

  method set_int64 (Str() $group_name, Str() $key, gint64 $value)
    is also<set-int64>
  {
    g_key_file_set_int64($!kf, $group_name, $key, $value);
  }

  method set_integer (Str() $group_name, Str() $key, gint $value)
    is also<set-integer>
  {
    g_key_file_set_integer($!kf, $group_name, $key, $value);
  }

  method set_list_separator (Str() $separator)
    is also<set-list-separator>
  {
    g_key_file_set_list_separator($!kf, $separator);
  }

  method set_locale_string (
    Str() $group_name,
    Str() $key,
    Str() $locale,
    Str() $string
  )
    is also<set-locale-string>
  {
    g_key_file_set_locale_string($!kf, $group_name, $key, $locale, $string);
  }

  method set_string (Str() $group_name, Str() $key, Str() $string)
    is also<set-string>
  {
    g_key_file_set_string($!kf, $group_name, $key, $string);
  }

  method set_uint64 (Str() $group_name, Str() $key, guint64 $value)
    is also<set-uint64>
  {
    g_key_file_set_uint64($!kf, $group_name, $key, $value);
  }

  method set_value (Str() $group_name, Str() $key, Str() $value)
    is also<set-value>
  {
    g_key_file_set_value($!kf, $group_name, $key, $value);
  }

  method to_data (
    gsize $length,
    GError $error = GError
  )
    is also<to-data>
  {
    g_key_file_to_data($!kf, $length, $error);
  }

  method unref is also<downref> {
    g_key_file_unref($!kf);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
