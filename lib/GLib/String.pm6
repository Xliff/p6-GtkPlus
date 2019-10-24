use v6.c;

use MONKEY-TYPING;

use GTK::Compat::Types;

use GLib::Raw::String;
use GLib::Raw::Bytes;

augment class GString {
  method new (Str() $init = Str) {
    g_string_new($init);
  }

  method new_len (Str() $init = Str, Int() $len = $init.chars) {
    my gssize $l = $len;

    g_string_new_len($init, $len);
  }

  method new_sized (Int() $dfl_size) {
    my gsize $d = $dfl_size;

    g_string_sized_new($d);
  }

  method append (Str() $val) {
    g_string_append(self, $val);
  }

  method append_c (Str() $c) {
    g_string_append_c(self, $c);
  }

  method append_len (Str() $val, Int() $len) {
    my gssize $l = $len;

    g_string_append_len(self, $val, $len);
  }

  method append_unichar ($unichar) {
    my guint32 $u = do given $unichar {
      when Int { $_ }
      when Str { .substr(0, 1).ord }
      default  { die 'Unexpected value given!'; }
    };

    g_string_append_unichar(self, $u);
  }

  method append_uri_escaped (
    Str() $unescaped,
    Str() $reserved_chars_allowed,
    Int() $allow_utf8
  ) {
    my gboolean $a = $allow_utf8;

    g_string_append_uri_escaped(self, $unescaped, $reserved_chars_allowed, $a);
  }

  method ascii_down {
    g_string_ascii_down(self);
  }

  method ascii_up {
    g_string_ascii_up(self);
  }

  method assign (Str() $rval) {
    g_string_assign(self, $rval);
  }

  method down {
    g_string_down(self);
  }

  method equal (GString() $v2) {
    g_string_equal(self, $v2);
  }

  method erase (Int() $pos, Int() $len) {
    my gssize ($p, $l) = ($pos, $len);

    g_string_erase(self, $p, $l);
  }

  method free (Int() $free_segment) {
    my gboolean $f = $free_segment;

    g_string_free(self, $f);
  }

  method free_to_bytes (:$raw = False) {
    my $b = g_string_free_to_bytes(self);

    $b ??
      ( $raw ?? $b !! GLib::Bytes.new($b) )
      !!
      Nil;
  }

  method hash {
    g_string_hash(self);
  }

  method insert (Int() $pos, Str() $val) {
    my gsize $p = $pos;

    g_string_insert(self, $pos, $val);
  }

  method insert_c (Int() $pos, Str() $c) {
    my gssize $p = $pos;

    g_string_insert_c(self, $p, $c);
  }

  method insert_len (Int() $pos, Str() $val, Int() $len) {
    my gssize ($p, $l) = ($pos, $len);

    g_string_insert_len(self, $p, $val, $l);
  }

  method insert_unichar (Int() $pos, Int $wc) {
    my gsize $p  = $pos;
    my guint $uc = do given $wc {
      when Int { $_ }
      when Str { .substr(0, 1).ord }
      default  { die 'Unexpected value given!'; }
    };

    g_string_insert_unichar(self, $pos, $wc);
  }

  method overwrite (Int() $pos, Str() $val) {
    my gsize $p = $pos;

    g_string_overwrite(self, $pos, $val);
  }

  method overwrite_len (Int() $pos, Str() $val, Int() $len) {
    my gsize $p = $pos;
    my gssize $l = $len;

    g_string_overwrite_len(self, $pos, $val, $len);
  }

  method prepend (Str() $val) {
    g_string_prepend(self, $val);
  }

  method prepend_c (Str() $c) {
    g_string_prepend_c(self, $c);
  }

  method prepend_len (Str() $val, Int() $len) {
    my gssize $l = $len;

    g_string_prepend_len(self, $val, $l);
  }

  multi method prepend_unichar ($wc) {
    my guint $uc = do given $wc {
      when Int { $_ }
      when Str { .substr(0, 1).ord }
      default  { die 'Unexpected value given!'; }
    };

    g_string_prepend_unichar(self, $uc);
  }

  method set_size (Int() $len) {
    my gsize $l = $len;

    g_string_set_size(self, $l);
  }

  method truncate (Int() $len) {
    my gsize $l = $len;

    g_string_truncate(self, $l);
  }

  method up {
    g_string_up(self);
  }

}
