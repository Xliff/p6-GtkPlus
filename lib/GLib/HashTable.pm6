use v6.c;

use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GLib::Raw::HashTable;

INIT {
  say qq:to/S/ unless %*ENV<P6_BUILDING_GTK>.so;
»»»»»»
» Please note that the objects in { $?FILE } are classed as use-at-your-own-risk!
»»»»»»
S

}

# Oy-ya-mama! The issues with this class. Let me start on the fact that it's
# all POINTER BASED. This is easy for C, but not so easy for Perl6 given
# the differences in typing system.. So let's try and determine scope.
#  - This object is to handle keys of all primative types. (Str, Num, Int)
#    - Int and Num types will be converted to the native equivalent and passed
#      via CArray[::T][0]
#  - This object is to handle values of all primative types. (Str, Num, Int)
#    - Int and Num types will be converted to the native equivalent and passed
#      via CArray[::T][0]
#  - This object will handle keys of native types (REPR eq <CStruct CPointer>.any
#    - These will be handled via a nativecast to Pointer
#  - This object will handle values of native types (REPR eq <CStruct CPointer>.any
#    - By extension, this means that this object will also handle all GObject derivatives
#    - These will be handled via a nativecast to Pointer

class GLib::HashTable {
  has GHashTable $!h;

  submethod BUILD (:$table) {
    self!setObject($!h = $table);
  }

  submethod DESTROY {
    self.downref
  }

  method GTK::Compat::Types::GHashTable
  { $!h }

  # Really, the only thing that's needed.
  # Look into the diff between %table and *%table.
  multi method new(%table) {
    my $o = GLib::HashTable.new(&g_str_hash, &g_str_equal);
    $o.insert($_, %table{$_}) for %table.keys;
    $o;
  }

  multi method new (GHashTable $table) {
    my $o = self.bless(:$table);
    $o.upref;
  }
  # COPIED FROM THE DOC PAGES IN FULL, FOR PROPER REFERENCE.
  #
  # Creates a new GHashTable with a reference count of 1.
  #
  # Hash values returned by hash_func are used to determine where keys are stored
  # within the GHashTable data structure. The g_direct_hash(), g_int_hash(),
  # g_int64_hash(), g_double_hash() and g_str_hash() functions are provided for
  # some common types of keys. If hash_func is NULL, g_direct_hash() is used.
  #
  # key_equal_func is used when looking up keys in the GHashTable. The
  # g_direct_equal(), g_int_equal(), g_int64_equal(), g_double_equal() and
  # g_str_equal() functions are provided for the most common types of keys. If
  # key_equal_func is NULL, keys are compared directly in a similar fashion to
  # g_direct_equal(), but without the overhead of a function call.
  # key_equal_func is called with the key from the hash table as its first
  # parameter, and the user-provided key to check against as its second.
  multi method new (
    # These parameters WILL NOT WORK
    &hash_func,
    &key_equal_func
  ) {
    g_hash_table_new(&hash_func, &key_equal_func);
  }

  method new_full (
    # THESE PARAMETERS WILL NOT WORK. See above.
    &hash_func,
    &key_equal_func,
    GDestroyNotify $key_destroy_func   = Pointer,
    GDestroyNotify $value_destroy_func = Pointer
  ) {
    g_hash_table_new_full(
      &hash_func,
      &key_equal_func,
      $key_destroy_func,
      $value_destroy_func
    );
  }

  method add ($key) {
    g_hash_table_add($!h, $key);
  }

  method contains ($key) {
    g_hash_table_contains($!h, $key);
  }

  method destroy {
    g_hash_table_destroy($!h);
  }

  method find (&predicate, gpointer $user_data) {
    g_hash_table_find($!h, &predicate, $user_data);
  }

  method foreach (&func, gpointer $user_data) {
    g_hash_table_foreach($!h, &func, $user_data);
  }

  method foreach_remove (&func, gpointer $user_data) {
    g_hash_table_foreach_remove($!h, &func, $user_data);
  }

  method foreach_steal (&func, gpointer $user_data) {
    g_hash_table_foreach_steal($!h, &func, $user_data);
  }

  # STATIC METHODS -- start
  method g_direct_equal (GLib::HashTable:U: $v1, $v2) {
    g_direct_equal($v1, $v2);
  }

  method g_direct_hash (GLib::HashTable:U: Pointer $dh) {
    g_direct_hash($dh);
  }

  method g_double_equal (GLib::HashTable:U: $v1, $v2) {
    g_double_equal($v1, $v2);
  }

  method g_double_hash (GLib::HashTable:U: CArray[num64] $d) {
    g_double_hash($d);
  }

  method g_int64_equal (GLib::HashTable:U: $v1, $v2) {
    g_int64_equal($v1, $v2);
  }

  method g_int64_hash (GLib::HashTable:U: CArray[int64] $i) {
    g_int64_hash($i);
  }

  method g_int_equal (GLib::HashTable:U: $i1, $i2) {
    g_int_equal($i1, $i2);
  }

