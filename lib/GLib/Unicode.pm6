use v6.c;

use Method::Also;

use NativeCall;

use GTK::Compat::Types;
use GLib::Raw::Unicode;

class GLib::Unicode {

  method new (|) {
    warn 'GLib::Unicode is a static class and does not need instantiation'
      if $DEBUG;

    GLib::Unicode;
  }

  method break_type (Int() $char) is also<break-type> {
    my gunichar $c = $char;

    g_unichar_break_type($c);
  }

  method combining_class (Int() $uc) is also<combining-class> {
    my gunichar $c = $uc;

    g_unichar_combining_class($c);
  }

  multi method compose (Int() $achar, Int() $bchar, :$all = False) {
    samewith($achar, $bchar, $, :$all);
  }
  multi method compose (
    Int() $achar,
    Int() $bchar,
    $cchar is rw,
    :$all = False
  ) {
    my gunichar ($a, $b, $c) = ($achar, $bchar, 0);

    my $rc = g_unichar_compose($a, $b, $c);
    $cchar = $c;
    $all.not ?? $rc !! ($rc, $cchar);
  }

  multi method decompose (Int() $cchar, :$all = False) {
    samewith($cchar, $, $, :$all);
  }
  multi method decompose (
    Int() $cchar,
    $achar is rw,
    $bchar is rw,
    :$all = False
  ) {
    my gunichar ($a, $b, $c) = (0, 0, $cchar);

    my $rc = g_unichar_decompose($c, $a, $b);
    ($achar, $bchar) = ($a, $b);
    $all.not ?? ($achar, $bchar, $rc) !! $rc;
  }

  method digit_value (Int() $char) is also<digit-value> {
    my gunichar $c = $char;

    g_unichar_digit_value($c);
  }

  # cw: Not sure of the best way to multi this...
  method fully_decompose (
    Int() $char,
    Int() $compat,
    $result is rw,
    Int() $result_len
  )
    is also<fully-decompose>
  {
    my gunichar $c = $char;
    my gboolean $com = $compat;
    my gsize $rl = $result_len;
    my gunichar $r = 0;

    g_unichar_fully_decompose($c, $com, $r, $rl);
    $result = $r;
  }

  proto method ucs4_to_utf16
    is also<ucs4-to-utf16>
  { * }

  multi method ucs4_to_utf16 (Str() $str, :$all = False) {
    samewith($str, -1, $, $, $, :$all);
  }
  multi method ucs4_to_utf16 (
    Str() $str,
    Int() $len,
    :$all = False
  ) {
    samewith($str, $len, $, $, $, :$all);
  }
  multi method ucs4_to_utf16 (
    Str() $str,
    Int() $len,
    $items_read    is rw,
    $items_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my glong ($ir, $iw) = 0 xx 2;
    my glong $l = $len;

    clear_error;
    my $rc = g_ucs4_to_utf16($str, $l, $ir, $iw, $error);
    set_error($error);
    ($items_read, $items_written) = ($ir, $iw);
    $all.not ?? $rc !! ($rc, $items_read, $items_written, $error);
  }

  proto method ucs4_to_utf8 (|)
    is also<ucs4-to-utf8>
  { * }

  multi method ucs4_to_utf8 (Str() $str, :$all = False) {
    samewith($str, -1, $, $, $, :$all);
  }
  multi method ucs4_to_utf8 (
    Str() $str,
    Int() $len,
    :$all = False
  ) {
    samewith($str, $len, $, $, $, :$all);
  }
  multi method ucs4_to_utf8 (
    Str() $str,
    Int() $len,
    $items_read    is rw,
    $items_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my glong ($ir, $iw) = 0 xx 2;
    my glong $l = $len;

    clear_error;
    my $rc = g_ucs4_to_utf8($str, $l, $ir, $iw, $error);
    set_error($error);
    ($items_read, $items_written) = ($ir, $iw);
    $all.not ?? $rc !! ($rc, $items_read, $items_written, $error);
  }

  # method unicode_canonical_decomposition (gunichar $ch, gsize $result_len)
  #   is also<unicode-canonical-decomposition>
  # {
  #   g_unicode_canonical_decomposition($ch, $result_len);
  # }

  method unicode_canonical_ordering (Str() $string, Int() $len = -1)
    is also<unicode-canonical-ordering>
  {
    my gsize $l = $len;

    g_unicode_canonical_ordering($string, $l);
  }

