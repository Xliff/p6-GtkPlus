use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Compat::FileTypes;

use GIO::Raw::FileInfo;

use GTK::Raw::Utils;

use GTK::Compat::Roles::Object;

class GIO::FileInfo {
  also does GTK::Compat::Roles::Object;

  has GFileInfo $!fi;

  submethod BUILD (:$info) {
    $!fi = $info;

    self.roleInit-Object;
  }

  method GTK::Compat::Types::GFileInfo
    is also<GFileInfo>
  { $!fi }

  method new {
    self.bless( info => g_file_info_new() );
  }

  method content_type is rw is also<content-type> {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_content_type($!fi);
      },
      STORE => sub ($, Str() $content_type is copy) {
        g_file_info_set_content_type($!fi, $content_type);
      }
    );
  }

  method display_name is rw is also<display-name> {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_display_name($!fi);
      },
      STORE => sub ($, Str() $display_name is copy) {
        g_file_info_set_display_name($!fi, $display_name);
      }
    );
  }

  method edit_name is rw is also<edit-name> {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_edit_name($!fi);
      },
      STORE => sub ($, Str() $edit_name is copy) {
        g_file_info_set_edit_name($!fi, $edit_name);
      }
    );
  }

  method file_type is rw is also<file-type> {
    Proxy.new(
      FETCH => sub ($) {
        GFileTypeEnum( g_file_info_get_file_type($!fi) );
      },
      STORE => sub ($, Int() $type is copy) {
        my GFileType $t = $type;

        g_file_info_set_file_type($!fi, $t);
      }
    );
  }

  method icon is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Icon.new( g_file_info_get_icon($!fi) );
      },
      STORE => sub ($, GIcon() $icon is copy) {
        g_file_info_set_icon($!fi, $icon);
      }
    );
  }

  method is_hidden is rw is also<is-hidden> {
    Proxy.new(
      FETCH => sub ($) {
        so g_file_info_get_is_hidden($!fi);
      },
      STORE => sub ($, Int() $is_hidden is copy) {
        my gboolean $ih = $is_hidden;

        g_file_info_set_is_hidden($!fi, $ih);
      }
    );
  }

  method is_symlink is rw is also<is-symlink> {
    Proxy.new(
      FETCH => sub ($) {
        so g_file_info_get_is_symlink($!fi);
      },
      STORE => sub ($, Int() $is_symlink is copy) {
        my gboolean $is = $is_symlink;

        g_file_info_set_is_symlink($!fi, $is);
      }
    );
  }

  method name is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_name($!fi);
      },
      STORE => sub ($, Str() $name is copy) {
        g_file_info_set_name($!fi, $name);
      }
    );
  }

  method size is rw {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_size($!fi);
      },
      STORE => sub ($, Int() $size is copy) {
        my goffset $s = $size;

        g_file_info_set_size($!fi, $s);
      }
    );
  }

  method sort_order is rw is also<sort-order> {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_sort_order($!fi);
      },
      STORE => sub ($, Int() $sort_order is copy) {
        my gint32 $so = $sort_order;

        g_file_info_set_sort_order($!fi, $so);
      }
    );
  }

  method symbolic_icon is rw is also<symbolic-icon> {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Icon.new( g_file_info_get_symbolic_icon($!fi) );
      },
      STORE => sub ($, GIcon() $icon is copy) {
        g_file_info_set_symbolic_icon($!fi, $icon);
      }
    );
  }

  method symlink_target is rw is also<symlink-target> {
    Proxy.new(
      FETCH => sub ($) {
        g_file_info_get_symlink_target($!fi);
      },
      STORE => sub ($, Str() $symlink_target is copy) {
        g_file_info_set_symlink_target($!fi, $symlink_target);
      }
    );
  }

  method clear_status is also<clear-status> {
    g_file_info_clear_status($!fi);
  }

  method copy_into (GFileInfo() $dest_info) is also<copy-into> {
    g_file_info_copy_into($!fi, $dest_info);
  }

  method dup (:$raw = False) {
    my $d = g_file_info_dup($!fi);

    $raw ?? $d !! GIO::FileInfo.new($d);
  }

  method get_attribute_as_string (Str() $attribute)
    is also<get-attribute-as-string>
  {
    g_file_info_get_attribute_as_string($!fi, $attribute);
  }

  method get_attribute_boolean (Str() $attribute)
    is also<get-attribute-boolean>
  {
    so g_file_info_get_attribute_boolean($!fi, $attribute);
  }

  method get_attribute_byte_string (Str() $attribute)
    is also<get-attribute-byte-string>
  {
    g_file_info_get_attribute_byte_string($!fi, $attribute);
  }

  proto method get_attribute_data (|)
      is also<get-attribute-data>
  { * }

  multi method get_attribute_data (Str() $attribute) {
    samewith($attribute, $, $, $);
  }
  multi method get_attribute_data (
    Str() $attribute,
    $type     is rw,
    $value_pp is rw,
    $status   is rw
  ) {
    my GFileAttributeType $t = $type;
    my GFileAttributeStatus $s = $status;
    my gpointer $p = gpointer.new;

    my $rv = so g_file_info_get_attribute_data($!fi, $attribute, $t, $p, $s);
    ($type, $value_pp, $status) = ($t, $p, $s);
    $rv ??
      ($rv, $type, $value_pp, $status)
      !!
      False;
  }

  method get_attribute_int32 (Str() $attribute) is also<get-attribute-int32> {
    g_file_info_get_attribute_int32($!fi, $attribute);
  }

  method get_attribute_int64 (Str() $attribute) is also<get-attribute-int64> {
    g_file_info_get_attribute_int64($!fi, $attribute);
  }

  method get_attribute_object (Str() $attribute, :$raw = False)
    is also<get-attribute-object>
  {
    my $o = g_file_info_get_attribute_object($!fi, $attribute);

    $o ??
      # Yet another name for a common option...
      ( $raw ?? $o !! GTK::Compat::Roles::Object.new-object-obj($o) )
      !!
      Nil;
  }

  method get_attribute_status (Str() $attribute)
    is also<get-attribute-status>
  {
    GFileAttributeStatusEnum(
      g_file_info_get_attribute_status($!fi, $attribute)
    );
  }

  method get_attribute_string (Str() $attribute)
    is also<get-attribute-string>
  {
    g_file_info_get_attribute_string($!fi, $attribute);
  }

  method get_attribute_stringv (Str() $attribute)
    is also<get-attribute-stringv>
  {
    CStringArrayToArray( g_file_info_get_attribute_stringv($!fi, $attribute) );
  }

  method get_attribute_type (Str() $attribute) is also<get-attribute-type> {
    g_file_info_get_attribute_type($!fi, $attribute);
  }

  method get_attribute_uint32 (Str() $attribute)
    is also<get-attribute-uint32>
  {
    g_file_info_get_attribute_uint32($!fi, $attribute);
  }

  method get_attribute_uint64 (Str() $attribute)
    is also<get-attribute-uint64>
  {
    g_file_info_get_attribute_uint64($!fi, $attribute);
  }

  method get_deletion_date ($raw = False) is also<get-deletion-date> {
    my $dt = g_file_info_get_deletion_date($!fi);

    $dt ??
      ( $raw ?? $dt !! GTK::Compat::DateTime.new($dt) )
      !!
      Nil;
  }

  method get_etag is also<get-etag> {
    g_file_info_get_etag($!fi);
  }

  method get_is_backup is also<get-is-backup> {
    so g_file_info_get_is_backup($!fi);
  }

  proto method get_modification_time (|)
      is also<get-modification-time>
  { * }

  multi method get_modification_time {
    samewith($);
  }
  multi method get_modification_time ($result is rw) {
    my $r = GTimeVal.new;
    g_file_info_get_modification_time($!fi, $r);
    $result = $r;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_file_info_get_type, $n, $t );
  }

  method has_attribute (Str() $attribute) is also<has-attribute> {
    so g_file_info_has_attribute($!fi, $attribute);
  }

  method has_namespace (Str() $name_space) is also<has-namespace> {
    so g_file_info_has_namespace($!fi, $name_space);
  }

  method list_attributes (Str() $name_space) is also<list-attributes> {
    CStringArrayToArray( g_file_info_list_attributes($!fi, $name_space) );
  }

  method remove_attribute (Str() $attribute) is also<remove-attribute> {
    g_file_info_remove_attribute($!fi, $attribute);
  }

  method set_attribute (
    Str() $attribute,
    Int() $type,
    gpointer $value_p
  )
    is also<set-attribute>
  {
    my GFileAttributeType $t = $type;

    g_file_info_set_attribute($!fi, $attribute, $t, $value_p);
  }

  method set_attribute_boolean (Str() $attribute, Int() $attr_value)
    is also<set-attribute-boolean>
  {
    my gboolean $av = $attr_value;

    g_file_info_set_attribute_boolean($!fi, $attribute, $av);
  }

  method set_attribute_byte_string (Str() $attribute, Str() $attr_value)
    is also<set-attribute-byte-string>
  {
    g_file_info_set_attribute_byte_string($!fi, $attribute, $attr_value);
  }

  method set_attribute_int32 (Str() $attribute, Int() $attr_value)
    is also<set-attribute-int32>
  {
    my gint32 $av = $attr_value;

    g_file_info_set_attribute_int32($!fi, $attribute, $av);
  }

  method set_attribute_int64 (Str() $attribute, Int() $attr_value)
    is also<set-attribute-int64>
  {
    my gint64 $av = $attr_value;

    g_file_info_set_attribute_int64($!fi, $attribute, $av);
  }

  method set_attribute_mask (GFileAttributeMatcher() $mask)
    is also<set-attribute-mask>
  {
    g_file_info_set_attribute_mask($!fi, $mask);
  }

  method set_attribute_object (Str() $attribute, GObject() $attr_value)
    is also<set-attribute-object>
  {
    g_file_info_set_attribute_object($!fi, $attribute, $attr_value);
  }

  method set_attribute_status (Str() $attribute, Int() $status)
    is also<set-attribute-status>
  {
    my GFileAttributeStatus $s = $status;

    g_file_info_set_attribute_status($!fi, $attribute, $s);
  }

  method set_attribute_string (Str() $attribute, Str() $attr_value)
    is also<set-attribute-string>
  {
    g_file_info_set_attribute_string($!fi, $attribute, $attr_value);
  }

  proto method set_attribute_stringv (|)
      is also<set-attribute-stringv>
  { * }

  multi method set_attribute_stringv (Str() $attribute, *@attr_value) {
    samewith($attribute, @attr_value);
  }
  multi method set_attribute_stringv (Str() $attribute, @attr_value) {
    my $sa = resolve-gstrv(@attr_value);

    samewith($attribute, $sa);
  }
  multi method set_attribute_stringv (Str() $attribute, GStrv $attr_value) {
    g_file_info_set_attribute_stringv($!fi, $attribute, $attr_value);
  }

  method set_attribute_uint32 (Str() $attribute, Int() $attr_value)
    is also<set-attribute-uint32>
  {
    my guint $av = $attr_value;

    g_file_info_set_attribute_uint32($!fi, $attribute, $av);
  }

  method set_attribute_uint64 (Str() $attribute, Int() $attr_value)
    is also<set-attribute-uint64>
  {
    my guint64 $av = $attr_value;

    g_file_info_set_attribute_uint64($!fi, $attribute, $av);
  }

  method set_modification_time (GTimeVal $mtime)
    is also<set-modification-time>
  {
    g_file_info_set_modification_time($!fi, $mtime);
  }

  method unset_attribute_mask is also<unset-attribute-mask> {
    g_file_info_unset_attribute_mask($!fi);
  }

}
