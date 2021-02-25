use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::TreeStore;
use GTK::Raw::Types;

use GLib::Value;
use GTK::TreeIter;

use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;
use GTK::Roles::Buildable;
use GTK::Roles::TreeDnD;
use GTK::Roles::TreeModel;
use GTK::Roles::TreeSortable;

class GTK::TreeStore  {
  also does GLib::Roles::Object;

  also does GTK::Roles::Buildable;
  also does GTK::Roles::TreeDragDest;
  also does GTK::Roles::TreeDragSource;
  also does GTK::Roles::TreeModel;
  also does GTK::Roles::TreeSortable;

  has GtkTreeStore $!tree is implementor;
  has @!types;

  submethod BUILD(:$treestore, :@!types) {
    self!setObject($!tree = $treestore);           # GLib::Roles::Object

    $!b  = nativecast(GtkBuildable,      $!tree);  # GTK::Roles::Buildable
    $!tm = nativecast(GtkTreeModel,      $!tree);  # GTK::Roles::TreeModel
    $!ts = nativecast(GtkTreeSortable,   $!tree);  # GTK::Roles::TreeSortable
    $!dd = nativecast(GtkTreeDragDest,   $!tree);  # GTK::Roles::TreeDragDest
    $!ds = nativecast(GtkTreeDragSource, $!tree);  # GTK::Roles::TreeDragSource
  }

  method GTK::Raw::Definitions::GtkTreeStore
    is also<GtkTreeStore>
  { $!tree }

  multi method new (GtkTreeStore $treestore) {
    $treestore ?? self.bless(:$treestore) !! Nil;
  }
  multi method new (*@types) {
    my $treestore = gtk_tree_store_newv(
      @types.elems,
      ArrayToCArray(GType, @types)
    );

    $treestore ?? self.bless(:$treestore, :@types) !! Nil;
  }

  method !checkCV (@columns, @values) {
    die 'Contents of @columns must be integers.'
      unless @columns.all ~~ (Int, IntStr).any;
    warn '@columns exceeds the number of @values'
      if +@columns > +@values;
    warn '@values exceeds the number of @columns'
      if +@values > +@columns;
    my $max = max(+@columns, +@values);

    say "Columns: { @columns.gist }";
    say "Values:  { @values.gist }";

    my $c = ArrayToCArray( uint32, @columns[^$max] );
    my $v = GLib::Roles::TypedBuffer[GValue].new( @values[^$max] ).p;

    ($c, $v);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  multi method append (
    GtkTreeIter() $parent =  GtkTreeIter,
                  :$raw   =  False
  ) {
    my $iter = GtkTreeIter.new;

    gtk_tree_store_append($!tree, $iter, $parent);

    $iter = $raw ?? $iter !! GTK::TreeIter.new($iter);
  }

  method clear {
    gtk_tree_store_clear($!tree);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_tree_store_get_type, $n, $t );
  }

  method insert (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    Int() $position
  ) {
    my gint $p = $position;

    gtk_tree_store_insert($!tree, $iter, $parent, $p);
  }

  method insert_after (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    GtkTreeIter() $sibling
  )
    is also<insert-after>
  {
    gtk_tree_store_insert_after($!tree, $iter, $parent, $sibling);
  }

  method insert_before (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent,
    GtkTreeIter() $sibling
  )
    is also<insert-before>
  {
    gtk_tree_store_insert_before($!tree, $iter, $parent, $sibling);
  }

  method insert_with_values(
    GtkTreeIter() $iter,
    GtkTreeIter() $pt, # parent
    Int() $position,
    %values
  )
    is also<insert-with-values>
  {
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
  )
    is also<insert-with-valuesv>
  {
    my ($c, $v) = self!checkCV(@columns, @values);
    my gint $p = $position;

    gtk_tree_store_insert_with_valuesv(
      $!tree,
      $iter,
      $pt,
      $p,
      $c,
      $v,
      $c.elems
    );
  }

  method is_ancestor (
    GtkTreeIter() $iter,
    GtkTreeIter() $descendant
  )
    is also<is-ancestor>
  {
    so gtk_tree_store_is_ancestor($!tree, $iter, $descendant);
  }

  method iter_depth (GtkTreeIter() $iter) is also<iter-depth> {
    gtk_tree_store_iter_depth($!tree, $iter);
  }

