use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::ListStore:ver<3.0.1146>;
use GTK::Raw::Types:ver<3.0.1146>;

use GLib::Value;
use GTK::TreeIter:ver<3.0.1146>;

use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;
use GTK::Roles::Buildable:ver<3.0.1146>;
use GTK::Roles::TreeModel:ver<3.0.1146>;
use GTK::Roles::TreeSortable:ver<3.0.1146>;


my subset GValues where GLib::Value | GValue;

our subset GtkListStoreAncestry is export of Mu
  where GtkListStore | GObject;

# YYY - This compunit needs another review! cw - 2019 01 24
#       cw: Ancestry review performed 2024/10/24, still needs full top down.

class GTK::ListStore:ver<3.0.1146> {
  also does GLib::Roles::Object;

  also does GTK::Roles::Buildable;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeSortable;

  has GtkListStore $!ls is implementor;

  has $!accessed = False;
  has $.columns;

  submethod BUILD(:$liststore, :$columns) {
    self.setGtkListStore($liststore, :$columns) if $liststore;
  }

  method setGtkListStore (GtkListStoreAncestry $_, :$!columns) {
    my $to-parent;

    $!ls = do {
      when GtkListStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GtkBuildable {
        $to-parent = cast(GObject, $_);
        $!b  = nativecast(GtkBuildable, $!ls);
        cast(GtkListStore, $_);
      }

      when GtkTreeSortable {
        $to-parent = cast(GObject, $_);
        $!ts = nativecast(GtkTreeSortable, $!ls);
        cast(GtkListStore, $_);
      }

      when GtkTreeModel {
        $to-parent = cast(GObject, $_);
        $!tm = nativecast(GtkTreeModel, $!ls);
        cast(GtkListStore, $_);
      }

      default {
        $to-parent = $_;
        cast(GtkListStore, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GtkBuildable;
    self.roleInit-GtkTreeSortable;
    self.roleInit-GtkTreeModel;
  }

  method GTK::Raw::Definitions::GtkListStore
    is also<
      ListStore
      GtkListStore
    >
  { $!ls }

   multi method new (
     $liststore where * ~~ GtkListStoreAncestry,

    :$ref = True
  ) {
    return unless $liststore;

    my $o = self.bless( :$liststore );
    $o.ref if $ref;
    $o;
  }
  multi method new (*@types) {
    for @types {
      next if $_ ~~ (Int, IntStr).any || .^can('Int').elems;
      my $v = .Int;
      die '@types must consist of Integers or objects that will convert to Integer'
        unless $v ~~ Int;
    }

    my $t = CArray[uint64].new;
    $t[$_] = @types[$_] for @types.keys;
    my gint $columns = @types.elems;
    my $liststore = gtk_list_store_newv($columns, $t);
    die 'GtkListStore not created!' unless $liststore;

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

  proto method append_with_values (|)
    is also<append-with-values>
  { * }

  multi method append_with_values (%values) {
    samewith(|%values)
  }
  multi method append_with_values (*%values) {
    self.insert_with_values($, -1, %values)
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

  # This is rapidly becoming a right fucking mess!
  method insert_with_valuesv (
    $iter is rw,
    Int() $position,
    @columns,
    @values,
    Int() $n_values
  )
    is also<insert-with-valuesv>
  {
    die '$position cannot be less than -1 (append)' unless $position >= -1;
    my @col_keys = @columns.map({
      die '@columns values must be integers.' unless .^can('Int');
      my $v = .Int;
      die 'Integer conversion failure!' unless $v ~~ Int;
      $v;
    });
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
    $c_columns[$_] = @columns[$_] for @col_keys;
    my $c_values = GLib::Roles::TypedBuffer[GValue].new(
      @values.map({
        die 'Cannot convert element to GValue!'
          unless $_ ~~ GValue || .^can('GValue').elems;
        $_ ~~ GValue ?? $_ !! .GValue;
      })
    );
    $iter = GtkTreeIter.new;
    die 'Could not create GtkTreeIter!' unless $iter;
    gtk_list_store_insert_with_valuesv(
      $!ls,
      $iter,
      $position,
      $c_columns,
      $c_values.p,
      $n_values
    );
  }

  multi method insert_with_values (
    $iter is rw,
    Int() $position,
    %values
  )
    is also<insert-with-values>
  {
    my (@columns, @values);

    for %values.pairs {
      die 'Keys used %values must be integers.' unless .key.^can('Int');
      my $v = .key.Int;
      die 'Integer conversion failure!' unless $v ~~ Int;
      @columns.push: $v;

      die 'Values used in %values must be GLib::Value or GValue.'
        unless .value ~~ GValue || .value.can('GValue');
      $v = .value ~~ GValue ?? .value !! .value.GValue;
      @values.push: $v;
    }

    $iter = GtkTreeIter.new;
    die 'Could not create GtkTreeIter!' unless $iter;

    self.insert_with_valuesv(
      $iter,
      $position,
      @columns,
      @values,
      @columns.elems
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
    die 'Cannot use GTK::ListStore:ver<3.0.1146>.set_column_types after store has been accessed.'
      if $!accessed;
    my @t_keys = @types.map({
      die 'Elements of @types must be integers, and must not exceeed column size'
        unless @types.all ~~ (Int, IntStr).any || .^can('Int');
      my $v = .Int;
      die 'Integer conversion failure!' unless $v ~~ Int;
    });
    my $c_types = CArray[uint64].new;
    $c_types[$_] = @types[$_] for @t_keys.keys;
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

    my @val_keys = %values.keys.map({
      die 'Keys used %values must be integers.'
        unless $_ ~~ (Int, IntStr).any || .^can('Int').elems;
      my $v = .Int;
      die 'Integer conversion failure!' unless $v ~~ Int;
      $v;
    });
    die 'Values used in %values must be GLib::Value or GValue.'
      unless %values.values.all ~~ GValues;

    %values.gist.say;

    self.set_valuesv(
      $iter,
      @val_keys.sort,
      @val_keys.sort.map({ %values{$_} }),
      @val_keys.elems
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
    $c_columns[$_] = @columns[$_].Int for ^$n_values;
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
