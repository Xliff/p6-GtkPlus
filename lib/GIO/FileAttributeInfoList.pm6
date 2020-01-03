use v6.c;

use Method::Also;

use GLib::Raw::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::FileAttributeInfoList;

use GIO::FileInfo;

# BOXED!
class GIO::FileAttributeInfoList {
  has GFileAttributeInfoList $!fail is implementor;

  submethod BUILD (:$list) {
    $!fail = $list;
  }

  method GLib::Raw::Types::GFileAttributeInfoList
    is also<GFileAttributeInfoList>
  { $!fail }

  method new {
    self.bless( list => g_file_attribute_info_list_new() );
  }

  method add (Str() $name, Int() $type, Int() $flags) {
    my GFileAttributeType $t = $type;
    my GFileAttributeInfoFlags $f = $flags;

    g_file_attribute_info_list_add($!fail, $name, $t, $f);
  }

  method dup {
    ::?CLASS.new( g_file_attribute_info_list_dup($!fail) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &g_file_attribute_info_list_get_type,
      $n,
      $t
    );
  }

  method lookup (Str() $name, :$raw = False) {
    my $l = g_file_attribute_info_list_lookup($!fail, $name);

    $l ??
      ( $raw ?? $l !! GIO::FileInfo.new($l) )
      !!
      Nil;
  }

  method ref is also<upref> {
    g_file_attribute_info_list_ref($!fail);
    self;
  }

  method unref is also<downref> {
    g_file_attribute_info_list_unref($!fail);
  }

}
