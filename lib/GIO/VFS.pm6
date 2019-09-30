use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::VFS;

use GTK::Compat::Roles::Object;

class GIO::VFS {
  also does GTK::Compat::Roles::Object;

  has GVfs $!fs;

  submethod BUILD (:$vfs) {
    $!fs = $vfs;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GVfs
    is also<GVfs>
  { $!fs }

  method new (GVfs $vfs) {
    self.bless(:$vfs);
  }

  method get_default is also<get-default> {
    self.bless( vfs => g_vfs_get_default() );
  }

  method get_local is also<get-local> {
    self.bless( vgs => g_vfs_get_local() );
  }

  method get_file_for_path (Str() $path, :$raw = False)
    is also<get-file-for-path>
  {
    my $f = g_vfs_get_file_for_path($!fs, $path);

    $f ??
      ( $raw ?? $f !! GTK::Compat::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method get_file_for_uri (Str() $uri, :$raw = False)
    is also<get-file-for-uri>
  {
    my $f = g_vfs_get_file_for_uri($!fs, $uri);

    $f ??
      ( $raw ?? $f !! GTK::Compat::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method get_supported_uri_schemes
    is also<
      get-supported-uri-schemes
      supported_uri_schemes
      supported-uri-schemes
    >
  {
    CStringArrayToArray( g_vfs_get_supported_uri_schemes($!fs) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_vfs_get_type, $n, $t );
  }

  method is_active is also<is-active> {
    so g_vfs_is_active($!fs);
  }

  method parse_name (Str() $parse_name, :$raw = False) is also<parse-name> {
    my $f = g_vfs_parse_name($!fs, $parse_name);

    $f ??
      ( $raw ?? $f !! GTK::Compat::Roles::GFile.new-file-obj($f) )
      !!
      Nil;
  }

  method register_uri_scheme (
    Str() $scheme,
    GVfsFileLookupFunc $uri_func,
    gpointer $uri_data,
    GDestroyNotify $uri_destroy,
    GVfsFileLookupFunc $parse_name_func,
    gpointer $parse_name_data,
    GDestroyNotify $parse_name_destroy
  )
    is also<register-uri-scheme>
  {
    so g_vfs_register_uri_scheme(
      $!fs,
      $scheme,
      $uri_func,
      $uri_data,
      $uri_destroy,
      $parse_name_func,
      $parse_name_data,
      $parse_name_destroy
    );
  }

  method unregister_uri_scheme (Str() $scheme) is also<unregister-uri-scheme> {
    so g_vfs_unregister_uri_scheme($!fs, $scheme);
  }

}
