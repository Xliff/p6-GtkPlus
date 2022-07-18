my $template = q:to/TEMPLATE/;
  class GLib::HashTable::{ ln } is GLib::HashTable {
    method new {
      nextwith(&{ hash }, &{ equal });
    }

    method getTypePair {
      GHashTable, GLib::HashTable::{ ln }
    }

    method add ({ pt }() $key) {
      sub g_hash_table_add_{ sn }(GHashTable, { ct } $k)
        returns uint32
        is native(glib)
        is symbol('g_hash_table_add')
        { * }

      so g_hash_table_add_{ sn }(
        self.GHashtTable,
        $key
      );
    }

    method contains ({ pt }() $key) {
      sub g_hash_table_contains_{ sn } (GHashTable, { ct } $k)
        returns uint32
        is native(glib)
        is symbol('g_hash_table_contains')
        { * }

      so g_hash_table_contains_{ sn }( self.GHashTable, $key);
    }

    multi method insert ({ pt }() $key, { pt }() $value) {
      sub g_hash_table_insert_{ sn }(GHashTable, { ct } $k, { ct } $v)
        returns uint32
        is native(glib)
        is symbol('g_hash_table_insert')
        { * }

      so g_hash_table_insert_{ sn }($key, $value);
    }

    method lookup ({ pt }() $key) {
      sub g_hash_table_lookup_{ sn }(GHashTable, { ct } $k)
        returns uint32
        is native(glib)
        is symbol('g_hash_table_lookup')
        { * }

      g_hash_table_lookup_{ sn }(self.GHashTable, $key);
    }

    proto method lookup_extended (|)
      is also<lookup-extended>
    { * }

    multi method lookup_extended ({ pt }() $lookup_key, :$all = False) {
      my @return-pointers;
      @return-pointers[0, 1] = newCArray({ ct }) xx 2;

      sub g_hash_table_lookup_extended_{ sn } (
        GHashTable    $hash_table,
        { ct } $lookup_key,
        { ct } $orig_key,
        { ct } $value
      )
        returns uint32
        is native(glib)
        is symbol('g_hash_table_lookup_extended')
        { * }


      my $rv = g_hash_table_lookup_extended_{ sn }(
        self.GHashTable,
        newCArray({ ct }, $lookup_key),
        @return-pointers[0],
        @return-pointers[1]
      );

      $all ?? $rv !! ($rv, |@return-pointers);
    }

    method remove ({ pt }() $key) {
      sub g_hash_table_remove_{ sn }(GHashTable, { ct } $k)
        returns uint32
        is native(glib)
        is symbol('g_hash_table_remove')
        { * }

      so g_hash_table_remove_{ sn }(
        self.GHashTable,
        newCArray({ ct }, $key )
      );
    }

    method replace ({ pt }() $key, { pt }() $value) {
      sub g_hash_table_replace_{ sn }(
        GHashTable,
        { ct } $k,
        { ct } $v
      )
        returns uint32
        is native(glib)
        is symbol('g_hash_table_replace')
        { * }

      so g_hash_table_replace_{ sn }(
        self.GHashTable,
        newCArray({ ct }, $key),
        newCArray({ ct }, $value)
      );
    }

    method steal ({ pt }() $key) {
      sub g_hash_table_steal_{ sn }(GHashTable, { ct } $k)
        returns uint32
        is native(glib)
        is symbol('g_hash_table_steal')
        { * }

      g_hash_table_steal_{ sn }(self.GHashTable, $key);
    }

  }
  TEMPLATE

my @hash-types = (
  # str => {
  #   ct    => 'CArray[uint8]',
  #   hash  => 'g_str_hash',
  #   equal => 'g_str_equal'
  # },
  {
    ln    => 'Integer',
    pt    => 'Int',
    sn    => 'int',
    ct    => 'CArray[gint]',
    hash  => 'g_int_hash',
    equal => 'g_int_equal'
  },
  {
    ln    => 'Int64',
    pt    => 'Int',
    sn    => 'int64',
    ct    => 'CArray[gint64]',
    hash  => 'g_int_hash',
    equal => 'g_int_equal'
  },
  {
    ln    => 'Float',
    pt    => 'Num',
    sn    => 'float',
    ct    => 'CArray[num32]',
    hash  => 'g_double_hash',
    equal => 'g_double_equal'
  },
  {
    ln    => 'Double',
    pt    => 'Num',
    sn    => 'double',
    ct    => 'CArray[num64]',
    hash  => 'g_double_hash',
    equal => 'g_double_equal'
  }
);

for @hash-types -> $a {
  my $type-block = $template;

  for $a.keys {
    (my $old = "\{ $_ \}");
    $type-block = $type-block.subst("\{ $_ \}", $a{$_}, :g);
  }
  $type-block.say;
}
