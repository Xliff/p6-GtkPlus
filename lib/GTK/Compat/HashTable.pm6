use v6.c;

use NativeCall;
use GTK::Compat::Types;

use GTK::Raw::Utils;

use GTK::Compat::Raw::HashTable;

use GTK::Compat::Roles::Object;

INIT {
  say qq:to/S/;
»»»»»»
» Please note that the objects in { $?FILE } are classed as use-at-your-own-risk!
»»»»»»
S

}

# Oy-ya-mama! The issues with this class. Let me start on the fact that it's
# all POINTER BASED. This is easy for C, but not so easy for Perl6 givene
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

class GTK::Compat::HashTable {
  also does GTK::Compat::Roles::Object;

  has GHashTable $!h;

  submethod BUILD (:$table) {
    self!setObject($!h = $table);
  }

  method GTK::Compat::Types::Raw::GHashTable
  { $!h }

  multi method new (GHashTable $table) {
    self.bless(:$table);
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
  method g_direct_equal ($v1, $v2) {
    g_direct_equal($v1, $v2);
  }

  method g_direct_hash (Pointer $dh) {
    g_direct_hash($dh);
  }

  method g_double_equal ($v1, $v2) {
    g_double_equal($v1, $v2);
  }

  method g_double_hash (CArray[num64] $d) {
    g_double_hash($d);
  }

  method g_int64_equal ($v1, $v2) {
    g_int64_equal($v1, $v2);
  }

  method g_int64_hash (CArray[int64] $i) {
    g_int64_hash($i);
  }

  method g_int_equal ($i1, $i2) {
    g_int_equal($i1, $i2);
  }

  method g_int_hash (CArray[int32] $i) {
    g_int_hash($i);
  }

  method g_str_equal (Str $s1, Str $s2) {
    g_str_equal($s1, $s2);
  }

  method g_str_hash (Str $s) {
    g_str_hash($s);
  }
  # STATIC METHODS -- end

  method get_keys {
    g_hash_table_get_keys($!h);
  }

  method get_keys_as_array (Int() $length) {
    my guint $l = resolve-uint($length);
    g_hash_table_get_keys_as_array($!h, $l);
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

  method insert ($key,  $value) {
    g_hash_table_insert($!h, $key, $value);
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

  method remove ( $key) {
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


# OPAQUE STRUCT

class GTK::Compat::HashTableIter {
    has GHashTableIter $!hi;

    method GTK::Compat::Raw::Types::GHashTableIter
    { $!hi }

    method get_hash_table {
      GTK::Compat::HashTable.new(
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