  method unicode_script_from_iso15924 (Int() $iso15924)
    is also<unicode-script-from-iso15924>
  {
    my guint $i = $iso15924;

    GUnicodeScriptEnum( g_unicode_script_from_iso15924($i) );
  }

  method unicode_script_to_iso15924 (Int() $script)
    is also<unicode-script-to-iso15924>
  {
    my GUnicodeScript $s = $script;

    g_unicode_script_to_iso15924($s);
  }

  proto method utf16_to_ucs4 (|)
    is also<utf16-to-ucs4>
  { * }

  multi method utf16_to_ucs4 (Str() $str, :$all = False) {
    samewith($str, -1, $, $, $, :$all);
  }
  multi method utf16_to_ucs4 (
    Str() $str,
    Int() $len,
    :$all = False
  ) {
    samewith($str, $len, $, $, $, :$all);
  }
  multi method utf16_to_ucs4 (
    Str() $str,
    Int() $len,
    $items_read    is rw,
    $items_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my glong ($l, $ir, $iw) = ($len, 0, 0);

    clear_error;
    my $rc = g_utf16_to_ucs4($str, $l, $ir, $iw, $error);
    set_error($error);
    ($items_read, $items_written) = ($ir, $iw);
    $all.not ?? $rc !! ($rc, $items_read, $items_written, $error);
  }

  proto method utf16_to_utf8 (|)
    is also<utf16-to-utf8>
  { * }

  multi method utf16_to_utf8 (Str() $str, :$all = False) {
    samewith($str, -1, $, $, $, :$all);
  }
  multi method utf16_to_utf8 (
    Str() $str,
    Int() $len,
    :$all = False
  ) {
    samewith($str, $len, $, $, $, :$all);
  }
  multi method utf16_to_utf8 (
    Str() $str,
    Int() $len,
    $items_read    is rw,
    $items_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my glong ($l, $ir, $iw) = ($len, 0, 0);

    clear_error;
    my $rc = g_utf16_to_utf8($str, $len, $items_read, $items_written, $error);
    set_error($error);
    ($items_read, $items_written) = ($ir, $iw);
    $all.not ?? $rc !! ($rc, $items_read, $items_written, $error);
  }

  method utf8_casefold (Str() $str, Int() $len = -1) is also<utf8-casefold> {
    my gssize $l = $len;

    g_utf8_casefold($str, $l);
  }

  method utf8_collate (Str() $str1, Str() $str2) is also<utf8-collate> {
    g_utf8_collate($str1, $str2);
  }

  method utf8_collate_key (Str() $str, Int() $len = -1)
    is also<utf8-collate-key>
  {
    my gssize $l = $len;

    g_utf8_collate_key($str, $l);
  }

  method utf8_collate_key_for_filename (Str() $str, Int() $len = -1)
    is also<utf8-collate-key-for-filename>
  {
    my gssize $l = $len;

    g_utf8_collate_key_for_filename($str, $l);
  }

  method utf8_find_next_char (Str() $p, Str() $end)
    is also<utf8-find-next-char>
  {
    g_utf8_find_next_char($p, $end);
  }

  method utf8_find_prev_char (Str() $str, Str() $p)
    is also<utf8-find-prev-char>
  {
    g_utf8_find_prev_char($str, $p);
  }

  method utf8_get_char (Str() $p) is also<utf8-get-char> {
    g_utf8_get_char($p);
  }

  method utf8_get_char_validated (Str() $p, Int() $max_len = -1)
    is also<utf8-get-char-validated>
  {
    my gssize $ml = $max_len;

    g_utf8_get_char_validated($p, $ml);
  }

  method utf8_make_valid (Str() $str, Int() $len = -1) is also<utf8-make-valid> {
    my gssize $l = $len;

    g_utf8_make_valid($str, $l);
  }

  method utf8_normalize (Str() $str, Int() $len, Int() $mode)
    is also<utf8-normalize>
  {
    my gssize $l = $len;
    my GNormalizeMode $m = $mode;

    g_utf8_normalize($str, $l, $m);
  }

  method utf8_offset_to_pointer (Str() $str, Int() $offset)
    is also<utf8-offset-to-pointer>
  {
    my glong $o = $offset;

    g_utf8_offset_to_pointer($str, $o);
  }

