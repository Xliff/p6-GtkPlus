use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;
use GTK::Raw::ListStore;
use GTK::Raw::Types;

use GTK::Roles::Buildable;
use GTK::Roles::TreeModel;
use GTK::Roles::TreeSortable;

my subset GValues where GTK::Compat::Value | GValue;

class GTK::ListStore {
  also does GTK::Roles::Buildable;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeSortable;

  has GtkListStore $!ls;
  has $!accessed = False;
  has $!columns;

  submethod BUILD(:$liststore) {
    $!ls = $liststore;
     $!b = nativecast(GtkBuildable, $!ls);      # GTK::Roles::Buildable
    $!ts = nativecast(GtkTreeSortable, $!ls);   # GTK::Roles::TreeSortable
    $!tm = nativecast(GtkTreeModel, $!ls);      # GTK::Roles::TreeSortable
  }

  method new (Int() @types) {
    my CArray[uint32] $t = CArray[uint32].new;
    $t[$++] = $_.Int for @types.elems;
    $!columns = @types.elems;
    my $liststore = gtk_list_store_newv($t.elems, $t);
    self.bless(:$liststore);
  }

  method append (GtkTreeIter() $iter) {
    $!accessed = True;
    gtk_list_store_append($!ls, $iter);
  }

  method clear {
    $!accessed = True;
    gtk_list_store_clear($!ls);
  }

  method get_type {
    gtk_list_store_get_type();
  }

  method insert (GtkTreeIter() $iter, Int() $position) {
    $!accessed = True;
    my gint $p = self.RESOLVE-INT($position);
    gtk_list_store_insert($!ls, $iter, $position);
  }

  method insert_after (GtkTreeIter() $iter, GtkTreeIter() $sibling) {
    $!accessed = True;
    gtk_list_store_insert_after($!ls, $iter, $sibling);
  }

  method insert_before (GtkTreeIter() $iter, GtkTreeIter() $sibling) {
    $!accessed = True;
    gtk_list_store_insert_before($!ls, $iter, $sibling);
  }

  method insert_with_valuesv (
    GtkTreeIter() $iter,
    Int() $position,
    Int @columns,
    @values,
    Int() $n_values
  ) {
    die '$position cannot be less than -1 (append)' unless $position >= -1;
    die '@columns must consist of Integers.'
      unless @columns.all ~~ (Int, IntStr).any;
    die '@values must contain GTK::Compat::Value or GValue elements'
      unless @values.all ~~ GValues;
    if $n_values > @columns.elems {
      $n_values = @columns.elems;
      warn '$n_values was greater than column count, and was corrected.';
    }

    $!accessed = True;
    # Throw exception if columns mismatch?
    my CArray[gint] $c_columns;
    my CArray[Pointer] $c_values;
    $c_columns[$_] = @columns[$_] for (^$n_values);
    for (^$n_values) {
      $c_values[$_] = do given @values[$_] {
        # NOTE! $_ is now the current element of @value
        when GValue { $_ }
        default     { $_.GValue }
      }
    }
    gtk_list_store_insert_with_valuesv(
      $!ls,
      $iter,
      $position,
      $c_columns,
      $c_values,
      $n_values
    );
  }

  multi method insert_with_values (
    GtkTreeIter() $iter,
    Int() $position,
    %values
  ) {
    die 'Keys used %values must be integers.'
      unless %values.keys.all ~~ (Int, IntStr).any;
    die 'Values used in %values must be GTK::Compat::Value or GValue.'
      unless %values.values.all ~~ GValues;

    my CArray[gint] $c_columns;
    my CArray[GValue] $c_values;
    for %values.keys.sort {
      my $c = $++;
      $c_columns[$c] = $_.Int;
      $c_values[$c] = %values{$_};
    }
    self.insert_with_valuesv(
      $!ls,
      $iter,
      $position,
      $c_columns,
      $c_values,
      $c_columns.elems
    );
  }

  method iter_is_valid (GtkTreeIter() $iter) {
    $!accessed = True;
    gtk_list_store_iter_is_valid($!ls, $iter);
  }

  method move_after (GtkTreeIter() $iter, GtkTreeIter() $position) {
    $!accessed = True;
    gtk_list_store_move_after($!ls, $iter, $position);
  }

  method move_before (GtkTreeIter() $iter, GtkTreeIter() $position) {
    $!accessed = True;
    gtk_list_store_move_before($!ls, $iter, $position);
  }

  method prepend (GtkTreeIter() $iter) {
    $!accessed = True;
    gtk_list_store_prepend($!ls, $iter);
  }

  method remove (GtkTreeIter() $iter) {
    $!accessed = True;
    gtk_list_store_remove($!ls, $iter);
  }

  method reorder (CArray[gint] $new_order) {
    $!accessed = True;
    gtk_list_store_reorder($!ls, $new_order);
  }

  method set_column_types (*@types) {
    die 'Cannot use GTK::ListStore.set_column_types after store has been accessed.'
      if $!accessed;
    die 'Elements of @types must be integers, and must not exceeed column size'
      unless @types.all ~~ (Int, IntStr).any;
    my CArray[uint32] $c_types = CArray[uint32].new;
    $c_types[$_++] = $_.Int for ^@types;
    $!columns = @types.elems;
    gtk_list_store_set_column_types($!ls, @types.elems, $c_types);
  }

  #method set_valist (GtkTreeIter $iter, va_list $var_args) {
  #  gtk_list_store_set_valist($!ls, $iter, $var_args);
  #}

  method set_value(
    GtkTreeIter() $iter,
    Int() $column,
    GValue() $value
  ) {
    my gint $c = self.RESOLVE-INT($column);
    gtk_list_store_set_value($iter, $c, $value);
  }

  method set_values (
    GtkTreeIter() $iter,
    %values
  ) {
    $!accessed = True;
    die 'Keys used %values must be integers.'
      unless %values.keys.all ~~ (Int, IntStr).any;
    die 'Values used in %values must be GTK::Compat::Value or GValue.'
      unless %values.values.all ~~ GValues;

    my CArray[gint] $c_columns;
    my CArray[GValue] $c_values;
    for %values.keys.sort {
      my $c = $++;
      $c_columns[$c] = $_.Int;
      $c_values[$c] = %values{$_};
    }

    gtk_list_store_set_valuesv(
      $!ls,
      $iter,
      $c_columns,
      $c_values,
      $c_columns.elems
    );
  }

  method set_valuesv (
    GtkTreeIter() $iter,
    @columns,
    @values,
    Int() $n_values
  ) {
    if $n_values > @columns.elems {
      $n_values = @columns.elems;
      warn '$n_values was greater than column count, and was corrected.';
    }

    die '@columns must contain GTypeEnum or integer values.'
      unless @columns.all ~~ (IntStr, Int);
    die '@values must contain GTK::Compat::Value or GValue elements'
      unless @values.all ~~ GValues;
    $!accessed = True;
    my CArray[gint] $c_columns;
    my CArray[GValue] $c_values;
    $c_columns[$_] = @columns[$_] for (^$n_values);
    $c_values[$_] = @values[$_] for (^$n_values);
    gtk_list_store_set_valuesv($!ls, $iter, $c_columns, $c_values, $n_values);
  }

  method swap (GtkTreeIter() $a, GtkTreeIter() $b) {
    $!accessed = True;
    gtk_list_store_swap($!ls, $a, $b);
  }

}
