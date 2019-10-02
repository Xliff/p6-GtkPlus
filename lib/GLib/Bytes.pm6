use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GLib::Raw::Bytes;

class GLib::Bytes {
  has GBytes $!b;

  submethod BUILD (:$bytes) {
    $!b = $bytes;
  }

  method GTK::Compat::Types::GBytes
    is also<GBytes>
  { $!b }

  method new (Buf() $data, Int() $size) {
    my gsize $s = $size;

    self.bless( bytes => g_bytes_new($data, $s) );
  }

  method new_from_bytes (GBytes() $bytes, Int() $offset, Int() $length)
    is also<new-from-bytes>
  {
    my gsize ($o, $l) = ($offset, $length);

    self.bless( bytes => g_bytes_new_from_bytes($bytes, $o, $l) );
  }

  method new_static (Buf() $data, Int() $size) is also<new-static> {
    my gsize $s = $size;

    self.bless( bytes => g_bytes_new_static($data, $s) );
  }

  method new_take (Buf() $data, Int() $size) is also<new-take> {
    my gsize $s = $size;

    self.bless( bytes => g_bytes_new_take($data, $s) );
  }

  method new_with_free_func (
    Buf() $data,
    Int() $size,
    GDestroyNotify $free_func,
    gpointer $user_data = gpointer
  )
    is also<new-with-free-func>
  {
    my gsize $s = $size;

    self.bless(
      bytes => g_bytes_new_with_free_func($data, $s, $free_func, $user_data)
    );
  }

  method compare (GBytes() $bytes2) {
    g_bytes_compare($!b, $bytes2);
  }

  method equal (GBytes() $bytes2) {
    g_bytes_equal($!b, $bytes2);
  }

  method get_data (Int() $size) is also<get-data> {
    my gsize $s = $size;

    g_bytes_get_data($!b, $s);
  }

  method get_size is also<get-size> {
    g_bytes_get_size($!b);
  }

  method hash {
    g_bytes_hash($!b);
  }

  method ref is also<upref> {
    g_bytes_ref($!b);
    self;
  }

  method unref is also<downref> {
    g_bytes_unref($!b);
  }

  method unref_to_array (:$raw = False) is also<unref-to-array> {
    my $ba = g_bytes_unref_to_array($!b);

    $ba ??
      ( $raw ?? $ba !! GLib::BytesArray.new($ba) )
      !!
      Nil;
  }

  method unref_to_data (Int() $size) is also<unref-to-data> {
    my gsize $s = $size;

    g_bytes_unref_to_data($!b, $s);
  }

}