  method utf8_pointer_to_offset (Str() $str, Str() $pos)
    is also<utf8-pointer-to-offset>
  {
    g_utf8_pointer_to_offset($str, $pos);
  }

  method utf8_prev_char (Str() $p) is also<utf8-prev-char> {
    g_utf8_prev_char($p);
  }

  method utf8_strchr (Str() $p, Int() $len, Int() $c) is also<utf8-strchr> {
    my gssize $l = $len;
    my gunichar $cc = $c;

    g_utf8_strchr($p, $l, $cc);
  }

  method utf8_strdown (Str() $str, Int() $len = -1) is also<utf8-strdown> {
    my gssize $l = $len;

    g_utf8_strdown($str, $l);
  }

  method utf8_strlen (Str() $p, Int() $max = -1) is also<utf8-strlen> {
    my gssize $m = $max;

    g_utf8_strlen($p, $m);
  }

  method utf8_strncpy (Str() $dest, Str() $src, Int() $n)
    is also<utf8-strncpy>
  {
    my gsize $nn = $n;

    g_utf8_strncpy($dest, $src, $nn);
  }

  proto method utf8_strrchr (|)
    is also<utf8-strrchr>
  { * }

  multi method utf8_strrchr(Str() $p, Int() $c) {
    samewith($p, -1, $c);
  }
  multi method utf8_strrchr (Str() $p, Int() $len, Int() $c) {
    my gssize $l = $len;

    g_utf8_strrchr($p, $l, $c);
  }

  method utf8_strreverse (Str() $str, Int() $len = -1) is also<utf8-strreverse> {
    my gssize $l = $len;

    g_utf8_strreverse($str, $l);
  }

  method utf8_strup (Str() $str, Int() $len = -1) is also<utf8-strup> {
    my gssize $l = $len;

    g_utf8_strup($str, $l);
  }

  method utf8_substring (
    Str() $str,
    Int() $start_pos,
    Int() $end_pos
  )
    is also<utf8-substring>
  {
    my glong ($sp, $ep) = ($start_pos, $end_pos);

    g_utf8_substring($str, $sp, $ep);
  }

