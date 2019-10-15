use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::Raw::Arrays;

use GLib::Bytes;

class GLib::ByteArray {
  has GByteArray $!ba handles <len Blob>;

  submethod BUILD (:$byte-array) {
    $!ba = $byte-array;
  }

  method GTK::Compat::Types::GByteArray
    is also<GByteArray>
  { $!ba }

  method new {
    my $ba = g_byte_array_new();

    $ba ?? self.bless( byte-array => $ba) !! Nil;
  }

  method new_take (Blob() $data, Int() $len) is also<new-take> {
    my gsize $l = $len;
    my $ba = g_byte_array_new_take($data, $l);

    $ba ?? self.bless( byte-array => $ba) !! Nil;
  }

  method sized_new (Int() $size)
    is also<
      sized-new
      new_sized
      new-sized
    >
  {
    my guint $s = $size;
    my $ba = g_byte_array_sized_new($s);

    $ba ?? self.bless( byte-array => $ba) !! Nil;
  }

  method append (Blob $data, Int() $len) {
    my guint $l = $len;

    g_byte_array_append($!ba, $data, $l);
    self;
  }

  method free (Int() $free_segment, :$blob = False) {
    my gboolean $f = $free_segment;
    my guint $ol = self.len;

    my $fa = g_byte_array_free($!ba, $f);
    $blob.not ?? $fa !! Blob.new( $fa[ ^$ol ] );
  }

  method free_to_bytes (:$raw = False) is also<free-to-bytes> {
    my $b = g_byte_array_free_to_bytes($!ba);

    $b ??
      ( $raw ?? $b !! GLib::Bytes.new($b) )
      !!
      Nil
  }

  method prepend (Blob $data, Int() $len) {
    my guint $l = $len;

    g_byte_array_prepend($!ba, $data, $l);
    self;
  }

  method ref is also<upref> {
    g_byte_array_ref($!ba);
    self;
  }

  method remove_index (Int() $index) is also<remove-index> {
    my guint $i = $index;

    g_byte_array_remove_index($!ba, $index);
    self;
  }

  method remove_index_fast (Int() $index) is also<remove-index-fast> {
    my guint $i = $index;

    g_byte_array_remove_index_fast($!ba, $index);
    self;
  }

  method remove_range (Int() $index, Int() $length) is also<remove-range> {
    my guint ($i, $l) = ($index, $length);

    g_byte_array_remove_range($!ba, $i, $l);
    self;
  }

  method set_size (Int() $len) is also<set-size> {
    my guint $l = $len;

    g_byte_array_set_size($!ba, $l);
  }

  method sort (GCompareFunc $compare_func) {
    g_byte_array_sort($!ba, $compare_func);
    self;
  }

  method sort_with_data (
    GCompareDataFunc $compare_func,
    gpointer $user_data = gpointer
  )
    is also<sort-with-data>
  {
    g_byte_array_sort_with_data($!ba, $compare_func, $user_data);
    self;
  }

  method unref is also<downref> {
    g_byte_array_unref($!ba);
  }

}
