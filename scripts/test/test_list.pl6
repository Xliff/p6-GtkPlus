use v6.c;

use NativeCall;

class GtkTreeIter is repr('CStruct')  {
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
  has OpaquePointer   $.v_pointer is rw;
};

class GValue is repr('CStruct') {
  has ulong           $.g_type is rw;
  HAS GTypeValueList  $.data1  is rw;
  HAS GTypeValueList  $.data2  is rw;
}

sub g_value_set_string (GValue $value, Str $v_string)
  is native('gtk-3')
  { * }

sub g_value_set_boolean (GValue $value, uint32 $v_boolean)
  is native('gtk-3')
  { * }

sub gtk_list_store_newv (int32 $n_columns, CArray[uint64] $types)
  returns Pointer
  is native('gtk-3')
  { * }

sub gtk_list_store_append (Pointer $list_store, GtkTreeIter $iter)
  is native('gtk-3')
  { * }

sub gtk_list_store_set_valuesv (
  Pointer $list_store,
  GtkTreeIter $iter,
  CArray[int32] $columns,
  CArray[GValue] $values,
  int32 $n_values
)
  is native('gtk-3')
  { * }

sub g_value_init (GValue $value, uint32 $type)
  returns GValue
  is native('gtk-3')
  is export
  { * }

sub gtk_tree_model_get_value (
  Pointer $tree_model,
  GtkTreeIter $iter,
  int32 $column,
  GValue $value
)
  is native('gtk-3')
  { * }

sub g_value_get_string (GValue $value)
  returns Str
  is native('gtk-3')
  { * }

sub gtk_list_store_set_value (
  Pointer $list_store,
  GtkTreeIter $iter,
  int32 $column,
  GValue $value
)
  is native('gtk-3')
  { * }

my $t = CArray[uint64].new(64, 64, 20);
my $l = nativecast(Pointer, gtk_list_store_newv($t.elems, $t) );
my $i = GtkTreeIter.new;
my $c = CArray[int32].new(0, 1, 2);
my $v = CArray[GValue].new;

$v[0] = GValue.new;
g_value_init($v[0], 64);
$v[1] = GValue.new;
g_value_init($v[1], 64);
$v[2] = GValue.new;
g_value_init($v[2], 20);

g_value_set_string($v[0], 'String1');
g_value_set_string($v[1], 'String3');
g_value_set_boolean($v[2], 1);

gtk_list_store_append($l, $i);
#gtk_list_store_set_valuesv($l, $i, $c, $v, 3);
gtk_list_store_set_value($l, $i, 0, $v[0]);
gtk_list_store_set_value($l, $i, 1, $v[1]);
gtk_list_store_set_value($l, $i, 2, $v[2]);

my $vs = GValue.new;
gtk_tree_model_get_value($l, $i, 1, $vs);

say g_value_get_string($vs);
