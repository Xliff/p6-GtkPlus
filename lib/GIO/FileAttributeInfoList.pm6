use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::FileAttributeInfoList;

# BOXED!
class GIO::FileAttributeInfoList {
  has GFileAttributeInfoList $!fail;

  submethod BUILD (:$list) {
    $!fail = $list;
  }

  method GTK::Compat::Types::GFileAttributeInfoList
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
      ( $raw ?? $l !! GIO::FileAttributeInfo.new($l) )
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