  method utf8_to_ucs4 (
    Str() $str,
    Int() $len,
    $items_read    is rw,
    $items_written is rw,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<utf8-to-ucs4>
  {
    my glong ($l, $ir, $iw) = ($len, 0, 0);

    clear_error;
    my $rc = g_utf8_to_ucs4($str, $l, $ir, $iw, $error);
    set_error($error);
    ($items_read, $items_written) = ($ir, $iw);
    $rc;
  }

  proto method utf8_to_ucs4_fast (|)
    is also<utf8-to-ucs4-fast>
  { * }

  multi method utf8to_ucs4_fast (Str() $str, :$all = False) {
    samewith($str, -1, $, :$all);
  }
  multi method utf8_to_ucs4_fast (
    Str() $str,
    $items_written is rw,
    :$all = False
  ) {
    samewith($str, -1, $items_written, :$all);
  }
  multi method utf8_to_ucs4_fast (
    Str() $str,
    Int() $len,
    $items_written is rw,
    :$all = False
  ) {
    my glong ($l, $iw) = ($len, 0);

    my $rc = g_utf8_to_ucs4_fast($str, $l, $iw);
    $items_written = $iw;
    $all.not ?? $rc !! ($rc, $items_written);
  }

  proto method utf8_to_utf16 (|)
    is also<utf8-to-utf16>
  { * }

  multi method utf8_to_utf16 ( Str() $str, :$all = False ) {
    samewith($str, -1, $, $, $, :all);
  }
  multi method utf8_to_utf16 (
    Str() $str,
    Int() $len,
    :$all = False
  ) {
    samewith($str, $len, $, $, $, :$all);
  }
  multi method utf8_to_utf16 (
    Str() $str,
    Int() $len,
    $items_read    is rw,
    $items_written is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$all = False
  ) {
    my glong ($l, $ir, $iw) = ($len, 0, 0);

    clear_error;
    my $rc = g_utf8_to_utf16($str, $l, $ir, $iw, $error);
    set_error($error);
    ($items_read, $items_written) = ($ir, $iw);
    $all.not ?? $rc !! ($rc, $items_read, $items_written, $error);
  }

  proto method utf8_validate (|)
    is also<utf8-validate>
  { * }

  multi method utf8_validate ( Str() $str, :$all = False ) {
    samewith($str, -1, $, :$all);
  }
  multi method utf8_validate (Str() $str, Int() $max_len, :$all = False) {
    samewith($str, $max_len, $, :$all);
  }
  multi method utf8_validate (
    Str() $str,
    Int() $max_len,
    $end is rw,
    :$all = False
  ) {
    my gssize $ml = $max_len;
    my $ea = CArray[Str].new;
    $ea[0] = '';

    my $rc = g_utf8_validate($str, $ml, $ea);
    $end = $ea[0];
    $all.not ?? $rc !! ($rc, $end);
  }

  proto method utf8_validate_len (|)
    is also<utf8-validate-len>
  { * }

  multi method utf8_validate_len (
    Str() $str,
    Int() $max_len,
    :$all = False
  ) {
    samewith($str, $max_len, $, :$all);
  }
  multi method utf8_validate_len (
    Str() $str,
    Int() $max_len,
    $end is rw,
    :$all = False
  ) {
    my gssize $ml = $max_len;
    my $ea = CArray[Str].new;
    $ea[0] = '';

    my $rc = g_utf8_validate_len($str, $max_len, $end);
    $end = $ea[0];
    $all.not ?? $rc !! ($rc, $end);
  }

  proto method get_mirror_char (|)
    is also<get-mirror-char>
  { * }

  multi method get_mirror_char (Int() $ch, :$all = False) {
    samewith($ch, $, :$all);
  }
  multi method get_mirror_char (Int() $ch, $mirrored_ch is rw, :$all = False) {
    my gunichar ($c, $mc) = ($ch, 0);

    my $rc = g_unichar_get_mirror_char($c, $mc);
    $mirrored_ch = $mc;
    $all.not ?? $rc !! ($rc, $mirrored_ch);
  }

  method get_script (Int() $ch) is also<get-script> {
    my gunichar $c = $ch;

    GUnicodeScriptEnum( g_unichar_get_script($ch) );
  }

  method isalnum (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isalnum($c);
  }

  method isalpha (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isalpha($c);
  }

  method iscntrl (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_iscntrl($c);
  }

  method isdefined (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isdefined($c);
  }

  method isdigit (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isdigit($c);
  }

  method isgraph (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isgraph($c);
  }

  method islower (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_islower($c);
  }

  method ismark (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_ismark($c);
  }

  method isprint (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isprint($c);
  }

  method ispunct (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_ispunct($c);
  }

  method isspace (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isspace($c);
  }

  method istitle (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_istitle($c);
  }

  method isupper (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isupper($c);
  }

  method iswide (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_iswide($c);
  }

  method iswide_cjk (Int() $ch) is also<iswide-cjk> {
    my gunichar $c = $ch;

    so g_unichar_iswide_cjk($c);
  }

  method isxdigit (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_isxdigit($c);
  }

  method iszerowidth (Int() $ch) {
    my gunichar $c = $ch;

    so g_unichar_iszerowidth($c);
  }

  proto method to_utf8 (|)
    is also<to-utf8>
  { * }

  multi method to_utf8 (Int() $ch, :$all = False) {
    samewith($ch, $, :$all);
  }
  multi method to_utf8 (Int() $ch, $outbuf is rw, :$all = False) {
    my gunichar $c = $ch;
    my Str $ob = '      ';  # 6 non-NUL bytes allocated for return.

    my $rc = g_unichar_to_utf8($c, $ob);
    $outbuf = $ob;
    $all.not ?? $rc !! ($rc, $outbuf);
  }

  method tolower (Int() $ch) {
    my gunichar $c = $ch;

    g_unichar_tolower($c);
  }

  method totitle (Int() $ch) {
    my gunichar $c = $ch;

    g_unichar_totitle($c);
  }

  method toupper (Int() $ch) {
    my gunichar $c = $ch;

    g_unichar_toupper($c);
  }

  method type (Int() $ch) {
    my gunichar $c = $ch;

    g_unichar_type($c);
  }

  method validate (gunichar $ch) {
    my gunichar $c = $ch;

    g_unichar_validate($ch);
  }

  method xdigit_value (Int() $ch) is also<xdigit-value> {
    my gunichar $c = $ch;

    g_unichar_xdigit_value($c);
  }

}