  method g_int_hash (GLib::HashTable:U: CArray[int32] $i) {
    g_int_hash($i);
  }

  method g_str_equal (GLib::HashTable:U: Str $s1, Str $s2) {
    g_str_equal($s1, $s2);
  }

  method g_str_hash (GLib::HashTable:U: Str $s) {
    g_str_hash($s);
  }
  # STATIC METHODS -- end

  method get_keys {
    g_hash_table_get_keys($!h);
  }

  # Keys can be of various types, so no easy way to do this. Will have to
  # consider the various options: Str, int32, int64, double, Pointer
  method get_keys_as_array (Int() $length is rw) {
    my guint $l = resolve-uint($length);
    $length = $l;

  }

  # Will return a list of POINTERS!
  method get_values (:$type) {
    my $die_msg = qq:to/D/.chomp;
      \$type must be native compatible. This means that the type must be{ ''
      } one of the following:
        Str uint8/16/32/64 num32/64, CStruct-based or CPointer-based.
      D

    die $die_msg unless
      $type ~~ (
        Str,
        uint8, int8, uint16, int16, uint32, int32, uint64, int64,
        num32, num64
      ).any
      ||
      $type.REPR eq <CStruct CArray>.any;

    my $l = GTK::Compat::List.new( g_hash_table_get_values($!h) );
    $type.defined ??
      $l !! $l but GTK::Compat::ListData[$type];
  }

  # Will have to be multi-typed
  multi method insert (Str $key, Str $value) {
    g_hash_table_insert_str($!h, $key, $value);
  }
  multi method insert (Str $key, Num $value) {
    my $v = CArray[num64].new;
    $v[0] = $value;
    g_hash_table_insert_double($!h, $key, $v);
  }
  multi method insert (Str $key, Int $value) {
    my ($v, &sub);
    if $value.abs.log(2).floor >= 32 {
      $v = CArray[uint64].new;
      &sub = &g_hash_table_insert_int64;
    } else {
      $v = CArray[uint32].new;
      &sub = &g_hash_table_insert_int;
    }
    $v[0] = $value;
    &sub($!h, $key, $v);
  }
  multi method insert (Str $key, $value is copy) {
    die "Do not know how to handle { $value.^name } for GLib::HashTable!"
      unless $value.REPR eq <CPointer CStruct>.any;
    my Pointer $v = $value.REPR eq 'CStruct' ?? cast(Pointer, $value) !! $value;
    g_hash_table_insert_pointer($!h, $key, $v);
  }

  method lookup ($key) {
    g_hash_table_lookup($!h, $key);
  }

  method lookup_extended ($lookup_key, $orig_key, $value) {
    g_hash_table_lookup_extended($!h, $lookup_key, $orig_key, $value);
  }

  method ref {
    g_hash_table_ref($!h);
  }

  method remove ($key) {
    g_hash_table_remove($!h, $key);
  }

  method remove_all {
    g_hash_table_remove_all($!h);
  }

  method replace ($key, $value) {
    g_hash_table_replace($!h, $key, $value);
  }

  method size {
    g_hash_table_size($!h);
  }

  method steal ($key) {
    g_hash_table_steal($!h, $key);
  }

  method steal_all {
    g_hash_table_steal_all($!h);
  }

  method steal_extended ($lookup_key, $stolen_key,  $stolen_value) {
    g_hash_table_steal_extended($!h, $lookup_key, $stolen_key, $stolen_value);
  }

  method unref {
    g_hash_table_unref($!h);
  }

}

class GLib::HashTable::String is GLib::HashTable {
  method new {
    self.new(&g_str_hash, &g_str_equal);
  }
}

class GLib::HashTable::Int is GLib::HashTable {
  method new {
    self.new(&g_int_hash, &g_int_equal);
  }
}

class GLib::HashTable::Int64 is GLib::HashTable {
  method new {
    self.new(&g_int64_hash, &g_int64_equal);
  }
}

class GLib::HashTable::Double is GLib::HashTable {
  method new {
    self.new(&g_double_hash, &g_double_equal);
  }
}

# OPAQUE STRUCT

class GLib::HashTableIter {
    has GHashTableIter $!hi;

    method GTK::Compat::Types::GHashTableIter
    { $!hi }

    method get_hash_table {
      GLib::HashTable.new(
        g_hash_table_iter_get_hash_table($!hi)
      );
    }

    method init (GHashTable() $hash_table) {
      my $i = GHashTableIter;
      self.bless( iter => g_hash_table_iter_init($i, $hash_table) );
    }

    method next (Pointer $key, Pointer $value) {
      so g_hash_table_iter_next($!hi, $key, $value);
    }

    method remove {
      g_hash_table_iter_remove($!hi);
    }

    method replace (Pointer $value) {
      g_hash_table_iter_replace($!hi, $value);
    }

    method steal {
      g_hash_table_iter_steal($!hi);
    }

  }
