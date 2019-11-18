use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::TreeStore;
use GTK::Raw::Types;
use GTK::Raw::Utils;

use GTK::Compat::Roles::Object;

use GTK::Roles::Buildable;
use GTK::Roles::TreeDnD;
use GTK::Roles::TreeModel;
use GTK::Roles::TreeSortable;

class GTK::TreeStore  {
  also does GTK::Compat::Roles::Object;

  also does GTK::Roles::Buildable;
  also does GTK::Roles::TreeDragDest;
  also does GTK::Roles::TreeDragSource;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeSortable;

  has GtkTreeStore $!tree is implementor;

  submethod BUILD(:$treestore) {
    self!setObject($!tree = $treestore);           # GTK::Compat::Roles::Object

    $!b  = nativecast(GtkBuildable,      $!tree);  # GTK::Roles::Buildable
    $!tm = nativecast(GtkTreeModel,      $!tree);  # GTK::Roles::TreeModel
    $!ts = nativecast(GtkTreeSortable,   $!tree);  # GTK::Roles::TreeSortable
    $!dd = nativecast(GtkTreeDragDest,   $!tree);  # GTK::Roles::TreeDragDest
    $!ds = nativecast(GtkTreeDragSource, $!tree);  # GTK::Roles::TreeDragSource
  }

  method new (*@types) {
    # self does NOT exist yet, so can't use GTK::Roles::Types methods.
    #
    # Really should check into macros for these for this EXACT situation.
    for (@types) {
      die "{ $_ } is not a valid GType value"
        unless $_.Int (elem) GTypeEnum.enums.values;
    }
    my $t = CArray[GType].new;
    my $i = 0;
    $t[$i++] = $_ for @types;
    my gint $c = @types.elems;
    my $treestore = gtk_tree_store_newv($c, $t);
    self.bless(:$treestore);
  }

  method !checkCV(@columns, @values) {
    die 'Contents of @columns must be integers.'
      unless @columns.all ~~ (Int, IntStr).any;
    warn '@columns exceeds the number of @values'
      if +@columns > +@values;
    warn '@values exceeds the number of @columns'
      if +@values > +@columns;
    my $max = max(+@columns, +@values);

    my $c = CArray[int32].new(@columns[^$max]);
    my $v = CArray[GValue].new;
    for (^$max) {
      $v[$_] = do given @values[$_] {
        # NOTE! $_ is now the current element of @value
        when GValue { $_ }
        default     { $_.GValue }
      }
    }
    ($c, $v);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method append (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent = GtkTreeIter
  ) {
    gtk_tree_store_append($!tree, $iter, $parent);
  }

  method clear {
    gtk_tree_store_clear($!tree);
  }

  method get_type is also<get-type> {
    gtk_tree_store_get_type();
  }

  method insert (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    Int() $position
  ) {
    my gint $p = resolve-int($position);
    gtk_tree_store_insert($!tree, $iter, $parent, $p);
  }

  method insert_after (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    GtkTreeIter() $sibling
  ) is also<insert-after> {
    gtk_tree_store_insert_after($!tree, $iter, $parent, $sibling);
  }

  method insert_before (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    GtkTreeIter() $sibling
  ) is also<insert-before> {
    gtk_tree_store_insert_before($!tree, $iter, $parent, $sibling);
  }

  method insert_with_values(
    GtkTreeIter() $iter,
    GtkTreeIter() $pt, # parent
    Int() $position,
    %values
  ) is also<insert-with-values> {
    my @c = %values.keys.map( *.Int ).sort;
    my @v;
    @v.push(%values{$_}) for @c;
    self.insert_with_valuesv($iter, $pt, $position, @c, @v)
  }

  method insert_with_valuesv (
    GtkTreeIter $iter,
    GtkTreeIter $pt, # parent
    Int() $position,
    @columns,
    @values,
  ) is also<insert-with-valuesv> {
    my ($c, $v) = self!checkCV(@columns, @values);
    my gint $p = resolve-int($position);
    gtk_tree_store_insert_with_valuesv($!tree, $iter, $pt, $p, $c, $v, $c.elems);
  }

  method is_ancestor (
    GtkTreeIter() $iter,
    GtkTreeIter() $descendant
  ) is also<is-ancestor> {
    gtk_tree_store_is_ancestor($!tree, $iter, $descendant);
  }

  method iter_depth (GtkTreeIter() $iter) is also<iter-depth> {
    gtk_tree_store_iter_depth($!tree, $iter);
  }

  method iter_is_valid (GtkTreeIter() $iter) is also<iter-is-valid> {
    gtk_tree_store_iter_is_valid($!tree, $iter);
  }

  method move_after (
    GtkTreeIter() $iter,
    GtkTreeIter() $position
  ) is also<move-after> {
    gtk_tree_store_move_after($!tree, $iter, $position);
  }

  method move_before (
    GtkTreeIter() $iter,
    GtkTreeIter() $position
  ) is also<move-before> {
    gtk_tree_store_move_before($!tree, $iter, $position);
  }

  method prepend (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent
  ) {
    gtk_tree_store_prepend($!tree, $iter, $parent);
  }

  method remove (GtkTreeIter() $iter) {
    gtk_tree_store_remove($!tree, $iter);
  }

  method reorder (GtkTreeIter() $parent, @new_order) {
    die '@new_order must consist of integers'
      unless @new_order.all ~~ (Int, IntStr).any;
    my $no = CArray[int32].new( @new_order.map( *.Int ) );
    gtk_tree_store_reorder($!tree, $parent, $no);
  }

  method set_column_types (*@types) is also<set-column-types> {
    die '@types must consist of integers'
      unless @types.all ~~ (Int, IntStr).any;
    my $t = CArray[uint64].new( @types.map( *.Int ) );
    gtk_tree_store_set_column_types($!tree, $t.elems, $t);
  }

  # method set_valist (GtkTreeIter $iter, va_list $var_args) {
  #   gtk_tree_store_set_valist($!tree, $iter, $var_args);
  # }

  method set_value (GtkTreeIter() $iter, Int() $column, GValue() $value) is also<set-value> {
    my gint $c = resolve-int($column);
    gtk_tree_store_set_value($!tree, $iter, $c, $value);
  }

  method set_values(GtkTreeIter() $iter, %values) is also<set-values> {
    my @c = %values.keys.map( *.Int ).sort;
    my @v;
    @v.push(%values{$_}) for @c;
    self.set_valuesv($iter, @c, @v);
  }

  method set_valuesv (
    GtkTreeIter() $iter,
    @columns,
    @values,
  ) is also<set-valuesv> {
    my ($c, $v) = self!checkCV(@columns, @values);
    gtk_tree_store_set_valuesv($!tree, $iter, $c, $v, $c.elems);
  }

  method swap (
    GtkTreeIter() $a,
    GtkTreeIter() $b
  ) {
    gtk_tree_store_swap($!tree, $a, $b);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
