use v6.c;

use NativeCall;

class GtkTreeIter is repr('CStruct') {
  has int32   $.stamp;
  has Pointer $.user_data;
  has Pointer $.user_data2;
  has Pointer $.user_data3;
}

class GTypeValueList is repr('CUnion') {
  has int32	          $.v_int     is rw;
  has uint32          $.v_uint    is rw;
  has long            $.v_long    is rw;
  has ulong           $.v_ulong   is rw;
  has int64           $.v_int64   is rw;
  has uint64          $.v_uint64  is rw;
  has num32           $.v_float   is rw;
  has num64           $.v_double  is rw;
  has Pointer         $.v_pointer is rw;
};

class GValue is repr('CStruct') {
  has ulong   $.g_type is rw;
  has uint64  $.data1  is rw;
  has uint64  $.data2  is rw;
}

sub gtk_list_store_newv (int32 $n_columns, CArray[uint64] $types)
  returns Pointer
  is native('gtk-3')
  is export
  { * }

sub gtk_list_store_set_valuesv (
  Pointer $list_store,
  GtkTreeIter $iter,
  CArray[int32] $columns,
  GValue $values,
  int32 $n_values
)
  is native('gtk-3')
  is export
  { * }

sub set_valuesv (
  Pointer $store,
  GtkTreeIter $iter,
  @columns,
  @values,
  Int() $n_values
) {
  my $c_columns = CArray[int32].new;
  my $c_values = CArray[GValue].new;
  $c_columns[$_] = @columns[$_].Int for (^$n_values);
  $c_values[$_]  = @values[$_] for (^$n_values);
  gtk_list_store_set_valuesv($store, $iter, $c_columns, $c_values[0], $n_values);
}

sub g_value_init (GValue $value, uint64 $type)
  returns GValue
  is native('gobject-2.0')
  is export
  { * }
sub gtk_list_store_append (Pointer $list_store, GtkTreeIter $iter)
  is native('gtk-3')
  is export
  { * }
sub g_value_set_string (GValue $value, Str $v_string)
  is native('gobject-2.0')
  is export
  { * }
sub g_value_set_boolean (GValue $value, uint32 $v_boolean)
  is native('gobject-2.0')
  is export
  { * }
sub gtk_list_store_set_value (
  Pointer $list_store,
  GtkTreeIter $iter,
  int32 $column,
  GValue $value
)
  is native('gtk-3')
  is export
  { * }

sub new_list_store (@types) {
  my $t = CArray[uint64].new(@types);
  my int32 $columns = @types.elems;
  gtk_list_store_newv($columns, $t);
}

my @types = (64, 64, 20);

sub new_value($t) {
  my $v = GValue.new;
  g_value_init($v, $t);
  $v;
}

my $store = new_list_store(@types);
my $iter = GtkTreeIter.new;
for (^5) -> $o {
  my %data = (
    0 => new_value(64), # String
    1 => new_value(64), # String
    2 => new_value(20), # Boolean
  );

  for (^3) {
    when 0 | 1 {
      g_value_set_string(%data{$_}, "String{ $_ + 1}-{ $o }");
    }
    default {
      g_value_set_boolean(%data{$_}, (^1).pick);
    }
  }
  gtk_list_store_append($store, $iter);
  set_valuesv(
    $store,
    $iter,
    %data.keys.sort,
    %data.keys.map({ %data{$_} }),
    %data.keys.elems
  )
  # gtk_list_store_set_value($store, $iter, $_.Int, %data{$_}) for %data.keys;
}
