use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GLib::Raw::Rand;

class GLib::Rand {
  has GRand $!r;

  submethod BUILD (:$rand) {
    $!r = $rand;
  }

  method GTK::Compat::Types::GRand
  { $!r }

  multi method new (GRand $rand) {
    self.bless( :$rand );
  }
  multi method new {
    self.bless( rand => g_rand_new() );
  }

  method new_with_seed (Int() $seed) is also<new-with-seed> {
    my guint $s = $seed;

    self.bless( rand => g_rand_new_with_seed($seed) );
  }

  proto method new_with_seed_array (|)
      is also<new-with-seed-array>
  { * }

  multi method new_with_seed_array (@seeds) {
    my $sa = CArray[guint].new;
    my $idx = 0;

    $sa[$_] = @seeds[$_] for ^@seeds;
    samewith($sa, @seeds.elems);
  }
  multi method new_with_seed_array (
    CArray[guint] $seed_array,
    Int() $seed_length
  ) {
    my guint $sl = $seed_length;

    self.bless( rand => g_rand_new_with_seed_array($seed_array, $sl) );
  }

  # Class methods,.
  multi method double (
    GLib::Rand:U:
  ) {
    g_random_double();
  }

  proto method double_range (|)
    is also<double-range>
  { * }

  multi method double_range (
    GLib::Rand:U:
    Num() $begin,
    Num() $end
  ) {
    my gdouble ($b, $e) = ($begin, $end);

    g_random_double_range($b, $e);
  }

  multi method int (GLib::Rand:U:) {
    g_random_int();
  }

  proto method int_range (|)
    is also<int-range>
  { * }

  multi method int_range (
    GLib::Rand:U:
    Int() $begin,
    Int() $end
  ) {
    my gint ($b, $e) = ($begin, $end);

    g_random_int_range($b, $e);
  }

  proto method set_seed (|)
    is also<set-seed>
  { * }

  multi method set_seed (
    GLib::Rand:U:
    Int() $seed
  ) {
    my guint $s = $seed;

    g_random_set_seed($s);
  }

  # Methods
  method copy {
    GLib::Rand.new( g_rand_copy($!r) );
  }

  multi method double {
    g_rand_double($!r);
  }

  multi method double_range (Num() $begin, Num() $end) {
    my gdouble ($b, $e) = ($begin, $end);

    g_rand_double_range($!r, $b, $e);
  }

  method free {
    g_rand_free($!r);
  }

  multi method int {
    g_rand_int($!r);
  }

  multi method int_range (Int() $begin, Int() $end) {
    my gint ($b, $e) = ($begin, $end);

    g_rand_int_range($!r, $b, $e);
  }

  multi method set_seed (Int() $seed) {
    my guint $s = $seed;

    g_rand_set_seed($!r, $seed);
  }

  proto method set_seed_array (|)
      is also<set-seed-array>
  { * }

  multi method set_seed_array (@seeds) {
    my $sa = CArray[guint].new;
    my $idx = 0;

    $sa[$_] = @seeds[$_] for ^@seeds;
    samewith($sa, @seeds.elems);
  }
  multi method set_seed_array (CArray[guint] $seed_array, Int() $seed_length) {
    my guint $sl = $seed_length;

    g_rand_set_seed_array($!r, $seed_array, $seed_length);
  }

}
