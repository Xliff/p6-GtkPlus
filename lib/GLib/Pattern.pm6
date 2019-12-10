use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::Raw::Pattern;

class GLib::Pattern {
  has GPatternSpec $!p;

  submethod BUILD (:$pattern) {
    $!p = $pattern;
  }

  method GTK::Compat::Types::GPatternSpec
    is also<GPatternSpec>
  { $!p }

  method new (Str() $p) {
    my $pattern = g_pattern_spec_new($p);

    $pattern ?? self.bless( :$pattern ) !! Nil;
  }

  multi method equal (
    GLib::Pattern:D:
    GPatternSpec() $pspec2
  ) {
    GLib::Pattern.equal($!p, $pspec2);
  }
  multi method equal (
    GPatternSpec() $pspec1,
    GPatternSpec() $pspec2
  ) {
    g_pattern_spec_equal($pspec1, $pspec2);
  }

  method free {
    g_pattern_spec_free($!p);
  }

  multi method match (
    Str() $string,
    Str() $string_reversed = Str
  ) {
    samewith($string.encode.elems, $string, $string_reversed);
  }
  multi method match (
    Int() $string_length,
    Str() $string,
    Str() $string_reversed = Str
  ) {
    my guint $s = $string_length;

    so g_pattern_match($!p, $string_length, $string, $string_reversed);
  }

  method match_simple (
    GLib::Pattern:U:
    Str() $pattern,
    Str() $string
  )
    is also<match-simple>
  {
    so g_pattern_match_simple($pattern, $string);
  }

  method match_string (Str() $string) is also<match-string> {
    so g_pattern_match_string($!p, $string);
  }

}