  method iter_is_valid (GtkTreeIter() $iter) is also<iter-is-valid> {
    so gtk_tree_store_iter_is_valid($!tree, $iter);
  }

  method move_after (
    GtkTreeIter() $iter,
    GtkTreeIter() $position
  )
    is also<move-after>
  {
    gtk_tree_store_move_after($!tree, $iter, $position);
  }

  method move_before (
    GtkTreeIter() $iter,
    GtkTreeIter() $position
  )
    is also<move-before>
  {
    gtk_tree_store_move_before($!tree, $iter, $position);
  }

  method prepend (
    GtkTreeIter() $iter,
    GtkTreeIter() $parent
  ) {
    gtk_tree_store_prepend($!tree, $iter, $parent);
  }

  method remove (GtkTreeIter() $iter) {
    so gtk_tree_store_remove($!tree, $iter);
  }

  multi method reorder (GtkTreeIter() $parent, @new_order) {
    my $no = CArray[gint].new(
      @new_order.map({
        die '@new_order must only consist of Int-compatible objects!'
          unless .^can('Int').elems;
        .Int;
      })
    );
    samewith($parent, $no);
  }
  multi method reorder (GtkTreeIter() $parent, CArray[gint] $new_order) {
    gtk_tree_store_reorder($!tree, $parent, $new_order);
  }

  proto method set_column_types (|)
    is also<set-column-types>
  { * }

  multi method set_column_types (*@types) {
    my $t = CArray[GType].new(
      @types.map({
        die '@new_order must only consist of GType values!'
          # GType resolves to Int
          unless .^can('Int').elems;
        .Int;
      })
    );
    samewith($t.elems, $t);
  }
  multi method set_column_types(Int() $n_columns, CArray[GType] $types) {
    gtk_tree_store_set_column_types($!tree, $n_columns, $types);
  }

  # method set_valist (GtkTreeIter $iter, va_list $var_args) {
  #   gtk_tree_store_set_valist($!tree, $iter, $var_args);
  # }

  method set_value (GtkTreeIter() $iter, Int() $column, GValue() $value)
    is also<set-value>
  {
    my gint $c = $column;

    gtk_tree_store_set_value($!tree, $iter, $c, $value);
  }

  method set (GtkTreeIter() $iter, *%values) {
    say 'Setting values...';

    # Values here MUST be GValues
    my %nv = %values.clone;

    # cw: Put extra work to bypass the next multi, but that's difficult.
    #     Could just leave as is and use the next multi, but that's inefficient.
    my (@columns);
    for %nv.keys {
      my $col = do if .Int -> $i {
        $i
      } elsif .Int.defined {
        # Handle 0
        .Int;
      } else {
        ::("$_").Int
      }

      my $val = %nv{$_};
      unless $val ~~ (GLib::Value, GValue).any {
        # cw: -XXX- Check to insure right types being used!
        my $v = GLib::Value.new( @!types[$col] );
        $v.valueFromGType( @!types[$col] ) = $val;
        $val = $v;
      }
      @columns[$col] = $val.GValue;
    }
    @columns = @columns.kv.rotor(2).grep( *[1] );

    self.set_valuesv(
      $iter,
      @columns.map( *[0] ).Array,
      @columns.map( *[1] ).Array
    )
  }

  # This is for when the .values in %values contain GLib::Value or GValues!
  method set_values(GtkTreeIter() $iter, %values) is also<set-values> {
    my (@c, @v);
    for %values.keys {
      my $col = do if .Int -> $i {
        $i
      } else {
        ::("$_").Int
      }

      my $v = %values{$_};
      if $v !~~ GValue {
        if $v.^lookup('GValue') -> $cm {
          @v.push: $cm($v);
        } else {
          die '.values in %values must contain GValue-compatible items!';
        }
      } else {
        @v.push: $v;
      }
      @c.push: $col;
    }
    self.set_valuesv($iter, @c, @v);
  }

  # @values must be GValue!
  method set_valuesv (
    GtkTreeIter() $iter,
                  @columns,
                  @values,
  )
    is also<set-valuesv>
  {
    my ($c, $v) = self!checkCV(@columns, @values);

    say 'Cols';
    say "\tC: { $_ }" for $c;

    say 'Vals';
    say "\tV: { $_ }" for $v;

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
