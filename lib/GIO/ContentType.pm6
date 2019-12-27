use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GIO::Raw::ContentType;

use GLib::Roles::ListData;

# STATIC CATCH-ALL
class GIO::ContentType {

  method can_be_executable (Str() $type) is also<can-be-executable> {
    so g_content_type_can_be_executable($type);
  }

  method equals (Str() $type1, Str() $type2) {
    so g_content_type_equals($type1, $type2);
  }

  method from_mime_type (Str() $mime_type) is also<from-mime-type> {
    g_content_type_from_mime_type($mime_type);
  }

  method get_registered (:$glist = False)
    is also<
      get-registered
      registered
    >
  {
    my $list = g_content_types_get_registered();

    return Nil   unless $list;
    return $list if     $glist;

    (
      GLib::GList.new($list) but GLib::Roles::ListData[Str]
    ).Array
  }

  method get_description (Str() $type) is also<get-description> {
    g_content_type_get_description($type);
  }

  method get_generic_icon_name (Str() $type) is also<get-generic-icon-name> {
    g_content_type_get_generic_icon_name($type);
  }

  method get_icon (Str() $type) is also<get-icon> {
    g_content_type_get_icon($type);
  }

  method get_mime_type (Str() $type) is also<get-mime-type> {
    g_content_type_get_mime_type($type);
  }

  method get_symbolic_icon (Str() $type) is also<get-symbolic-icon> {
    g_content_type_get_symbolic_icon($type);
  }

  method guess (
    Str() $filename,
    Str() $data,
    Int() $data_size,
    $result_uncertain is rw
  ) {
    my gulong $ds = $data_size;
    my guint $ru = 0;
    my $rc = g_content_type_guess($filename, $data, $ds, $ru);

    $result_uncertain = $ru.defined ?? $ru !! Nil;
    # GLib::Memory.free($rc);
    $rc;
  }

  method guess_for_tree (GFile() $root) is also<guess-for-tree> {
    my CArray[Str] $guesses = g_content_type_guess_for_tree($root);
    my ($gc, @guess_list) = (0);

    @guess_list.push( $guesses[$gc++] ) while $guesses[$gc].defined;
    @guess_list;
  }

  method is_a (Str() $type, Str() $supertype) is also<is-a> {
    so g_content_type_is_a($type, $supertype);
  }

  method is_mime_type (Str() $type, Str() $mime_type) is also<is-mime-type> {
    so g_content_type_is_mime_type($type, $mime_type);
  }

  method is_unknown (Str() $type) is also<is-unknown> {
    so g_content_type_is_unknown($type);
  }

}
