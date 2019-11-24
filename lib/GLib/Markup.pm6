use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GLib::Raw::Markup;

class GLib::Markup {
  has GMarkupParseContext $!mp is implementor;

  submethod BUILD (:$markup-parser) {
    $!mp = $markup-parser;
  }

  method GTK::Compat::Types::GMarkupParseContext
  { $!mp }

  method new (
    GMarkupParser $parser,
    Int() $flags,
    gpointer $user_data               = gpointer,
    GDestroyNotify $user_data_dnotify = gpointer
  ) {
    my GMarkupParseFlags $f = $flags;

    my $mp = g_markup_parse_context_new(
      $parser,
      $flags,
      $user_data,
      $user_data_dnotify
    );

    $mp ?? self.bless( markup-parser => $mp ) !! Nil;
  }

  method error_quark (GLib::Markup:U: ) is also<error-quark> {
    g_markup_error_quark();
  }

  method markup_escape_text (
    GLib::Markup:U:
    Str() $text,
    Int() $length = $text.chars
  )
    is also<markup-escape-text>
  {
    my gssize $l = $length;

    g_markup_escape_text($text, $l);
  }

  method end_parse (CArray[Pointer[GError]] $error = gerror)
    is also<end-parse>
  {
    clear_error;
    my $rv = so g_markup_parse_context_end_parse($!mp, $error);
    set_error($error);
    $rv;
  }

  method free {
    g_markup_parse_context_free($!mp);
  }

  method get_element is also<get-element> {
    g_markup_parse_context_get_element($!mp);
  }

  method get_element_stack (:$glist = False) is also<get-element-stack> {
    my $sl = g_markup_parse_context_get_element_stack($!mp);

    return Nil unless $sl;
    return $sl if     $glist;

    $sl = $sl but GTK::Compat::Roles::ListData[Str];
    $sl.Array;
  }

  method get_position (Int() $line_number, Int() $char_number) is also<get-position> {
    my ($l, $c) = ($line_number, $char_number);

    g_markup_parse_context_get_position($!mp, $l, $c);
  }

  method get_user_data is also<get-user-data> {
    g_markup_parse_context_get_user_data($!mp);
  }

  method parse (
    Str() $text,
    Int() $text_len,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gssize $t = $text_len;

    clear_error;
    my $rv = so g_markup_parse_context_parse($!mp, $text, $t, $error);
    set_error($error);
    $rv;
  }

  method pop {
    g_markup_parse_context_pop($!mp);
  }

  method push (GMarkupParser() $parser, gpointer $user_data = gpointer) {
    g_markup_parse_context_push($!mp, $parser, $user_data);
  }

  method ref {
    g_markup_parse_context_ref($!mp);
    self;
  }

  method unref {
    g_markup_parse_context_unref($!mp);
  }

  # method g_markup_vprintf_escaped (va_list $args) {
  #   g_markup_vprintf_escaped($!mp, $args);
  # }

}
