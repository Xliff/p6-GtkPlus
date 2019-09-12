use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::Base64;

class GLib::Base64 {

  method new (|) {
    warn 'GLib::Base64 is a static class and does not need instantiation.'
      if $DEBUG;

    GLib::Base64;
  }

  multi method decode (Str() $text, :$all = False) {
    samewith($text, $, :$all);
  }
  multi method decode (Str() $text, $out_len is rw, :$all = False) {
    my gsize $ol = 0;

    my $decoded = g_base64_decode($text, $ol);
    $out_len = $ol;
    $all ?? $decoded !! ($decoded, $out_len);
  }

  proto method decode_inplace (|)
      is also<decode-inplace>
  { * }

  multi method decode_inplace (Str() $text, :$all = False) {
    samewith($text, $, :$all);
  }
  multi method decode_inplace (Str() $text, $out_len is rw, :$all = False) {
    my gsize $ol = 0;

    my $decoded = g_base64_decode_inplace($text, $ol);
    $out_len = $ol;
    $all ?? $decoded !! ($decoded, $out_len);
  }

  proto method decode_step (|)
      is also<decode-step>
  { * }

  multi method decode_step (Str() $in, Int() $len) {
    samewith($in, $len, $, $, $);
  }
  multi method decode_step (
    Str() $in,
    Int() $len,
    $out        is rw,
    $state      is rw,
    $save       is rw
  ) {
    my gsize $l = 0;
    my Str $o = '';
    my gint $s = 0;
    my guint $ss = 0;

    my $rv = g_base64_decode_step($in, $l, $o, $s, $ss);
    ($out, $state, $save) = ($o, $s, $ss);
    ($out, $state, $save, $rv);
  }


  method encode (Str() $data, Int() $len) {
    my gsize $l = $len;

    g_base64_encode($data, $len);
  }

  proto method encode_close (|)
      is also<encode-close>
  { * }

  multi method encode_close (
    Int() $break_lines,
    Int() $state is rw,
    Int() $save  is rw
  ) {
    samewith($break_lines, $, $state, $save);
  }
  multi method encode_close (
    Int() $break_lines,
    $out               is rw,
    Int() $state       is rw,
    Int() $save        is rw
  ) {
    my Str $o = '';
    my gboolean $b = $break_lines;
    my gint ($s, $ss) = ($state, $save);
    my $rv = g_base64_encode_close($b, $o, $s, $ss);

    ($out, $state, $save) = ($o, $s, $ss);
    ($out, $state, $save, $rv);
  }

  proto method encode_step (|)
      is also<encode-step>
  { * }

  multi method encode_step (Str() $in, Int() $len, Int() $break_lines) {
    samewith($in, $len, $break_lines, $, $, $);
  }
  multi method encode_step (
    Str() $in,
    Int() $len,
    Int() $break_lines,
    $out         is rw,
    Int() $state is rw,
    Int() $save  is rw
  ) {
    my Str $o = '';
    my gsize $l = $len;
    my gboolean $b = $break_lines;
    my gint ($s, $ss) = ($state, $save);
    my $rv = g_base64_encode_step($in, $l, $b, $o, $s, $ss);

    ($out, $state, $save) = ($b, $o, $s, $ss);
    ($out, $state, $save, $rv);
  }

}
