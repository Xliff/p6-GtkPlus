use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GIO::Raw::FileInfo;

# BOXED!
class GIO::FileAttributeMatcher {
  has GFileAttributeMatcher $!fam is implementor;

  method BUILD (:$matcher) {
    $!fam = $matcher;
  }

  method GTK::Compat::Types::GFileAttributeMatcher
    is also<GFileAttributeMatcher>
  { $!fam }

  multi method new (GFileAttributeMatcher $matcher) {
    self.bless( :$matcher );
  }
  multi method new (Str() $attributes) {
    self.bless( matcher => g_file_attribute_matcher_new($attributes) );
  }

  method enumerate_namespace (Str() $ns) is also<enumerate-namespace> {
    so g_file_attribute_matcher_enumerate_namespace($!fam, $ns);
  }

  method enumerate_next is also<enumerate-next> {
    g_file_attribute_matcher_enumerate_next($!fam);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &g_file_attribute_matcher_get_type, $n, $t );
  }

  method matches (Str() $attribute) {
    so g_file_attribute_matcher_matches($!fam, $attribute);
  }

  method matches_only (Str() $attribute) is also<matches-only> {
    so g_file_attribute_matcher_matches_only($!fam, $attribute);
  }

  method ref is also<upref> {
    g_file_attribute_matcher_ref($!fam);
    self;
  }

  method subtract (GFileAttributeMatcher() $subtract) {
    GIO::FileAttributeMatcher.new(
      g_file_attribute_matcher_subtract($!fam, $subtract)
    );
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    g_file_attribute_matcher_to_string($!fam);
  }

  method unref is also<downref> {
    g_file_attribute_matcher_unref($!fam);
  }

}
