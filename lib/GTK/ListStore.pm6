use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::ListStore;
use GTK::Raw::Types;

use GLib::Value;

use GLib::Roles::Object;
use GTK::Roles::Buildable;
use GTK::Roles::TreeModel;
use GTK::Roles::TreeSortable;

use GTK::TreeIter;

my subset GValues where GLib::Value | GValue;

class GTK::ListStore {
  also does GLib::Roles::Object;

  also does GTK::Roles::Buildable;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeSortable;

  has GtkListStore $!ls is implementor;
  has $!accessed = False;
  has $!columns;

  submethod BUILD(:$liststore, :$columns) {
    self!setObject($!ls = $liststore);          # GLib::Roles::Object

    $!columns = $columns;

    $!b  = nativecast(GtkBuildable, $!ls);      # GTK::Roles::Buildable
    $!ts = nativecast(GtkTreeSortable, $!ls);   # GTK::Roles::TreeSortable
    $!tm = nativecast(GtkTreeModel, $!ls);      # GTK::Roles::TreeSortable
  }

  method GTK::Raw::Definitions::GtkListStore
    is also<
      ListStore
      GtkListStore
    >
  { $!ls }

  method new (*@types) {
    for @types {
      next if $_ ~~ (Int, IntStr).any || .^can('Int').elems;
      die '@types must consist of Integers or objects that will convert to Integer';
    }

    my $t = CArray[uint64].new;
    $t[$_] = @types[$_] for @types.keys;
    my gint $columns = @types.elems;
    my $liststore = gtk_list_store_newv($columns, $t);
    die 'GtkListStore not created!' unless $liststore.defined;

    $liststore ?? self.bless(:$liststore, :$columns) !! Nil;
  }

  multi method append {
    samewith($);
  }
  multi method append ($iter is rw) {
    $!accessed = True;
    $iter = GtkTreeIter.new;
    gtk_list_store_append($!ls, $iter);
    $iter;
  }

  method clear {
    $!accessed = True;
    gtk_list_store_clear($!ls);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_list_store_get_type, $n, $t );
  }

  method insert (GtkTreeIter() $iter, Int() $position) {
    my gint $p = $position;

    $!accessed = True;
    gtk_list_store_insert($!ls, $iter, $position);
  }

  method insert_after (GtkTreeIter() $iter, GtkTreeIter() $sibling)
    is also<insert-after>
  {
    $!accessed = True;
    gtk_list_store_insert_after($!ls, $iter, $sibling);
  }

  method insert_before (GtkTreeIter() $iter, GtkTreeIter() $sibling)
    is also<insert-before>
  {
    $!accessed = True;
    gtk_list_store_insert_before($!ls, $iter, $sibling);
  }

  method insert_with_valuesv (
    GtkTreeIter() $iter,
    Int() $position,
    Int @columns,
    @values,
    Int() $n_values
  )
    is also<insert-with-valuesv>
  {
    die '$position cannot be less than -1 (append)' unless $position >= -1;
    die '@columns must consist of Integers.'
      unless @columns.all ~~ (Int, IntStr).any;
    die '@values must contain GLib::Value or GValue elements'
      unless @values.all ~~ GValues;
    if $n_values > @columns.elems {
      $n_values = @columns.elems;
      warn '$n_values was greater than column count, and was corrected.';
    }

    $!accessed = True;
    # Throw exception if columns mismatch?
    my $c_columns = CArray[gint].new;
    $c_columns[$_] = @columns[$_] for @columns.keys;
    my $c_values = CArray[GValue].new;
    $c_columns[$_] = @columns[$_] for ^$n_values;
    for ^$n_values {
      $c_values[$_] = do given @values[$_] {
        # NOTE! $_ is now the current element of @value
        when GValue { $_ }
        default     { $_.gvalue }
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
  )
    is also<insert-with-values>
  {
    die 'Keys used %values must be integers.'
      unless %values.keys.all ~~ (Int, IntStr).any;
    die 'Values used in %values must be GLib::Value or GValue.'
      unless %values.values.all ~~ GValues;

    my CArray[gint] $c_columns;
    my CArray[GValue] $c_values;
    my $c = 0;
    for %values.keys.sort {
      $c_columns[$c] = $_.Int;
      $c_values[$c++] = %values{$_};
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

  method iter_is_valid (GtkTreeIter() $iter) is also<iter-is-valid> {
    $!accessed = True;
    gtk_list_store_iter_is_valid($!ls, $iter);
  }

  method move_after (GtkTreeIter() $iter, GtkTreeIter() $position)
    is also<move-after>
  {
    $!accessed = True;
    gtk_list_store_move_after($!ls, $iter, $position);
  }

  method move_before (GtkTreeIter() $iter, GtkTreeIter() $position)
    is also<move-before>
  {
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

  method set_column_types (*@types) is also<set-column-types> {
    die 'Cannot use GTK::ListStore.set_column_types after store has been accessed.'
      if $!accessed;
    die 'Elements of @types must be integers, and must not exceeed column size'
      unless @types.all ~~ (Int, IntStr).any;
    my $c_types = CArray[uint64].new;
    $c_types[$_] = @types[$_] for @types.keys;
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
  )
    is also<set-value>
  {
    my gint $c = $column;
    
    gtk_list_store_set_value($!ls, $iter, $c, $value);
  }

  method set_values (
    GtkTreeIter() $iter,
    %values
  )
    is also<set-values>
  {
    $!accessed = True;
    for %values.keys {
      unless $_ ~~ (Int, IntStr).any {
        die 'Keys used %values must be integers.' unless .^can('Int').elems;
      }
    }
    die 'Values used in %values must be GLib::Value or GValue.'
      unless %values.values.all ~~ GValues;

    %values.gist.say;

    self.set_valuesv(
      $iter,
      %values.keys.sort,
      %values.keys.sort.map({ %values{$_} }),
      %values.keys.elems
    );

  }

  # gtk_list_store_set_valuesv(
  #   $!ls,
  #   $iter,
  #   $c_columns,
  #   $c_values,
  #   $c_columns.elems
  # );
  method set_valuesv (
    GtkTreeIter() $iter,
    @columns,
    @values,
    Int() $n_values
  )
    is also<set-valuesv>
  {
    if $n_values > @columns.elems {
      $n_values = @columns.elems;
      warn '$n_values was greater than column count, and was corrected.';
    }

    die '@columns must contain values that have an integer representation.'
      unless @columns.map( *.^can('Int').elems ).all > 0;
    die '@values must contain GLib::Value or GValue elements'
      unless @values.all ~~ GValues;
    $!accessed = True;
    my $c_columns = CArray[gint].new;
    my $c_values = CArray[GValue].new;
    $c_columns[$_] = @columns[$_].Int for (^$n_values);
    for (^$n_values) {
      $c_values[$_]  = do given @values[$_] {
        when GLib::Value { .gvalue }
        when GValue             { $_      }
        default {
          die "Unknown type '{ .^name }' passed to GTK::ListStore.set_valuesv";
        }
      }
      say "SV{ $_ }: { $c_values[$_].gist }";
    }
    gtk_list_store_set_valuesv($!ls, $iter, $c_columns, $c_values, $n_values);
  }

  method swap (GtkTreeIter() $a, GtkTreeIter() $b) {
    $!accessed = True;
    gtk_list_store_swap($!ls, $a, $b);
  }

}
